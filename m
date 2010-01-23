From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC PATCH 07/10] gitweb: Use CHI compatibile (compute method) caching (WIP)
Date: Sat, 23 Jan 2010 01:27:30 +0100
Message-ID: <d878f121da06da6dc9f9b7174b34c62ed754f482.1264198194.git.jnareb@gmail.com>
References: <1263432185-21334-10-git-send-email-warthog9@eaglescrag.net>
Cc: John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	John 'Warthog9' Hawley <warthog9@kernel.org>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 23 01:28:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NYTrj-0002dP-PG
	for gcvg-git-2@lo.gmane.org; Sat, 23 Jan 2010 01:28:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756472Ab0AWA14 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jan 2010 19:27:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756459Ab0AWA1y
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jan 2010 19:27:54 -0500
Received: from mail-fx0-f220.google.com ([209.85.220.220]:64315 "EHLO
	mail-fx0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756439Ab0AWA1v (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jan 2010 19:27:51 -0500
Received: by mail-fx0-f220.google.com with SMTP id 20so1932491fxm.21
        for <git@vger.kernel.org>; Fri, 22 Jan 2010 16:27:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=LWFrPEIJ5ebaguTBrh4CrygpICqiPrk+zKzRIvVm4oY=;
        b=hJp1GfAs82OsivHuGhrsfecr4IoZjQX/tn8yqWeRFt3bIJxU6x/wu1ReFh19M9JkfP
         clFDpBk9KeMoRk3w7H2JVuNSZ604FL7Mwd2EJtE+GHCPNmgPBeUR587WGsqO+qFJXKv1
         eawbDg3MqvSnMW/qpOQfwGZ8BEm/g8VMHqDX0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=emkf5m7TyTZz5F8ys6hnJVEJroiLElnYQJKQbVR81mdFJV0ZWdqdJsNomFqIKkUwDN
         QrYGeCbuS1vgcewwd/srD1n+mAHyTgnwelQIGeQs/NpXUI7grGxfnypMvx/5JiaHF3hj
         ZDpRC+myO02Iz4pwbM8cWOGyT0ulTFDFFnW90=
Received: by 10.102.161.7 with SMTP id j7mr1882496mue.111.1264206470565;
        Fri, 22 Jan 2010 16:27:50 -0800 (PST)
Received: from localhost.localdomain (abvr137.neoplus.adsl.tpnet.pl [83.8.215.137])
        by mx.google.com with ESMTPS id s11sm11094697mue.19.2010.01.22.16.27.49
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 22 Jan 2010 16:27:49 -0800 (PST)
X-Mailer: git-send-email 1.6.6.1
In-Reply-To: <1263432185-21334-10-git-send-email-warthog9@eaglescrag.net>
In-Reply-To: <cover.1264198194.git.jnareb@gmail.com>
References: <cover.1264198194.git.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137798>

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This patch, as you can see, lack proper commit message: it is work in
progress.

The reason behind supporting compute() as interface to cache is that
with this interface it is possible (as it can be seen in the following
patch) to use locking to avoid cache miss stampede (only one process
regenerates cache).

The support for $cache which do not provide '->compute($key, $code)'
method is left just in case we would want to use such (external)
caching engine.  We should probably add generic_compute() subroutine
which would use get/set, and provide compute-like interface.

 gitweb/cache.pm |   53 +++++++++++++++++++++++++++++++++++++++++++----------
 1 files changed, 43 insertions(+), 10 deletions(-)

diff --git a/gitweb/cache.pm b/gitweb/cache.pm
index 9692e8d..8dd4f39 100644
--- a/gitweb/cache.pm
+++ b/gitweb/cache.pm
@@ -432,6 +432,48 @@ sub cache_fetch {
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
+	my $data;
+	open my $data_fh, '>', \$data
+		or die "Can't open memory file: $!";
+	# matches "binmode STDOUT, ':uft8'" at beginning
+	binmode $data_fh, ':utf8';
+
+	$out = $data_fh || \*STDOUT;
+	$actions{$action}->();
+
+	close $data_fh;
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
+		local $/ = undef;
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
@@ -440,22 +482,13 @@ sub cache_fetch {
 		print STDOUT $data;
 
 	} else {
-		# calculate data and regenerate data
-		open my $data_fh, '>', \$data
-			or die "Can't open memory file: $!";
-		# matches "binmode STDOUT, ':uft8'" at beginning
-		binmode $data_fh, ':utf8';
-
-		$out = $data_fh || \*STDOUT;
-		$actions{$action}->();
+		$data = cache_calculate($action);
 
 		if (defined $data) {
 			$cache->set($key, $data);
 			binmode STDOUT, ':raw';
 			local $/ = undef;
 			print STDOUT $data;
 		}
-
-		close $data_fh;
 	}
 }
 
-- 
1.6.6.1
