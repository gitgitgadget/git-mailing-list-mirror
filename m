From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [RFC] origin link for cherry-pick and revert, and more about porcelain-level metadata
Date: Wed, 10 Sep 2008 18:33:29 +0400
Message-ID: <20080910143329.GE28210@dpotapov.dyndns.org>
References: <20080909132212.GA25476@cuci.nl> <20080909211355.GB10544@machine.or.cz> <20080909225603.GA7459@cuci.nl> <20080909230525.GC10360@machine.or.cz> <48C794D6.20001@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@suse.cz>,
	"Stephen R. van den Berg" <srb@cuci.nl>, git@vger.kernel.org
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Wed Sep 10 16:36:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdQmK-00077U-4U
	for gcvg-git-2@gmane.org; Wed, 10 Sep 2008 16:34:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751643AbYIJOdg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Sep 2008 10:33:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751574AbYIJOdg
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Sep 2008 10:33:36 -0400
Received: from wx-out-0506.google.com ([66.249.82.228]:20371 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751402AbYIJOdf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Sep 2008 10:33:35 -0400
Received: by wx-out-0506.google.com with SMTP id h27so867574wxd.4
        for <git@vger.kernel.org>; Wed, 10 Sep 2008 07:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=bd5ZuYFC7jmwLlWI0ja6/35yM6i4uSJV8gav+WL7CQc=;
        b=bP25eDn/GTQJpsy47NXu/AuHTvfundjeExUbxQydUKqUF2JNxMJQOZfjl9s9wxPKDl
         W3KoatwZy/iq1tc1W+NhAvepF9N+zpu3sSu7V86RrfoovpioC+1zaz4HfkRjKo5R+RDb
         XGAwTvn5w0jsWfwx4f9kdd7yfQzym1C0th/qE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=TAApjbU6+2mupUdbdYQ4KZEpUMrB51wlR8p8rt/x6PWA56MDvRc3wzIJJAaGVC3A81
         81nc9jfc0LRl/2Iu0VHyUJ23z6Mskfyo0LDyeiReZVKS9mJDoc7Cz82FGtsl/t8BqEHA
         +kusayD4J1c93YTUV8uoqE1A2F9LjrLSZ4IMg=
Received: by 10.86.79.19 with SMTP id c19mr1035758fgb.5.1221057213609;
        Wed, 10 Sep 2008 07:33:33 -0700 (PDT)
Received: from localhost ( [85.141.189.164])
        by mx.google.com with ESMTPS id d4sm8610004fga.5.2008.09.10.07.33.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 10 Sep 2008 07:33:32 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <48C794D6.20001@gnu.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95522>

On Wed, Sep 10, 2008 at 11:35:18AM +0200, Paolo Bonzini wrote:
> 
> Junio explained that the way achieves the same effect in git is by
> forking the topic branch off the "oldest" branch where the patch will
> possibly be of interest.  Then he can merge it in that branch and all
> the newest ones.  That's great, but not all people are as
> forward-looking (he did say that sometimes he needs to cherrypick).

Those who base their work on the newest ones must be very forward-
looking :) but, seriously, cherry-picking is *not* a normal workflow
with Git. Git is optimized for easy merging while cherry-picking is
a rare operation reserved for correcting some past mistakes.

> 
> Another problem is that in some projects actually there are two "maint"
> branches (e.g. currently GCC 4.2 and GCC 4.3), and most developers do
> not care about what goes in the older "maint" branch; they develop for
> trunk and for the newer "maint" branch, and then one person comes and
> cherry-picks into the older "maint" branch.  This has two problems:
> 
> 1) Having to fork topic branches off the older branch would force extra
> testing on the developers.

If a branch is meant to included in the oldest version, it must be
tested with that version anyway, and it is better when it is written for
the old version, because functions tend to be more backward compatible
than forward compatible. In other words, functions may often acquire
some extra functionality over time without changing their signature, so
the code written for a new version will merge without any conflict to
the old one, but it won't work correctly under some conditions. It is
certainly possible to have a problem in the opposite direction, but it
is much less likely, and usually bugs introduced in the development
version are not as bad as destabilizing a stable branch. Thus starting
branch that is clearly meant for inclusion to the old version from that
version is the right thing do.

Of course, if you have more than one stable branch for a long time then
you may want some branches forked from the new stable. You can do that
by merging uninteresting changes from the new stable with the 'ours'
strategy (so they will be ignored), and after that merging actually
interesting features from the new stable.

In contrast to cherry-picking, the real merge creates the history that
can be easily visualized and understood.

> 
> 2) Besides this, topic branches are not cloned, so if I am the
> integrator on the older "maint" branch, I need to dig manually in the
> commits to find bugfixes.  True, I could use Bugzilla, but what if I
> want to use git instead?  There is "git cherry -v ... | grep -w ^+.*PR",
> except that it has too many false negatives (fixes that have already
> been backported, but do show up in the list).

If you clearly mark all bugs in the commit message, there will be no
problem to find them by grepping log. There is a lot of potentially
useful information, and the 'origin' link is just one of many. It may
be okay to do some general mechanism for custom commit attributes (if
it's really necessary), but making a hack for one specific item of
information feels very wrong. In fact, I have not convinced at all
that the free-form text is not suitable to store this information.


Dmitry
