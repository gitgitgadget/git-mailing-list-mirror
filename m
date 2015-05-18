From: Jeff King <peff@peff.net>
Subject: Re: sh -x -i -v with continuous integration, was Re: [PATCH 1/4]
 t7601: test for pull.ff=true overrides merge.ff=false
Date: Mon, 18 May 2015 14:45:29 -0400
Message-ID: <20150518184528.GA11463@peff.net>
References: <1431510740-9710-1-git-send-email-pyokagan@gmail.com>
 <1431510740-9710-2-git-send-email-pyokagan@gmail.com>
 <2a5e49ff1cc3a0275e09328a3ad07866@www.dscho.org>
 <xmqqy4kr85wg.fsf@gitster.dls.corp.google.com>
 <81926313e0a131cd7224f0f6f8984dd2@www.dscho.org>
 <xmqqh9rf84we.fsf@gitster.dls.corp.google.com>
 <20150516152858.GA19269@peff.net>
 <xmqq1tigfij8.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Paul Tan <pyokagan@gmail.com>, git@vger.kernel.org,
	Stefan Beller <sbeller@google.com>,
	David Aguilar <davvid@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 18 20:45:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YuQ2k-00033x-2n
	for gcvg-git-2@plane.gmane.org; Mon, 18 May 2015 20:45:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932298AbbERSpd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 May 2015 14:45:33 -0400
Received: from cloud.peff.net ([50.56.180.127]:60305 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932233AbbERSpc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 May 2015 14:45:32 -0400
Received: (qmail 1098 invoked by uid 102); 18 May 2015 18:45:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 18 May 2015 13:45:32 -0500
Received: (qmail 26764 invoked by uid 107); 18 May 2015 18:45:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 18 May 2015 14:45:32 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 18 May 2015 14:45:29 -0400
Content-Disposition: inline
In-Reply-To: <xmqq1tigfij8.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269297>

On Sat, May 16, 2015 at 12:07:23PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Do we object to having to sprinkle the "verbose" throughout the test
> > scripts?
> 
> Yes.  
> 
> An unconstrained "verbose" that applies to anything would make
> people less careful to come up with more useful abstractions,
> e.g. test_line_count, which I view as a bigger problem.

I don't think that is true at all. They serve two different purposes.

We need "test_line_count" because of portability considerations. But we
do not need "test_eq" for that; the only reason to add it is for
debuggable output. We _could_ add a bunch of little helpers to cover
each situation, but empirically we have not[1], because it's annoying to
do so. Instead we just write a bare "test". I had hoped that "verbose"
would make it sufficiently easy to improve upon the status quo that
people would actually use it[2].

So I don't really buy the argument that "verbose" makes things worse. I
think I _do_ buy the argument that it is not worth the extra effort
given that I implemented "-x" around the same time. I think the
"verbose" output is a little nicer, as I said earlier, but having the
test-writer do literally zero work may be worth it.

-Peff

[1] The exception, AFAIK, is test_path_is_*.

[2] For the most part, actually, I think the status quo is using
    test_cmp, and most of the uses of "test" are old. Using test_cmp is
    more verbose, but it does have the advantage of checking the exit
    code of the sub-programs (and also its output is much saner for
    multi-line comparisons, but that isn't relevant to Paul's patches).

    I'd be in favor of helpers that made it shorter to use test_cmp.
    E.g.:

      # "actual" contains "foo\n"; we save one line of "echo"
      git foo >actual &&
      test_cmp_str foo actual

      # same, but take multiline input on stdin. Saves one line of "cat"
      git foo >actual &&
      test_cmp_str - actual <<-\EOF
      foo
      EOF

      # similar, but it runs the command for us and compares its
      # stdout, saving another line. Note that we take stdout as-is,
      # so you get no opportunity to post-process it (but you
      # can still do it the "long" way as above if you need to).
      test_cmp_cmd foo git foo

      # same, with stdin; obviously this doesn't work if you need to
      # send something over stdin to the command, but again, you can
      # fallback to the old way.
      test_cmp_cmd - git foo <<-\EOF
      foo
      EOF

   These also go in the direction of "verbose", by providing generic
   solutions rather than specific ones. So by the argument you made
   above, this is a bad thing.
