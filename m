From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC PATCHv4 12/17] gitweb/lib - Use CHI compatibile (compute method) caching interface
Date: Mon, 14 Jun 2010 18:08:25 +0200
Message-ID: <1276531710-22945-14-git-send-email-jnareb@gmail.com>
References: <1276531710-22945-1-git-send-email-jnareb@gmail.com>
Cc: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>,
	Petr Baudis <pasky@ucw.cz>,
	Christian Couder <chriscool@tuxfamily.org>,
	John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	John 'Warthog9' Hawley <warthog9@kernel.org>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 14 18:10:39 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OOCEs-0002Dq-OS
	for gcvg-git-2@lo.gmane.org; Mon, 14 Jun 2010 18:10:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755517Ab0FNQJF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jun 2010 12:09:05 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:33637 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755480Ab0FNQI7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jun 2010 12:08:59 -0400
Received: by fxm8 with SMTP id 8so2649923fxm.19
        for <git@vger.kernel.org>; Mon, 14 Jun 2010 09:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=0RAQ/XEyFs3QDCSVKgFLZYw7FYsbdWaRuIl/GMt4jnM=;
        b=Tl9bD/3FcdvzKOF8N8mE+3CoBfrtCoRY5VSMRPTJYYVWivQ3vL8CukBDzG1DJrk4UV
         CQOnSpXrNLa4ZN/AAKrH3P5/NDdwiwfKYdIWQDN7Yh+oKJjVZhlJKmXTXf+2StY1RAqN
         ezhttpwq/2u7WI5U4Vp/hQa8nXAxfzOnRwZ14=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=TiKaEIdAa0ykP5yAIqOAvMN7SiHM5m0oGS/Q6fWK7ti3GlUSUhD/u+/bj7MubDAi/a
         7QC5R1nkoDMF7sK3btZGyG1el+JfuKxj25vL+O+YNXc7GlJrkMf+ldusa+xzq+oCp+p+
         V8kryN/TI4kz8EIuQ0DEcZHo40xtFXvjocRNo=
Received: by 10.223.35.12 with SMTP id n12mr5673276fad.35.1276531737733;
        Mon, 14 Jun 2010 09:08:57 -0700 (PDT)
Received: from localhost.localdomain (abuz111.neoplus.adsl.tpnet.pl [83.8.197.111])
        by mx.google.com with ESMTPS id u12sm7476715fah.28.2010.06.14.09.08.56
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 14 Jun 2010 09:08:57 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.1
In-Reply-To: <1276531710-22945-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149111>

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
 gitweb/lib/GitwebCache/CacheOutput.pm |   31 +++++++++++++++++++++++++++++++
 1 files changed, 31 insertions(+), 0 deletions(-)

diff --git a/gitweb/lib/GitwebCache/CacheOutput.pm b/gitweb/lib/GitwebCache/CacheOutput.pm
index 8195f0b..de4bd4d 100644
--- a/gitweb/lib/GitwebCache/CacheOutput.pm
+++ b/gitweb/lib/GitwebCache/CacheOutput.pm
@@ -35,6 +35,37 @@ our $CAPTURE_CLASS = 'GitwebCache::Capture::SelectFH';
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
1.7.0.1
