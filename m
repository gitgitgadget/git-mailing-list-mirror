From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC PATCHv3 06/10] gitweb: Use CHI compatibile (compute method) caching
Date: Tue, 16 Feb 2010 20:36:41 +0100
Message-ID: <1266349005-15393-7-git-send-email-jnareb@gmail.com>
References: <1266349005-15393-1-git-send-email-jnareb@gmail.com>
Cc: John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	John 'Warthog9' Hawley <warthog9@kernel.org>,
	Petr Baudis <pasky@suse.cz>, Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 16 20:37:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhTF9-0002i3-8R
	for gcvg-git-2@lo.gmane.org; Tue, 16 Feb 2010 20:37:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933236Ab0BPThX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2010 14:37:23 -0500
Received: from mail-bw0-f213.google.com ([209.85.218.213]:48810 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933215Ab0BPThM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2010 14:37:12 -0500
Received: by bwz5 with SMTP id 5so2281331bwz.1
        for <git@vger.kernel.org>; Tue, 16 Feb 2010 11:37:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=z4Ifys3en6ieRhUU/nt3pb8YoUoc8MYRt+n6wua5pF4=;
        b=wgdhVOzhKv3vkBVfJ7t61gk4cFhNMNcYmVy6jOdGHlxnOMDwwcyvSnzLjO3e/qyA4O
         5q8GSEKmlGVHCVpNlbNzCfD9LB4NOyQ3O0FxuXppSV7Cdha/iG/CjfIpi5Ip2P1I4GBV
         mh9blNriYB9SMZ+qtFPDsAB8C0J0jAMZJhRn4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Y85evBLjysr3hqadp/d7VOak0cx+hHc88aKcj3inuoM5XEpbW/AkxQymIKJ/S/y551
         DD2W/mRdsGD4NCHxrleGOHX3x/QiFeDLc/1kmoRtXuaxGXskWoe8yUyFyzCy49wkF5hb
         d8i0E4mq4/j6av5Gp6aQ1xIPVjlDDHlZRr88s=
Received: by 10.204.81.9 with SMTP id v9mr1902914bkk.129.1266349028382;
        Tue, 16 Feb 2010 11:37:08 -0800 (PST)
Received: from localhost.localdomain (abvy197.neoplus.adsl.tpnet.pl [83.8.222.197])
        by mx.google.com with ESMTPS id 15sm3243751bwz.12.2010.02.16.11.37.06
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 16 Feb 2010 11:37:07 -0800 (PST)
X-Mailer: git-send-email 1.6.6.1
In-Reply-To: <1266349005-15393-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140142>

If $cache provides CHI compatible ->compute($key, $code) method, use it
instead of Cache::Cache compatible ->get($key) and ->set($key, $data).
While at it, refactor regenerating cache into cache_calculate subroutine.

GitwebCache::SimpleFileCache provides 'compute' method, which currently
simply use 'get' and 'set' methods in proscribed manner.  Nevertheless
'compute' method can be more flexible in choosing when to refresh cache,
and which process is to refresh/(re)generate cache entry.  This method
would use (advisory) locking to prevent 'cache miss stampede' (aka
'stampeding herd') problem in the next commit.

The support for $cache which do not provide '->compute($key, $code)'
method is left just in case we would want to use such (external)
caching engine.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This commit could be moved one commit earlier in this patch series for
shortlog to look nicer (although commit message would have to be adjusted to
that fact) ;-)

Differences from v2:
* Update/change signature of cache_fetch_compute and cache_fetch_get_set
* cache_fetch_compute updated to use new output capturing mechanism
* Fixed cache_fetch_get_set

This patch doesn't strictly have an equivalent in J.H. patch adding caching
to gitweb.

 gitweb/cache.pm |   46 ++++++++++++++++++++++++++++++++++++++++++----
 1 files changed, 42 insertions(+), 4 deletions(-)

diff --git a/gitweb/cache.pm b/gitweb/cache.pm
index dcddd28..b828102 100644
--- a/gitweb/cache.pm
+++ b/gitweb/cache.pm
@@ -455,12 +455,50 @@ sub cache_capture (&) {
 sub cache_fetch {
 	my ($cache, $key, $code) = @_;
 
-	my $data = $cache->get($key);
+	if ($cache->can('compute')) {
+		#goto &cache_fetch_compute
+		cache_fetch_compute($cache, $key, $code);
+	} else {
+		#goto &cache_fetch_get_set
+		cache_fetch_get_set($cache, $key, $code);
+	}
+}
+
+# calculate data to regenerate cache via capturing output
+# (probably unnecessary level of indirection)
+sub cache_calculate {
+	my $code = shift;
+
+	my $data = cache_capture {
+		$code->();
+	};
+
+	return $data;
+}
+
+# for $cache which can ->compute($key, $code)
+sub cache_fetch_compute {
+	my ($cache, $key, $code) = @_;
+
+	my $data = $cache->compute($key, sub { cache_calculate($code) });
 
+	if (defined $data) {
+		# print cached data
+		#binmode STDOUT, ':raw';
+		#print STDOUT $data;
+		# for t9503 test:
+		binmode select(), ':raw';
+		print $data;
+	}
+}
+
+# for $cache which can ->get($key) and ->set($key, $data)
+sub cache_fetch_get_set {
+	my ($cache, $key, $code) = @_;
+
+	my $data = $cache->get($key);
 	if (!defined $data) {
-		$data = cache_capture {
-			$code->();
-		};
+		$data = cache_calculate($code);
 		$cache->set($key, $data) if defined $data;
 	}
 
-- 
1.6.6.1
