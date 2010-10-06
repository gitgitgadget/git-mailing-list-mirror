From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCHv5 10/21] gitweb/lib - Use CHI compatibile (compute method) caching interface
Date: Thu,  7 Oct 2010 00:01:55 +0200
Message-ID: <1286402526-13143-11-git-send-email-jnareb@gmail.com>
References: <1286402526-13143-1-git-send-email-jnareb@gmail.com>
Cc: John 'Warthog9' Hawley <warthog9@kernel.org>,
	Petr Baudis <pasky@ucw.cz>, admin@repo.or.cz,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 07 00:04:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3c5o-0002Gb-Je
	for gcvg-git-2@lo.gmane.org; Thu, 07 Oct 2010 00:04:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933230Ab0JFWDB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Oct 2010 18:03:01 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:63360 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932921Ab0JFWCw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Oct 2010 18:02:52 -0400
Received: by mail-bw0-f46.google.com with SMTP id 11so49448bwz.19
        for <git@vger.kernel.org>; Wed, 06 Oct 2010 15:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=ZwywpyzrXnIUB7BDodgtkIoqvrJ5nKAtYyzTw79I/AA=;
        b=gJ+VZO3z5YJnywu9IJOYQp1990CX0wrgyd7+H2drqKwndj8CNjq0vAmFfTslWogDO0
         lkIWxUXK4AWfLJbTfcJccx21PedGEs9XDbAl/ITUQxfQpVb20eYG1IoD0/FTNV1yuhjV
         SjAMzW3Uq8LUePIkf2Kie5eEeAyosomCQY384=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=nCmEAPR2Vko9bQ18H3PngLugYzS1fuxIk+jRkCH57MMB2seq16It1H63bMWAt617ut
         sqJ5CFI+i7VeVXaIwK5lU/ap5RSME2+FmK6LHTPEwjgqK4zJ4yphdEey5jI/+m8pCsUa
         ATGgoc+3ARXZ8dF8+TxlGLB8iVMtf1xfrkhjI=
Received: by 10.204.49.11 with SMTP id t11mr10300188bkf.64.1286402569007;
        Wed, 06 Oct 2010 15:02:49 -0700 (PDT)
Received: from localhost.localdomain (abwe253.neoplus.adsl.tpnet.pl [83.8.228.253])
        by mx.google.com with ESMTPS id 24sm1044480bkr.19.2010.10.06.15.02.47
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 06 Oct 2010 15:02:48 -0700 (PDT)
X-Mailer: git-send-email 1.7.3
In-Reply-To: <1286402526-13143-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158324>

If $cache provides CHI compatible ->compute($key, $code) method, use it
instead of Cache::Cache compatible ->get($key) and ->set($key, $data).

GitwebCache::SimpleFileCache provides 'compute' method, which currently
simply use 'get' and 'set' methods in proscribed manner.  Nevertheless
'compute' method can be more flexible in choosing when to refresh cache,
and which process is to refresh/(re)generate cache entry.  This method
would use (advisory) locking to prevent 'cache miss stampede' (aka
'stampeding herd') problem in the next commit.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This patch has no differences since v4.

This patch doesn't strictly have an equivalent in J.H. patch adding
caching to gitweb.


 gitweb/lib/GitwebCache/CacheOutput.pm |   31 +++++++++++++++++++++++++++++++
 1 files changed, 31 insertions(+), 0 deletions(-)

diff --git a/gitweb/lib/GitwebCache/CacheOutput.pm b/gitweb/lib/GitwebCache/CacheOutput.pm
index bba73ee..7a13b2f 100644
--- a/gitweb/lib/GitwebCache/CacheOutput.pm
+++ b/gitweb/lib/GitwebCache/CacheOutput.pm
@@ -37,6 +37,37 @@ our $CAPTURE_CLASS = 'GitwebCache::Capture::SelectFH';
 sub cache_output {
 	my ($cache, $key, $code) = @_;
 
+	if ($cache->can('compute')) {
+		#other solution: goto &cache_output_compute;
+		return cache_output_compute($cache, $key, $code);
+	} else {
+		#other solution: goto &cache_output_get_set;
+		return cache_output_get_set($cache, $key, $code);
+	}
+}
+
+# for $cache which can ->compute($key, $code)
+sub cache_output_compute {
+	my ($cache, $key, $code) = @_;
+
+	my $capture = $CAPTURE_CLASS;
+	setup_capture($capture);
+
+	my $data = $cache->compute($key, sub { &capture_block($code) });
+
+	if (defined $data) {
+		# select() instead of STDOUT is here for t9503 test:
+		binmode select(), ':raw';
+		print $data;
+	}
+
+	return $data;
+}
+
+# for $cache which can ->get($key) and ->set($key, $data)
+sub cache_output_get_set {
+	my ($cache, $key, $code) = @_;
+
 	my $data = $cache->get($key);
 
 	# capture and cache output, if there was nothing in the cache
-- 
1.7.3
