From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 08/10] revert: Introduce HEAD, TODO files to persist
 state, plan
Date: Thu, 26 May 2011 11:11:02 -0500
Message-ID: <20110526161102.GC24931@elie>
References: <1306333025-29893-1-git-send-email-artagnon@gmail.com>
 <1306425233-504-1-git-send-email-artagnon@gmail.com>
 <1306425233-504-9-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Christian Couder <christian.couder@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 26 18:11:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPd9W-0005WZ-GK
	for gcvg-git-2@lo.gmane.org; Thu, 26 May 2011 18:11:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758054Ab1EZQLJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 May 2011 12:11:09 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:56494 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756512Ab1EZQLI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2011 12:11:08 -0400
Received: by vws1 with SMTP id 1so647972vws.19
        for <git@vger.kernel.org>; Thu, 26 May 2011 09:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=JceMgmHJkTbHUwGDbmcwhXfJXe1GvwB6aJL2CoCOzI8=;
        b=D8UhTMnFK3PDcSe/0UrxKe1LZBIQ7W8niZKion4CTMM5gbzoN+/skEHI9U+EEIKK+d
         nqTullstkzVQ8JkTgK2jrTDJ6ct2snRsTyCGH71fgTM4EeR+uRN13C5x3SqIW8/WAbBE
         kf7CXkhl/7wRZ8RpISvD4SMjW1aWtouo6gXI8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=LUX7wSnVo6P/CMzO1gJRaqYm6bphvBh+KR5qJcCx82PU5gjoRqM9QEzqcuyUnBS4LU
         8mwYL1YQqc6UBDgkAmCyDO26I1qHbIy1oPyGl3awekiV5AraEjl8zNuRTvF4RE3BV7yB
         b+8lmWYPmO2rHmi+VSyYUuULZLhi3yb77joZk=
Received: by 10.52.100.163 with SMTP id ez3mr1240673vdb.150.1306426267085;
        Thu, 26 May 2011 09:11:07 -0700 (PDT)
Received: from elie (adsl-69-209-65-98.dsl.chcgil.ameritech.net [69.209.65.98])
        by mx.google.com with ESMTPS id dm3sm496731vdb.19.2011.05.26.09.11.05
        (version=SSLv3 cipher=OTHER);
        Thu, 26 May 2011 09:11:06 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1306425233-504-9-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174540>

Ramkumar Ramachandra wrote:

> --- a/builtin/revert.c
> +++ b/builtin/revert.c
> @@ -573,22 +580,86 @@ static void read_and_refresh_cache(const char *me, struct replay_opts *opts)
[...]
>  	prepare_revs(&revs, opts);
> +	persist_head(head);
> +	persist_todo(revs.commits, opts);
>  
>  	while ((commit = get_revision(&revs))) {
>  		int res = do_pick_commit(commit, opts);
> -		if (res)
> +		if (res) {
> +			commit_list_insert(commit, &revs.commits);
> +			persist_todo(revs.commits, opts);
>  			return res;
> +		}
>  	}

Almost there.  To comfort overly-worried people like me that think we
have not finished converted all die() calls yet, wouldn't this need to
look like

	persist_head(head);
	while ((commit = ...)) {
		int status_or_error;

		/*
		 * Checkpoint.  If do_pick_commit exits, make sure the user
		 * can still use "git cherry-pick --continue" to recover.
		 */
		persist_todo(revs.commits, opts);

		status_or_error = do_pick_commit(...);
		if (status_or_error)
			return status_or_error;
	}

	/* Success! */
	remove_todo(opts);
	remove_head();
	return 0;

And with that, this would no longer depend on the (valuable enough on
their own terms) patches 1 and 2 so they could be treated as a
separate series, no?
