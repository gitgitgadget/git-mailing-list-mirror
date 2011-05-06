From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v5] Add default merge options for all branches
Date: Fri, 6 May 2011 16:32:57 -0500
Message-ID: <20110506213257.GD20182@elie>
References: <20110503090351.GA27862@elie>
 <4DC1CE16.5030808@dailyvoid.com>
 <7vsjsuc704.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Grubb <devel@dailyvoid.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 06 23:33:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QISe7-0000pb-Av
	for gcvg-git-2@lo.gmane.org; Fri, 06 May 2011 23:33:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932848Ab1EFVdG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2011 17:33:06 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:35054 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932792Ab1EFVdD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2011 17:33:03 -0400
Received: by iwn34 with SMTP id 34so3002215iwn.19
        for <git@vger.kernel.org>; Fri, 06 May 2011 14:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=gQX+CXBmgY88k+y40O2l9YRiqMYkWE7EqutzC5T7xpI=;
        b=D2aGxliMxN1dF+UlWyqIun4cudYSwfX6O/fDTyBfaD+AKb1ZG/tRqQZJWnjIXO1+A2
         xruA0XeBo2AfFAo82REWhuqFH/xcqGJsQ1hVNwAahjEncz+OMaa3yEi/lkS1/NmITm2x
         lcDE8I9meys480YJKwZ1z3I2svBePy5mNmVP4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=GCtnqhrz46AKn5dynG3otxyruvvIxuQsNPROzGGIa48+1bCYE1CAxngxWHYtIsIW4y
         eha0p4XxSAVkG6q7jRQUNqrb70Wx46abW+O6zMQoowXQaYVco0uTsfg8G9QtJrjrrQL5
         mo2xI5ejfYB/yOHVUuB2fg48DzZLuxR/TRut0=
Received: by 10.231.117.7 with SMTP id o7mr2660927ibq.46.1304717583315;
        Fri, 06 May 2011 14:33:03 -0700 (PDT)
Received: from elie ([76.206.232.100])
        by mx.google.com with ESMTPS id c1sm1485069ibe.17.2011.05.06.14.33.00
        (version=SSLv3 cipher=OTHER);
        Fri, 06 May 2011 14:33:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vsjsuc704.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173011>

Junio C Hamano wrote:

> Subject: [PATCH] merge: fix branch.<name>.mergeoptions

To be more precise, if I understand correctly:

	merge: allow branch.<name>.mergeoptions to override merge.*

> This patch should fix it, even though I now strongly suspect that
> branch.<name>.mergeoptions that gives a single command line that
> needs to be parsed was likely to be an ill-conceived idea to begin
> with.  Sigh...

Yes, and introducing branch.<name>.ff and branch.<name>.log might
still be a good idea.

The patch looks mostly good.  I see only one actual problem, marked
with [*] below.

> --- a/builtin-merge.c
> +++ b/builtin-merge.c
> @@ -54,6 +54,7 @@ static size_t use_strategies_nr, use_strategies_alloc;
>  static const char **xopts;
>  static size_t xopts_nr, xopts_alloc;
>  static const char *branch;
> +static char *branch_mergeoptions;
>  static int verbosity;
>  static int allow_rerere_auto;
>  
> @@ -474,25 +475,33 @@ cleanup:
>  	strbuf_release(&bname);
>  }
>  
> +static void parse_branch_merge_options(char *bmo)
> +{
> +	const char **argv;
> +	int argc;
> +	char *buf;
> +
> +	if (!bmo)
> +		return;
> +	argc = split_cmdline(bmo, &argv);
> +	if (argc < 0)
> +		die("Bad branch.%s.mergeoptions string", branch);
> +	argv = xrealloc(argv, sizeof(*argv) * (argc + 2));
> +	memmove(argv + 1, argv, sizeof(*argv) * (argc + 1));

This is not new code, but it might make sense to do

	argv[0] = "merge.*.options";

for a saner error message when someone tries

	[branch "master"]
		mergeoptions = --nonsense

> +	argc++;
> +	parse_options(argc, argv, NULL, builtin_merge_options,
> +		      builtin_merge_usage, 0);
> +	free(buf);

[*]
This buf seems to be left over.  (I don't think the intent is to
call free on an uninitialized pointer. ;-))

[...]
> -		free(buf);
> +		free(branch_mergeoptions);
> +		branch_mergeoptions = xstrdup(v);

It is tempting to do

	size_t len;

	len = strlen(v);
	branch_mergeoptions = xrealloc(branch_mergeoptions, len + 1);
	memcpy(branch_mergeoptions, v, len + 1);

but free + xstrdup is simpler and clearer.  Makes sense.

> +test_expect_success 'merge c1 with c2 (log in config gets overridden)' '
> +	(
> +		git config --remove-section branch.master
> +		git config --remove-section merge
> +	)

Since this patch is meant to apply to a very old git, we cannot use
test_might_fail.  Makes sense: it can be fixed up later to use
&&-friendly syntax as part of a series introducing checks to make
sure we don't regress in that.

Thanks and hope that helps,
Jonathan
