From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: Trying to sync two svn repositories with git-svn (repost)
Date: Tue, 28 Apr 2009 23:19:51 -0400
Message-ID: <32541b130904282019n4b930f80g1ed22b2dde22510a@mail.gmail.com>
References: <20090427201251.GC15420@raven.wolf.lan>
	 <32541b130904281353k572fed5la468de65f73ccd19@mail.gmail.com>
	 <20090428223728.GE15420@raven.wolf.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Josef Wolf <jw@raven.inka.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 29 05:20:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lz0Lk-0006mN-E2
	for gcvg-git-2@gmane.org; Wed, 29 Apr 2009 05:20:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753872AbZD2DTx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 28 Apr 2009 23:19:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753181AbZD2DTx
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Apr 2009 23:19:53 -0400
Received: from yx-out-2324.google.com ([74.125.44.28]:31299 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751847AbZD2DTw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Apr 2009 23:19:52 -0400
Received: by yx-out-2324.google.com with SMTP id 3so556266yxj.1
        for <git@vger.kernel.org>; Tue, 28 Apr 2009 20:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=/7nx7CdBX/fe6bQcbYm5M4pxa0KzjeEkLIpX3CjNfA4=;
        b=asAWf2bvYNo8aIqP4WUL1unWExRQuq7woZF6+bJKvFBeolPaVD+r5wkhnoocCEgnnT
         TZnjFFGxv6gAt3GtK3ZwPlPVQUjFFGRh0F2UDULyI8gcSQDjPUXP5wqX49J+okmQveeO
         QyPT5WKgOWT6aq/6yd+uq7QwAqdFj+MIGAbRs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=pK72rhofVjgAVYHIjWhFIZIkVdBsoOc7iSBtaUzItLq1NUrHjTRoWIZmHTYvn0MeiX
         EZ14S4LLx/7DNHHtRmHL13MJe297N5Ij5Mhk5fsKS0af6ggh0GRnDKYcll6WMTPWNgeW
         Ez8atFeNHITBkXmOWkuH+LOFTJ9jEiAChN/xQ=
Received: by 10.151.122.3 with SMTP id z3mr474890ybm.231.1240975191479; Tue, 
	28 Apr 2009 20:19:51 -0700 (PDT)
In-Reply-To: <20090428223728.GE15420@raven.wolf.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117841>

On Tue, Apr 28, 2009 at 6:37 PM, Josef Wolf <jw@raven.inka.de> wrote:
> Currently, there exist multiple independent repositories (for securit=
y
> reasons). =A0In the past, the repositories were "synchronized" manual=
ly.
> So technically, the repositories have no common history (at least not
> in svn's metadata). =A0But the contents are actually rather "similar"=
,
> since they were synchronized multiple times in the past.
>
> In the long term, I'd like to move everything completely to git. =A0T=
hat
> would make it much easier to move changes from one repos to the other
> while keeping the (intended) differences in the policy.
>
> So my first goal is to bring the contents into sync. =A0The next step=
 would
> be to create a "reference" (the official) git repository, which can b=
e
> cloned by the administrations to create their localized repositories.
>
> In the meantime, I need a way to synchronize the contents from time t=
o
> time. =A0I guess it will take some time to create the official repos =
and
> get used to the work flow.

Okay, I think I'm following you.  And I think the difficulty of your
solution will depend on how important it is to cherry-pick each
individual commit from each repo vs. just merging everything as a
batch.

At Versabanq, we're using git for a bunch of stuff including our
autobuilder (http://github.com/apenwarr/gitbuilder) and my own
branching/merging.  However, for historical reasons, everything needs
to also go into an svn repository, which some people use.

Yes, it is possible to rebase everything from git onto an svn branch,
and then git svn dcommit it.  However, in my experience, this is
fairly nasty (and it also tries to linearize non-linear history, which
is just messy).  What we've been doing lately is just merging all
changes from git into the svn branch as a single commit:

   git checkout git-svn
   git merge --no-ff mybranch   # --no-ff prevents git-svn from
crazily linearizing things
   git svn dcommit

   git checkout mybranch
   git merge git-svn

As long as you "git config merge.summary true" (to make the merge
commit list all the commits it's merging) and you merge frequently
enough, this is reasonably painless.  You end up with a lot of merge
commits, but the git history is recording everything fully, so if you
want to throw away svn someday, you can just go ahead.

Now, your problem is a little more complex, because it sounds like
people are checking in two types of things on both sides: private
things and public things.  So if you want *only* the private things,
you're going to have to cherry-pick, and cherry-picking is going to
confuse your merging.

If you could convince the people using svn to use two branches: one
for private stuff and one for public stuff, then your life would be
easier.  You could just merge the public stuff in git, and ignore the
private stuff.

If that's not an option, you *can* combine cherry-pick with -s ours as
you suggest, though it's kind of nasty.  The trick is to merge -s ours
in *both* directions at the right time, so you can avoid conflicts.

    git checkout git-svn
    git merge mybranch

    git checkout mybranch
    [git cherry-pick or git merge *everything* you're missing from git-=
svn...]
    git merge -s ours --no-ff git-svn
      # future merges from git-svn will ignore everything in mybranch u=
p to now

    git checkout git-svn
      # we know git-svn is already up to date, because of the first mer=
ge above
    git merge -s ours --no-ff mybranch
      # future merges from mybranch will ignore everything in git-svn u=
p to now
    git svn dcommit

After these steps (WARNING: I didn't actually run them, so I might
have made a mistake), you should have both branches in sync, and you
*should* be able to merge in both directions whenever you want (make
sure you use --no-ff), until the next time someone commits something
private and screws you over again.

If you have more than one svn server, the above method should be
extensible; just use another svn branch in place of 'mybranch' or keep
cross-merging across all the branches.

Good luck :)

Avery
