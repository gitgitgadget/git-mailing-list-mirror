From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/6] t5516 (fetch-push): introduce mk_test_with_name()
Date: Wed, 20 Mar 2013 14:58:45 -0400
Message-ID: <20130320185844.GB30165@sigill.intra.peff.net>
References: <1363783501-27981-1-git-send-email-artagnon@gmail.com>
 <1363783501-27981-4-git-send-email-artagnon@gmail.com>
 <20130320182830.GJ3655@google.com>
 <CALkWK0mCVb6N76QU+U3iTO_gmU4PmhrTOgU53DAMd5x1bCQEtA@mail.gmail.com>
 <20130320184157.GO3655@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 20 19:59:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UIOEI-0004SD-TT
	for gcvg-git-2@plane.gmane.org; Wed, 20 Mar 2013 19:59:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752430Ab3CTS6w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Mar 2013 14:58:52 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:60399 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750902Ab3CTS6v (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Mar 2013 14:58:51 -0400
Received: (qmail 11477 invoked by uid 107); 20 Mar 2013 19:00:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 20 Mar 2013 15:00:34 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Mar 2013 14:58:45 -0400
Content-Disposition: inline
In-Reply-To: <20130320184157.GO3655@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218656>

On Wed, Mar 20, 2013 at 11:41:57AM -0700, Jonathan Nieder wrote:

> Ramkumar Ramachandra wrote:
> > Jonathan Nieder wrote:
> 
> >> I dunno.  The helper functions at the top of this test are already
> >> intimidating, so I guess I am looking for a way to avoid making that
> >> problem worse.
> [...]
> > My patch does not make the situation worse in any way:
> 
> Um, yes it does.  It adds another function to learn to an already
> intimidating list.

Personally I do not find the set of helper functions intimidating. I
tend to read the tests in a top-down manner: a test is interesting
(usually because it fails), and then I want to see what it is doing, so
I look at any functions it calls, and so forth.

What I usually find _much_ harder to debug is when there is hidden state
leftover from other tests. So even though it is longer to write, I would
much rather see:

  test_expect_success 'check that frob only affects foo' '
          set_state_of foo &&
          set_state_of bar &&
          git frob &&
          check_state_of foo &&
          check_state_of bar
  '

than for the test to assume the state of "foo" or "bar" prior to the
test. And I think helper functions can help make writing those sorts of
pre-conditions more reasonable (and without looking too hard, I think
t5516 does an OK job of that).

Related to that is when the helper functions operate on hidden state. In
this instance, we have tests that do things like:

    mk_empty &&
    git push testrepo refs/heads/master:refs/remotes/origin/master

and as a reader I say "wait, what's in testrepo?". I can follow mk_empty
and see that it hardcodes testrepo, but it is even better if the
function and its arguments are named in a way that I don't have to. So
even though it is more typing, I would argue that:

  mk_empty testrepo &&
  git push testrepo ...

is better, because the test script is more readable as a unit.

None of this is that huge a deal to me (and yet I seem to have written a
page about it :) ), but I figure while we are bikeshedding about test
style...

-Peff
