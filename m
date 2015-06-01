From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] checkout: don't check worktrees when not necessary
Date: Mon, 1 Jun 2015 17:23:17 +0700
Message-ID: <20150601102317.GA20607@lanh>
References: <1433114189-9779-1-git-send-email-sbaugh@catern.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Spencer Baugh <sbaugh@catern.com>
X-From: git-owner@vger.kernel.org Mon Jun 01 12:23:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzMsG-0007YP-D2
	for gcvg-git-2@plane.gmane.org; Mon, 01 Jun 2015 12:23:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752275AbbFAKXM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jun 2015 06:23:12 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:35562 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751901AbbFAKXK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jun 2015 06:23:10 -0400
Received: by padjw17 with SMTP id jw17so34029588pad.2
        for <git@vger.kernel.org>; Mon, 01 Jun 2015 03:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=EsOQs2hTZW/Uocg+YcRx04JjihShjTAJMxMqG+m5fQg=;
        b=BiFdnekdXcxnpsKC4tc87qADa1jb5RovfbkOuLISlo1EGo0So9V1ADCe/599CtdmJB
         zUgVbEq2wavCVpdmNtRJ79XxMriF2KV7ui80c4L4YdLgL/AtNN/EG1LvLmSRoPgXuhfw
         31SpO4C35tFWSdQqDAQ912XnL0g5OUBvvK4IEk4R7ReQLH0h5utdSJpx4jkOysLo95Da
         F2MfMUUUuiEl0ap8RC6nL9xv+DGPe1Q+awDe+NMoirN5X8cQW5a9egshKT6YRa5cEzFG
         tP3HNEZAYZS0/p4KjpfMAxB3oemqnIq2FT/NvDIAHgHQaBmuuUcFp2kxS6abtAV46Iah
         ZkdQ==
X-Received: by 10.66.155.197 with SMTP id vy5mr39767170pab.104.1433154189993;
        Mon, 01 Jun 2015 03:23:09 -0700 (PDT)
Received: from lanh ([115.73.25.58])
        by mx.google.com with ESMTPSA id ob15sm14014408pdb.40.2015.06.01.03.23.06
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Jun 2015 03:23:08 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Mon, 01 Jun 2015 17:23:17 +0700
Content-Disposition: inline
In-Reply-To: <1433114189-9779-1-git-send-email-sbaugh@catern.com>
X-Clacks-Overhead: GNU Terry Pratchett
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270395>

On Sun, May 31, 2015 at 07:16:29PM -0400, Spencer Baugh wrote:
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -1237,6 +1237,7 @@ static int parse_branchname_arg(int argc, const char **argv,
>  		char *head_ref = resolve_refdup("HEAD", 0, sha1, &flag);
>  		if (head_ref &&
>  		    (!(flag & REF_ISSYMREF) || strcmp(head_ref, new->path)) &&
> +		    !(opts->patch_mode || opts->pathspec.nr) &&
>  		    !opts->ignore_other_worktrees)
>  			check_linked_checkouts(new);
>  		free(head_ref);

Simple and effective. But if in future we add more options for
non-switching-branch checkout, we need to update both places, here and
near the end of cmd_checkout().

Perhaps we can move all this block inside checkout_branch() so we only
need to test "opts->patch_mode || opts->pathspec.nr" once, at the end
of cmd_checkout(). Something like below?

I'm not opposed to your change, but if you go with it, you should
cherry pick my test in the below patch. Or create a similar test.

-- 8< --
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 2f92328..e9aee58 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1110,7 +1110,6 @@ static int parse_branchname_arg(int argc, const char **argv,
 {
 	struct tree **source_tree = &opts->source_tree;
 	const char **new_branch = &opts->new_branch;
-	int force_detach = opts->force_detach;
 	int argcount = 0;
 	unsigned char branch_rev[20];
 	const char *arg;
@@ -1231,17 +1230,6 @@ static int parse_branchname_arg(int argc, const char **argv,
 	else
 		new->path = NULL; /* not an existing branch */
 
-	if (new->path && !force_detach && !*new_branch) {
-		unsigned char sha1[20];
-		int flag;
-		char *head_ref = resolve_refdup("HEAD", 0, sha1, &flag);
-		if (head_ref &&
-		    (!(flag & REF_ISSYMREF) || strcmp(head_ref, new->path)) &&
-		    !opts->ignore_other_worktrees)
-			check_linked_checkouts(new);
-		free(head_ref);
-	}
-
 	new->commit = lookup_commit_reference_gently(rev, 1);
 	if (!new->commit) {
 		/* not a commit */
@@ -1321,6 +1309,17 @@ static int checkout_branch(struct checkout_opts *opts,
 		die(_("Cannot switch branch to a non-commit '%s'"),
 		    new->name);
 
+	if (new->path && !opts->force_detach && !opts->new_branch) {
+		unsigned char sha1[20];
+		int flag;
+		char *head_ref = resolve_refdup("HEAD", 0, sha1, &flag);
+		if (head_ref &&
+		    (!(flag & REF_ISSYMREF) || strcmp(head_ref, new->path)) &&
+		    !opts->ignore_other_worktrees)
+			check_linked_checkouts(new);
+		free(head_ref);
+	}
+
 	if (opts->new_worktree)
 		return prepare_linked_checkout(opts, new);
 
diff --git a/t/t2025-checkout-to.sh b/t/t2025-checkout-to.sh
index f8e4df4..a8d9336 100755
--- a/t/t2025-checkout-to.sh
+++ b/t/t2025-checkout-to.sh
@@ -28,6 +28,14 @@ test_expect_success 'checkout --to refuses to checkout locked branch' '
 	! test -d .git/worktrees/zere
 '
 
+test_expect_success 'checking out paths not complaining about linked checkouts' '
+	(
+	cd existing_empty &&
+	echo dirty >>init.t &&
+	git checkout master -- init.t
+	)
+'
+
 test_expect_success 'checkout --to a new worktree' '
 	git rev-parse HEAD >expect &&
 	git checkout --detach --to here master &&
-- 8< --
--
Duy
