From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-log: allow --decorate[=short|full]
Date: Tue, 18 Aug 2009 13:18:23 -0700
Message-ID: <7viqgkc1v4.fsf@alter.siamese.dyndns.org>
References: <8c5c35580908150250y62b1042cmf6071016bac98a48@mail.gmail.com>
 <20090815122812.GB30630@coredump.intra.peff.net>
 <8c5c35580908150723h6e4c8fcay43b708969a86ae27@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 18 22:18:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdV8n-00082w-9m
	for gcvg-git-2@lo.gmane.org; Tue, 18 Aug 2009 22:18:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751640AbZHRUSg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Aug 2009 16:18:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751557AbZHRUSf
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Aug 2009 16:18:35 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:54894 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751515AbZHRUSf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Aug 2009 16:18:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3F0BC2E0C3;
	Tue, 18 Aug 2009 16:18:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=fV4LXpa5punOM8Z112SSroDQ7eA=; b=FgU4aD2wQVMhRwEg/zR3t+L
	IECC/1mQLFTGLGJt2rfkWzyDRKhvkor0vle2kzZFN7pYelzeo41bRbfRYLvV+rAn
	Ac5JKtJJWWC873eXg8Xe7aJx5NQxFFrKXgLp6WDrQM/6iX5RloiGnWcE6tQRstqw
	v0vQWWYc0uJytusdqQUI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=dGb2NApgCx8Z48Lq3RHZyA01K6H/GW9m4jmKCYg2DP0I3CUkM
	LNR58VhB3J0dw/a78iPRr4Ok1m2LJhvC+Hzscn8PwtpQldBfRv76/AnuGtXGfBGU
	bGMpCxLY9HxRGWACvBkjU5d1artE3hW+x1GkFDAShm6bWvTXjZP2WZ2q1k=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0FA3E2E0BC;
	Tue, 18 Aug 2009 16:18:32 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id E72912E0B5; Tue, 18 Aug 2009
 16:18:25 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 4CAAABC6-8C34-11DE-A85B-3142836986A2-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126449>

Lars Hjemli <hjemli@gmail.com> writes:

> diff --git a/builtin-log.c b/builtin-log.c
> index 3817bf1..1ed4c76 100644
> --- a/builtin-log.c
> +++ b/builtin-log.c
> @@ -61,8 +61,15 @@ static void cmd_log_init(int argc, const char
> **argv, const char *prefix,
>  	for (i = 1; i < argc; i++) {
>  		const char *arg = argv[i];
>  		if (!strcmp(arg, "--decorate")) {
> -			load_ref_decorations();
> -			rev->show_decorations = 1;
> +			rev->show_decorations = DECORATE_SHORT_REFS;
> +		} else if (!prefixcmp(arg, "--decorate=")) {
> +			const char *v = skip_prefix(arg, "--decorate=");
> +			if (!strcmp(v, "full"))
> +				rev->show_decorations = DECORATE_FULL_REFS;
> +			else if (!strcmp(v, "short"))
> +				rev->show_decorations = DECORATE_SHORT_REFS;
> +			else
> +				die("invalid --decorate option: %s", arg);
>  		} else if (!strcmp(arg, "--source")) {
>  			rev->show_source = 1;
>  		} else if (!strcmp(arg, "-h")) {
> @@ -70,6 +77,8 @@ static void cmd_log_init(int argc, const char
> **argv, const char *prefix,
>  		} else
>  			die("unrecognized argument: %s", arg);
>  	}
> +	if (rev->show_decorations)
> +		load_ref_decorations(rev->show_decorations);
>  }

If you are deciding whether full refs are given or short ones when you
call load_ref_decorations(), I do not think there is any reason for you to
change the type of rev->short_decorations from bool to enum.  Shouldn't
you maintain a local variable in this function and pass it down to this
call instead?

That is, something like this on top (I had to fix the breakage your MUA
has done to your patch, so there might be some fuzz around whitespace).


 builtin-log.c |   13 ++++++++-----
 log-tree.c    |    2 +-
 revision.h    |    2 +-
 3 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/builtin-log.c b/builtin-log.c
index 2a0f5f7..25e21ed 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -35,6 +35,7 @@ static void cmd_log_init(int argc, const char **argv, const char *prefix,
 		      struct rev_info *rev)
 {
 	int i;
+	int decoration_style = 0;
 
 	rev->abbrev = DEFAULT_ABBREV;
 	rev->commit_format = CMIT_FMT_DEFAULT;
@@ -61,13 +62,13 @@ static void cmd_log_init(int argc, const char **argv, const char *prefix,
 	for (i = 1; i < argc; i++) {
 		const char *arg = argv[i];
 		if (!strcmp(arg, "--decorate")) {
-			rev->show_decorations = DECORATE_SHORT_REFS;
+			decoration_style = DECORATE_SHORT_REFS;
 		} else if (!prefixcmp(arg, "--decorate=")) {
 			const char *v = skip_prefix(arg, "--decorate=");
 			if (!strcmp(v, "full"))
-				rev->show_decorations = DECORATE_FULL_REFS;
+				decoration_style = DECORATE_FULL_REFS;
 			else if (!strcmp(v, "short"))
-				rev->show_decorations = DECORATE_SHORT_REFS;
+				decoration_style = DECORATE_SHORT_REFS;
 			else
 				die("invalid --decorate option: %s", arg);
 		} else if (!strcmp(arg, "--source")) {
@@ -77,8 +78,10 @@ static void cmd_log_init(int argc, const char **argv, const char *prefix,
 		} else
 			die("unrecognized argument: %s", arg);
 	}
-	if (rev->show_decorations)
-		load_ref_decorations(rev->show_decorations);
+	if (decoration_style) {
+		rev->show_decorations = 1;
+		load_ref_decorations(decoration_style);
+	}
 }
 
 /*
diff --git a/log-tree.c b/log-tree.c
index 1c767c9..1c9eefe 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -25,7 +25,7 @@ static int add_ref_decoration(const char *refname, const unsigned char *sha1, in
 	struct object *obj = parse_object(sha1);
 	if (!obj)
 		return 0;
-	if (!cb_data || *(int *)cb_data & DECORATE_SHORT_REFS)
+	if (!cb_data || *(int *)cb_data == DECORATE_SHORT_REFS)
 		refname = prettify_refname(refname);
 	add_name_decoration("", refname, obj);
 	while (obj->type == OBJ_TAG) {
diff --git a/revision.h b/revision.h
index 9a644ee..b10984b 100644
--- a/revision.h
+++ b/revision.h
@@ -59,6 +59,7 @@ struct rev_info {
 			rewrite_parents:1,
 			print_parents:1,
 			show_source:1,
+			show_decorations:1,
 			reverse:1,
 			reverse_output_stage:1,
 			cherry_pick:1,
@@ -98,7 +99,6 @@ struct rev_info {
 	const char	*subject_prefix;
 	int		no_inline;
 	int		show_log_size;
-	int		show_decorations;
 
 	/* Filter by commit log message */
 	struct grep_opt	grep_filter;
