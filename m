From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH] Introduce a hook to run after formatting patches
Date: Sat, 15 Nov 2014 10:44:43 -0000
Organization: OPDS
Message-ID: <B4E02729E7DE4F90BC6F1A065A7D4D5D@PhilipOakley>
References: <1416012460-4459-1-git-send-email-sbeller@google.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Stefan Beller" <sbeller@google.com>
To: "Stefan Beller" <sbeller@google.com>, <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Nov 15 11:44:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xpapr-00079u-F3
	for gcvg-git-2@plane.gmane.org; Sat, 15 Nov 2014 11:44:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753286AbaKOKoB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Nov 2014 05:44:01 -0500
Received: from out1.ip01ir2.opaltelecom.net ([62.24.128.237]:57939 "EHLO
	out1.ip01ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752191AbaKOKn7 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 15 Nov 2014 05:43:59 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: ApMJAE8tZ1QCYJEfPGdsb2JhbABbgw5VWYhBxFOHRAQEAoEVFwEBAQEBAQUBAQEBODuDfQYBAQQIAQEdER4BASELAgMFAgEDDgcMJRQBBBoGBwMUBgESCAIBAgMBiDQJwX2PHgEBAQEGAQEBAQEZBJEigzSBHgWFJQKGLIZ0ZoN1iF6RPIgGPTCCSwEBAQ
X-IPAS-Result: ApMJAE8tZ1QCYJEfPGdsb2JhbABbgw5VWYhBxFOHRAQEAoEVFwEBAQEBAQUBAQEBODuDfQYBAQQIAQEdER4BASELAgMFAgEDDgcMJRQBBBoGBwMUBgESCAIBAgMBiDQJwX2PHgEBAQEGAQEBAQEZBJEigzSBHgWFJQKGLIZ0ZoN1iF6RPIgGPTCCSwEBAQ
X-IronPort-AV: E=Sophos;i="5.07,391,1413241200"; 
   d="scan'208";a="763028482"
Received: from host-2-96-145-31.as13285.net (HELO PhilipOakley) ([2.96.145.31])
  by out1.ip01ir2.opaltelecom.net with SMTP; 15 Nov 2014 10:43:54 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Stefan Beller" <sbeller@google.com>
> This comes in handy if you want to post-process formatted patches.
> One examplary use case would be removing ChangeIds, which are used
> in Gerrit, a program sitting on top of Git, used for tracking
> different versions of a patch.
>
> Another use case would be checking if all your commits are signed off,
> or have another kind of property.
>
> So in my case a hook like the following will help a lot.
>
> # Run with on formatted patches. The first argument is the filename to 
> the patch.
> sed --in-place '/^Change-Id:/d' $1
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>
> Hi Git people,
> I haven't sent a patch for some time now, but I intend to change that
> soon, as I'll be overtaking the transactions series from Ronnie 
> Sahlberg.
>
> The patch series I intend to overtake has been reviewed on this list
> as well as https://code-review.googlesource.com/#/q/project:git
> using Gerrit. Gerrit uses Change-Ids, which I want to reliably
> remove before sending them on the list. And for reliability
> you better trust a machine than a human like me.
>
> Documentation/githooks.txt |  9 +++++++++
> builtin/log.c              | 17 +++++++++++++----
> 2 files changed, 22 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
> index 9ef2469..b4f06a9 100644
> --- a/Documentation/githooks.txt
> +++ b/Documentation/githooks.txt
> @@ -69,6 +69,15 @@ and is invoked after the patch is applied and a 
> commit is made.
> This hook is meant primarily for notification, and cannot affect
> the outcome of 'git am'.
>
> +post-format-patch
> +~~~~~~~~~~~~
> +
> +This hook is called after format-patch created a patch and it is
> +invoked with the filename of the patch as the first parameter.
> +
> +This hook can be used to alter the created patch, such as removing
> +or adding Sign-Offs or similar information.

surely   s/adding/checking/  as described in the commit message.
We wouldn't want unthinking sign-offs being applied;-)

> +
> pre-commit
> ~~~~~~~~~~
>
> diff --git a/builtin/log.c b/builtin/log.c
> index 734aab3..863fcef 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -761,7 +761,8 @@ static const char *output_directory = NULL;
> static int outdir_offset;
>
> static int reopen_stdout(struct commit *commit, const char *subject,
> - struct rev_info *rev, int quiet)
> + struct rev_info *rev, int quiet,
> + struct strbuf *choosen_filename)
> {
>  struct strbuf filename = STRBUF_INIT;
>  int suffix_len = strlen(rev->patch_suffix) + 1;
> @@ -788,6 +789,11 @@ static int reopen_stdout(struct commit *commit, 
> const char *subject,
>  if (freopen(filename.buf, "w", stdout) == NULL)
>  return error(_("Cannot open patch file %s"), filename.buf);
>
> + if (choosen_filename) {
> + strbuf_reset(choosen_filename);
> + strbuf_addstr(choosen_filename, filename.buf);
> + }
> +
>  strbuf_release(&filename);
>  return 0;
> }
> @@ -921,7 +927,7 @@ static void make_cover_letter(struct rev_info 
> *rev, int use_stdout,
>  committer = git_committer_info(0);
>
>  if (!use_stdout &&
> -     reopen_stdout(NULL, rev->numbered_files ? NULL : "cover-letter", 
> rev, quiet))
> +     reopen_stdout(NULL, rev->numbered_files ? NULL : "cover-letter", 
> rev, quiet, NULL))
>  return;
>
>  log_write_email_headers(rev, head, &pp.subject, &pp.after_subject,
> @@ -1176,6 +1182,7 @@ int cmd_format_patch(int argc, const char 
> **argv, const char *prefix)
>  const char *in_reply_to = NULL;
>  struct patch_ids ids;
>  struct strbuf buf = STRBUF_INIT;
> + struct strbuf filename = STRBUF_INIT;
>  int use_patch_format = 0;
>  int quiet = 0;
>  int reroll_count = -1;
> @@ -1531,7 +1538,7 @@ int cmd_format_patch(int argc, const char 
> **argv, const char *prefix)
>  }
>
>  if (!use_stdout &&
> -     reopen_stdout(rev.numbered_files ? NULL : commit, NULL, &rev, 
> quiet))
> +     reopen_stdout(rev.numbered_files ? NULL : commit, NULL, &rev, 
> quiet, &filename))
>  die(_("Failed to create output files"));
>  shown = log_tree_commit(&rev, commit);
>  free_commit_buffer(commit);
> @@ -1552,8 +1559,10 @@ int cmd_format_patch(int argc, const char 
> **argv, const char *prefix)
>  else
>  print_signature();
>  }
> - if (!use_stdout)
> + if (!use_stdout) {
>  fclose(stdout);
> + run_hook_le(NULL, "post-format-patch", filename.buf, NULL);
> + }
>  }
>  free(list);
>  free(branch_name);
> -- 
> 2.2.0.rc1.24.g562add4
>
> --
Philip 
