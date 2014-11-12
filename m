From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] t1410: fix breakage on case-insensitive filesystems
Date: Wed, 12 Nov 2014 16:59:23 -0500
Message-ID: <20141112215923.GB6801@peff.net>
References: <CAO2U3QiFvwMiwVCdVju_vJKK_HVndpQf4VyrEaHeeVVN6rgYgA@mail.gmail.com>
 <20141109014354.GA23883@peff.net>
 <20141109015918.GA24736@peff.net>
 <5463C106.5090803@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Blume <blume.mike@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Wed Nov 12 22:59:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xofwo-00046u-Aw
	for gcvg-git-2@plane.gmane.org; Wed, 12 Nov 2014 22:59:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752208AbaKLV71 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Nov 2014 16:59:27 -0500
Received: from cloud.peff.net ([50.56.180.127]:39653 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752009AbaKLV70 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Nov 2014 16:59:26 -0500
Received: (qmail 14802 invoked by uid 102); 12 Nov 2014 21:59:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 12 Nov 2014 15:59:26 -0600
Received: (qmail 14614 invoked by uid 107); 12 Nov 2014 21:59:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 12 Nov 2014 16:59:36 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 12 Nov 2014 16:59:23 -0500
Content-Disposition: inline
In-Reply-To: <5463C106.5090803@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 12, 2014 at 09:20:22PM +0100, Johannes Sixt wrote:

> Am 09.11.2014 um 02:59 schrieb Jeff King:
> >  test_expect_success 'stale dirs do not cause d/f conflicts (reflogs off)' '
> > -	test_when_finished "git branch -d a || git branch -d a/b" &&
> > +	test_when_finished "git branch -d one || git branch -d one/two" &&
> >  
> > -	git branch a/b master &&
> > -	echo "a/b@{0} branch: Created from master" >expect &&
> > -	git log -g --format="%gd %gs" a/b >actual &&
> > +	git branch one/two master &&
> > +	echo "one/two@{0} branch: Created from master" >expect &&
> > +	git log -g --format="%gd %gs" one/two >actual &&
> >  	test_cmp expect actual &&
> > -	git branch -d a/b &&
> > +	git branch -d one/two &&
> >  
> > -	# same as before, but we only create a reflog for "a" if
> > +	# same as before, but we only create a reflog for "one" if
> >  	# it already exists, which it does not
> > -	git -c core.logallrefupdates=false branch a master &&
> > +	git -c core.logallrefupdates=false branch one master &&
> >  	: >expect &&
> > -	git log -g --format="%gd %gs" a >actual &&
> > +	git log -g --format="%gd %gs" one >actual &&
> >  	test_cmp expect actual
> >  '
> >  
> 
> On Linux I observe
> 
> Deleted branch one/two (was b60a214).
> warning: unable to unlink .git/logs/refs/heads/one: Is a directory
> Deleted branch one (was b60a214).
> ok 15 - stale dirs do not cause d/f conflicts (reflogs off)
> 
> (notice the warning)

Yes, this is expected. The warning actually comes from the "git branch
-d" run during cleanup. Branch "one" exists but has no reflog. Instead
there is a crufty dir call "logs/refs/heads/one". The deletion process
blindly calls "unlink" on it and complains when it fails for reasons
other than ENOENT.

We could suppress that warning, but I didn't think it was really worth
the bother. This is such a funny setup (reflogs on, then off, then on,
_and_ a d/f conflict in the branches) that I doubt it will come up much.

I seem to recall that ancient versions of SunOS used to do bad things
when you called "unlink" on a directory, but I do not know if that is
still the case (I also would doubt this is the only place in git where
we blindly do an "unlink if you can" without actually checking the file.

> but on Windows the test fails with
> 
> Deleted branch one/two (was b60a214).
> error: Unable to append to .git/logs/refs/heads/one: Permission denied
> fatal: Cannot update the ref 'refs/heads/one'.
> not ok 15 - stale dirs do not cause d/f conflicts (reflogs off)

That looks more like it is failing the actual test (i.e., the creation
of branch "one" when there is cruft in the reflog). My guess is that
calling open() on a directory is giving us EACCES instead of EISDIR. Can
you verify that?

If that is the case, then this isn't a new breakage, I think, but just
code we weren't previously exercising. It would be interesting to know
whether:

  git config core.logallrefupdates true
  git branch one/two
  git branch -d one/two
  git branch one

works (even without my patch). If so, then there's probably something
else going on.

The relevant bits are in log_ref_setup. We try to open() once, and
accept EISDIR as a hint that we may need to remove an empty directory
and try again. If Windows gives us EACCES, then we may need to have that
trigger the same code.

-Peff
