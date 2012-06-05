From: Jeff King <peff@peff.net>
Subject: Re: Bugreport on Ubuntu LTS: not ok - 2 Objects creation does not
 break ACLs with restrictive umask
Date: Tue, 5 Jun 2012 10:10:39 -0400
Message-ID: <20120605141039.GB15640@sigill.intra.peff.net>
References: <7vhauqsue3.fsf@alter.siamese.dyndns.org>
 <CALbm-EatNCPjFRO4NyGfZuSa72-FXwZcd_7cFe-f_iMOdGL4MQ@mail.gmail.com>
 <7vy5o2ra7w.fsf@alter.siamese.dyndns.org>
 <vpqpq9ejnxs.fsf@bauges.imag.fr>
 <CALbm-EZrKGaj1Q7gbmPmG0wQHxksnJqaS3bz3tMDsego7Zm2ZQ@mail.gmail.com>
 <20120605075614.GE25809@sigill.intra.peff.net>
 <vpq4nqqj8ss.fsf@bauges.imag.fr>
 <CALbm-EbGoaxkvBXphAPF8rRkS=VFeeFHXQSFdWVrZUJJ8DYovw@mail.gmail.com>
 <vpqk3zlhorc.fsf@bauges.imag.fr>
 <20120605140449.GA15640@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stefan Beller <stefanbeller@googlemail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Jun 05 16:10:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SbuT8-0008In-Ve
	for gcvg-git-2@plane.gmane.org; Tue, 05 Jun 2012 16:10:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752356Ab2FEOKn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jun 2012 10:10:43 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:43773
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751997Ab2FEOKm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jun 2012 10:10:42 -0400
Received: (qmail 19608 invoked by uid 107); 5 Jun 2012 14:10:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 05 Jun 2012 10:10:45 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 05 Jun 2012 10:10:39 -0400
Content-Disposition: inline
In-Reply-To: <20120605140449.GA15640@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199245>

On Tue, Jun 05, 2012 at 10:04:49AM -0400, Jeff King wrote:

>   # and create some files with different permissions
>   perl -MFcntl -e '
>     sysopen(X, "a", O_WRONLY|O_CREAT, 0666);
>     sysopen(X, "b", O_WRONLY|O_CREAT, 0600);
>   '
> 
>   # and then check the permissions
>   getfacl a b
> 
> which yields:
> 
>   # file: a
>   # owner: peff
>   # group: peff
>   user::rw-
>   group::---
>   mask::r--
>   other::---
> 
>   # file: b
>   # owner: peff
>   # group: peff
>   user::rw-
>   group::---
>   mask::---
>   other::---
> 
> That just seems wrong to me.

Hmm, no I'm wrong. That is OK, as the mask should be restricted by the
group permission (and it is on ext4, too). But when I traced through
git, the tmp_obj_* files are created with the right permissions on ext4,
but not on ecryptfs. Let me trace through it again...<sigh>

-Peff
