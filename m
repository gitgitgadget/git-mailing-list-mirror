From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 1/2] submodule: implement `module_list` as a builtin helper
Date: Fri, 31 Jul 2015 18:01:50 -0700
Message-ID: <xmqqmvybakjl.fsf@gitster.dls.corp.google.com>
References: <1438384147-3275-1-git-send-email-sbeller@google.com>
	<1438384147-3275-2-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jens.Lehmann@web.de, hvoigt@hvoigt.net
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Sat Aug 01 03:01:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZLLBV-0003dS-Ip
	for gcvg-git-2@plane.gmane.org; Sat, 01 Aug 2015 03:01:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752616AbbHABBx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Jul 2015 21:01:53 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:36602 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751671AbbHABBw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Jul 2015 21:01:52 -0400
Received: by pachj5 with SMTP id hj5so48649121pac.3
        for <git@vger.kernel.org>; Fri, 31 Jul 2015 18:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=2iMVSmBVfhndq8dUZqh8wT+4g7ZDXdBWyC/ko2eE0Bc=;
        b=ylX998YnCU1v8XlPNK4JrITKesSRkykzHOs6WARyBim+Bfoz/y/57afIQi7VyXv2Ad
         ULBAe73UysBP96vueNgoDt55pq0QPQmd4wLh4xjI0z1GKAjOi5ndzQjZYOaan+xW069B
         RX+Hs0esYUVphLdoSfbF1RBQL7tFkcpJFKPkz5omahVcrhedmnE6rhkgVB4B39TPeRW0
         XLui/EABViVpwRxyvgexQanyvYez1/7nKcFdCoccHCeOdhKC2lHGiFm3F+qZdLT16YIi
         8nrfyNp9HmpAXRaHU/0rD7M/IYkYir9wpN3ggh81g1jaPhOX8X1wcVRKZEIzQ3GERQkc
         adNg==
X-Received: by 10.66.184.197 with SMTP id ew5mr13241342pac.54.1438390912211;
        Fri, 31 Jul 2015 18:01:52 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:1b0:46e8:ba02:35e3])
        by smtp.gmail.com with ESMTPSA id bo10sm9686006pdb.83.2015.07.31.18.01.51
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 31 Jul 2015 18:01:51 -0700 (PDT)
In-Reply-To: <1438384147-3275-2-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Fri, 31 Jul 2015 16:09:06 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275102>

Stefan Beller <sbeller@google.com> writes:

> +static const char * const git_submodule_helper_usage[] = {
> +	N_("git submodule--helper --module_list [<path>...]"),

Yuck.  Please do not force --multi_word_opt upon us, which is simply
too ugly to live around here.  --module-list is perhaps OK, but
because submodule--helper would not have an default action, I'd
prefer to make these just "command words", i.e.

    $ git submodule--helper module_list

> +int module_list(int argc, const char **argv, const char *prefix)
> +{
> +	int i;
> +	static struct pathspec pathspec;
> +	const struct cache_entry **ce_entries = NULL;
> +	int alloc = 0, used = 0;
> +	char *ps_matched = NULL;
> +	char *max_prefix;
> +	int max_prefix_len;
> +	struct string_list already_printed = STRING_LIST_INIT_NODUP;
> +
> +	parse_pathspec(&pathspec, 0,
> +		       PATHSPEC_PREFER_FULL,
> +		       prefix, argv);
> +
> +	/* Find common prefix for all pathspec's */
> +	max_prefix = common_prefix(&pathspec);
> +	max_prefix_len = max_prefix ? strlen(max_prefix) : 0;
> +
> +	if (pathspec.nr)
> +		ps_matched = xcalloc(1, pathspec.nr);

Up to this point it interprets its input, and ...

> +	if (read_cache() < 0)
> +		die("index file corrupt");
> +
> +	for (i = 0; i < active_nr; i++) {
> +		const struct cache_entry *ce = active_cache[i];
> +
> +		if (!match_pathspec(&pathspec, ce->name, ce_namelen(ce),
> +				    max_prefix_len, ps_matched,
> +				    S_ISGITLINK(ce->ce_mode) | S_ISDIR(ce->ce_mode)))
> +			continue;
> +
> +		if (S_ISGITLINK(ce->ce_mode)) {
> +			ALLOC_GROW(ce_entries, used + 1, alloc);
> +			ce_entries[used++] = ce;
> +		}
> +	}
> +
> +	if (ps_matched && report_path_error(ps_matched, &pathspec, prefix)) {
> +		printf("#unmatched\n");
> +		return 1;
> +	}

... does the computation, with diagnosis.

And then it does the I/O with formatting.

> +
> +	for (i = 0; i < used; i++) {
> +		const struct cache_entry *ce = ce_entries[i];
...
> +	return 0;
> +}

When you have the implementation of "foreach-parallel" to move the
most expensive part of "submodule update" of a tree with 500
submodules, you would want to receive more or less the same "args"
as this thing takes and pass the ce_entries[] list to the "spawn and
run the user script in them in parallel" engine.

So I think it makes more sense to split this function into two (or
three).  One that reads from (argc, argv) and allocates and fills
ce_entries[] can become a helper that you can reuse later.  

'int module_list()' (shouldn't it be static?), can make a call to
that helper at the begining of it, and the remainder of the function
would do the textual I/O.
