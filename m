From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] ls-files: fix pathspec display on error
Date: Mon, 01 Aug 2011 15:30:42 -0700
Message-ID: <7vvcughii5.fsf@alter.siamese.dyndns.org>
References: <CAEBDL5XJbYT9yczZiVPpeA3mpROuKQdw+-AOJjUmRp4W6M5uzg@mail.gmail.com>
 <b535c21e1becdf8aeeb1d3f8ddaa7f5415830844.1311767679.git.git@drmicha.warpmail.net> <20110729130330.GA31941@toss.lan> <7vipqiknjh.fsf@alter.siamese.dyndns.org> <20110801180320.GA17556@toss> <7vhb60j3e1.fsf@alter.siamese.dyndns.org> <20110801211958.GA23238@toss>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org,
	rrt@sc3d.org, john@szakmeister.net
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Tue Aug 02 00:30:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qo10d-0001kO-42
	for gcvg-git-2@lo.gmane.org; Tue, 02 Aug 2011 00:30:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752958Ab1HAWar (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Aug 2011 18:30:47 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43606 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752467Ab1HAWap (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2011 18:30:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A41CE5DE2;
	Mon,  1 Aug 2011 18:30:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=eFbeGq4uA2PNueyv55iuFJ+qZK4=; b=eUKc24
	faP5LYZLghito0qE1//1kcpf+lHcwO6m85hmaGa9Gz6gYsXRRh1fRiS8AQK5F2Jm
	C7i0MvLo7aumhWxmLE9IBR22CYbST77abiRRCbi+dZsO0oSjxWDkaRO4RIsfu62M
	bi1YIBWnwOj7S5ObAFycB+fzrzRVOobyg5ZzM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eMcyvnczQwvtFQDPkxOhHFObkvn6BzVd
	AM0LKno1yY0cOPtsnVw8wxkXikl9lOrMxmi08LU8rw1t69vD7bbz6FvsM0cqW+vF
	dWnPXLI2WOIXzO43cA9X+cPuXG9xVkoIYZ6PQRpUYM1H+hiciqQwNV7Kyum2sdb8
	6uKIMFJjr70=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9919E5DE0;
	Mon,  1 Aug 2011 18:30:44 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C421B5DDF; Mon,  1 Aug 2011
 18:30:43 -0400 (EDT)
In-Reply-To: <20110801211958.GA23238@toss> (Clemens Buchacher's message of
 "Mon, 1 Aug 2011 23:19:58 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E4EB4E1E-BC8D-11E0-97F2-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178423>

Clemens Buchacher <drizzd@aon.at> writes:

> ... No changes except to address your comments.
> Thanks for reviewing.

Thank *you* for re-rolling.
> diff --git a/builtin/ls-files.c b/builtin/ls-files.c
> index 0e98bff..fef5642 100644
> --- a/builtin/ls-files.c
> +++ b/builtin/ls-files.c
> @@ -353,11 +353,14 @@ void overlay_tree_on_cache(const char *tree_name, const char *prefix)
>  	}
>  }
>  
> -int report_path_error(const char *ps_matched, const char **pathspec, int prefix_len)
> +int report_path_error(const char *ps_matched, const char **pathspec,
> +		const char *prefix, int prefix_len)
>  {
>  	/*
>  	 * Make sure all pathspec matched; otherwise it is an error.
>  	 */
> +	struct strbuf sb = STRBUF_INIT;
> +	const char *name;
>  	int num, errors = 0;
>  	for (num = 0; pathspec[num]; num++) {
>  		int other, found_dup;

> @@ -382,10 +385,12 @@ int report_path_error(const char *ps_matched, const char **pathspec, int prefix_
>  		if (found_dup)
>  			continue;
>  
> +		name = quote_path_relative(pathspec[num], -1, &sb, prefix);
>  		error("pathspec '%s' did not match any file(s) known to git.",
> -		      pathspec[num] + prefix_len);
> +		      name);

Is prefix_len still being used in this function?

> +		ls ../x* >>expect &&
> +		(git ls-files -c --error-unmatch ../[xy]* || true) >actual 2>&1 &&

The "|| true" construct says "ls-files _may_ exit with non-zero, but we do
not care". Shouldn't we be actively expecting it to exit with non-zero,
using test-must-fail here?

I am not sure if passing NULL in checkout.c is the right thing to do. I
know that is not the problem this patch introduces, but it leads to this
inconsistent behaviour:

	$ cd Documentation
        $ git checkout nosuch.txt
        error: pathspec 'Documentation/nosuch.txt' did not match...
        $ git commit nosuch.txt
        error: pathspec 'nosuch.txt' did not match...

I suspect that cmd_checkout() should pass prefix down to checkout_paths()
so that the latter can properly strip it from the pathspec.

Perhaps this squashed in on top of your patch...

 builtin/checkout.c           |    6 +++---
 builtin/commit.c             |    2 +-
 builtin/ls-files.c           |    5 ++---
 cache.h                      |    2 +-
 t/t3005-ls-files-relative.sh |    6 +++---
 5 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index efe5e8e..a5717f1 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -201,7 +201,7 @@ static int checkout_merged(int pos, struct checkout *state)
 }
 
 static int checkout_paths(struct tree *source_tree, const char **pathspec,
-			  struct checkout_opts *opts)
+			  const char *prefix, struct checkout_opts *opts)
 {
 	int pos;
 	struct checkout state;
@@ -231,7 +231,7 @@ static int checkout_paths(struct tree *source_tree, const char **pathspec,
 		match_pathspec(pathspec, ce->name, ce_namelen(ce), 0, ps_matched);
 	}
 
-	if (report_path_error(ps_matched, pathspec, NULL, -1))
+	if (report_path_error(ps_matched, pathspec, prefix))
 		return 1;
 
 	/* "checkout -m path" to recreate conflicted state */
@@ -1060,7 +1060,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 		if (1 < !!opts.writeout_stage + !!opts.force + !!opts.merge)
 			die(_("git checkout: --ours/--theirs, --force and --merge are incompatible when\nchecking out of the index."));
 
-		return checkout_paths(source_tree, pathspec, &opts);
+		return checkout_paths(source_tree, pathspec, prefix, &opts);
 	}
 
 	if (patch_mode)
diff --git a/builtin/commit.c b/builtin/commit.c
index a16d00b..9679a99 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -272,7 +272,7 @@ static int list_paths(struct string_list *list, const char *with_tree,
 			item->util = item; /* better a valid pointer than a fake one */
 	}
 
-	return report_path_error(m, pattern, prefix, -1);
+	return report_path_error(m, pattern, prefix);
 }
 
 static void add_remove_files(struct string_list *list)
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 72b986f..468bb13 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -388,8 +388,7 @@ void overlay_tree_on_cache(const char *tree_name, const char *prefix)
 	}
 }
 
