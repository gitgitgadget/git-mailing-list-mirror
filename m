From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] Fix commit-msg hook to allow editing
Date: Sat, 08 Dec 2007 23:21:34 -0800
Message-ID: <7vtzmss58h.fsf@gitster.siamese.dyndns.org>
References: <1197113889-16243-1-git-send-email-win@wincent.com>
	<1197113889-16243-2-git-send-email-win@wincent.com>
	<1197113889-16243-3-git-send-email-win@wincent.com>
	<1197113889-16243-4-git-send-email-win@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, krh@redhat.com
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Sun Dec 09 08:22:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1GUy-0001xg-8e
	for gcvg-git-2@gmane.org; Sun, 09 Dec 2007 08:22:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750905AbXLIHW0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Dec 2007 02:22:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751201AbXLIHW0
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Dec 2007 02:22:26 -0500
Received: from a-sasl-quonix.pobox.com ([208.72.237.25]:45237 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750884AbXLIHWZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Dec 2007 02:22:25 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 78A38445A;
	Sun,  9 Dec 2007 02:22:18 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id E9B7B4458;
	Sun,  9 Dec 2007 02:21:35 -0500 (EST)
In-Reply-To: <1197113889-16243-4-git-send-email-win@wincent.com> (Wincent
	Colaiuta's message of "Sat, 8 Dec 2007 12:38:09 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67599>

Wincent Colaiuta <win@wincent.com> writes:

> The old git-commit.sh script allowed the commit-msg hook to not only
> prevent a commit from proceding, but also to edit the commit message
> on the fly and allow it to proceed. So here we teach builtin-commit
> to do the same.

This is a bit unfortunate.

> @@ -787,14 +787,18 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
>  		const char *env[2] = { index, NULL };
>  		snprintf(index, sizeof(index), "GIT_INDEX_FILE=%s", index_file);
>  		launch_editor(git_path(commit_editmsg), &sb, env);

Here, launch-editor lets the user edit an external file, and reads it
back into &sb, but ...

>  	}
> +	if (!no_verify) {
> +		if (run_hook(index_file, "commit-msg", git_path(commit_editmsg))) {
> +			rollback_index_files();
> +			exit(1);
> +		}
> +		strbuf_setlen(&sb, header_len);
> +	}

we need to discard it (I would prefer setlen to be done before running
the hook, just to make the logic flow more natural), because we need to
read it back again anyway.  On the other hand, if we do not start the
editor, we used to read the contents before running the hook, which was
wrong, and the call to read the file is moved after, like this:

> +	if ((no_edit || !no_verify) &&
> +	    strbuf_read_file(&sb, git_path(commit_editmsg), 0) < 0) {
>  		rollback_index_files();
> +		die("could not read commit message");
>  	}

which makes the logic to decide if we read the file back again
unnecessarily convoluted.  The reason why (no_edit || !no_verify) is
there is very closely tied to the fact that you happened to have already
read in the launch_editor() codepath but not yet in no_edit codepath.
This feels very error prone.

	Side note. an unrelated reason where this convolution comes from
	is the unfortunate naming of many options and double-negations
	they bring in.  A normal human being needs to read expressions
	like "if (!no_foo || no_foo)" three times before understanding
	what is being checked.

I would suggest doing the above differently.

 * Allow launch_editor() not to read back the edited result into strbuf
   at all (perhaps pass NULL to signal that), and make "if (!no_edit)"
   codepath use it;

 * The codeflow would become:

	if (!no_edit) {
		launch editor, in "no readback" mode;
	}
	if (!no_verify) {
        	run hook, let it interfere;
	}
	read the file to &sb, no matter what no_edit/no_verify says.

IOW, how about something like this?

---

 builtin-commit.c |    9 +++++----
 builtin-tag.c    |    2 ++
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/builtin-commit.c b/builtin-commit.c
index 2032ca3..30a9deb 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -787,16 +787,17 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		char index[PATH_MAX];
 		const char *env[2] = { index, NULL };
 		snprintf(index, sizeof(index), "GIT_INDEX_FILE=%s", index_file);
-		launch_editor(git_path(commit_editmsg), &sb, env);
-	} else if (strbuf_read_file(&sb, git_path(commit_editmsg), 0) < 0) {
-		rollback_index_files();
-		die("could not read commit message");
+		launch_editor(git_path(commit_editmsg), NULL, env);
 	}
 	if (!no_verify &&
 	    run_hook(index_file, "commit-msg", git_path(commit_editmsg))) {
 		rollback_index_files();
 		exit(1);
 	}
+	if (strbuf_read_file(&sb, git_path(commit_editmsg), 0) < 0) {
+		rollback_index_files();
+		die("could not read commit message");
+	}
 
 	/* Truncate the message just before the diff, if any. */
 	p = strstr(sb.buf, "\ndiff --git a/");
diff --git a/builtin-tag.c b/builtin-tag.c
index 729389b..9f966fc 100644
--- a/builtin-tag.c
+++ b/builtin-tag.c
@@ -53,6 +53,8 @@ void launch_editor(const char *path, struct strbuf *buffer, const char *const *e
 			die("There was a problem with the editor %s.", editor);
 	}
 
+	if (!buffer)
+		return;
 	if (strbuf_read_file(buffer, path, 0) < 0)
 		die("could not read message file '%s': %s",
 		    path, strerror(errno));


                
