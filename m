From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] submodule: implement `module_list` as a builtin helper
Date: Fri, 07 Aug 2015 12:53:16 -0700
Message-ID: <xmqqwpx6yixf.fsf@gitster.dls.corp.google.com>
References: <1438733070-15805-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, jens.lehmann@web.de, hvoigt@hvoigt.net
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Aug 07 21:53:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZNnhj-0002QZ-FY
	for gcvg-git-2@plane.gmane.org; Fri, 07 Aug 2015 21:53:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932092AbbHGTxT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Aug 2015 15:53:19 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:34754 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751373AbbHGTxS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Aug 2015 15:53:18 -0400
Received: by pawu10 with SMTP id u10so95254220paw.1
        for <git@vger.kernel.org>; Fri, 07 Aug 2015 12:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=H0t7MT+gEgmKYGZ3vLNNRkeXQLKW6xLHZpr/EXgMGpo=;
        b=UmHCWUB3xnSqG4K4eRAHP4UgprzIpcc848qSpPy2NOk/i5Vl5iqjgbKcz0r4PPhOZ3
         LrijtGliBPFlasR4G+/XrJ2moHonzT1kBSxvTxa8zxdT0nASubyanIuw9nEgNQipXqV1
         lNeW9xjxORlUiXlm7Rw0tWxKqtigFN1ExUgJWZFwTvbI9+QkZ1Xdh+YBk+03qIvGkjIa
         Gf93roSOU1DOmVEI2QG1145Z/VrB5rWSTsuhBUWOQEFUp23xijmBq4+j8zahB3Jaf2jK
         qfVr+dwV1C85AvHUTksjuNLypO1prlu/+u5fxSaEirtT42xhM5XdOHtuuqcJcysixCHo
         iutA==
X-Received: by 10.68.205.232 with SMTP id lj8mr18393979pbc.116.1438977197932;
        Fri, 07 Aug 2015 12:53:17 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:6597:23b2:a33a:2b5b])
        by smtp.gmail.com with ESMTPSA id fj6sm11057051pdb.21.2015.08.07.12.53.16
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 07 Aug 2015 12:53:17 -0700 (PDT)
In-Reply-To: <1438733070-15805-1-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Tue, 4 Aug 2015 17:04:29 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275482>

Stefan Beller <sbeller@google.com> writes:

> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> new file mode 100644
> index 0000000..cb18ddf
> --- /dev/null
> +++ b/builtin/submodule--helper.c
> @@ -0,0 +1,111 @@
> + ...
> +static char *ps_matched;
> +static const struct cache_entry **ce_entries;
> +static int ce_alloc, ce_used;
> +static struct pathspec pathspec;
> +static const char *alternative_path;

These are OK for now to be global variables, but in the longer run,
I think you would need to introduce a struct or two that group the
relevant pieces and passed around the callchain.  For example, a
caller calling into module_list_compute() would want to pass a
pointer to a struct that has ce_entries[] and ps_matched to receive
the result.  pathspec and alternative_path would want to be a
function-scope auto variable in module_list, I would think.

> +static void module_list_compute(int argc, const char **argv,
> +				const char *prefix,
> +				struct pathspec *pathspec)
> +{
> +	int i;
> +	char *max_prefix;
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
> +		ps_matched = xcalloc(1, pathspec->nr);
> +
> +
> +	if (read_cache() < 0)
> +		die("index file corrupt");

Again, this is OK for now, but I suspect you would eventually want
to return an error and have the caller react to it.

> +static int module_list(int argc, const char **argv, const char *prefix)
> +{
> +...
> +	for (i = 0; i < ce_used; i++) {
> +		const struct cache_entry *ce = ce_entries[i];
> +
> +		if (string_list_has_string(&already_printed, ce->name))
> +			continue;
> +
> +		if (ce_stage(ce)) {
> +			printf("%06o %s U\t", ce->ce_mode, sha1_to_hex(null_sha1));
> +		} else {
> +			printf("%06o %s %d\t", ce->ce_mode, sha1_to_hex(ce->sha1), ce_stage(ce));
> +		}
> +
> +		utf8_fprintf(stdout, "%s\n", ce->name);
> +
> +		string_list_insert(&already_printed, ce->name);

This looks a wasteful use of string-list.

When we iterate over the in-core index, or a subset obtained from
the in-core index without reordering, the standard technique to
handle entries for the same path only once is to handle one (while
remembering what it is) and then skip the ones that follow with the
same name, with a loop like this:

	i = 0;
        while (i < ce_used) {
        	ce = ce_entries[i++];
		use that ce;
                while (i < ce_used && !strcmp(ce->ce_name, ce_entries[i]->ce_name))
			i++; /* skip entries with the same name */
	}

Take advantage of the fact that the entries are still sorted.
