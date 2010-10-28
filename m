From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 06/10] Change incorrect "remote branch" to "remote
 tracking branch" in C code
Date: Thu, 28 Oct 2010 14:13:03 -0500
Message-ID: <20101028191303.GE14212@burratino>
References: <1287851481-27952-1-git-send-email-Matthieu.Moy@imag.fr>
 <1288290117-6734-7-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com,
	Thore Husfeldt <thore.husfeldt@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Thu Oct 28 21:13:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBXuW-0006ZR-Bh
	for gcvg-git-2@lo.gmane.org; Thu, 28 Oct 2010 21:13:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760202Ab0J1TNM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Oct 2010 15:13:12 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:52579 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755840Ab0J1TNK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Oct 2010 15:13:10 -0400
Received: by gxk23 with SMTP id 23so1514884gxk.19
        for <git@vger.kernel.org>; Thu, 28 Oct 2010 12:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=565TiticDwlIAxxLBgG/Co/zEopaez05bVGWNdzlQF4=;
        b=vWetlShJ6soWTdBiarXqg5w4OO3JgtDVEkbVnSQ2OO+DZL2sNnR9gasJr3k4kKMQZ/
         wbU7whOLYiuqDKrfTKooIrLEsA6jEhlVzYF7iDiCLIaSlznBAC3GaDsR/scmccIMKpMh
         DnqClOzxQa5xvuQX0tLrRNvP4s7QwrfEOO12E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=D4mx9uw9FQJxtBJTpKKGceoZC/35J6CkkOnjyuRYjARPSS2n9Dz7CctTXroQhmC3LU
         EfN1Ld0tLp6LuliIeN3PAiNOGSQtOc4z1wC+oSgGDC86Oq+/Nlz15RG860xungzpY/LB
         D2M4s7A41L63JEtkC78nKvKcUPFUq2UkzA9Z8=
Received: by 10.223.79.68 with SMTP id o4mr4353862fak.0.1288293188974;
        Thu, 28 Oct 2010 12:13:08 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id n8sm665546faa.7.2010.10.28.12.13.07
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 28 Oct 2010 12:13:08 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1288290117-6734-7-git-send-email-Matthieu.Moy@imag.fr>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160212>

Matthieu Moy wrote:

> --- a/branch.h
> +++ b/branch.h
> @@ -22,7 +22,7 @@ void create_branch(const char *head, const char *name, const char *start_name,
>  void remove_branch_state(void);
>  
>  /*
> - * Configure local branch "local" to merge remote branch "remote"
> + * Configure local branch "local" to merge remote-tracking branch "remote"
>   * taken from origin "origin".
>   */
>  #define BRANCH_CONFIG_VERBOSE 01

This still seems inaccurate (and even misleading).  Presumably you mean

	             ... to merge remote-tracking branch "origin/remote"
	based on origin "origin".

or

	             ... to merge remote branch "remote"
	taken from origin "origin"

or even better,

	Configure local branch "local" as downstream to branch "remote"
	from remote "origin".  Used by git branch --set-upstream.

More confusion could presumably be avoided by renaming the parameters.

> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -359,7 +359,7 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
>  			what = rm->name + 10;
>  		}
>  		else if (!prefixcmp(rm->name, "refs/remotes/")) {
> -			kind = "remote branch";
> +			kind = "remote-tracking branch";
>  			what = rm->name + 13;

I didn't follow before --- what concrete effect does this have?  Are
scripts affected?  Is fmt-merge-msg affected?

> --- a/builtin/remote.c
> +++ b/builtin/remote.c
> @@ -791,9 +791,9 @@ static int rm(int argc, const char **argv)
>  
>  	if (skipped.nr) {
>  		fprintf(stderr, skipped.nr == 1 ?
> -			"Note: A non-remote branch was not removed; "
> +			"Note: A branch outside the refs/remotes/ hierarchy was not removed;\n"
>  			"to delete it, use:\n" :
> -			"Note: Non-remote branches were not removed; "
> +			"Note: Some branches outside the refs/remotes/ hierarchy were not removed;\n"
>  			"to delete them, use:\n");
>  		for (i = 0; i < skipped.nr; i++)
>  			fprintf(stderr, "  git branch -d %s\n",

Nice.

Maybe the commit message should explain the reasoning, something like:

 The non-deleted branch is somehow remote-tracking since "fetch" feeds
 it, and the code detecting this case is:

	/* don't delete non-remote-tracking refs */
	if (prefixcmp(refname, "refs/remotes")) {
		/* advise user how to delete local branches */
		if (!prefixcmp(refname, "refs/heads/"))
			string_list_append(branches->skipped,
					   abbrev_branch(refname));
		/* silently skip over other non-remote refs */
		return 0;
	}
 
 hence, really "branches outside the refs/remotes/ hierarchy".

Thanks for your tireless work.  Everything not mentioned above looks good.
