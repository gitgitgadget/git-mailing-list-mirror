From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] log --children
Date: Tue, 04 Oct 2011 22:12:28 +0200
Message-ID: <4E8B68AC.7020009@drmicha.warpmail.net>
References: <1317736923-20539-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 04 22:12:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBBLy-0000eW-71
	for gcvg-git-2@lo.gmane.org; Tue, 04 Oct 2011 22:12:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933645Ab1JDUMe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Oct 2011 16:12:34 -0400
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:35215 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933571Ab1JDUMc (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Oct 2011 16:12:32 -0400
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 159342A2A4;
	Tue,  4 Oct 2011 16:12:32 -0400 (EDT)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute5.internal (MEProxy); Tue, 04 Oct 2011 16:12:32 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=iGHSavVqf45UoM2+ON/Axu
	MPu4Y=; b=Sv8x0L8CyFdeDEIOkULg2WtegVuTRIZEtU9Yro2zelpecr21DwOdUZ
	lM4G+63mwAL2RgY/VnQRIj9PUaxaYCZ0Cm7tOKwjDwCxZKe5cVjo6GXAcKSiahhj
	5QqJdE0K0O7bfB3BlTpX5hTNO5fWhy/ueEuNqQDk17zpSw3P2e/zQ=
X-Sasl-enc: YVoYMOfTj0VC4L7ue7LcJ+thFWNypcfpk0D4khTlEmE3 1317759151
Received: from localhost.localdomain (p5485928F.dip0.t-ipconnect.de [84.133.146.143])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 51DB14C0E63;
	Tue,  4 Oct 2011 16:12:31 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:7.0) Gecko/20110927 Thunderbird/7.0
In-Reply-To: <1317736923-20539-1-git-send-email-jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182797>

Jay Soffian venit, vidit, dixit 04.10.2011 16:02:
> Teach git-log to support --children, which was added by f35f5603f4
> to the revision machinery, and by 72276a3ecb to rev-list, but
> was never added to git-log.
> 
> Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
> ---
>  log-tree.c |   12 ++++++++++++
>  1 files changed, 12 insertions(+), 0 deletions(-)
> 
> diff --git a/log-tree.c b/log-tree.c
> index 24c295ea1d..e7694a3a4c 100644
> --- a/log-tree.c
> +++ b/log-tree.c
> @@ -165,6 +165,14 @@ static void show_parents(struct commit *commit, int abbrev)
>  	}
>  }
>  
> +static void show_children(struct rev_info *opt, struct commit *commit, int abbrev)
> +{
> +	struct commit_list *p = lookup_decoration(&opt->children, &commit->object);
> +	for ( ; p; p = p->next) {
> +		printf(" %s", find_unique_abbrev(p->item->object.sha1, abbrev));
> +	}
> +}
> +
>  void show_decorations(struct rev_info *opt, struct commit *commit)
>  {
>  	const char *prefix;
> @@ -414,6 +422,8 @@ void show_log(struct rev_info *opt)
>  		fputs(find_unique_abbrev(commit->object.sha1, abbrev_commit), stdout);
>  		if (opt->print_parents)
>  			show_parents(commit, abbrev_commit);
> +		if (opt->children.name)
> +			show_children(opt, commit, abbrev_commit);

That means that "log --children --parents" will print out the parents'
sha1s, then the children's. Is that a good default format, or should we
somehow deal with the case when both are specified?

>  		show_decorations(opt, commit);
>  		if (opt->graph && !graph_is_commit_finished(opt->graph)) {
>  			putchar('\n');
> @@ -473,6 +483,8 @@ void show_log(struct rev_info *opt)
>  		      stdout);
>  		if (opt->print_parents)
>  			show_parents(commit, abbrev_commit);
> +		if (opt->children.name)
> +			show_children(opt, commit, abbrev_commit);
>  		if (parent)
>  			printf(" (from %s)",
>  			       find_unique_abbrev(parent->object.sha1,

And I guess we would like to test this...

Michael
