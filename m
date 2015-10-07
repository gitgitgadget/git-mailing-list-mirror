From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v2 42/43] refs: add LMDB refs backend
Date: Wed, 07 Oct 2015 15:20:29 -0400
Organization: Twitter
Message-ID: <1444245629.8836.12.camel@twopensource.com>
References: <1443477738-32023-1-git-send-email-dturner@twopensource.com>
		 <1443477738-32023-43-git-send-email-dturner@twopensource.com>
		 <56129B77.1030409@alum.mit.edu>
	 <1444182660.7739.77.camel@twopensource.com> <561564EC.8070704@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Oct 07 21:20:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZjuGU-0003lh-0K
	for gcvg-git-2@plane.gmane.org; Wed, 07 Oct 2015 21:20:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754034AbbJGTUe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Oct 2015 15:20:34 -0400
Received: from mail-qg0-f44.google.com ([209.85.192.44]:35961 "EHLO
	mail-qg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752838AbbJGTUc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Oct 2015 15:20:32 -0400
Received: by qgx61 with SMTP id 61so23528508qgx.3
        for <git@vger.kernel.org>; Wed, 07 Oct 2015 12:20:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=H3syZv/GnLwtO55IOkf2kwNLVy7EXc0+WU27kmGT93w=;
        b=So9mu84PTHZ/2ek1Cq11B3azConIFCzmMP3+xpO9BU+koNqT4peFK37vPjCFe/BH1p
         0ZLlrAOdVkP/jAcwILMMREz6Zo1uAkCZMqugoGQzp5IktWZSMtmVKlvR+XV3gZQwGfz9
         0Rw3nnavWIgul6PNs81CU/sMEkgxrJM1+yl6bNuemvwZulfPNm+TtcBxORqVIkpEzcPa
         pM2GwNtukc2FCF7xHZXp/LBEnSjVcDzmVC8sq7XWfEfv7WwEIa4JbunFH8Te3vvjQ4V+
         xuHQ555DTO581gb2DjLWkhyCi6u7OiAnkpGpVV3RYHTYX4qmA+JNx6AE7RaxpLsDWtOb
         phww==
X-Gm-Message-State: ALoCoQn0sw8/Punv2WDopJeyILbW2PL38Tq+47m6OH07glZ9vMf5jl1E9cgotgCUy6P/p+tMeuma
X-Received: by 10.140.216.211 with SMTP id m202mr3775767qhb.80.1444245631677;
        Wed, 07 Oct 2015 12:20:31 -0700 (PDT)
Received: from ubuntu ([192.133.79.147])
        by smtp.gmail.com with ESMTPSA id z196sm16740583qhd.22.2015.10.07.12.20.30
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Oct 2015 12:20:30 -0700 (PDT)
In-Reply-To: <561564EC.8070704@alum.mit.edu>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279194>

On Wed, 2015-10-07 at 20:31 +0200, Michael Haggerty wrote:
> On 10/07/2015 03:51 AM, David Turner wrote:
> > On Mon, 2015-10-05 at 17:47 +0200, Michael Haggerty wrote:
> >> On 09/29/2015 12:02 AM, David Turner wrote:
> >>> Add a database backend for refs using LMDB.  [...]
> >>
> >> I think you have said before that if one writer holds the write lock on
> >> the DB, then other writers fail immediately. Is that correct? If so, is
> >> that something that can be adjusted? I think it would be preferable for
> >> the second writer to retry acquiring the write lock for a little while
> >> with a timeout (as we now do when trying to acquire the packed-refs
> >> lock). Otherwise you could have the unhappy situation that somebody
> >> spends a long time pushing a packfile to a server, only to have the
> >> reference update be rejected at the last moment due to a lock conflict
> >> with another process that was touching completely different references.
> >> We already do before/after consistency checks when updating references,
> >> so you wouldn't even have to add such code in the backend yourself.
> > 
> > No, the second writer waits for the first writer to unlock (or for it to
> > crash).
> 
> Cool, that's better behavior.
> 
> > [...]
> >> Do you store "peeled" reference values for tags, as is done in
> >> packed-refs? I think that is an important optimization.
> > 
> > No.  Do you happen to know in what situations this is a performance
> > benefit, so that I can benchmark?  I suspect it would matter much less
> > for the LMDB backend, because lookups are pretty quick.
> 
> The reference lookup speed is not relevant here. "Peeling" is applied to
> references that point at tag objects (a.k.a. annotated tags). It means
> that the tag object is looked up to see what *it* points at (recursively
> if necessary) and the result is stored to the packed-refs file in a
> specially-formatted extra line that looks like
> 
>     17f9f635c101aef03874e1de1d8d0322187494b3 refs/tags/v2.6.0
>     ^be08dee9738eaaa0423885ed189c2b6ad8368cf0
> 
> I think a good command to benchmark would be `git show-refs -d` in a
> repository with a number of annotated tags. This command's output is
> similar to the output of `git ls-remote <remote>` and also comes up
> during reference negotiation when fetching (so its performance is
> definitely not moot).
> 
> > [...]
> >> Currently we discard the reflog for a reference when the reference is
> >> deleted. [...]
> >> Have you thought about removing this limitation in the lbdb backend?
> > 
> > I'm going for feature parity first.  We can always add new functionality
> > later.  This particular function would be pretty straightforward to add,
> > I think.
> 
> +1
> 
> > [...]
> >>> +The rsync and file:// transports don't work yet, because they
> >>> +don't use the refs API.
> >>
> >> Do they fail gracefully?
> > 
> > Not particularly gracefully.
> > 
> > rsync: link_stat "/home/dturner/git/t/trash
> > directory.t5510-fetch/.git/packed-refs" failed: No such file or
> > directory (2)
> > rsync error: some files/attrs were not transferred (see previous errors)
> > (code 23) at main.c(1183) [sender=3.1.1]
> > fatal: Could not run rsync to get refs
> > -------------
> > 
> > The problem is that rsync on the client assumes that packed-refs exists.
> > We could hack it to also check for refdb.
> 
> I guess this is something that will have to be improved sooner or later,
> though I guess not as a precondition for merging this patch series.
> 
> > [...]
> >> I'm somewhat surprised that you only register the lmdb backend if it is
> >> used in the main repo. I would expect the backend to be registered
> >> unconditionally on startup. The cost is trivial, isn't it?
> > 
> > Yeah, but this was the easiest place to do it.
> 
> OK.
> 
> > [...]
> 
> I'm really happy about your work.
> 
> Regarding strategy: I think a good approach would be to get as much of
> the preparatory work as possible (the abstraction and separation of
> refs-be-files) to the point where it can be merged before there is too
> much more code churn in the area. That work is not very controversial, I
> think, and letting it wait for a long time will increase the likelihood
> of conflicts with other people's changes. The refs-be-lmdb patches, on
> the other hand, (1) will take longer to get polished, (2) will take
> longer to review because other people are not familiar with LDMB, and
> (3) won't bitrot very fast anyway because they don't overlap as much
> with areas that other people are likely to work on. So I would advocate
> working on those at a more deliberate pace and planning for them to be
> merged as a separate batch.

Works for me.  

Would you like me to start sending those as a separate series, or shall
I keep it as one series and let you split it as you choose?
