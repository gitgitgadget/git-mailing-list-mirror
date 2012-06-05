From: Jeff King <peff@peff.net>
Subject: Re: Bugreport on Ubuntu LTS: not ok - 2 Objects creation does not
 break ACLs with restrictive umask
Date: Tue, 5 Jun 2012 11:05:50 -0400
Message-ID: <20120605150550.GA19843@sigill.intra.peff.net>
References: <7vy5o2ra7w.fsf@alter.siamese.dyndns.org>
 <vpqpq9ejnxs.fsf@bauges.imag.fr>
 <CALbm-EZrKGaj1Q7gbmPmG0wQHxksnJqaS3bz3tMDsego7Zm2ZQ@mail.gmail.com>
 <20120605075614.GE25809@sigill.intra.peff.net>
 <vpq4nqqj8ss.fsf@bauges.imag.fr>
 <CALbm-EbGoaxkvBXphAPF8rRkS=VFeeFHXQSFdWVrZUJJ8DYovw@mail.gmail.com>
 <vpqk3zlhorc.fsf@bauges.imag.fr>
 <20120605140449.GA15640@sigill.intra.peff.net>
 <20120605141039.GB15640@sigill.intra.peff.net>
 <20120605142813.GA17238@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: ecryptfs@vger.kernel.org,
	Stefan Beller <stefanbeller@googlemail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Jun 05 17:05:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SbvKX-0003dk-6P
	for gcvg-git-2@plane.gmane.org; Tue, 05 Jun 2012 17:05:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751445Ab2FEPFx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jun 2012 11:05:53 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:43826
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750912Ab2FEPFw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jun 2012 11:05:52 -0400
Received: (qmail 20102 invoked by uid 107); 5 Jun 2012 15:05:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 05 Jun 2012 11:05:56 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 05 Jun 2012 11:05:50 -0400
Content-Disposition: inline
In-Reply-To: <20120605142813.GA17238@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199249>

[+cc ecryptfs@vger, as I think this is an ecryptfs bug]

On Tue, Jun 05, 2012 at 10:28:13AM -0400, Jeff King wrote:

> OK, here's the _real_ issue. Git creates with mode 0444, which should
> still allow read in the mask. But it's the restrictive umask at the top
> of the test script that causes the problem. Try this:
> 
>   setfacl -m m:rwx .
>   perl -MFcntl -e 'sysopen(X, "a", O_WRONLY|O_CREAT, 0444)'
>   umask 077
>   perl -MFcntl -e 'sysopen(X, "b", O_WRONLY|O_CREAT, 0444)'
>   getfacl a b
> 
> On ext4, both files will have the read bit set in the mask. On ecryptfs,
> "b" will have an empty mask. I think the wrong thing is that we should
> not be respecting umask at all when default ACLs are in play, and
> ecryptfs is getting that wrong. But I'm having trouble digging up an
> authoritative source.

Reading the withdrawn posix 1003.1e and "man 5 acl", it seems pretty
clear that if a default ACL is present, it should be used, and umask
consulted only if it is not (so the umask should not be making a
difference in this case).

The reproduction recipe above shows the minimum required to trigger it;
adding a more realistic default ACL (with actual entries for users) does
not seem to make a difference.

-Peff
