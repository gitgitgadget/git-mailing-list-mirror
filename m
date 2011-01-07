From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: clone breaks replace
Date: Fri, 7 Jan 2011 14:51:03 -0600
Message-ID: <20110107205103.GC4629@burratino>
References: <4D262D68.2050804@cfl.rr.com>
 <20110106213338.GA15325@burratino>
 <4D276CD2.60607@cfl.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
To: Phillip Susi <psusi@cfl.rr.com>
X-From: git-owner@vger.kernel.org Fri Jan 07 21:51:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PbJHd-0003iZ-DR
	for gcvg-git-2@lo.gmane.org; Fri, 07 Jan 2011 21:51:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752762Ab1AGUvW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jan 2011 15:51:22 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:50259 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753207Ab1AGUvV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jan 2011 15:51:21 -0500
Received: by vws16 with SMTP id 16so7280285vws.19
        for <git@vger.kernel.org>; Fri, 07 Jan 2011 12:51:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=ifi66fUhHWA8zMRIkJeFmRNIwtpofwVht9Gzi2tekhE=;
        b=h3rDh2kkWRUVNvOoG/da0vGY8Hm7FoWGkPsg1AzpFpFw2fQDjtdMfsPfgz9e9aZH12
         OVfMRvJyF4wGtChwcojvFvjCrrofwAD95jQ+2/6xaKoMDh/cjnujn5L89hassY316vuz
         EDqS7DXLGE9jZNPRrb1fwM1i3mCPVzAF+Y+60=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=krVo2hGHRMmVeC3fUhlRSPETBQoW7csfMQ5+URLg3dtW71FDHsKyOPnTkkI05049BD
         ++EGwzriMCKMzNv0iU/a45JOcsO3ks1zHuqU/Dga5H2zpUGA+0KMIzycZwEu75+ovAU5
         6mb4zCAneb5NK+gzZstCi0Y4BhrFvrBityOgA=
Received: by 10.220.189.129 with SMTP id de1mr7593366vcb.88.1294433479083;
        Fri, 07 Jan 2011 12:51:19 -0800 (PST)
Received: from burratino (adsl-69-209-72-219.dsl.chcgil.sbcglobal.net [69.209.72.219])
        by mx.google.com with ESMTPS id e18sm9977582vbm.15.2011.01.07.12.51.16
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 07 Jan 2011 12:51:18 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4D276CD2.60607@cfl.rr.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164762>

Phillip Susi wrote:

> Isn't the whole purpose of using replace to avoid having to use
> filter-branch, which throws out all of the existing commit records, and
> creates an entirely new commit chain that is slightly modified?

No.  What documentation suggested that?  Maybe it can be fixed.

The original purpose of grafts (the ideological ancestor of
replacement refs) was to serve a very particular use case.  Sit down
by the fire, if you will, and...

Git had just came into existence and pack files did not exist yet.  A
full import of the Linux kernel history was possible but the result
was enormous and not something ready to be imposed on all Linux
contributors.  So what can one do?

 $ git show -s v2.6.12-rc2^0
 commit 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2
 Author: Linus Torvalds <torvalds@ppc970.osdl.org>
 Date:   Sat Apr 16 15:20:36 2005 -0700

     Linux-2.6.12-rc2

     Initial git repository build. I'm not bothering with the full history,
     even though we have it. We can create a separate "historical" git
     archive of that later if we want to, and in the meantime it's about
     3.2GB when imported into git - space that would just make the early
     git days unnecessarily complicated, when we don't have a lot of good
     infrastructure for it.

     Let it rip!

Fast forward three months, and there is discussion[1] about what to do
with the historical git archive.  A clever idea: teach git to _pretend_
that the historical archive is the parent to v2.6.12-rc2, so
"git log --grep", "gitk", and so on work as they ought to.

So grafts were born.  One of the nicest advantages of grafts is that
they make it easy to do complex history surgery: make some grafts ---
cut here, paste there --- and then run "git filter-branch" to make it
permanent.

But grafts have a serious problem.

Transport machinery needs to ignore grafts --- otherwise, the two ends
of a connection could have different ideas of the history preceding a
commit, resulting in confusion and breakage.  A fix to that was
finally grafted on a few years later (see also [2]).

 $ GIT_NOTES_REF=refs/remotes/charon/notes/full \
   git log --grep=graft --grep=repack --all-match --no-merges
 [...]
     git repack: keep commits hidden by a graft
 [...]
     Archived-At: <http://thread.gmane.org/gmane.comp.version-control.git/123874>

There is also the problem that grafts are too "raw": it is very easy
to make a graft pointing to a nonexistent object, say.  And meanwhile
git has no native support for transfering grafts over the wire.

In that context there emerged the nicer (imho) refs/replace mechanism:

 - reachability checking and transport machinery can treat them like
   all other references --- no need for low-level tools to pay
   attention to the artificial history;
 - easy to script around with "git replace" and "git for-each-ref"
 - can choose to fetch or not fetch with the usual
   "git fetch repo refs/replace/*:refs/replace/*" syntax

Common applications:

 - locally staging history changes that will later be made permanent
   with "git filter-branch";
 - grafting on additional (historical) history;
 - replacing ancient broken commits with fixed ones, for use by "git
   bisect".

Hope that helps,
Jonathan

[1] http://thread.gmane.org/gmane.comp.version-control.git/6470/focus=6484
found with "git log --grep=graft --reverse"
[2] http://thread.gmane.org/gmane.comp.version-control.git/37744/focus=37908
