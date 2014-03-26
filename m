From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] t4212: handle systems with post-apocalyptic gmtime
Date: Wed, 26 Mar 2014 15:25:36 -0400
Message-ID: <20140326192536.GA13989@sigill.intra.peff.net>
References: <20140224073348.GA20221@sigill.intra.peff.net>
 <20140224074905.GE9969@sigill.intra.peff.net>
 <20140326110559.GA32625@hashpling.org>
 <20140326182103.GB7087@sigill.intra.peff.net>
 <20140326185153.GA12912@sigill.intra.peff.net>
 <xmqqr45oixa6.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Charles Bailey <cbailey32@bloomberg.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 26 20:25:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WStSJ-0003TI-0y
	for gcvg-git-2@plane.gmane.org; Wed, 26 Mar 2014 20:25:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755662AbaCZTZj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Mar 2014 15:25:39 -0400
Received: from cloud.peff.net ([50.56.180.127]:47823 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754037AbaCZTZi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Mar 2014 15:25:38 -0400
Received: (qmail 18768 invoked by uid 102); 26 Mar 2014 19:25:38 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 26 Mar 2014 14:25:38 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 26 Mar 2014 15:25:36 -0400
Content-Disposition: inline
In-Reply-To: <xmqqr45oixa6.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245216>

On Wed, Mar 26, 2014 at 12:18:25PM -0700, Junio C Hamano wrote:

> > +		echo "$candidate" >expect &&
> > +		test_cmp expect actual &&
> > +		return 0
> > +	done
> > +	return 1
> > +}
> 
> It actually may be easier to understand if you write a trivial case
> statement at the sole calling site of this helper function, though.

Yeah, perhaps. I wanted to build on test_cmp because it has nice output
for the failure case, but it is probably simple enough to do:

  output=$(cat actual)
  case "$output" in
  ...
  *) echo >&2 "unrecognized date: $output"

> In any case, would it really be essential to make sure that the
> output shows a phony (or a seemingly real) datestamp for this test?
> 
> The primary thing you wanted to achieve by the "gmtime gave us NULL,
> let's substitute it with an arbitrary value to avoid dereferencing
> the NULL" change was *not* that we see that same arbitrary value
> comes out of the system, but that we do not die by attempting to
> reference the NULL, I think.  Not dying is the primary thing we want
> to (and we already do) test, no?

I think there are really two separate behaviors we are testing here (and
in the surrounding tests):

  1. Don't segfault if gmtime returns NULL.

  2. Whenever we cannot process a date (either because gmtime fails, or
     because we fail before even getting the value to gmtime),
     consistently return the sentinel date (so the reader can easily
     know it's bogus).

Having the test be particular about its output helped us find a case
where FreeBSD did not trigger (1), but did trigger (2), by returning a
blanked "struct tm".

I'm open to the argument that (2) is not worth worrying about that much
if it is a hassle to test. But I don't think it is that much hassle
(yet, anyway).

-Peff
