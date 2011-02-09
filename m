From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v3 3/3] Add support for merging from upstream by default.
Date: Tue, 8 Feb 2011 19:41:29 -0600
Message-ID: <20110209014129.GB24346@elie>
References: <1297198129-3403-1-git-send-email-jaredhance@gmail.com>
 <1297211028-14382-1-git-send-email-jaredhance@gmail.com>
 <1297211028-14382-4-git-send-email-jaredhance@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jared Hance <jaredhance@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 09 02:41:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pmz3r-0000Pk-VM
	for gcvg-git-2@lo.gmane.org; Wed, 09 Feb 2011 02:41:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756022Ab1BIBle (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Feb 2011 20:41:34 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:50455 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755950Ab1BIBle (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Feb 2011 20:41:34 -0500
Received: by iyj8 with SMTP id 8so3896615iyj.19
        for <git@vger.kernel.org>; Tue, 08 Feb 2011 17:41:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=bGTGMJbSj6sqmhGL3p5uq1TkAu1P5fYybWfwto160FY=;
        b=iFOhCbZOXgQVmrrNjZavi+hJtixzdXx20bsZtuB55+FYfw4Wtp7UTZPWZVKjPP63d3
         5tkzunGbntERO/lROi+Ls0c5hlofwr0Z2jVOQC8AxWuHiss6kFHruzkkrSnfslMVESWY
         usLLuZgxNW7Vy5ohJBomP706IyCaHuck/ilmY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=iQSZDqJF8Mj/PlSaD7WVQSdCT60s1GjscJ7+BeBCxVlEQzjGISvzXXp/oV/wFw+fhJ
         4YuP51tV7haSXfGB0qadj3qjWVGvumCchCodedKVlMPKZulovFFZKEuGQ14ZnNhJBT7w
         02lzbKemDFl4PWEf8Lg7WkydpYiXIUqYyxCOo=
Received: by 10.42.227.9 with SMTP id iy9mr14213366icb.128.1297215693447;
        Tue, 08 Feb 2011 17:41:33 -0800 (PST)
Received: from elie (adsl-76-206-235-233.dsl.chcgil.sbcglobal.net [76.206.235.233])
        by mx.google.com with ESMTPS id d21sm178012ibg.15.2011.02.08.17.41.31
        (version=SSLv3 cipher=OTHER);
        Tue, 08 Feb 2011 17:41:32 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1297211028-14382-4-git-send-email-jaredhance@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166385>

Jared Hance wrote:

> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -1389,6 +1389,12 @@ man.<tool>.path::
> 
>  include::merge-config.txt[]
> 
> +merge.defaultUpstream::
[...]

Might make sense to put this in merge-config.txt, to get documentation
in git-merge(1) for free.

> --- a/builtin/merge.c
> +++ b/builtin/merge.c
> @@ -525,6 +527,8 @@ static int per_branch_config(const char *k, const char *v, void *cb)
>  
>  		return 0;
>  	}
> +	else if (!strcmp(variable, ".merge"))
> +		return git_config_string(&upstream_branch, k, v);

Style:

	} else if (...) {
		return git_config_string(...);
	}

> @@ -1017,9 +1023,13 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
>  	if (!allow_fast_forward && fast_forward_only)
>  		die("You cannot combine --no-ff with --ff-only.");
>  
> -	if (!argc)
> -		usage_with_options(builtin_merge_usage,
> -			builtin_merge_options);
> +	if (!argc) {
> +		if (!default_upstream || !upstream_branch)
> +			usage_with_options(builtin_merge_usage,
> +					builtin_merge_options);
> +		else
> +			setup_merge_commit(&buf, &remotes, upstream_branch);

Why the "else"?  usage_msg_opt doesn't return to the caller.

Hopefully someone will chime in with some tests to complement
t5520-pull (hint, hint). :)

Jonathan

diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index c1efaaa..bc8ce25 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -11,7 +11,7 @@ SYNOPSIS
 [verse]
 'git merge' [-n] [--stat] [--no-commit] [--squash]
 	[-s <strategy>] [-X <strategy-option>]
-	[--[no-]rerere-autoupdate] [-m <msg>] <commit>...
+	[--[no-]rerere-autoupdate] [-m <msg>] [<commit>...]
 'git merge' <msg> HEAD <commit>...
 'git merge' --abort
 
@@ -97,7 +97,10 @@ commit or stash your changes before running 'git merge'.
 	Commits, usually other branch heads, to merge into our branch.
 	You need at least one <commit>.  Specifying more than one
 	<commit> obviously means you are trying an Octopus.
-
++
+By default, if no commit is specified then git will error out.
+However, the `merge.defaultToUpstream` configuration item (see below)
+changes that.
 
 PRE-MERGE CHECKS
 ----------------
