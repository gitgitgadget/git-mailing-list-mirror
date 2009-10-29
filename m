From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH/RFC 2/2] Provide a build time default-editor setting
Date: Thu, 29 Oct 2009 02:50:22 -0500
Message-ID: <20091029075021.GC15403@progeny.tock>
References: <1256742357-sup-3798@ntdws12.chass.utoronto.ca>
 <7vskd3o11t.fsf@alter.siamese.dyndns.org>
 <20091029073224.GA15403@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ben Walton <bwalton@artsci.utoronto.ca>,
	GIT List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 29 08:40:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3PcU-00054U-IJ
	for gcvg-git-2@lo.gmane.org; Thu, 29 Oct 2009 08:40:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751864AbZJ2HkU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 29 Oct 2009 03:40:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751834AbZJ2HkT
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Oct 2009 03:40:19 -0400
Received: from mail-yx0-f187.google.com ([209.85.210.187]:49734 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751757AbZJ2HkR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Oct 2009 03:40:17 -0400
Received: by yxe17 with SMTP id 17so1439179yxe.33
        for <git@vger.kernel.org>; Thu, 29 Oct 2009 00:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=PHkpV8ByPYK1VNlnaWHudGQ6+3IHL33UWE/s3ysEQKw=;
        b=RT9SSQAvUkkGQCV4DDix43Pl8wCG57b8rY5zdI9pOvEwMD6JlGrJI34jZ/BkgzKlwk
         tCY9H4csWSfWo1JObXGKJYc7uAqE0W1DVaqenRYilIfHUQYzYjhZIDgc5Uphffx77ihX
         F0sbtdIDUwOpvNCt2QVm+qUU3sBEKF0kraBks=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=Zs9PzrgBxIIrRrtfxbpKCGgTrypwjMVBfd979qo5r8aiyFErUDIO1+uNFMkSvSqXyM
         hHUKDHeZE0YfiHyzX7eBXFArNMTBOKdn3cShNbCIAoMrcqvmgAfU1OyUbZiLTvsAFFt3
         rDr2sBFtYkWDSu9h4earR6LXoB1WHdCG3WOgM=
Received: by 10.90.38.26 with SMTP id l26mr789225agl.30.1256802022491;
        Thu, 29 Oct 2009 00:40:22 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 8sm789951yxb.43.2009.10.29.00.40.21
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 29 Oct 2009 00:40:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20091029073224.GA15403@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131571>

Provide a DEFAULT_EDITOR knob to allow the fallback editor (to
use instead of vi if VISUAL, EDITOR, and GIT_EDITOR are unset) to
be set at build time according to a system=E2=80=99s policy.  For
example, on Debian systems, the default editor should be the
'editor' command.

The contrib/fast-import/git-p4 script still uses vi, since it is
not modified by the Makefile currently, and making it require
build-time modification would create too much trouble for people
deploying that script.

This change makes t7005-editor into a mess.  Any ideas for fixing
this?

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Makefile                  |   10 ++++++++++
 editor.c                  |    2 +-
 git-add--interactive.perl |    3 ++-
 git-sh-setup.sh           |    6 ++++--
 git-svn.perl              |    5 +++--
 t/Makefile                |    2 ++
 t/t7005-editor.sh         |   29 ++++++++++++++++++++++-------
 7 files changed, 44 insertions(+), 13 deletions(-)

diff --git a/Makefile b/Makefile
index fc1a461..fae8647 100644
--- a/Makefile
+++ b/Makefile
@@ -203,6 +203,9 @@ all::
 #
 # Define DEFAULT_PAGER to the path of a sensible pager (defaults to "l=
ess") if
 # you want to use something different.
+#
+# Define DEFAULT_EDITOR to a sensible editor command (defaults to "vi"=
) if you
+# want to use something different.
=20
 GIT-VERSION-FILE: .FORCE-GIT-VERSION-FILE
 	@$(SHELL_PATH) ./GIT-VERSION-GEN
@@ -1301,6 +1304,11 @@ ifndef DEFAULT_PAGER
 	DEFAULT_PAGER =3D less
 endif
 BASIC_CFLAGS +=3D -DDEFAULT_PAGER=3D'"$(DEFAULT_PAGER)"'
