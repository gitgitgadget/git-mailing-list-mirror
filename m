From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] add receive.denyNonFastforwards config variable
Date: Wed, 20 Sep 2006 15:44:06 -0700
Message-ID: <7vfyemf9ah.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0609210027430.19042@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Sep 21 00:44:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQAnd-0005Z3-SP
	for gcvg-git@gmane.org; Thu, 21 Sep 2006 00:44:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932432AbWITWoK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Sep 2006 18:44:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932433AbWITWoK
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Sep 2006 18:44:10 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:49075 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S932432AbWITWoH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Sep 2006 18:44:07 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060920224407.BAMN12909.fed1rmmtao05.cox.net@fed1rmimpo01.cox.net>;
          Wed, 20 Sep 2006 18:44:07 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Qmjs1V00e1kojtg0000000
	Wed, 20 Sep 2006 18:43:53 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0609210027430.19042@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Thu, 21 Sep 2006 00:28:35 +0200
	(CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27421>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> If receive.denyNonFastforwards is set to true, git-receive-pack will deny
> non fast-forwards, i.e. forced updates. Most notably, a push to a repository
> which has that flag set to true will fail.
>
> As a first user, 'git-init-db --shared' sets this flag, since in a shared
> setup, you are most unlikely to want forced pushes to succeed.

I am Ok with the general idea, but ...

> @@ -127,6 +129,16 @@ static int update(struct command *cmd)
>  		return error("unpack should have generated %s, "
>  			     "but I can't find it!", new_hex);
>  	}
> +	if (deny_non_fast_forwards) {
> +		struct commit *old_commit, *new_commit;
> +		old_commit = (struct commit *)parse_object(old_sha1);
> +		new_commit = (struct commit *)parse_object(new_sha1);
> +		struct commit_list *bases = get_merge_bases(old_commit,
> +				new_commit, 1);
> +		if (!bases || hashcmp(old_sha1, bases->item->object.sha1))
> +			return error("denying non-fast forward;"
> +					" you should pull first");
> +	}
>  	safe_create_leading_directories(lock_name);
>  
>  	newfd = open(lock_name, O_CREAT | O_EXCL | O_WRONLY, 0666);

I am wondering if there can be more than one base and the old_sha1
is not returned as the first one.
