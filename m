From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [WIP PATCH] revision-walk: --parent option to find children of
 a parent
Date: Thu, 30 Sep 2010 09:32:34 -0500
Message-ID: <20100930143234.GH4850@burratino>
References: <99aa4cd5a60b2b2d3eae962acb8a49c2a62a8f77.1285842569.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Sep 30 16:35:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P1KEf-0005Fx-Lp
	for gcvg-git-2@lo.gmane.org; Thu, 30 Sep 2010 16:35:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756397Ab0I3Ofm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Sep 2010 10:35:42 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:60152 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755750Ab0I3Ofl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Sep 2010 10:35:41 -0400
Received: by fxm4 with SMTP id 4so746281fxm.19
        for <git@vger.kernel.org>; Thu, 30 Sep 2010 07:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=EFkBa8jupFOX+cRumqTDRlS40DbpkUMkFVJk63S3SEY=;
        b=Tl+fooz4Hj0Q9sUsbMUu7mZ2492CqvONcxvpZ/z4adnIscfeifHQzyCWO1TvW1CF4V
         QNUXAYhQB+KGEtvRsla9kfnVozeO0FfCZxYpZ4oX9j9eqB8MMrss96HaWhMFoxbpjpbH
         LUwJEXXwNGD09QXloXUhmBtZNgoGTyGccTkxs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=V+TWqQjuJYi0IvnylS3Co/YbRopXV9DcSBrinCvV60VVa/ES+V7ZOUYLjF5rThsu3E
         Cji4wCg39BdXdB8lo3j+5x7bRZlN3Y1aS3Sd3Yjk4aafzZFamExhhPwRDCdG2IKN2ydo
         kv7ZSleAB7Yd5fOPPX9oUGelOod9yQTROiLvg=
Received: by 10.223.56.4 with SMTP id w4mr3785260fag.91.1285857339931;
        Thu, 30 Sep 2010 07:35:39 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id k15sm4542116fai.16.2010.09.30.07.35.37
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 30 Sep 2010 07:35:38 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <99aa4cd5a60b2b2d3eae962acb8a49c2a62a8f77.1285842569.git.git@drmicha.warpmail.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157674>

Hi,

Michael J Gruber wrote:

> Introduce a new --parent=<commit> option for the revision walker which
> limits the commits to those which have <commit> as one of their parents.

So this lists the direct children for a given commit.  Could you
mention a use case?  Why would one want to use this instead of

 the_commit=$(git rev-parse --verify <commit>) &&
 git rev-list --parents ... ^<commit> |
 grep -F " $the_commit"

?
 
> --- a/revision.c
> +++ b/revision.c
> @@ -1149,6 +1149,7 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
>  {
>  	const char *arg = argv[0];
>  	const char *optarg;
> +	unsigned char sha1[20];

Could this be given narrower scope?

> @@ -1989,6 +1999,14 @@ enum commit_action get_commit_action(struct rev_info *revs, struct commit *commi
>  		return commit_ignore;
>  	if (revs->merges_only && !(commit->parents && commit->parents->next))
>  		return commit_ignore;
> +	if (revs->parent_list) {
> +		struct commit_list *a, *b;
> +		for (b = revs->parent_list; b; b = b->next)
> +			for (a = commit->parents; a; a = a->next)
> +				if (!hashcmp(b->item->object.sha1, a->item->object.sha1))
> +					return commit_show;
> +		return commit_ignore;
> +	}

The implementation looks good.