-int report_path_error(const char *ps_matched, const char **pathspec,
-		const char *prefix, int prefix_len)
+int report_path_error(const char *ps_matched, const char **pathspec, const char *prefix)
 {
 	/*
 	 * Make sure all pathspec matched; otherwise it is an error.
@@ -616,7 +615,7 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 
 	if (ps_matched) {
 		int bad;
-		bad = report_path_error(ps_matched, pathspec, prefix, prefix_len);
+		bad = report_path_error(ps_matched, pathspec, prefix);
 		if (bad)
 			fprintf(stderr, "Did you forget to 'git add'?\n");
 
diff --git a/cache.h b/cache.h
index 80c60b4..d55a6bb 100644
--- a/cache.h
+++ b/cache.h
@@ -1175,7 +1175,7 @@ extern int ws_blank_line(const char *line, int len, unsigned ws_rule);
 #define ws_tab_width(rule)     ((rule) & WS_TAB_WIDTH_MASK)
 
 /* ls-files */
-int report_path_error(const char *ps_matched, const char **pathspec, const char *prefix, int prefix_len);
+int report_path_error(const char *ps_matched, const char **pathspec, const char *prefix);
 void overlay_tree_on_cache(const char *tree_name, const char *prefix);
 
 char *alias_lookup(const char *alias);
diff --git a/t/t3005-ls-files-relative.sh b/t/t3005-ls-files-relative.sh
index 3c3ff5e..a2b63e2 100755
--- a/t/t3005-ls-files-relative.sh
+++ b/t/t3005-ls-files-relative.sh
@@ -48,7 +48,7 @@ test_expect_success 'ls-files -c' '
 		done >expect &&
 		echo "Did you forget to ${sq}git add${sq}?" >>expect &&
 		ls ../x* >>expect &&
-		(git ls-files -c --error-unmatch ../[xy]* || true) >actual 2>&1 &&
+		test_must_fail git ls-files -c --error-unmatch ../[xy]* >actual 2>&1 &&
 		test_cmp expect actual
 	)
 '
@@ -58,11 +58,11 @@ test_expect_success 'ls-files -o' '
 		cd top/sub &&
 		for f in ../x*
 		do
-			echo "error: pathspec ${sq}${f}${sq} did not match any file(s) known to git."
+			echo "error: pathspec $sq$f$sq did not match any file(s) known to git."
 		done >expect &&
 		echo "Did you forget to ${sq}git add${sq}?" >>expect &&
 		ls ../y* >>expect &&
-		(git ls-files -o --error-unmatch ../[xy]* || true) >actual 2>&1 &&
+		test_must_fail git ls-files -o --error-unmatch ../[xy]* >actual 2>&1 &&
 		test_cmp expect actual
 	)
 '