+ifndef DEFAULT_EDITOR
+	DEFAULT_EDITOR =3D vi
+endif
+export DEFAULT_EDITOR
+BASIC_CFLAGS +=3D -DDEFAULT_EDITOR=3D'"$(DEFAULT_EDITOR)"'
=20
 ifdef USE_NED_ALLOCATOR
        COMPAT_CFLAGS +=3D -DUSE_NED_ALLOCATOR -DOVERRIDE_STRDUP -DNDEB=
UG -DREPLACE_SYSTEM_ALLOCATOR -Icompat/nedmalloc
@@ -1435,6 +1443,7 @@ $(patsubst %.sh,%,$(SCRIPT_SH)) : % : %.sh
 	    -e 's|@SHELL_PATH@|$(SHELL_PATH_SQ)|' \
 	    -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
 	    -e 's/@@NO_CURL@@/$(NO_CURL)/g' \
+	    -e 's|DEFAULT_EDITOR:=3Dvi|DEFAULT_EDITOR:=3D$(DEFAULT_EDITOR)|' =
\
 	    -e $(BROKEN_PATH_FIX) \
 	    $@.sh >$@+ && \
 	chmod +x $@+ && \
@@ -1459,6 +1468,7 @@ $(patsubst %.perl,%,$(SCRIPT_PERL)): % : %.perl
 	    -e 's|@@INSTLIBDIR@@|'"$$INSTLIBDIR"'|g' \
 	    -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
 	    -e 's/@@DEFAULT_PAGER@@/$(DEFAULT_PAGER)/g' \
+	    -e 's/@@DEFAULT_EDITOR@@/$(DEFAULT_EDITOR)/g' \
 	    $@.perl >$@+ && \
 	chmod +x $@+ && \
 	mv $@+ $@
