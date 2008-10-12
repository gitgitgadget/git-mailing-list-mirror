From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] fetch: refuse to fetch into the current branch in a
	non-bare repository
Date: Sun, 12 Oct 2008 11:52:09 -0700
Message-ID: <20081012185209.GB5255@spearce.org>
References: <alpine.DEB.1.00.0810111336350.22125@pacific.mpi-cbg.de.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Oct 12 20:53:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kp64A-000625-To
	for gcvg-git-2@gmane.org; Sun, 12 Oct 2008 20:53:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754218AbYJLSwL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Oct 2008 14:52:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754191AbYJLSwK
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Oct 2008 14:52:10 -0400
Received: from george.spearce.org ([209.20.77.23]:58394 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754086AbYJLSwK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Oct 2008 14:52:10 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 49FF03835F; Sun, 12 Oct 2008 18:52:09 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0810111336350.22125@pacific.mpi-cbg.de.mpi-cbg.de>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98048>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> diff --git a/builtin-fetch.c b/builtin-fetch.c
> index ee93d3a..d701550 100644
> --- a/builtin-fetch.c
> +++ b/builtin-fetch.c
> @@ -534,6 +534,25 @@ static void find_non_local_tags(struct transport *transport,
>  	string_list_clear(&new_refs, 0);
>  }
>  
> +static void check_ref_map(struct ref *ref_map)
> +{
> +	int flag;
> +	unsigned char sha1[20];
> +	const char *HEAD;
> +
> +	if (is_bare_repository())
> +		return;
> +
> +	HEAD = resolve_ref("HEAD", sha1, 1, &flag);

I'd rather see local variables named lowercase.  Constants should
be the only thing that is all uppercase.

> @@ -558,6 +577,7 @@ static int do_fetch(struct transport *transport,
>  	}
>  
>  	ref_map = get_ref_map(transport, refs, ref_count, tags, &autotags);
> +	check_ref_map(ref_map);

This should only be called if update_head_ok is false.  So maybe:

	if (!update_head_ok)
		check_ref_map(ref_map)
  
> diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
> index 9aae496..cd8b550 100755
> --- a/t/t5510-fetch.sh
> +++ b/t/t5510-fetch.sh
> @@ -323,4 +323,10 @@ test_expect_success 'auto tag following fetches minimum' '
>  	)
>  '
>  
> +test_expect_success 'refuse to fetch into the current branch' '
> +
> +	test_must_fail git fetch . side:master
> +
> +'
> +

Repeat this test, but with --update-head-ok and expect success,
since the check_ref_map logic is conditional on that?

-- 
Shawn.
