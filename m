From: Johan Herland <johan@herland.net>
Subject: [RFC/PATCHv3 2/3] git-svn: Warn about changing default for --prefix in Git v2.0
Date: Fri, 11 Oct 2013 14:57:06 +0200
Message-ID: <1381496227-28700-3-git-send-email-johan@herland.net>
References: <1381015833-696-1-git-send-email-johan@herland.net>
 <1381496227-28700-1-git-send-email-johan@herland.net>
Cc: tfnico@gmail.com, Johan Herland <johan@herland.net>,
	Eric Wong <normalperson@yhbt.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 11 14:57:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VUcHn-0002nN-64
	for gcvg-git-2@plane.gmane.org; Fri, 11 Oct 2013 14:57:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757896Ab3JKM5g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Oct 2013 08:57:36 -0400
Received: from mail-ea0-f174.google.com ([209.85.215.174]:34435 "EHLO
	mail-ea0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757872Ab3JKM5d (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Oct 2013 08:57:33 -0400
Received: by mail-ea0-f174.google.com with SMTP id z15so1860354ead.19
        for <git@vger.kernel.org>; Fri, 11 Oct 2013 05:57:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BclW/k6FDf5TrNgew6aZrjk94UJFjeGCzWOf1JSIIuI=;
        b=TOcoUBEpZCDvRVyifh7dzHqDUiKWZ36sk2Bvb9EmcGDZiM9l4/wsDTOLOpbUKi78zw
         QeNVPCB+uIWdh4smykJlD4gYSbcnbDgeEIlxntgVH73+XqlZpHJjfQyvJm6wMojw0hjn
         eXzzx6eJD2o6XBCN9cwEK54yLwX4CgB2e0N9SVTHy3jPpoGibm/f24JJa9ndxRmwQIQO
         D4z21N+5XXuue38JVopC6eWrin7IxES89lcQT0dad329FepggNOBbs5iufheGOqPZXpf
         w0H+Gku22myR3GZTlPd3I9ukit3fT/nQVxG/9fE1A6udHQr1cKaZhar+hWQ0px4ugm6u
         Q6zw==
X-Received: by 10.14.241.141 with SMTP id g13mr2031556eer.75.1381496252604;
        Fri, 11 Oct 2013 05:57:32 -0700 (PDT)
Received: from beta.cisco.com (173-38-208-169.cisco.com. [173.38.208.169])
        by mx.google.com with ESMTPSA id k7sm114514621eeg.13.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 11 Oct 2013 05:57:31 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.653.g2df02b3
In-Reply-To: <1381496227-28700-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235902>

In Git v2.0, we will change the default --prefix for init/clone from
none/empty to "origin/" (which causes SVN-tracking branches to be
placed at refs/remotes/origin/* instead of refs/remotes/*).

This patch warns users about the upcoming change, both in the git-svn
manual page, and on stderr when running init/clone in the "multi-mode"
without providing a --prefix.

Cc: Eric Wong <normalperson@yhbt.net>
Signed-off-by: Johan Herland <johan@herland.net>
---
 Documentation/git-svn.txt     | 11 ++++++-
 git-svn.perl                  | 12 +++++++-
 t/t9117-git-svn-init-clone.sh | 67 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 88 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index ac0c72f..7980c20 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -86,6 +86,14 @@ COMMANDS
 	(refs/remotes/$remote/*). Setting a prefix is also useful
 	if you wish to track multiple projects that share a common
 	repository.
++
+NOTE: In Git v2.0, the default prefix will CHANGE from "" (no prefix)
+to "origin/". This is done to put SVN-tracking refs at
+"refs/remotes/origin/*" instead of "refs/remotes/*", and make them
+more compatible with how Git's own remote-tracking refs are organized
+(i.e. refs/remotes/$remote/*). You can enjoy the same benefits today,
+by using the --prefix option.
+
 --ignore-paths=<regex>;;
 	When passed to 'init' or 'clone' this regular expression will
 	be preserved as a config key.  See 'fetch' for a description
@@ -986,7 +994,8 @@ placed at refs/remotes/origin/* rather than the default refs/remotes/*.
 The former is more compatible with the layout of Git's "regular"
 remote-tracking refs (refs/remotes/$remote/*), and may potentially
 prevent similarly named SVN branches and Git remotes from clobbering
-each other.
+each other. In Git v2.0 the default prefix used (i.e. when no --prefix
+is given) will change from "" (no prefix) to "origin/".
 
 When using multiple --branches or --tags, 'git svn' does not automatically
 handle name collisions (for example, if two branches from different paths have
diff --git a/git-svn.perl b/git-svn.perl
index ff1ce3d..0443a4f 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -1389,7 +1389,17 @@ sub cmd_multi_init {
 		usage(1);
 	}
 
-	$_prefix = '' unless defined $_prefix;
+	unless (defined $_prefix) {
+		$_prefix = '';
+		warn <<EOF
+WARNING: --prefix is not given, defaulting to empty prefix.
+         This is probably not what you want! In order to stay compatible
+         with regular remote-tracking refs, provide a prefix like
+         --prefix=origin/ (remember the trailing slash), which will cause
+         the SVN-tracking refs to be placed at refs/remotes/origin/*.
+NOTE: In Git v2.0, the default prefix will change from empty to 'origin/'.
+EOF
+	}
 	if (defined $url) {
 		$url = canonicalize_url($url);
 		init_subdir(@_);
diff --git a/t/t9117-git-svn-init-clone.sh b/t/t9117-git-svn-init-clone.sh
index b7ef9e2..69e9c0d 100755
--- a/t/t9117-git-svn-init-clone.sh
+++ b/t/t9117-git-svn-init-clone.sh
@@ -52,4 +52,71 @@ test_expect_success 'clone to target directory with --stdlayout' '
 	rm -rf target
 	'
 
+test_expect_success 'init without -s/-T/-b/-t does not warn' '
+	test ! -d trunk &&
+	git svn init "$svnrepo"/project/trunk trunk 2>warning &&
+	test_must_fail grep -q prefix warning &&
+	rm -rf trunk &&
+	rm -f warning
+	'
+
+test_expect_success 'clone without -s/-T/-b/-t does not warn' '
+	test ! -d trunk &&
+	git svn clone "$svnrepo"/project/trunk 2>warning &&
+	test_must_fail grep -q prefix warning &&
+	rm -rf trunk &&
+	rm -f warning
+	'
+
+test_svn_configured_prefix () {
+	prefix=$1 &&
+	cat >expect <<EOF &&
+project/trunk:refs/remotes/${prefix}trunk
+project/branches/*:refs/remotes/${prefix}*
+project/tags/*:refs/remotes/${prefix}tags/*
+EOF
+	test ! -f actual &&
+	git --git-dir=project/.git config svn-remote.svn.fetch >>actual &&
+	git --git-dir=project/.git config svn-remote.svn.branches >>actual &&
+	git --git-dir=project/.git config svn-remote.svn.tags >>actual &&
+	test_cmp expect actual &&
+	rm -f expect actual
+}
+
+test_expect_success 'init with -s/-T/-b/-t without --prefix warns' '
+	test ! -d project &&
+	git svn init -s "$svnrepo"/project project 2>warning &&
+	grep -q prefix warning &&
+	test_svn_configured_prefix "" &&
+	rm -rf project &&
+	rm -f warning
+	'
+
+test_expect_success 'clone with -s/-T/-b/-t without --prefix warns' '
+	test ! -d project &&
+	git svn clone -s "$svnrepo"/project 2>warning &&
+	grep -q prefix warning &&
+	test_svn_configured_prefix "" &&
+	rm -rf project &&
+	rm -f warning
+	'
+
+test_expect_success 'init with -s/-T/-b/-t and --prefix does not warn' '
+	test ! -d project &&
+	git svn init -s "$svnrepo"/project project --prefix="" 2>warning &&
+	test_must_fail grep -q prefix warning &&
+	test_svn_configured_prefix "" &&
+	rm -rf project &&
+	rm -f warning
+	'
+
+test_expect_success 'clone with -s/-T/-b/-t and --prefix does not warn' '
+	test ! -d project &&
+	git svn clone -s "$svnrepo"/project --prefix="" 2>warning &&
+	test_must_fail grep -q prefix warning &&
+	test_svn_configured_prefix "" &&
+	rm -rf project &&
+	rm -f warning
+	'
+
 test_done
-- 
1.8.4.653.g2df02b3
