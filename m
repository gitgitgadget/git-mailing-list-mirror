From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/5] completion: fix args of run_completion() test helper
Date: Fri, 28 Sep 2012 15:55:31 -0400
Message-ID: <20120928195531.GB3912@sigill.intra.peff.net>
References: <20120928100530.GL10144@goldbirke>
 <1348826975-2225-1-git-send-email-szeder@ira.uka.de>
 <1348826975-2225-2-git-send-email-szeder@ira.uka.de>
 <7vehlmm3ca.fsf@alter.siamese.dyndns.org>
 <20120928183840.GB10719@goldbirke>
 <7vzk4aj6ik.fsf@alter.siamese.dyndns.org>
 <20120928193008.GA3912@sigill.intra.peff.net>
 <7vvceyj5bu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 28 21:55:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THgf9-00021x-GJ
	for gcvg-git-2@plane.gmane.org; Fri, 28 Sep 2012 21:55:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031771Ab2I1Tzi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Sep 2012 15:55:38 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:33838 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031293Ab2I1Tze (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Sep 2012 15:55:34 -0400
Received: (qmail 19217 invoked by uid 107); 28 Sep 2012 19:56:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 28 Sep 2012 15:56:02 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 28 Sep 2012 15:55:31 -0400
Content-Disposition: inline
In-Reply-To: <7vvceyj5bu.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206606>

On Fri, Sep 28, 2012 at 12:49:25PM -0700, Junio C Hamano wrote:

> >> And these "words" can be split at $IFS boundaries without any
> >> issues?  IOW, nobody would ever want to make words array in the
> >> run_completion function to ['git' 'foo bar' 'baz']?
> >
> > It might be simpler to just convert test_completion into the
> > test_completion_long I added in my series; the latter takes the expected
> > output on stdin, leaving the actual arguments free to represent the real
> > command-line. E.g., your example would become:
> >
> >   test_completion git "foo bar" baz <<-\EOF
> >   ... expected output ...
> >   EOF
> 
> I realize that the way my question was stated was misleading.  It
> was not meant as a rhetorical "You would never be able to pass
> ['git' 'foo bar' 'baz'] with that interface, and the patch sucks."
> but was meant as a pure question "Do we want to pass such word
> list?".  "test_completion is almost always used to test completion
> with inputs without any $IFS letters in it, so not being able to
> test such an input via this interface is fine. If needed, we can
> give another less often used interface to let you pass such an
> input" is perfectly fine by me.

I think we may eventually want to pass arguments with IFS into the
function, just to make sure it works (the tests I added checked for IFS
in the completion list rather than the input, but we should probably
check both).

I'm OK if it needs to be an alternate interface (right now you could do
it by calling run_completion yourself).

> But I suspect that the real reason test_completion requires the
> caller to express the list of inputs to run_completion as $IFS
> separate list is because it needs to also get expected from the
> command line:

Right, that's why I suggested bumping that to stdin for the function.

> >> >  test_completion ()
> >> >  {
> >> >  	test $# -gt 1 && echo "$2" > expected
> >> > -	run_completion "$@" &&
> >> > +	run_completion $1 &&
> >> >  	test_cmp expected out
> >> >  }
> 
> I wonder if doing something like this would be a far simpler
> solution:
> 
> 	test_completion ()
>         {
> 		case "$1" in
>                 '')
> 			;;
> 		*)
> 			echo "$1" >expect &&
> 	                shift
>                         ;;
> 		esac &&
>                 run_completion "$@" &&
>                 test_cmp expect output
> 	}

That would also work. I mainly suggested the stdin thing because we need
it anyway for output that generates multiple answers (well, you don't
_need_ it; you can call run_completion yourself, but it saves a few
lines at each call site).

-Peff
