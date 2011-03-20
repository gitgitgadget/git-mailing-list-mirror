From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Mar 2011, #02; Sun, 20)
Date: Sun, 20 Mar 2011 14:06:18 -0700
Message-ID: <7vtyexv6wl.fsf@alter.siamese.dyndns.org>
References: <7vy649vah1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 20 22:06:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1Ppa-0008Qv-Ro
	for gcvg-git-2@lo.gmane.org; Sun, 20 Mar 2011 22:06:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751275Ab1CTVGb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Mar 2011 17:06:31 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:59154 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751043Ab1CTVG3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Mar 2011 17:06:29 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C422C49E0;
	Sun, 20 Mar 2011 17:08:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4Uucf7uNJT3p2atI94SFQhlUGVg=; b=XHwku1
	itHy+RgzyS9X6eUtqRv6EE4GEx8kTZ6cxXNUxRPRln0zkq0bNbDmWAMmiXuewN9H
	fRFtxezHbnHSCKnWS4LgIQJ9PcLQXuREKdYz6R1/2l9uFM8IW2JR0mTpebm0wfen
	5+c1M36chmTGh8Pat7eneRyFknzM026xxTVWk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SHLPljjO9zFzOjFsj9EkVEXB9G7dBVM0
	DWcer07S65RilRMAvvDlHEmVvotanKWWYXXAmQhgH9CCGmdg+yjincuFd/9/0LfP
	ddcPDWL+iQmn6QN2QhuKP+27mkcUSULJ9wzNaPPSkNj9v8zHmOj6G0SLwQVA9IqK
	0tsxje+XbZY=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A37BA49DF;
	Sun, 20 Mar 2011 17:08:01 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 84D6F49DD; Sun, 20 Mar 2011
 17:07:58 -0400 (EDT)
In-Reply-To: <7vy649vah1.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sun, 20 Mar 2011 12:49:14 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 23D6780E-5336-11E0-BE41-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169525>

Junio C Hamano <gitster@pobox.com> writes:

> * nd/rfc-add-u-full-tree (2011-02-07) 1 commit
>  - add: make "add -u" update full tree without pathspec
>
> A three-phase migration that:
>
>  (1) first only warns when we would deviate from traditional behaviour and
>      suggest adding "." if the user wants to limit it to cwd, but doesn't
>      actually add full-tree, in the next release;
>
>  (2) warn that we have changed the behaviour and suggest adding "." if the
>      user wants to limit it to cwd, and actually do full-tree, in 1.8.0;
>
>  (3) remove the warning, in 1.8.X (for X at least 2 or more).
>
> would be a good way forward.

... and here is how the first step would look like.

-- >8 --
Subject: [PATCH] add -u: warn when ran without pathspec from a subdirectory

We will be changing the behaviour of "add -u" without any pathspec
to be tree-wide in future releases; warn the users and train them
to say "add -u ." to help smoother migration.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/add.c |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index e127d5a..443d3bb 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -359,6 +359,21 @@ static int add_files(struct dir_struct *dir, int flags)
 	return exit_status;
 }
 
+static const char *warn_add_u_without_pathspec_msg[] = {
+	"In release 1.8.0, running 'git add -u' from a subdirectory",
+	"without giving any pathspec WILL take effect on the whole",
+	"working tree, not just the part under the current directory.",
+	"Please make it a habit to say 'git add -u .' when you mean",
+	"to only add paths under the current directory."
+};
+
+static void warn_add_u_without_pathspec(void)
+{
+	int i;
+	for (i = 0; i < ARRAY_SIZE(warn_add_u_without_pathspec_msg); i++)
+		warning("%s", warn_add_u_without_pathspec_msg[i]);
+}
+
 int cmd_add(int argc, const char **argv, const char *prefix)
 {
 	int exit_status = 0;
@@ -390,6 +405,9 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 		die("Option --ignore-missing can only be used together with --dry-run");
 	if ((addremove || take_worktree_changes) && !argc) {
 		static const char *here[2] = { ".", NULL };
+
+		if (take_worktree_changes && prefix)
+			warn_add_u_without_pathspec();
 		argc = 1;
 		argv = here;
 	}
-- 
1.7.4.1.514.ga171c
