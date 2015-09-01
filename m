From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv4 1/3] submodule: implement `list` as a builtin helper
Date: Tue, 01 Sep 2015 12:55:51 -0700
Message-ID: <xmqqtwrdrk1k.fsf@gitster.mtv.corp.google.com>
References: <1441131869-29474-1-git-send-email-sbeller@google.com>
	<1441131869-29474-2-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: sunshine@sunshineco.com, git@vger.kernel.org, jrnieder@gmail.com,
	johannes.schindelin@gmail.com, Jens.Lehmann@web.de, peff@peff.net
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Sep 01 21:55:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWrev-0008Jb-VY
	for gcvg-git-2@plane.gmane.org; Tue, 01 Sep 2015 21:55:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751700AbbIATzy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Sep 2015 15:55:54 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:33851 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751645AbbIATzx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Sep 2015 15:55:53 -0400
Received: by padhy1 with SMTP id hy1so5887619pad.1
        for <git@vger.kernel.org>; Tue, 01 Sep 2015 12:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=wx+1aJEtX+8loKT0KpbnM/Um4FVzxlNclEBKzEke/hc=;
        b=gSzCUAyfux/tdZdqRoUcTQ02/hmSVAFKgHHHc4wrIUiTZElVFu9018T69xZn6vEHfo
         5eSzqj/vEth8e+tp16LqVVtRmm+/65VUicLfFnzEe9lzvSfHiVeQnRpT35MAQ/zhwvHC
         QHxtxkhW6xUvCXbRtdQuNj7ptKP/dwun+OwsdNaBwIvCvoNbY2LkOlCsd+HRz4nsrakM
         dj2U+cfZUDSA/7WEKaHf7i9GMrmdbJrmN41zhGOPqbnH75tBw/PCf+J2BhR+n6ZU//5X
         NP5k7Q1RZClvrZHnrPLfh/cI2V6Gfqtc/7yzVZrVeq9lb8eLfAWXge7OwBGqv42ApntL
         90rA==
X-Received: by 10.66.160.133 with SMTP id xk5mr48849884pab.131.1441137352772;
        Tue, 01 Sep 2015 12:55:52 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:c585:9fe7:e0d8:e718])
        by smtp.gmail.com with ESMTPSA id j7sm19109273pdn.8.2015.09.01.12.55.51
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 01 Sep 2015 12:55:51 -0700 (PDT)
In-Reply-To: <1441131869-29474-2-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Tue, 1 Sep 2015 11:24:27 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277035>

Stefan Beller <sbeller@google.com> writes:

> +static int module_list_compute(int argc, const char **argv,
> +				const char *prefix,
> +				struct pathspec *pathspec)
> +{
> +	int i, result = 0;
> +	char *max_prefix, *ps_matched = NULL;
> +	int max_prefix_len;
> +	parse_pathspec(pathspec, 0,
> +		       PATHSPEC_PREFER_FULL |
> +		       PATHSPEC_STRIP_SUBMODULE_SLASH_CHEAP,
> +		       prefix, argv);
> +
> +	/* Find common prefix for all pathspec's */
> +	max_prefix = common_prefix(pathspec);
> +	max_prefix_len = max_prefix ? strlen(max_prefix) : 0;
> +
> +	if (pathspec->nr)
> +		ps_matched = xcalloc(pathspec->nr, 1);
> +
> +	if (read_cache() < 0)
> +		die(_("index file corrupt"));
> +
> +	for (i = 0; i < active_nr; i++) {
> +		const struct cache_entry *ce = active_cache[i];
> +
> +		if (!match_pathspec(pathspec, ce->name, ce_namelen(ce),
> +				    max_prefix_len, ps_matched,
> +				    S_ISGITLINK(ce->ce_mode) | S_ISDIR(ce->ce_mode)))
> +			continue;
> +
> +		if (S_ISGITLINK(ce->ce_mode)) {
> +			ALLOC_GROW(ce_entries, ce_used + 1, ce_alloc);
> +			ce_entries[ce_used++] = ce;
> +		}
> +
> +		while (i + 1 < active_nr && !strcmp(ce->name, active_cache[i + 1]->name))
> +			/*
> +			 * Skip entries with the same name in different stages
> +			 * to make sure an entry is returned only once.
> +			 */
> +			i++;
> +	}

I hate myself not catching this earlier, but I suspect that this is
not quite a faithful rewrite of the original.  It changes behaviour
when a conflicted path records a non submodule in stage #1 and a
submodule in stage #2 (or stage #3), doesn't it?

The original scripted version will see the stage #1 entry and skips
it because it is not a submodule, then will see the stage #2 entry
and because the path is not yet in the %unmerged hash, and it will
push it to @out.

This loop instead sees a non-submodule entry at stage #1, skips it
(because it is not a submodule), then goes on to skip the entries
with the same name, including the stage #2 entry that _is_ a
submodule.

I think the clever "we are done with this entry, so let's skip all
others that have the same name" optimization should be done only
when we did handle an entry with the same name.  I.e. something like
this squashed in.
	
--------------------------------------------------

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 16d9abe..c4aff0c 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -39,12 +39,13 @@ static int module_list_compute(int argc, const char **argv,
 				    S_ISGITLINK(ce->ce_mode) | S_ISDIR(ce->ce_mode)))
 			continue;
 
-		if (S_ISGITLINK(ce->ce_mode)) {
-			ALLOC_GROW(ce_entries, ce_used + 1, ce_alloc);
-			ce_entries[ce_used++] = ce;
-		}
+		if (!S_ISGITLINK(ce->ce_mode))
+			continue;
 
-		while (i + 1 < active_nr && !strcmp(ce->name, active_cache[i + 1]->name))
+		ALLOC_GROW(ce_entries, ce_used + 1, ce_alloc);
+		ce_entries[ce_used++] = ce;
+		while (i + 1 < active_nr &&
+		       !strcmp(ce->name, active_cache[i + 1]->name))
 			/*
 			 * Skip entries with the same name in different stages
 			 * to make sure an entry is returned only once.

--------------------------------------------------

> +static int module_list(int argc, const char **argv, const char *prefix)
> +{
> +	int i;
> +	struct pathspec pathspec;
> +	const char *alternative_path;
> +
> +	struct option module_list_options[] = {
> +		OPT_STRING(0, "prefix", &alternative_path,
> +			   N_("path"),
> +			   N_("alternative anchor for relative paths")),
> +		OPT_END()
> +	};

Do we really need this alternative_path variable?  The "--prefix"
option that overrides the passed-in variable prefix would be easier
to understand if it touched the same variable, i.e.

--------------------------------------------------

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 16d9abe..387539f 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -65,10 +66,9 @@ static int module_list(int argc, const char **argv, const char *prefix)
 {
 	int i;
 	struct pathspec pathspec;
-	const char *alternative_path;
 
 	struct option module_list_options[] = {
-		OPT_STRING(0, "prefix", &alternative_path,
+		OPT_STRING(0, "prefix", &prefix,
 			   N_("path"),
 			   N_("alternative anchor for relative paths")),
 		OPT_END()
@@ -82,9 +82,7 @@ static int module_list(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, prefix, module_list_options,
 			     git_submodule_helper_usage, 0);
 
-	if (module_list_compute(argc, argv, alternative_path
-					    ? alternative_path
-					    : prefix, &pathspec) < 0) {
+	if (module_list_compute(argc, argv, prefix, &pathspec) < 0) {
 		printf("#unmatched\n");
 		return 1;
 	}

--------------------------------------------------
