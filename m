From: Jeff King <peff@peff.net>
Subject: Re: Bugreport on Ubuntu LTS: not ok - 2 Objects creation does not
 break ACLs with restrictive umask
Date: Tue, 5 Jun 2012 10:04:49 -0400
Message-ID: <20120605140449.GA15640@sigill.intra.peff.net>
References: <CALbm-Ea5ZkAGFyB2OETqe7vK7LE+yO0zSaa_+kFMXOhO-nMwMQ@mail.gmail.com>
 <7vhauqsue3.fsf@alter.siamese.dyndns.org>
 <CALbm-EatNCPjFRO4NyGfZuSa72-FXwZcd_7cFe-f_iMOdGL4MQ@mail.gmail.com>
 <7vy5o2ra7w.fsf@alter.siamese.dyndns.org>
 <vpqpq9ejnxs.fsf@bauges.imag.fr>
 <CALbm-EZrKGaj1Q7gbmPmG0wQHxksnJqaS3bz3tMDsego7Zm2ZQ@mail.gmail.com>
 <20120605075614.GE25809@sigill.intra.peff.net>
 <vpq4nqqj8ss.fsf@bauges.imag.fr>
 <CALbm-EbGoaxkvBXphAPF8rRkS=VFeeFHXQSFdWVrZUJJ8DYovw@mail.gmail.com>
 <vpqk3zlhorc.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stefan Beller <stefanbeller@googlemail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Jun 05 16:05:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SbuNV-0002kh-Lk
	for gcvg-git-2@plane.gmane.org; Tue, 05 Jun 2012 16:04:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934337Ab2FEOEw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jun 2012 10:04:52 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:43759
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934331Ab2FEOEw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jun 2012 10:04:52 -0400
Received: (qmail 19550 invoked by uid 107); 5 Jun 2012 14:04:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 05 Jun 2012 10:04:55 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 05 Jun 2012 10:04:49 -0400
Content-Disposition: inline
In-Reply-To: <vpqk3zlhorc.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199244>

On Tue, Jun 05, 2012 at 03:28:07PM +0200, Matthieu Moy wrote:

> Stefan Beller <stefanbeller@googlemail.com> writes:
> 
> > Hi,
> >
> > so I applied that patch with git apply, but here 2 out of 4 tests now
> > still fail.
> 
> Yes, Jeff's patch checks for a "working" setfacl/getfacl, but does not
> check for subtle brokenness of it.
> 
> I'd say a filesystem that accepts setfacl, returns the right line in
> getfacl, and then does not really work is broken, and it's a feature
> that the testsuite shows test failures. A simple fix for you would be to
> disable ACLs, either on your system or in your $HOME.

I found the problem. If you create a file on an ecryptfs filesystem with
a restrictive mode, then the inherited mask bits get cleared. For
example:

  # if you don't have one already, create an ecryptfs mount; you
  # will need the ecryptfs-utils package on Debian and Ubuntu
  ecryptfs-setup-private
  ecryptfs-mount-private
  cd Private

  # now set up an inherited mask
  setfacl -m d:m:rwx .

  # and create some files with different permissions
  perl -MFcntl -e '
    sysopen(X, "a", O_WRONLY|O_CREAT, 0666);
    sysopen(X, "b", O_WRONLY|O_CREAT, 0600);
  '

  # and then check the permissions
  getfacl a b

which yields:

  # file: a
  # owner: peff
  # group: peff
  user::rw-
  group::---
  mask::r--
  other::---

  # file: b
  # owner: peff
  # group: peff
  user::rw-
  group::---
  mask::---
  other::---

That just seems wrong to me.

-Peff
