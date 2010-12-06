From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 10/24] gitweb/lib - Use CHI compatibile (compute method) caching interface
Date: Tue,  7 Dec 2010 00:10:55 +0100
Message-ID: <1291677069-6559-11-git-send-email-jnareb@gmail.com>
References: <1291677069-6559-1-git-send-email-jnareb@gmail.com>
Cc: John 'Warthog9' Hawley <warthog9@kernel.org>,
	John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	Junio C Hamano <gitster@pobox.com>,
	demerphq <demerphq@gmail.com>,
	Aevar Arnfjord Bjarmason <avarab@gmail.com>,
	Thomas Adam <thomas@xteddy.org>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 07 00:12:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PPkEO-0008RS-U0
	for gcvg-git-2@lo.gmane.org; Tue, 07 Dec 2010 00:12:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753520Ab0LFXMJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Dec 2010 18:12:09 -0500
Received: from mail-ew0-f45.google.com ([209.85.215.45]:64271 "EHLO
	mail-ew0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752968Ab0LFXMH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Dec 2010 18:12:07 -0500
Received: by ewy10 with SMTP id 10so7581974ewy.4
        for <git@vger.kernel.org>; Mon, 06 Dec 2010 15:12:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=qBJVvAqzhwMfkY/luq71slfHaUUPHyxTtGZgWPlwWyg=;
        b=gGxrnQNqapYYSVbpQSLmNhpsek2WXf9/1yE6c6taXUwo8VXMS10p+DOhftFC70xa2F
         XmGB4NFVMPdUnnDpK1ItulYLCZfLKFEAxUzzZJ07YaQED+IcjIeJBPIMa/8dJBYdo+ob
         PTl086RHYGpyhAr6iHinTX52lo8CbgfXo3CJ4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=JdHoKMviUZL942JOib4YrcJ8thsX2/uE6tkoqXMZmu6fY4CKdg2Vu/1SfFCuTOv7nB
         Wwmr+XEs08VwrZPLYpP9U/X4LOdgDjVYeAvI79vmc1xIiykBk3/krWiCJhL172a/xK/w
         UWYJdX+mYRyh7GiZcZQVwnbqDGtt4hrem/7jk=
Received: by 10.213.14.18 with SMTP id e18mr112303eba.67.1291677126500;
        Mon, 06 Dec 2010 15:12:06 -0800 (PST)
Received: from localhost.localdomain (abwg200.neoplus.adsl.tpnet.pl [83.8.230.200])
        by mx.google.com with ESMTPS id y5sm5190626eeh.22.2010.12.06.15.12.04
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 06 Dec 2010 15:12:05 -0800 (PST)
X-Mailer: git-send-email 1.7.3
In-Reply-To: <1291677069-6559-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163036>

If $cache provides CHI compatible ->compute($key, $code) method, use it
instead of Cache::Cache compatible ->get($key) and ->set($key, $data).
In the future other compatibile but differently named methods, like
Cache::FastMmap's ->get_and_set($key, $code) method, could also be
supported; though CHI which has ->compute() includes CHI::Driver::FastMmap
wrapper.

GitwebCache::SimpleFileCache provides 'compute' method, which currently
simply use 'get' and 'set' methods in proscribed manner.  Nevertheless
'compute' method can be more flexible in choosing when to refresh cache,
and which process is to refresh/(re)generate cache entry.  This method
would use (advisory) locking to prevent 'cache miss stampede' (aka
'stampeding herd') problem in the next commit.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This patch has less importance that it had before, because when using
GitwebCache::FileCacheWithLocking it is ->compute_fh interface that would
be used, not ->compute.  As far as I understand CHI ->compute looks the
same simple wrapper around ->get/->set that GitwebCache::SimpleFileCache
uses.

On the other hand (as you would see later) ->compute and ->compute_fh have
lot of code in common, and it is easier to test behavior of ->compute in
t9503 tests.

 gitweb/lib/GitwebCache/CacheOutput.pm |   36 +++++++++++++++++++++++++++-----
 1 files changed, 30 insertions(+), 6 deletions(-)

diff --git a/gitweb/lib/GitwebCache/CacheOutput.pm b/gitweb/lib/GitwebCache/CacheOutput.pm
index 458e314..4a96ac9 100644
--- a/gitweb/lib/GitwebCache/CacheOutput.pm
+++ b/gitweb/lib/GitwebCache/CacheOutput.pm
@@ -38,6 +38,36 @@ sub cache_output {
 
 	$capture = setup_capture($capture);
 
+	my $data;
+	if ($cache->can('compute')) {
+		$data = cache_output_compute($cache, $capture, $key, $code);
+	} else {
+		$data = cache_output_get_set($cache, $capture, $key, $code);
+	}
+
+	if (defined $data) {
+		binmode STDOUT, ':raw';
+		print $data;
+	}
+
+	return $data;
+}
+
+# for $cache which can ->compute($key, $code)
+sub cache_output_compute {
+	my ($cache, $capture, $key, $code) = @_;
+
+	my $data = $cache->compute($key, sub {
+		$capture->capture($code);
+	});
+
+	return $data;
+}
+
+# for $cache which can ->get($key) and ->set($key, $data)
+sub cache_output_get_set {
+	my ($cache, $capture, $key, $code) = @_;
+
 	# check if data is in the cache
 	my $data = $cache->get($key);
 
@@ -47,12 +77,6 @@ sub cache_output {
 		$cache->set($key, $data) if defined $data;
 	}
 
-	# print cached data
-	if (defined $data) {
-		binmode STDOUT, ':raw';
-		print $data;
-	}
-
 	return $data;
 }
 
-- 
1.7.3
