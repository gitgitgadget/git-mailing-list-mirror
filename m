From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [RFC/PATCH] commit: update the index after running the pre-commit hook
Date: Wed, 18 Aug 2010 13:54:09 +0000
Message-ID: <1282139649-21097-1-git-send-email-avarab@gmail.com>
References: <6e4c323b0905031620m48769dbdp52684d6b470ebea3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Hinrik=20=C3=96rn=20Sigur=C3=B0sson?= 
	<hinrik.sig@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 18 15:55:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Olj6o-00005Y-0D
	for gcvg-git-2@lo.gmane.org; Wed, 18 Aug 2010 15:55:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753142Ab0HRNzJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 18 Aug 2010 09:55:09 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:40875 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751137Ab0HRNzG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Aug 2010 09:55:06 -0400
Received: by eyg5 with SMTP id 5so330118eyg.19
        for <git@vger.kernel.org>; Wed, 18 Aug 2010 06:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=uhdfnCPdV/t8nJFMJZzFtOFE2/V20RwCim+ki3RCiK0=;
        b=KS0BS+1ysrKc4H1xfGDF2KbZU5JZZpSbAn7yWrHzBmXkSyFrhpP4FDlSDkbYbdcY3q
         BmHe4lpdKgJP3QnBtkJ567oWCd/DufpO8eZ+sNqG6T1OFD9FLl3xxo6l7F2o4hFQxymL
         bcVsnSkLaJokPqhk2H9EYM7eRaONEHBUFC22k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=vYfbRw0VnOUI3ho+gfN7fWTA1MAr7yCE72Yg7jmkrNyfpAKRME5XRRcoLhE2QKWGSJ
         iDp4WCnnHZlc8VHZ5lj5k/c/Go6/40Ycr4rWiT3F1Ras46AxFxDtyClQHgb1zs3626KE
         p8k3DDcrAfQepAGQ362PXAH3xPkCS4Ui9mzes=
Received: by 10.216.12.8 with SMTP id 8mr2044594wey.107.1282139702752;
        Wed, 18 Aug 2010 06:55:02 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id p42sm209984weq.36.2010.08.18.06.55.01
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 18 Aug 2010 06:55:01 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1.414.g9bf49
In-Reply-To: <6e4c323b0905031620m48769dbdp52684d6b470ebea3@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153855>

Change git-commit to update the index after running the pre-commit
hook, but before it constructs the comments that'll accompany the
commit message displayed in the $EDITOR.

The use case for this is e.g. a pre-commit hook that looks like this:

    #!/bin/sh
    echo unf >>hlagh
    git add hlagh

In that case the $EDITOR will display "hlagh" under "Untracked files",
but it should be under "Changes to be committed:". Refreshing before
we construct the message fixes this bug.

Reported-by: Hinrik =C3=96rn Sigur=C3=B0sson <hinrik.sig@gmail.com>
Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---

2009/5/3 Hinrik =C3=96rn Sigur=C3=B0sson <hinrik.sig@gmail.com>:
> I have a pre-commit hook which extracts documentation from file $foo
> if it has pending changes to be committed. The hook creates/updates
> the documentation file and calls "git add" on it.
>
> When I do "git commit", the COMMIT_EDITMSG delivered to my editor
> notes that this documentation file has been created/updated, but not
> that its changes have been added to the index. However, if I go ahead
> with the commit, I can see that the doc file changes were indeed
> committed.
>
> Here is a simplified test case:
>
> $ cat .git/hooks/pre-commit
> #!/usr/bin/env perl
> use strict;
> use warnings;
>
> my $old =3D qx"git rev-parse HEAD:foo 2>/dev/null";
> my $new =3D qx"git rev-parse :foo 2>/dev/null";
>
> if (($? >> 8) !=3D 0 || $old ne $new) {
>    system "cat source > dest";
>    system "git add dest";
> }
>
> $ ls
> source
>
> $ echo 123 >> source
>
> $ git status
> # On branch master
> # Changed but not updated:
> #   (use "git add <file>..." to update what will be committed)
> #   (use "git checkout -- <file>..." to discard changes in working di=
rectory)
> #
> #       modified:   source
> #
> no changes added to commit (use "git add" and/or "git commit -a")
>
> $ git commit -a
> Test commit
> # Please enter the commit message for your changes. Lines starting
> # with '#' will be ignored, and an empty message aborts the commit.
> # On branch master
> # Changes to be committed:
> #   (use "git reset HEAD <file>..." to unstage)
> #
> #       modified:   source
> #
> # Untracked files:
> #   (use "git add <file>..." to include in what will be committed)
> #
> #       dest
> [master 535ed7f] Test commit
>  2 files changed, 3 insertions(+), 0 deletions(-)
>  create mode 100644 dest
>
> $ git status
> # On branch master
> nothing to commit (working directory clean)

Thanks for the report. Here's a proposed fix for this. I'm not
familiar with the commit code so this may be the wrong way to go, but
it fixes the bug and passes all tests.

The reporter has promised offlist to write a test for this.

 builtin/commit.c |   33 +++++++++++++++++++++++++--------
 1 files changed, 25 insertions(+), 8 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 66fdd22..dbb4ff5 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -550,6 +550,20 @@ static int ends_rfc2822_footer(struct strbuf *sb)
 	return 1;
 }
=20
+static int update_index(const char *index_file) {
+	discard_cache();
+	read_cache_from(index_file);
+	if (!active_cache_tree)
+		active_cache_tree =3D cache_tree();
+	if (cache_tree_update(active_cache_tree,
+			      active_cache, active_nr, 0, 0) < 0) {
+		error("Error building trees");
+		return 0;
+	}
+
+	return 1;
+}
+
 static int prepare_to_commit(const char *index_file, const char *prefi=
x,
 			     struct wt_status *s)
 {
@@ -565,6 +579,16 @@ static int prepare_to_commit(const char *index_fil=
e, const char *prefix,
 	if (!no_verify && run_hook(index_file, "pre-commit", NULL))
 		return 0;
=20
+	/* Update the index after we run the pre-commit hook, but before
+	 * we construct the message we're sending to the editor. The
+	 * pre-commit hook may e.g. create a new file and add it to the
+	 * index.
+	 *
+	 * Having that file show up as modified but not staged is confusing.
+	 */
+	if (!update_index(index_file))
+		return 0;
+
 	if (message.len) {
 		strbuf_addbuf(&sb, &message);
 		hook_arg1 =3D "message";
@@ -728,15 +752,8 @@ static int prepare_to_commit(const char *index_fil=
e, const char *prefix,
 	 * and write it out as a tree.  We must do this before we invoke
 	 * the editor and after we invoke run_status above.
 	 */
-	discard_cache();
-	read_cache_from(index_file);
-	if (!active_cache_tree)
-		active_cache_tree =3D cache_tree();
-	if (cache_tree_update(active_cache_tree,
-			      active_cache, active_nr, 0, 0) < 0) {
-		error("Error building trees");
+	if (!update_index(index_file))
 		return 0;
-	}
=20
 	if (run_hook(index_file, "prepare-commit-msg",
 		     git_path(commit_editmsg), hook_arg1, hook_arg2, NULL))
--=20
1.7.2.1.414.g9bf49
