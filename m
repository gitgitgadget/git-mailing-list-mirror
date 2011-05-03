From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v3] Add default merge options for all branches
Date: Tue, 3 May 2011 04:03:52 -0500
Message-ID: <20110503090351.GA27862@elie>
References: <4DBF04C5.1080608@dailyvoid.com>
 <4DBF94E9.2010502@dailyvoid.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	vmiklos@frugalware.org, deskinm@umich.edu
To: Michael Grubb <devel@dailyvoid.com>
X-From: git-owner@vger.kernel.org Tue May 03 11:11:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHBdU-0003i9-Uz
	for gcvg-git-2@lo.gmane.org; Tue, 03 May 2011 11:11:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751820Ab1ECJLL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 May 2011 05:11:11 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:45684 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751613Ab1ECJLK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2011 05:11:10 -0400
Received: by iyb14 with SMTP id 14so5324763iyb.19
        for <git@vger.kernel.org>; Tue, 03 May 2011 02:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=TefXBlSbtXC2rIaeJL1HPBfrIHklQNjiXMAHeX7IwXc=;
        b=WAgzhLM9UuBw7Il8ZaVwD9Z0QNXZE1kE0sBND9kXWoYjC4LOTFn3aqwDL/7mquVJaW
         PRIu0LLd+7AXuK59xbAdyUodf49VCeMGJyF8/iIEZuzODwG5uFO6ApfNrjmcEJbjUnbn
         i5Sy5F9dUgudP+Bi6iVG5BPCZ3c0rPp/tM6z8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=PBCBbM8+4Aj8cEP3j2yZ4XYK9FYxqH38Ki9HjV+edj0I3E/E/qviAREcPjkShBpljh
         olcKLVsg9bSfwCpwTXtl0Ol4s0QRN4rrb0f7xN67SSlb7RuePQ+bshvWxJTIUtzOTNbw
         ChSnEYGul/T8rFBQ3eWWHzoCdarVZp6Dg9FVs=
Received: by 10.42.158.74 with SMTP id g10mr11846826icx.324.1304413440884;
        Tue, 03 May 2011 02:04:00 -0700 (PDT)
Received: from elie (adsl-69-209-62-211.dsl.chcgil.ameritech.net [69.209.62.211])
        by mx.google.com with ESMTPS id c1sm2710943ibe.51.2011.05.03.02.03.58
        (version=SSLv3 cipher=OTHER);
        Tue, 03 May 2011 02:04:00 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4DBF94E9.2010502@dailyvoid.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172654>

Hi,

Michael Grubb wrote:

> Add support for branch.*.mergeoptions for setting default options for
> all branches.  This new value shares semantics with the existing
> branch.<name>.mergeoptions variable. If a branch specific value is
> found, that value will be used.

So in the future one might be able to do things like

	[branch "git-gui/*"]
		mergeoptions = -s subtree

Interesting.

> The need for this arises from the fact that there is currently not an
> easy way to set merge options for all branches.

I'm curious: what merge options/workflows does this tend to be useful
for?  The above explanation seems a bit abstract (though already
convincing).

> The approach taken is to make note of whether a branch specific
> mergeoptions key has been seen and only apply the global value if it
> hasn't.

What happens if the global value is seen first?

On to the code.  Warning: nitpicks ahead.

[...]
> +++ b/builtin/merge.c
> @@ -32,6 +32,13 @@
>  #define NO_FAST_FORWARD (1<<2)
>  #define NO_TRIVIAL      (1<<3)
>  
> +#define MERGEOPTIONS_DEFAULT (1<<0)
> +#define MERGEOPTIONS_BRANCH (1<<1)

Are these bitflags?

