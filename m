From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: git-submodule getting submodules from the parent repository
Date: Sat, 29 Mar 2008 18:35:59 -0400
Message-ID: <32541b130803291535m317e84e6p321ebccd5dedaab3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 29 23:36:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JfjfR-0006Lj-Kr
	for gcvg-git-2@gmane.org; Sat, 29 Mar 2008 23:36:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751135AbYC2WgF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Mar 2008 18:36:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750999AbYC2WgE
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Mar 2008 18:36:04 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:22611 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750810AbYC2WgC (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Mar 2008 18:36:02 -0400
Received: by fg-out-1718.google.com with SMTP id l27so991590fgb.17
        for <git@vger.kernel.org>; Sat, 29 Mar 2008 15:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=G/8Gnb4XmMeylmaNMX6SbcYX7dtfHoLBmBbcklWXaEY=;
        b=gEXHxPNqMFuKj8FwMtV3xBS2HYuA2Fo7d9Fc/odTlHMj1jUejDVADb8Sb2r4UGVeLEC47rHmeQJUu21OpdMgjxYxTPRjj6+1DLO1HmtHN6kErKz1+siywtNHeaufhutSx7YzarCJZsac7R4iwzf9v/dqqEQp7e5kfA/htdLQe3o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=IfTYlL2CG2Nsh8FTEz7WPI6YjBzPQNtNtqi0LUAHnWwadYncS9FR28YAIM3hig/hg0ZwbofW0TGtWalWkDJXdo6f8queLwl8cqXLMTNA93Rb68ysn3I9O+AAfZRbHFpowKDkR+McmJMb8RCJjxSNVaVVj/3szb4hlN4o+P7TBaI=
Received: by 10.82.175.7 with SMTP id x7mr10286856bue.36.1206830159832;
        Sat, 29 Mar 2008 15:35:59 -0700 (PDT)
Received: by 10.82.100.5 with HTTP; Sat, 29 Mar 2008 15:35:59 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78489>

Hi all,

I have a fairly pressing need for git-submodule-like behaviour, but
having tried git-submodule, it doesn't really work the way I'd like.

A super-simplified example of what I do:

- Project A (app) includes project B (build environment), which
includes project C (tool library)

- The projects are all open source, but B includes some binary
packages so it's a big download.  If you don't need the binary
packages, people want to just download C (hence the separation). But
everyone using A wants B and C, because they're lazy and bandwidth
isn't a problem.

- We have a local repository at work with mirrors of A, B, and C,
which are also available publicly (but there's no reason for everyone
in our office to be uploading/downloading the same big blobs all the
time).

- We frequently change B and C as part of building A (as well as other
A-like applications).

Here are the main problems, all in a jumble:

It's a  pain to check out / mirror / check in / push.  git-submodule
doesn't even init automatically when you check out A, so you have to
run it yourself.  The relative paths of A, B, and C on your mirror
have to be the same as upstream.  You can't make a local mirror of A
without mirroring B and C.  B and C start out with a disconnected
HEAD, so if you check in, it goes nowhere, and then when you push,
nothing happens, and if you're unlucky enough to pull someone else's
update to A and then "git-submodule update", it forgets your changes
entirely.  When you check in to C, you then have to check in to B, and
then to A, all by hand; and when you git-pull, you'd better to C, then
B, then A, or risk having A try to check out a revision from B that
you haven't pulled, etc.

...phew.

It would probably be possible to fix each of these problems
individually, but it would be a whole series of different fixes.  I'd
like to propose a rather different way of doing things that I think
would solve most of these problems, and get some feedback:

What if *all* the objects for A, B, and C were always in the *same*
repository?  Almost all the problems would go away.  Imagine if it
worked like this:

1. git-clone had a way to *not* clone every single object from every
branch in the parent repository; only the ones you were interested in.
So if you git-clone only project C, you don't end up with A and B.  (I
personally would never need to clone A without B and C, but maybe
someone else would.  It's actually a different implementation issue,
since A refers to B, but B doesn't refer to A.)

2. You still check into C, then B, then A, but it doesn't actually
matter if you put B and C on a branch first or not, because 'git push'
will work properly, because it auto-pushes B and C revisions based on
the fact that A refers to them (ie. implicit branches via the
submodule mechanism).

3. You can still upload B and C to their own separate upstream
repository, which is obviously a critical feature.  But you can do
that simply by making a branch in your copy of C and pushing just that
branch.  The objects come from your one local A repository, but you
simply avoid accidentally pushing the wrong branch.

4. You can 'git clone' a local copy of A, and B/C will be cloned
automatically along with it.

5. B and C, when git-submodule checks them out, should have their own
.git directories, but use A as an 'alternatives' entry.

6. git-pull should be modified to auto-download objects referred to by
'submodule' references in trees.

This would really help my workflow a lot.  Am I missing something?

Thoughts?

Thanks,

Avery
