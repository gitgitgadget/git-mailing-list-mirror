From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC PATCHv2 06/10] gitweb: Use CHI compatibile (compute method) caching
Date: Tue,  9 Feb 2010 11:30:23 +0100
Message-ID: <1265711427-15193-7-git-send-email-jnareb@gmail.com>
References: <1265711427-15193-1-git-send-email-jnareb@gmail.com>
Cc: John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	John 'Warthog9' Hawley <warthog9@kernel.org>,
	Petr Baudis <pasky@suse.cz>, Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 09 11:31:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NenNe-00041a-Mj
	for gcvg-git-2@lo.gmane.org; Tue, 09 Feb 2010 11:31:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753642Ab0BIKbV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Feb 2010 05:31:21 -0500
Received: from mail-fx0-f220.google.com ([209.85.220.220]:57151 "EHLO
	mail-fx0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752602Ab0BIKat (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Feb 2010 05:30:49 -0500
Received: by mail-fx0-f220.google.com with SMTP id 20so3026581fxm.21
        for <git@vger.kernel.org>; Tue, 09 Feb 2010 02:30:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=6SKrqnpSNLKmIRCWrkuyddVTtcfPvrA0w5EAUP+fYGE=;
        b=m7Z4EVO8Q9IA335TAeVxTWBXo70sigOfvCosP2gsZY7nzSJvgK/1vo0sKjplFjerN7
         +4GFX+lQde3Nm9ZjKceA96GXgzyLRby/fLw1pwfBUKXkqTAwQi8YumssGEeNj9YnVFeE
         BBmIFMpVT29e+yOcAc18pLTdCH/7gLsrWjJJ8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=xga7f24Egz421kGFCdNfl+pDZn0P7ayg0lBvpzST45uHmQxlavTi7xWXNzkbrnaUzF
         +/UCwMBo1f6hhSwLFpTWhUmfw1z/jQBC+En5dO+oXa0zjEHdGne8dGmERRZa4Ykm1rYU
         6PZwqQFxN5Gr8dnEidGOfug2SXvGFt9plls9s=
Received: by 10.223.5.81 with SMTP id 17mr3663625fau.3.1265711449117;
        Tue, 09 Feb 2010 02:30:49 -0800 (PST)
Received: from localhost.localdomain (abvg140.neoplus.adsl.tpnet.pl [83.8.204.140])
        by mx.google.com with ESMTPS id 16sm2344332fxm.8.2010.02.09.02.30.47
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 09 Feb 2010 02:30:48 -0800 (PST)
X-Mailer: git-send-email 1.6.6.1
In-Reply-To: <1265711427-15193-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139391>

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

Differences from v1:
* Proper commit message
* cache_calculate uses cache_capture and is therefore shorter
* Don't set $/ to undef, which applies to input, for printing (output).

This patch doesn't strictly have an equivalent in J.H. patch adding caching
to gitweb.

 gitweb/cache.pm |   39 ++++++++++++++++++++++++++++++++++++---
 1 files changed, 36 insertions(+), 3 deletions(-)

diff --git a/gitweb/cache.pm b/gitweb/cache.pm
index d81f6e8..899a4b4 100644
--- a/gitweb/cache.pm
+++ b/gitweb/cache.pm
@@ -399,6 +399,41 @@ sub cache_fetch {
 	my ($cache, $action) = @_;
 
 	my $key = gitweb_output_key();
+	if ($cache->can('compute')) {
+		cache_fetch_compute($cache, $action, $key);
+	} else {
+		cache_fetch_get_set($cache, $action, $key);
+	}
+}
+
+# calculate data to regenerate cache
+sub cache_calculate {
+	my ($action) = @_;
+
+	my $data = cache_capture {
+		$actions{$action}->();
+	};
+
+	return $data;
+}
+
+# for $cache which can ->compute($key, $code)
+sub cache_fetch_compute {
+	my ($cache, $action, $key) = @_;
+
+	my $data = $cache->compute($key, sub { cache_calculate($action) });
+
+	if (defined $data) {
+		# print cached data
+		binmode STDOUT, ':raw';
+		print STDOUT $data;
+	}
+}
+
+# for $cache which can ->get($key) and ->set($key, $data)
+sub cache_fetch_get_set {
+	my ($cache, $action, $key) = @_;
+
 	my $data = $cache->get($key);
 
 	if (defined $data) {
@@ -407,9 +442,7 @@ sub cache_fetch {
 		print STDOUT $data;
 
 	} else {
-		$data = cache_capture {
-			$actions{$action}->();
-		};
+		$data = cache_calculate($action);
 
 		if (defined $data) {
 			$cache->set($key, $data);
-- 
1.6.6.1
