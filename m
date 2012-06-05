From: Jeff King <peff@peff.net>
Subject: Re: Bugreport on Ubuntu LTS: not ok - 2 Objects creation does not
 break ACLs with restrictive umask
Date: Tue, 5 Jun 2012 10:28:13 -0400
Message-ID: <20120605142813.GA17238@sigill.intra.peff.net>
References: <CALbm-EatNCPjFRO4NyGfZuSa72-FXwZcd_7cFe-f_iMOdGL4MQ@mail.gmail.com>
 <7vy5o2ra7w.fsf@alter.siamese.dyndns.org>
 <vpqpq9ejnxs.fsf@bauges.imag.fr>
 <CALbm-EZrKGaj1Q7gbmPmG0wQHxksnJqaS3bz3tMDsego7Zm2ZQ@mail.gmail.com>
 <20120605075614.GE25809@sigill.intra.peff.net>
 <vpq4nqqj8ss.fsf@bauges.imag.fr>
 <CALbm-EbGoaxkvBXphAPF8rRkS=VFeeFHXQSFdWVrZUJJ8DYovw@mail.gmail.com>
 <vpqk3zlhorc.fsf@bauges.imag.fr>
 <20120605140449.GA15640@sigill.intra.peff.net>
 <20120605141039.GB15640@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stefan Beller <stefanbeller@googlemail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Jun 05 16:28:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SbukE-0007ZU-8U
	for gcvg-git-2@plane.gmane.org; Tue, 05 Jun 2012 16:28:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757868Ab2FEO2R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jun 2012 10:28:17 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:43787
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756657Ab2FEO2Q (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jun 2012 10:28:16 -0400
Received: (qmail 19772 invoked by uid 107); 5 Jun 2012 14:28:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 05 Jun 2012 10:28:19 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 05 Jun 2012 10:28:13 -0400
Content-Disposition: inline
In-Reply-To: <20120605141039.GB15640@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199246>

On Tue, Jun 05, 2012 at 10:10:39AM -0400, Jeff King wrote:

> On Tue, Jun 05, 2012 at 10:04:49AM -0400, Jeff King wrote:
> 
> >   # and create some files with different permissions
> >   perl -MFcntl -e '
> >     sysopen(X, "a", O_WRONLY|O_CREAT, 0666);
> >     sysopen(X, "b", O_WRONLY|O_CREAT, 0600);
> >   '
> Hmm, no I'm wrong. That is OK, as the mask should be restricted by the
> group permission (and it is on ext4, too). But when I traced through
> git, the tmp_obj_* files are created with the right permissions on ext4,
> but not on ecryptfs. Let me trace through it again...<sigh>

OK, here's the _real_ issue. Git creates with mode 0444, which should
still allow read in the mask. But it's the restrictive umask at the top
of the test script that causes the problem. Try this:

  setfacl -m m:rwx .
  perl -MFcntl -e 'sysopen(X, "a", O_WRONLY|O_CREAT, 0444)'
  umask 077
  perl -MFcntl -e 'sysopen(X, "b", O_WRONLY|O_CREAT, 0444)'
  getfacl a b

On ext4, both files will have the read bit set in the mask. On ecryptfs,
"b" will have an empty mask. I think the wrong thing is that we should
not be respecting umask at all when default ACLs are in play, and
ecryptfs is getting that wrong. But I'm having trouble digging up an
authoritative source.

-Peff