> @@ -505,24 +512,42 @@ cleanup:
>  
>  static int git_merge_config(const char *k, const char *v, void *cb)
>  {
> +	int merge_option_mode = 0;
> +	struct merge_options_cb *merge_options =
> +		(struct merge_options_cb *)cb;

This cast should not needed, I'd think.

[...]
> -	if (branch && !prefixcmp(k, "branch.") &&
> -		!prefixcmp(k + 7, branch) &&
> -		!strcmp(k + 7 + strlen(branch), ".mergeoptions")) {
> +	if (!strcmp(k, "branch.*.mergeoptions"))
> +		merge_option_mode = MERGEOPTIONS_DEFAULT;
> +	else if (branch && !prefixcmp(k, "branch.") &&
> +			 !prefixcmp(k + 7, branch) &&
> +			 !strcmp(k + 7 + strlen(branch), ".mergeoptions"))
> +		merge_option_mode = MERGEOPTIONS_BRANCH;
> +
> +	if ((merge_option_mode == MERGEOPTIONS_DEFAULT &&
> +		!merge_options->override_default) ||
> +		merge_option_mode == MERGEOPTIONS_BRANCH) {
>  		const char **argv;

It is hard to see at a glance where the "if" condition ends and
the body begins.  Why not

	if ((merge_option_mode == MERGEOPTIONS_DEFAULT &&
	     !merge_options->override_default) ||
	    merge_option_mode == MERGEOPTIONS_BRANCH) {
		const char **argv;
		...

or

	if (merge_option_mode == MERGEOPTIONS_BRANCH ? 1 :
	    merge_option_mode == MERGEOPTIONS_DEFAULT ?
			!merge_options->override_default : 0) {
		const char **argv;
		...

or even

	if (merge_option_mode == MERGEOPTIONS_DEFAULT &&
	    merge_options->override_default)
		merge_option_mode = 0;

	if (merge_option_mode) {
		const char **argv;
		...

?
	    
>  		int argc;
>  		char *buf;
>  
>  		buf = xstrdup(v);
>  		argc = split_cmdline(buf, &argv);
> -		if (argc < 0)
> -			die(_("Bad branch.%s.mergeoptions string: %s"), branch,
> -			    split_cmdline_strerror(argc));
> +		if (argc < 0) {
> +			if (merge_option_mode == 1)
> +				die(_("Bad merge.mergeoptions string: %s"), 
> +					split_cmdline_strerror(argc));

merge.*.mergeoptions, no?

> +			else
> +				die(_("Bad branch.%s.mergeoptions string: %s"), branch,
> +					split_cmdline_strerror(argc));
> +		}
>  		argv = xrealloc(argv, sizeof(*argv) * (argc + 2));
>  		memmove(argv + 1, argv, sizeof(*argv) * (argc + 1));
>  		argc++;
>  		parse_options(argc, argv, NULL, builtin_merge_options,
>  			      builtin_merge_usage, 0);
>  		free(buf);
> +		if (merge_option_mode == MERGEOPTIONS_BRANCH)
> +			merge_options->override_default = 1;

Could be clearer to put this next to the code that checks
override_default.

[...]
> --- a/t/t7600-merge.sh
> +++ b/t/t7600-merge.sh
> @@ -415,6 +415,33 @@ test_expect_success 'merge c0 with c1 (no-ff)' '
>  
>  test_debug 'git log --graph --decorate --oneline --all'
>  
> +test_expect_success 'merge c0 with c1 (global no-ff)' '
> +	git reset --hard c0 &&
> +	git config --unset branch.master.mergeoptions &&

Better to make that

	test_might_fail git config --unset ...

so it will still work if earlier tests stop setting that
variable.

> +	git config "branch.*.mergeoptions" "--no-ff" &&
> +	test_tick &&
> +	git merge c1 &&
> +	git config --remove-section "branch.*" &&
> +	verify_merge file result.1 &&
> +	verify_parents $c0 $c1
> +'
> +
> +test_debug 'git log --graph --decorate --oneline --all'

Yuck.  Did anything come of the idea of a --between-tests option to
use an arbitrary command here automatically?  (Not your fault.)  

> +
> +test_expect_success 'combine merge.mergeoptions with branch.x.mergeoptions' '
> +	git reset --hard c0 &&
> +	git config --remove-section branch.master &&

Could make sense to use test_might_fail for this one, too.

> +	git config "branch.*.mergeoptions" "--no-ff" &&
> +	git config branch.master.mergeoptions "--ff" &&
> +	test_tick &&
> +	git merge c1 &&
> +	git config --remove-section "branch.*" &&
> +	verify_merge file result.1 &&
> +	verify_parents "$c0"
> +'
> +
> +test_debug 'git log --graph --decorate --oneline --all'

Nice, a clean patch with a few reasonable tests.

With whichever of the changes below make sense,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.
---
 builtin/merge.c  |   37 ++++++++++++++++++++-----------------
 t/t7600-merge.sh |    4 ++--
 2 files changed, 22 insertions(+), 19 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 9fe129f..7156e92 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -32,8 +32,8 @@
 #define NO_FAST_FORWARD (1<<2)
 #define NO_TRIVIAL      (1<<3)
 
-#define MERGEOPTIONS_DEFAULT (1<<0)
-#define MERGEOPTIONS_BRANCH (1<<1)
+#define MERGEOPTIONS_DEFAULT 1
+#define MERGEOPTIONS_BRANCH 2
 
 struct merge_options_cb {
 	int override_default;
@@ -513,8 +513,7 @@ cleanup:
 static int git_merge_config(const char *k, const char *v, void *cb)
 {
 	int merge_option_mode = 0;
-	struct merge_options_cb *merge_options =
-		(struct merge_options_cb *)cb;
+	struct merge_options_cb *merge_options = cb;
 
 	if (!strcmp(k, "branch.*.mergeoptions"))
 		merge_option_mode = MERGEOPTIONS_DEFAULT;
@@ -523,31 +522,35 @@ static int git_merge_config(const char *k, const char *v, void *cb)
 			 !strcmp(k + 7 + strlen(branch), ".mergeoptions"))
 		merge_option_mode = MERGEOPTIONS_BRANCH;
 
-	if ((merge_option_mode == MERGEOPTIONS_DEFAULT &&
-		!merge_options->override_default) ||
-		merge_option_mode == MERGEOPTIONS_BRANCH) {
+	/*
+	 * If an applicable [branch "foo"] mergeoptions setting was
+	 * seen already, let it mask the [branch "*"] defaults.
+	 */
+	if (merge_options->override_default &&
+	    merge_option_mode == MERGEOPTIONS_DEFAULT)
+		merge_option_mode = 0;
+
+	if (merge_option_mode == MERGEOPTIONS_BRANCH)
+		merge_options->override_default = 1;
+
+	if (merge_option_mode) {
 		const char **argv;
 		int argc;
 		char *buf;
 
 		buf = xstrdup(v);
 		argc = split_cmdline(buf, &argv);
-		if (argc < 0) {
-			if (merge_option_mode == 1)
-				die(_("Bad merge.mergeoptions string: %s"), 
-					split_cmdline_strerror(argc));
-			else
-				die(_("Bad branch.%s.mergeoptions string: %s"), branch,
-					split_cmdline_strerror(argc));
-		}
+		if (argc < 0)
+			die(_("Bad merge.%s.mergeoptions string: %s"), 
+			    merge_option_mode == MERGEOPTIONS_DEFAULT ?
+							"*" : branch,
+			    split_cmdline_strerror(argc));
 		argv = xrealloc(argv, sizeof(*argv) * (argc + 2));
 		memmove(argv + 1, argv, sizeof(*argv) * (argc + 1));
 		argc++;
 		parse_options(argc, argv, NULL, builtin_merge_options,
 			      builtin_merge_usage, 0);
 		free(buf);
-		if (merge_option_mode == MERGEOPTIONS_BRANCH)
-			merge_options->override_default = 1;
 	}
 
 	if (!strcmp(k, "merge.diffstat") || !strcmp(k, "merge.stat"))
diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
index cea2b31..ff807f4 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -417,7 +417,7 @@ test_debug 'git log --graph --decorate --oneline --all'
 
 test_expect_success 'merge c0 with c1 (global no-ff)' '
 	git reset --hard c0 &&
-	git config --unset branch.master.mergeoptions &&
+	test_might_fail git config --unset branch.master.mergeoptions &&
 	git config "branch.*.mergeoptions" "--no-ff" &&
 	test_tick &&
 	git merge c1 &&
@@ -430,7 +430,7 @@ test_debug 'git log --graph --decorate --oneline --all'
 
 test_expect_success 'combine merge.mergeoptions with branch.x.mergeoptions' '
 	git reset --hard c0 &&
-	git config --remove-section branch.master &&
+	test_might_fail git config --remove-section branch.master &&
 	git config "branch.*.mergeoptions" "--no-ff" &&
 	git config branch.master.mergeoptions "--ff" &&
 	test_tick &&
-- 
1.7.5
