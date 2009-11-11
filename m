From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 2/9] Do not use VISUAL editor on dumb terminals
Date: Wed, 11 Nov 2009 17:56:07 -0600
Message-ID: <20091111235607.GC1140@progeny.tock>
References: <20091030101634.GA1610@progeny.tock>
 <20091031012050.GA5160@progeny.tock>
 <20091111235100.GA1140@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ben Walton <bwalton@artsci.utoronto.ca>,
	Johannes Sixt <j.sixt@viscovery.net>,
	David Roundy <roundyd@physics.oregonstate.edu>,
	GIT List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 12 00:46:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8Msz-00065V-O7
	for gcvg-git-2@lo.gmane.org; Thu, 12 Nov 2009 00:46:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757519AbZKKXpv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Nov 2009 18:45:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756222AbZKKXpu
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Nov 2009 18:45:50 -0500
Received: from mail-gx0-f226.google.com ([209.85.217.226]:45282 "EHLO
	mail-gx0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752526AbZKKXpu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Nov 2009 18:45:50 -0500
Received: by gxk26 with SMTP id 26so1566522gxk.1
        for <git@vger.kernel.org>; Wed, 11 Nov 2009 15:45:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=px3KNH3sV3kna72L7PKFQpQLWuOXR+3Lp4Y+iHc4rzg=;
        b=l5/SIzQRopOQeIN4mTv4ne53zYRjrOjn95ddjvm6EgGrw1RAs0lJsR0F119FfQvP6A
         uM1FjpZfHFAkgMvzhOHOUVgZz3ba3DG7XbWPFNyWbRTsnLlhv8kJlRRZwRCpp31+SFAe
         yVGmRdkFYRDA7QUXB482liSQfOEoPa6jXIO+Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=j39Xvmi+UnDNsXNt3ZOfXidPr6KzO9qqreIa/DYo+hT4WJu+hMfBzXqndKINpnHK6w
         kLIJq5+hGQ9LN/5JWOsAT2DBeOdQHie1vZ9iMfTbklOGUBNpKXXwGKJEgdxpsoh0zI6h
         V2nC4gPWWduiqL5rQjpMYcC9Xe2jsRmB5pLzU=
Received: by 10.90.176.16 with SMTP id y16mr3322149age.52.1257983155136;
        Wed, 11 Nov 2009 15:45:55 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 34sm1025410yxf.29.2009.11.11.15.45.52
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 11 Nov 2009 15:45:54 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20091111235100.GA1140@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132723>

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
---
Fixes broken sign-off, patch unchanged.

I am personally most interested in this for usage from a text editor,
but vim does not set TERM=dumb like it probably ought to.  A more
realistic everyday example might be "ssh user@domain git commit".

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
