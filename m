From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH v2 2/8] Do not use VISUAL editor on dumb terminals
Date: Sat, 31 Oct 2009 02:46:24 -0500
Message-ID: <20091031074624.GA635@progeny.tock>
References: <20091030101634.GA1610@progeny.tock>
 <20091031012050.GA5160@progeny.tock>
 <20091031013039.GC5160@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ben Walton <bwalton@artsci.utoronto.ca>,
	Johannes Sixt <j.sixt@viscovery.net>,
	David Roundy <roundyd@physics.oregonstate.edu>,
	GIT List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 31 08:36:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N48Ve-00060Y-79
	for gcvg-git-2@lo.gmane.org; Sat, 31 Oct 2009 08:36:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753489AbZJaHgH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Oct 2009 03:36:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753445AbZJaHgG
	(ORCPT <rfc822;git-outgoing>); Sat, 31 Oct 2009 03:36:06 -0400
Received: from mail-yx0-f187.google.com ([209.85.210.187]:37812 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753396AbZJaHgF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Oct 2009 03:36:05 -0400
Received: by yxe17 with SMTP id 17so3330573yxe.33
        for <git@vger.kernel.org>; Sat, 31 Oct 2009 00:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=w7yC9GNiZjJhemUMwdFQUlSjqncS2oCj9nLbn4bEGwQ=;
        b=GxXdmBGlW9tGkPPakfInY2IgnGLyNo8DMw/8pTQflQt/T48BemFWHS5SzmF1/MhIz7
         /GKF/nNYpbsM4Q+bZMbKp/rRk5EuKOvix1hCSN1WLqaom/gPPGS6S9cHjITrxxWcmHE7
         6maLzo5zeuHoocojQe5JwJkQq33pLBcAx0Kac=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=AJ8rNVugHehPgnSqBmG13/KjjNj9Uq5LBODm2J93s2NW2LdifwGFjg1g1y7qkIm0PO
         LiK8KwQjZJ0+vyepDbt6qdMn5fKFNSwvqZjIh3ejlbsfZKN7SZH8z+VxtCAevWWS3aR6
         p5CwV7eJ4WMrHnaIkBBp22qjzuJa9KpJBwsTo=
Received: by 10.90.127.20 with SMTP id z20mr6152485agc.118.1256974568291;
        Sat, 31 Oct 2009 00:36:08 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 4sm1696964yxd.16.2009.10.31.00.36.06
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 31 Oct 2009 00:36:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20091031013039.GC5160@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131836>

Jonathan Nieder wrote:

> Refuse to use $VISUAL and fall back to $EDITOR if TERM is unset
> or set to "dumb".  Traditionally, VISUAL is set to a screen
> editor and EDITOR to a line-based editor, which should be more
> useful in that situation.

I was too lazy to wait for tests to finish on this one, and lo and
behold, they did not pass.

These additional changes seem to help, and they also add a test to
explain the change in editor behavior.  The patch with these changes
squashed is also included in this message, below the scissors mark.

In the controlled environment used for tests, TERM is set to dumb
and ever since commit 02b3566 (test-lib.sh: Add a test_set_editor
function to safely set $VISUAL, 2008-05-04), most tests set VISUAL
when they want to set an editor for git to use.  With this patch, they
should be using EDITOR instead.

--- a/t/t7005-editor.sh
+++ b/t/t7005-editor.sh
@@ -42,6 +42,16 @@ test_expect_success 'dumb should error out when falling back on vi' '
 	fi
 '
 
+test_expect_success 'dumb should prefer EDITOR to VISUAL' '
+
+	EDITOR=./e-EDITOR.sh &&
+	VISUAL=./e-VISUAL.sh &&
+	export EDITOR VISUAL &&
+	git commit --amend &&
+	test "$(git show -s --format=%s)" = "Edited by EDITOR"
+
+'
+
 TERM=vt100
 export TERM
 for i in vi EDITOR VISUAL core_editor GIT_EDITOR
--- a/t/t7501-commit.sh
+++ b/t/t7501-commit.sh
@@ -86,7 +86,7 @@ chmod 755 editor
 
 test_expect_success \
 	"amend commit" \
-	"VISUAL=./editor git commit --amend"
+	"EDITOR=./editor git commit --amend"
 
 test_expect_success \
 	"passing -m and -F" \
@@ -107,7 +107,7 @@ chmod 755 editor
 test_expect_success \
 	"editing message from other commit" \
 	"echo 'hula hula' >file && \
-	 VISUAL=./editor git commit -c HEAD^ -a"
+	 EDITOR=./editor git commit -c HEAD^ -a"
 
 test_expect_success \
 	"message from stdin" \
@@ -141,10 +141,10 @@ EOF
 test_expect_success \
 	'editor not invoked if -F is given' '
 	 echo "moo" >file &&
-	 VISUAL=./editor git commit -a -F msg &&
+	 EDITOR=./editor git commit -a -F msg &&
 	 git show -s --pretty=format:"%s" | grep -q good &&
 	 echo "quack" >file &&
-	 echo "Another good message." | VISUAL=./editor git commit -a -F - &&
+	 echo "Another good message." | EDITOR=./editor git commit -a -F - &&
 	 git show -s --pretty=format:"%s" | grep -q good
 	 '
 # We could just check the head sha1, but checking each commit makes it
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -30,7 +30,7 @@ TZ=UTC
 TERM=dumb
 export LANG LC_ALL PAGER TERM TZ
 EDITOR=:
-VISUAL=:
+unset VISUAL
 unset GIT_EDITOR
 unset AUTHOR_DATE
 unset AUTHOR_EMAIL
@@ -58,7 +58,7 @@ GIT_MERGE_VERBOSITY=5
 export GIT_MERGE_VERBOSITY
 export GIT_AUTHOR_EMAIL GIT_AUTHOR_NAME
 export GIT_COMMITTER_EMAIL GIT_COMMITTER_NAME
-export EDITOR VISUAL
+export EDITOR
 GIT_TEST_CMP=${GIT_TEST_CMP:-diff -u}
 
 # Protect ourselves from common misconfiguration to export
@@ -207,8 +207,8 @@ trap 'die' EXIT
 test_set_editor () {
 	FAKE_EDITOR="$1"
 	export FAKE_EDITOR
-	VISUAL='"$FAKE_EDITOR"'
-	export VISUAL
+	EDITOR='"$FAKE_EDITOR"'
+	export EDITOR
 }
 
 test_tick () {

-- %< --
Subject: [PATCH] Do not use VISUAL editor on dumb terminals

Refuse to use $VISUAL and fall back to $EDITOR if TERM is unset
or set to "dumb".  Traditionally, VISUAL is set to a screen
editor and EDITOR to a line-based editor, which should be more
useful in that situation.

vim, for example, is happy to assume a terminal supports ANSI
sequences even if TERM is dumb (e.g., when running from a text
editor like Acme).  git already refuses to fall back to vi on a
dumb terminal if GIT_EDITOR, core.editor, VISUAL, and EDITOR are
unset, but without this patch, that check is suppressed by
VISUAL=vi.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Jonathan Nieder <jrn@progeny.tock>
---

 editor.c          |   12 ++++++------
 t/t7005-editor.sh |   10 ++++++++++
 t/t7501-commit.sh |    8 ++++----
 t/test-lib.sh     |    8 ++++----
 4 files changed, 24 insertions(+), 14 deletions(-)

diff --git a/editor.c b/editor.c
index 941c0b2..3f13751 100644
--- a/editor.c
+++ b/editor.c
@@ -4,19 +4,19 @@
 
 int launch_editor(const char *path, struct strbuf *buffer, const char *const *env)
 {
-	const char *editor, *terminal;
+	const char *editor = getenv("GIT_EDITOR");
+	const char *terminal = getenv("TERM");
+	int terminal_is_dumb = !terminal || !strcmp(terminal, "dumb");
 
-	editor = getenv("GIT_EDITOR");
 	if (!editor && editor_program)
 		editor = editor_program;
-	if (!editor)
+	if (!editor && !terminal_is_dumb)
 		editor = getenv("VISUAL");
 	if (!editor)
 		editor = getenv("EDITOR");
 
-	terminal = getenv("TERM");
-	if (!editor && (!terminal || !strcmp(terminal, "dumb")))
-		return error("Terminal is dumb but no VISUAL nor EDITOR defined.");
+	if (!editor && terminal_is_dumb)
+		return error("terminal is dumb, but EDITOR unset");
 
 	if (!editor)
 		editor = "vi";
diff --git a/t/t7005-editor.sh b/t/t7005-editor.sh
index b647957..a95fe19 100755
--- a/t/t7005-editor.sh
+++ b/t/t7005-editor.sh
@@ -42,6 +42,16 @@ test_expect_success 'dumb should error out when falling back on vi' '
 	fi
 '
 
+test_expect_success 'dumb should prefer EDITOR to VISUAL' '
+
+	EDITOR=./e-EDITOR.sh &&
+	VISUAL=./e-VISUAL.sh &&
+	export EDITOR VISUAL &&
+	git commit --amend &&
+	test "$(git show -s --format=%s)" = "Edited by EDITOR"
+
+'
+
 TERM=vt100
 export TERM
 for i in vi EDITOR VISUAL core_editor GIT_EDITOR
diff --git a/t/t7501-commit.sh b/t/t7501-commit.sh
index d2de576..a603f6d 100755
--- a/t/t7501-commit.sh
+++ b/t/t7501-commit.sh
@@ -86,7 +86,7 @@ chmod 755 editor
 
 test_expect_success \
 	"amend commit" \
-	"VISUAL=./editor git commit --amend"
+	"EDITOR=./editor git commit --amend"
 
 test_expect_success \
 	"passing -m and -F" \
@@ -107,7 +107,7 @@ chmod 755 editor
 test_expect_success \
 	"editing message from other commit" \
 	"echo 'hula hula' >file && \
-	 VISUAL=./editor git commit -c HEAD^ -a"
+	 EDITOR=./editor git commit -c HEAD^ -a"
 
 test_expect_success \
 	"message from stdin" \
@@ -141,10 +141,10 @@ EOF
 test_expect_success \
 	'editor not invoked if -F is given' '
 	 echo "moo" >file &&
-	 VISUAL=./editor git commit -a -F msg &&
+	 EDITOR=./editor git commit -a -F msg &&
 	 git show -s --pretty=format:"%s" | grep -q good &&
 	 echo "quack" >file &&
-	 echo "Another good message." | VISUAL=./editor git commit -a -F - &&
+	 echo "Another good message." | EDITOR=./editor git commit -a -F - &&
 	 git show -s --pretty=format:"%s" | grep -q good
 	 '
 # We could just check the head sha1, but checking each commit makes it
diff --git a/t/test-lib.sh b/t/test-lib.sh
index f2ca536..ec3336a 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -30,7 +30,7 @@ TZ=UTC
 TERM=dumb
 export LANG LC_ALL PAGER TERM TZ
 EDITOR=:
-VISUAL=:
+unset VISUAL
 unset GIT_EDITOR
 unset AUTHOR_DATE
 unset AUTHOR_EMAIL
@@ -58,7 +58,7 @@ GIT_MERGE_VERBOSITY=5
 export GIT_MERGE_VERBOSITY
 export GIT_AUTHOR_EMAIL GIT_AUTHOR_NAME
 export GIT_COMMITTER_EMAIL GIT_COMMITTER_NAME
-export EDITOR VISUAL
+export EDITOR
 GIT_TEST_CMP=${GIT_TEST_CMP:-diff -u}
 
 # Protect ourselves from common misconfiguration to export
@@ -207,8 +207,8 @@ trap 'die' EXIT
 test_set_editor () {
 	FAKE_EDITOR="$1"
 	export FAKE_EDITOR
-	VISUAL='"$FAKE_EDITOR"'
-	export VISUAL
+	EDITOR='"$FAKE_EDITOR"'
+	export EDITOR
 }
 
 test_tick () {
-- 
1.6.5.2

> 
> vim, for example, is happy to assume a terminal supports ANSI
> sequences even if TERM is dumb (e.g., when running from a text
> editor like Acme).  git already refuses to fall back to vi on a
> dumb terminal if GIT_EDITOR, core.editor, VISUAL, and EDITOR are
> unset, but without this patch, that check is suppressed by
> VISUAL=vi.
> 
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
> This patch eases my discomfort about the error message a little.  It
> is not actually needed to support any ways of working I engage in.
> 
> If stdout is redirected, this is probably still making the wrong
> choice; isatty(STDOUT_FILENO) might be a more useful datum to use.
> But it does not seem worth complicating the logic further.
> 
>  editor.c |   12 ++++++------
>  1 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/editor.c b/editor.c
> index 941c0b2..3f13751 100644
> --- a/editor.c
> +++ b/editor.c
> @@ -4,19 +4,19 @@
>  
>  int launch_editor(const char *path, struct strbuf *buffer, const char *const *env)
>  {
> -	const char *editor, *terminal;
> +	const char *editor = getenv("GIT_EDITOR");
> +	const char *terminal = getenv("TERM");
> +	int terminal_is_dumb = !terminal || !strcmp(terminal, "dumb");
>  
> -	editor = getenv("GIT_EDITOR");
>  	if (!editor && editor_program)
>  		editor = editor_program;
> -	if (!editor)
> +	if (!editor && !terminal_is_dumb)
>  		editor = getenv("VISUAL");
>  	if (!editor)
>  		editor = getenv("EDITOR");
>  
> -	terminal = getenv("TERM");
> -	if (!editor && (!terminal || !strcmp(terminal, "dumb")))
> -		return error("Terminal is dumb but no VISUAL nor EDITOR defined.");
> +	if (!editor && terminal_is_dumb)
> +		return error("terminal is dumb, but EDITOR unset");
>  
>  	if (!editor)
>  		editor = "vi";
> -- 
> 1.6.5.2
> 
