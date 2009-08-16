From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] svn: assume URLs from the command-line are URI-encoded
Date: Sun, 16 Aug 2009 14:22:12 -0700
Message-ID: <20090816212212.GA19859@dcvr.yhbt.net>
References: <4A86F4DA.5090605@smullindesign.com> <20090815181637.GC19833@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mike Smullin <mike@smullindesign.com>,
	=?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 16 23:22:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1McnBF-00068q-4U
	for gcvg-git-2@lo.gmane.org; Sun, 16 Aug 2009 23:22:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756091AbZHPVWN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 16 Aug 2009 17:22:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755802AbZHPVWN
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Aug 2009 17:22:13 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:57800 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754091AbZHPVWM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Aug 2009 17:22:12 -0400
Received: from localhost (user-118bg0q.cable.mindspring.com [66.133.192.26])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by dcvr.yhbt.net (Postfix) with ESMTPSA id 4ECA21F5F7;
	Sun, 16 Aug 2009 21:22:13 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20090815181637.GC19833@atjola.homenet>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126078>

And then unescape them when writing to $GIT_CONFIG.

SVN has different rules for repository URLs (usually the root)
and for paths within that repository (below the HTTP layer).
Thus, for the request URI path at the HTTP level, the URI needs
to be encoded.  However, in the body of the HTTP request (the
with underlying SVN XML protocol), those paths should not be
URI-encoded[1].  For non-HTTP(S) requests, SVN appears to be
more flexible and will except weird characters in the URL as
well as URI-encoded ones.

Since users are used to using URLs being entirely URI-encoded,
git svn will now attempt to unescape the path portion of URLs
while leaving the actual repository URL untouched.

This change will be reflected in newly-created $GIT_CONFIG files
only.  This allows users to switch between svn(+ssh)://, file://
and http(s):// urls without changing the fetch/branches/tags
config keys.  This won't affect existing imports at all (since
things didn't work before this commit anyways), and will allow
users to force escaping into repository paths that look like
they're escaped (but are not).

Thanks to Mike Smullin for the original bug report and Bj=F6rn
Steinbrink for summarizing it into testable cases for me.

[1] Except when committing copies/renames, see
    commit 29633bb91c7bcff31ff3bb59378709e3e3ef627d

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---

 When I first wrote git svn back in early 2006, I remember
 telling a friend I hope I'd never have to deal with SVN ever
 again...

 git-svn.perl                                  |    2 +
 t/t9120-git-svn-clone-with-percent-escapes.sh |   52 +++++++++++++++++=
++++++++
 2 files changed, 54 insertions(+), 0 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index b0bfb74..5083c30 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -1211,6 +1211,7 @@ sub complete_url_ls_init {
 	}
 	command_oneline('config', $k, $gs->{url}) unless $orig_url;
 	my $remote_path =3D "$gs->{path}/$repo_path";
+	$remote_path =3D~ s{%([0-9A-F]{2})}{chr hex($1)}ieg;
 	$remote_path =3D~ s#/+#/#g;
 	$remote_path =3D~ s#^/##g;
 	$remote_path .=3D "/*" if $remote_path !~ /\*/;
@@ -1879,6 +1880,7 @@ sub init_remote_config {
 		command_noisy('config',
 			      "svn-remote.$self->{repo_id}.url", $url);
 		$self->{path} =3D~ s{^/}{};
+		$self->{path} =3D~ s{%([0-9A-F]{2})}{chr hex($1)}ieg;
 		command_noisy('config', '--add',
 			      "svn-remote.$self->{repo_id}.fetch",
 			      "$self->{path}:".$self->refname);
diff --git a/t/t9120-git-svn-clone-with-percent-escapes.sh b/t/t9120-gi=
t-svn-clone-with-percent-escapes.sh
index f159ab6..9d9ebd5 100755
--- a/t/t9120-git-svn-clone-with-percent-escapes.sh
+++ b/t/t9120-git-svn-clone-with-percent-escapes.sh
@@ -10,6 +10,10 @@ test_expect_success 'setup svnrepo' '
 	mkdir project project/trunk project/branches project/tags &&
 	echo foo > project/trunk/foo &&
 	svn_cmd import -m "$test_description" project "$svnrepo/pr ject" &&
+	svn_cmd cp -m "branch" "$svnrepo/pr ject/trunk" \
+	  "$svnrepo/pr ject/branches/b" &&
+	svn_cmd cp -m "tag" "$svnrepo/pr ject/trunk" \
+	  "$svnrepo/pr ject/tags/v1" &&
 	rm -rf project &&
 	start_httpd
 '
@@ -21,6 +25,54 @@ test_expect_success 'test clone with percent escapes=
' '
 	cd ..
 '
=20
+# SVN works either way, so should we...
+
+test_expect_success 'svn checkout with percent escapes' '
+	svn_cmd checkout "$svnrepo/pr%20ject" svn.percent &&
+	svn_cmd checkout "$svnrepo/pr%20ject/trunk" svn.percent.trunk
+'
+
+test_expect_success 'svn checkout with space' '
+	svn_cmd checkout "$svnrepo/pr ject" svn.space &&
+	svn_cmd checkout "$svnrepo/pr ject/trunk" svn.space.trunk
+'
+
+test_expect_success 'test clone trunk with percent escapes and minimiz=
e-url' '
+	git svn clone --minimize-url "$svnrepo/pr%20ject/trunk" minimize &&
+	(
+		cd minimize &&
+		git rev-parse refs/${remotes_git_svn}
+	)
+'
+
+test_expect_success 'test clone trunk with percent escapes' '
+	git svn clone "$svnrepo/pr%20ject/trunk" trunk &&
+	(
+		cd trunk &&
+		git rev-parse refs/${remotes_git_svn}
+	)
+'
+
+test_expect_success 'test clone --stdlayout with percent escapes' '
+	git svn clone --stdlayout "$svnrepo/pr%20ject" percent &&
+	(
+		cd percent &&
+		git rev-parse refs/remotes/trunk^0 &&
+		git rev-parse refs/remotes/b^0 &&
+		git rev-parse refs/remotes/tags/v1^0
+	)
+'
+
+test_expect_success 'test clone -s with unescaped space' '
+	git svn clone -s "$svnrepo/pr ject" space &&
+	(
+		cd space &&
+		git rev-parse refs/remotes/trunk^0 &&
+		git rev-parse refs/remotes/b^0 &&
+		git rev-parse refs/remotes/tags/v1^0
+	)
+'
+
 stop_httpd
=20
 test_done
--=20
Eric Wong
