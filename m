From: Jeff King <peff@peff.net>
Subject: Re: Use mongoose to test smart-http unconditionally?
Date: Wed, 4 Dec 2013 17:25:22 -0500
Message-ID: <20131204222522.GA16706@sigill.intra.peff.net>
References: <CACsJy8BHnTHRugJoTDGs7h=dF1qQUWyPXYxCU8YsDU57s+5gyg@mail.gmail.com>
 <xmqqa9ggl6oq.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 04 23:25:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VoKsq-0002lj-K3
	for gcvg-git-2@plane.gmane.org; Wed, 04 Dec 2013 23:25:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755584Ab3LDWZZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Dec 2013 17:25:25 -0500
Received: from cloud.peff.net ([50.56.180.127]:50537 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753206Ab3LDWZY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Dec 2013 17:25:24 -0500
Received: (qmail 32676 invoked by uid 102); 4 Dec 2013 22:25:24 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 04 Dec 2013 16:25:24 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 04 Dec 2013 17:25:22 -0500
Content-Disposition: inline
In-Reply-To: <xmqqa9ggl6oq.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238821>

On Wed, Dec 04, 2013 at 12:09:09PM -0800, Junio C Hamano wrote:

> Duy Nguyen <pclouds@gmail.com> writes:
> 
> > I was thinking of an alternative to apache for testing smart-http
> > so that most of http tests could always run.  Mongoose [1] looks
> > like a good candidate to bundle with git. Just one pair of source
> > files, mongoose.[ch], a mainloop wrapper and we have an http
> > server.
> 
> Hmmmm.  How would the high-level integration look like?
> 
>  - we add contrib/mongoose/*;
> 
>  - in t/Makefile, we:
> 
>    . set GIT_TEST_HTTPD to yes, unless it is already set to another value;
> 
>    . set LIB_HTTPD_PATH to $GIT_BUILD_DIR/contrib/mongoose/mongoose,
>      unless it is already set to another value;
> 
>    . if LIB_HTTPD_PATH is set to our mongoose and if it hasn't been
>      built, go ../contrib/mongoose and build it.

I think building it on-demand is probably too much effort. If it is
portable, then it should not be a problem to just build it along with
the rest of git. If it is not, then we should rethink whether it is
worth including.

>  - we teach lib-httpd.sh to trigger the DEFAULT_HTTPD_PATH
>    computation when LIB_HTTPD_PATH is set to 'system-apache', so
>    that people can test with their installed apache if they choose
>    to; and

I do not think we want to allow run-time switching between an embedded
solution and apache. That would mean that we have to keep two sets of
http-server config in sync.

> Or were you thinking about embedding mongoose in the git executable?

I don't think it makes sense to embed it in git, but it could easily be
test-httpd.

The rollout would be:

  1. add contrib/mongoose/*

  2. add test-httpd which links against mongoose, built by default in the
     Makefile

  3. convert lib-httpd/apache.conf into mongoose config as necessary

  4. convert lib-httpd.sh to run test-httpd instead of LIB_HTTPD_PATH

  5. delete apache.conf, LIB_HTTPD_PATH and any other apache remnants

  6. default GIT_TEST_HTTPD to yes

Step 3 is the part where I would anticipate trouble (i.e., finding out
that the new server does not do everything the tests expect).

-Peff