diff --git a/editor.c b/editor.c
index 4d469d0..93b8cbb 100644
--- a/editor.c
+++ b/editor.c
@@ -19,7 +19,7 @@ int launch_editor(const char *path, struct strbuf *bu=
ffer, const char *const *en
 		return error("Terminal is dumb but no VISUAL nor EDITOR defined.");
=20
 	if (!editor)
-		editor =3D "vi";
+		editor =3D DEFAULT_EDITOR;
=20
 	if (strcmp(editor, ":")) {
 		size_t len =3D strlen(editor);
diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 69aeaf0..c3d932c 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -1,6 +1,7 @@
 #!/usr/bin/perl -w
=20
 use strict;
+use constant DEFAULT_EDITOR =3D> '@@DEFAULT_EDITOR@@';
 use Git;
=20
 binmode(STDOUT, ":raw");
@@ -988,7 +989,7 @@ EOF
 	close $fh;
=20
 	my $editor =3D $ENV{GIT_EDITOR} || $repo->config("core.editor")
-		|| $ENV{VISUAL} || $ENV{EDITOR} || "vi";
+		|| $ENV{VISUAL} || $ENV{EDITOR} || DEFAULT_EDITOR;
 	system('sh', '-c', $editor.' "$@"', $editor, $hunkfile);
=20
 	if ($? !=3D 0) {
diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index c41c2f7..d053d56 100755
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -99,19 +99,21 @@ set_reflog_action() {
 }
=20
 git_editor() {
+	: "${DEFAULT_EDITOR:=3Dvi}"
 	: "${GIT_EDITOR:=3D$(git config core.editor)}"
 	: "${GIT_EDITOR:=3D${VISUAL:-${EDITOR}}}"
 	case "$GIT_EDITOR,$TERM" in
 	,dumb)
 		echo >&2 "No editor specified in GIT_EDITOR, core.editor, VISUAL,"
-		echo >&2 "or EDITOR. Tried to fall back to vi but terminal is dumb."
+		echo >&2 "or EDITOR. Tried to fall back to $DEFAULT_EDITOR" \
+			"but terminal is dumb."
 		echo >&2 "Please set one of these variables to an appropriate"
 		echo >&2 "editor or run $0 with options that will not cause an"
 		echo >&2 "editor to be invoked (e.g., -m or -F for git-commit)."
 		exit 1
 		;;
 	esac
-	eval "${GIT_EDITOR:=3Dvi}" '"$@"'
+	eval "${GIT_EDITOR:=3D$DEFAULT_EDITOR}" '"$@"'
 }
=20
 is_bare_repository () {
diff --git a/git-svn.perl b/git-svn.perl
index c270b23..b98d378 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -3,12 +3,13 @@
 # License: GPL v2 or later
 use warnings;
 use strict;
-use vars qw/	$AUTHOR $VERSION $DEFAULT_PAGER
+use vars qw/	$AUTHOR $VERSION $DEFAULT_PAGER $DEFAULT_EDITOR
 		$sha1 $sha1_short $_revision $_repository
 		$_q $_authors $_authors_prog %users/;
 $AUTHOR =3D 'Eric Wong <normalperson@yhbt.net>';
 $VERSION =3D '@@GIT_VERSION@@';
 $DEFAULT_PAGER =3D '@@DEFAULT_PAGER@@';
+$DEFAULT_EDITOR =3D '@@DEFAULT_EDITOR@@';
=20
 # From which subdir have we been invoked?
 my $cmd_dir_prefix =3D eval {
@@ -1322,7 +1323,7 @@ sub get_commit_entry {
 	close $log_fh or croak $!;
=20
 	if ($_edit || ($type eq 'tree')) {
-		my $editor =3D $ENV{VISUAL} || $ENV{EDITOR} || 'vi';
+		my $editor =3D $ENV{VISUAL} || $ENV{EDITOR} || $DEFAULT_EDITOR;
 		# TODO: strip out spaces, comments, like git-commit.sh
 		system($editor, $commit_editmsg);
 	}
diff --git a/t/Makefile b/t/Makefile
index bd09390..9174bbb 100644
--- a/t/Makefile
+++ b/t/Makefile
@@ -9,6 +9,8 @@
 SHELL_PATH ?=3D $(SHELL)
 TAR ?=3D $(TAR)
 RM ?=3D rm -f
+DEFAULT_EDITOR ?=3D vi
+export DEFAULT_EDITOR
=20
 # Shell quote;
 SHELL_PATH_SQ =3D $(subst ','\'',$(SHELL_PATH))
diff --git a/t/t7005-editor.sh b/t/t7005-editor.sh
index b647957..2b76f72 100755
--- a/t/t7005-editor.sh
+++ b/t/t7005-editor.sh
@@ -4,7 +4,18 @@ test_description=3D'GIT_EDITOR, core.editor, and stuff=
'
=20
 . ./test-lib.sh
=20
-for i in GIT_EDITOR core_editor EDITOR VISUAL vi
+: ${DEFAULT_EDITOR=3Dvi}
+
+unset EDITOR VISUAL GIT_EDITOR
+
+case "$DEFAULT_EDITOR" in
+*/* | [A-Z]*)
+	DEFAULT_EDITOR=3D
+	;;
+esac
+
+for i in GIT_EDITOR core_editor EDITOR VISUAL \
+	${DEFAULT_EDITOR:+"$DEFAULT_EDITOR"}
 do
 	cat >e-$i.sh <<-EOF
 	#!$SHELL_PATH
@@ -12,15 +23,17 @@ do
 	EOF
 	chmod +x e-$i.sh
 done
-unset vi
-mv e-vi.sh vi
-unset EDITOR VISUAL GIT_EDITOR
+
+if test -n "$DEFAULT_EDITOR"
+then
+	mv "e-$DEFAULT_EDITOR.sh" "$DEFAULT_EDITOR"
+fi
=20
 test_expect_success setup '
=20
 	msg=3D"Hand edited" &&
 	echo "$msg" >expect &&
-	git add vi &&
+	git add "e-VISUAL.sh" &&
 	test_tick &&
 	git commit -m "$msg" &&
 	git show -s --pretty=3Doneline |
@@ -44,7 +57,8 @@ test_expect_success 'dumb should error out when falli=
ng back on vi' '
=20
 TERM=3Dvt100
 export TERM
-for i in vi EDITOR VISUAL core_editor GIT_EDITOR
+for i in ${DEFAULT_EDITOR:+"$DEFAULT_EDITOR"} \
+	EDITOR VISUAL core_editor GIT_EDITOR
 do
 	echo "Edited by $i" >expect
 	unset EDITOR VISUAL GIT_EDITOR
@@ -68,7 +82,8 @@ done
=20
 unset EDITOR VISUAL GIT_EDITOR
 git config --unset-all core.editor
-for i in vi EDITOR VISUAL core_editor GIT_EDITOR
+for i in ${DEFAULT_EDITOR:+"$DEFAULT_EDITOR"} \
+	EDITOR VISUAL core_editor GIT_EDITOR
 do
 	echo "Edited by $i" >expect
 	case "$i" in
--=20
1.6.5.2
