From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: git checkout under 1.7.6 does not properly list untracked files
 and aborts
Date: Wed, 21 Sep 2011 11:16:15 +0200
Message-ID: <4E79AB5F.5020809@drmicha.warpmail.net>
References: <4E6A7167.6070408@workspacewhiz.com> <4E779BA4.8070109@workspacewhiz.com> <4E78ACE2.60306@drmicha.warpmail.net> <4E78DACF.3030200@workspacewhiz.com> <4E7996AA.4040909@drmicha.warpmail.net> <4E79A04B.7080607@drmicha.warpmail.net> <20110921085842.GA29768@duynguyen-vnpc>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Joshua Jensen <jjensen@workspacewhiz.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 21 11:16:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R6Iup-0003ma-EQ
	for gcvg-git-2@lo.gmane.org; Wed, 21 Sep 2011 11:16:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752675Ab1IUJQU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Sep 2011 05:16:20 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:44098 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752216Ab1IUJQT (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Sep 2011 05:16:19 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway2.nyi.mail.srv.osa (Postfix) with ESMTP id 31D3A24CA7;
	Wed, 21 Sep 2011 05:16:19 -0400 (EDT)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute3.internal (MEProxy); Wed, 21 Sep 2011 05:16:19 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=lVecMx/wPLNd6JLaDfeYih
	SgO30=; b=ke4udZ4uQhjht2PEbl8otFMBH2N6FzyPix+y3iVx4SV6mDQ/v2TL3d
	ABHVSX7q+yqlm+6eujHIZUEKCfwa53EyFYCblT4QaYkf8Pjw/tuv3pG5r54sw0Jk
	UrgJMlz6bkAFUw0hghv6c13hReyQHtgoR20JLFxjobd+KeEwbA4Dg=
X-Sasl-enc: eXdBg9HHMxrFOxFVZ7xjvCLM0Ekyl9E/gd7pxY3H0tmS 1316596578
Received: from localhost.localdomain (p548594C9.dip0.t-ipconnect.de [84.133.148.201])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 696227C0642;
	Wed, 21 Sep 2011 05:16:18 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:6.0.2) Gecko/20110906 Thunderbird/6.0.2
In-Reply-To: <20110921085842.GA29768@duynguyen-vnpc>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181828>

Nguyen Thai Ngoc Duy venit, vidit, dixit 21.09.2011 10:58:
> On Wed, Sep 21, 2011 at 10:28:59AM +0200, Michael J Gruber wrote:
>> So, I bisected it. The first bad commit is
>>
>> 9037026 (unpack-trees: fix sparse checkout's "unable to match
>> directories", 2010-11-27)
>>
>> although the real culprit may be its predecessor
>>
>> 2431afb (unpack-trees: move all skip-worktree checks back to
>> unpack_trees(), 2010-11-27)
>>
>> which does not compile:
>>
>>     CC unpack-trees.o
>> unpack-trees.c: In function 'mark_new_skip_worktree':
>> unpack-trees.c:852:75: error: 'o' undeclared (first use in this function)
>> unpack-trees.c:852:75: note: each undeclared identifier is reported only
>> once for each function it appears in
>> make: *** [unpack-trees.o] Error 1
> 
> This may help
> 
> --8<--
> diff --git a/unpack-trees.c b/unpack-trees.c
> index a6518db..a239af7 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -245,13 +245,13 @@ static int check_updates(struct unpack_trees_options *o)
>  static int verify_uptodate_sparse(struct cache_entry *ce, struct unpack_trees_options *o);
>  static int verify_absent_sparse(struct cache_entry *ce, enum unpack_trees_error_types, struct unpack_trees_options *o);
>  
> -static int will_have_skip_worktree(const struct cache_entry *ce, struct unpack_trees_options *o)
> +static int will_have_skip_worktree(const struct cache_entry *ce, struct exclude_list *el)
>  {
>  	const char *basename;
>  
>  	basename = strrchr(ce->name, '/');
>  	basename = basename ? basename+1 : ce->name;
> -	return excluded_from_list(ce->name, ce_namelen(ce), basename, NULL, o->el) <= 0;
> +	return excluded_from_list(ce->name, ce_namelen(ce), basename, NULL, el) <= 0;
>  }
> 
>  static int apply_sparse_checkout(struct cache_entry *ce, struct unpack_trees_options *o)
> @@ -849,7 +849,7 @@ static void mark_new_skip_worktree(struct exclude_list *el,
>  		if (select_flag && !(ce->ce_flags & select_flag))
>  			continue;
>  
> -		if (!ce_stage(ce) && will_have_skip_worktree(ce, o))
> +		if (!ce_stage(ce) && will_have_skip_worktree(ce, el))
>  			ce->ce_flags |= skip_wt_flag;
>  		else
>  			ce->ce_flags &= ~skip_wt_flag;
> --8<--
> 
>> Duy, sorry for prodding you again.
> 
> No problem (and sorry for breaking the build). I'll also have a look
> at this problem.

Thanks. I can confirm that with the above patch, the code compiles and
fails my test. So it's the earlier of the two commits which introduces this.

Michael
