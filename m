From: Markus Trippelsdorf <markus@trippelsdorf.de>
Subject: Re: general protection faults with "git grep" version 1.7.7.1
Date: Tue, 25 Oct 2011 17:32:12 +0200
Message-ID: <20111025153212.GC1678@x4.trippels.de>
References: <20111024201153.GA1647@x4.trippels.de>
 <20111024214949.GA5237@amd.home.annexia.org>
 <201110251550.22248.trast@student.ethz.ch>
 <87y5w9ayoa.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>,
	"Richard W.M. Jones" <rjones@redhat.com>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>, Jeff King <peff@peff.net>,
	Nicolas Pitre <nico@fluxnic.net>
To: Jim Meyering <jim@meyering.net>
X-From: git-owner@vger.kernel.org Tue Oct 25 17:32:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RIizD-0007wS-84
	for gcvg-git-2@lo.gmane.org; Tue, 25 Oct 2011 17:32:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756613Ab1JYPcP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Oct 2011 11:32:15 -0400
Received: from ud10.udmedia.de ([194.117.254.50]:47573 "EHLO
	mail.ud10.udmedia.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751682Ab1JYPcO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Oct 2011 11:32:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=mail.ud10.udmedia.de; h=
	date:from:to:cc:subject:message-id:references:mime-version:
	content-type:in-reply-to; q=dns/txt; s=beta; bh=FnYbsl0d4MHevJho
	HgagcOa1npHJdfF3xhL1EjKSdGg=; b=P1dx870J+yh7GyamRFGkIPNw+Y/v0U11
	3DyQofQQ5Mv9Wa+DDQLECBjsRl2xVB3ZIuS3P2/u1WvF7hKFRe5zPHAkNBj2hkHr
	d2sp7CFDFLzyyI/ewVl6YgTweh5+ak0r1k3jHWprxfM2FVco1JADbwaoWlE7HhIr
	M1TaevLIzvw=
Received: (qmail 11035 invoked from network); 25 Oct 2011 17:32:12 +0200
Received: from unknown (HELO x4.trippels.de) (ud10?360p3@91.64.56.160)
  by mail.ud10.udmedia.de with ESMTPSA (DHE-RSA-AES256-SHA encrypted, authenticated); 25 Oct 2011 17:32:12 +0200
Content-Disposition: inline
In-Reply-To: <87y5w9ayoa.fsf@rho.meyering.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184211>

On 2011.10.25 at 17:17 +0200, Jim Meyering wrote:
> Thomas Rast wrote:
> > [Shawn, Peff, Nicolas: maybe you can say something on the
> > (non)raciness of xmalloc() in parallel with read_sha1_file().  See the
> > last paragraph below.]
> >
> > Richard W.M. Jones wrote:
> >> On Mon, Oct 24, 2011 at 10:11:53PM +0200, Markus Trippelsdorf wrote:
> >> > Suddenly I'm getting strange protection faults when I run "git grep" on
> >> > the gcc tree:
> >>
> >> Jim Meyering and I are trying to chase what looks like a similar or
> >> identical bug in git-grep.  We've not got much further than gdb and
> >> valgrind so far, but see:
> >>
> >> https://bugzilla.redhat.com/show_bug.cgi?id=747377
> >>
> >> It's slightly suspicious that this bug only started to happen with the
> >> latest glibc, but that could be coincidence, or could be just that
> >> glibc exposes a latent bug in git-grep.
> >
> > I'm tempted to write this off as a GCC bug.  If that's ok for you,
> > I'll leave further investigation and communication with the GCC folks
> > to you.
> >
> > My findings are as follows:
> >
> > It's easy to reproduce the behavior described in the above bug report,
> > using an F16 beta install in a VM.  I gave the VM two cores, but
> > didn't test what happens with only one.  By "easy" I mean I didn't
> > have to do any fiddling and it crashes at least one out of two times.
> >
> > I looked at how git builds grep.o by saying
> >
> >   rm builtin/grep.o; make V=1
> >
> > I then modified this to give me the assembly output from the compiler
> >
> >   gcc -S -s builtin/grep.o -c -MF builtin/.depend/grep.o.d -MMD -MP  -g -O2 -Wall -I.  -DHAVE_PATHS_H -DSHA1_HEADER='<openssl/sha.h>'  -DNO_STRLCPY -DNO_MKSTEMPS  builtin/grep.c
> ...
> > So AFAICS, we're just unlucky to hit a GCC optimizer bug that voids
> > all guarantees given on locks.
> 
> Thanks for the investigation.
> Actually, isn't gcc -O2's code-motion justified?
> While we *know* that those globals may be modified asynchronously,
> builtin/grep.c forgot to tell gcc about that.
> Once you do that (via "volatile"), gcc knows not to move things.
> 
> This patch solved the problem for me:

Yes. This fixes the issue here also.

(BTW the only recent pthread related change in glibc was the removal
of the gettimeofday vsyscall)

-- 
Markus
