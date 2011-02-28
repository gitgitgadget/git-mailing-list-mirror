From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Limit file descriptors used by packs
Date: Mon, 28 Feb 2011 12:47:27 -0800
Message-ID: <20110228204727.GB26052@spearce.org>
References: <1298924835-23413-1-git-send-email-spearce@spearce.org>
 <7vwrkjhp27.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 28 21:47:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PuA0F-0006vE-C7
	for gcvg-git-2@lo.gmane.org; Mon, 28 Feb 2011 21:47:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753899Ab1B1Ura (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Feb 2011 15:47:30 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:38686 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752805Ab1B1Ura (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Feb 2011 15:47:30 -0500
Received: by pwi15 with SMTP id 15so794349pwi.19
        for <git@vger.kernel.org>; Mon, 28 Feb 2011 12:47:29 -0800 (PST)
Received: by 10.142.128.19 with SMTP id a19mr4697329wfd.278.1298926049557;
        Mon, 28 Feb 2011 12:47:29 -0800 (PST)
Received: from localhost (sop.mtv.corp.google.com [172.18.74.69])
        by mx.google.com with ESMTPS id m10sm6458507wfl.11.2011.02.28.12.47.28
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 28 Feb 2011 12:47:28 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vwrkjhp27.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168141>

Junio C Hamano <gitster@pobox.com> wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> 
> > ...  The output file is opened by pack-objects after
> > object enumeration and delete compression are done, ...
> 
> s/delete/deflate/, I guess.

s/delete/delta/ is what I meant. "Compressing objects" is the
delta compression phase. The fact that we save some small deltas in
deflated format during this phase is an uninteresting implementation
detail not worth mentioning in the comments.
 
> > diff --git a/sha1_file.c b/sha1_file.c
> > index d949b35..8863ff6 100644
> > --- a/sha1_file.c
> > +++ b/sha1_file.c
> > @@ -708,9 +713,35 @@ static int open_packed_git_1(struct packed_git *p)
> >  	if (!p->index_data && open_pack_index(p))
> >  		return error("packfile %s index unavailable", p->pack_name);
> >  
> > +	if (!pack_max_fds) {
> > + ...
> > +		if (lim.rlim_cur < lim.rlim_max) {
> > +			lim.rlim_cur = lim.rlim_max;
> > +			if (!setrlimit(RLIMIT_NOFILE, &lim))
> > +				max_fds = lim.rlim_max;
> > +		}
> 
> This is somewhat questionable, isn't it?  We don't know why the user chose
> to ulimit the process yet forcibly bust that limit without telling him?

Maybe you are right.

In network server code is somewhat common to push the rlim_cur to
rlim_max if its not already there, since you might need to use a
lot of fds to handle a lot of concurrent clients. So habit sort of
caused me to just do this out of instinct.

In this particular part of C Git, if we are bumping up against the
hard pack_max_fds limit we're already into some pretty difficult
computation. Trying to push the rlimit higher in order to avoid
close/open calls as we cycle through fds isn't really going to make
a huge difference on end-user latency for the command to finish
its task. So maybe we are better off honoring the rlim_cur that we
inherited from the user/environment.

I'll respin a v2 for you.

-- 
Shawn.
