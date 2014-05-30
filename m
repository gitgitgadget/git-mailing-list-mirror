From: Jeff King <peff@peff.net>
Subject: Re: [RFC PATCH] t5538: move http push tests out to t5542
Date: Fri, 30 May 2014 13:20:52 -0400
Message-ID: <20140530172051.GB25443@sigill.intra.peff.net>
References: <87y4xk8asq.fsf@spindle.srvr.nix>
 <20140530010649.GD28683@sigill.intra.peff.net>
 <20140530013419.GE28683@sigill.intra.peff.net>
 <87lhtj8sqx.fsf_-_@spindle.srvr.nix>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Duy Nguyen <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Nix <nix@esperi.org.uk>
X-From: git-owner@vger.kernel.org Fri May 30 19:21:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WqQUE-0004EM-De
	for gcvg-git-2@plane.gmane.org; Fri, 30 May 2014 19:20:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933965AbaE3RUy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 May 2014 13:20:54 -0400
Received: from cloud.peff.net ([50.56.180.127]:34262 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933202AbaE3RUy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 May 2014 13:20:54 -0400
Received: (qmail 14480 invoked by uid 102); 30 May 2014 17:20:53 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 30 May 2014 12:20:53 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 30 May 2014 13:20:52 -0400
Content-Disposition: inline
In-Reply-To: <87lhtj8sqx.fsf_-_@spindle.srvr.nix>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250446>

On Fri, May 30, 2014 at 11:29:10AM +0100, Nix wrote:

> As 0232852b, but for the push tests instead: this avoids a start_httpd
> in the middle of the file, which fails under GIT_TEST_HTTPD=false.
> 
> Signed-off-by: Nick Alcock <nick.alcock@oracle.com>

Thanks, this makes sense. I'm really not sure why we didn't notice this
at the same time as t5537.

I'm cc-ing Duy, who wrote the original test, to give input on the new
test setup.

> ---
> On 30 May 2014, Jeff King said:
> > diff --git a/t/t5537-fetch-shallow.sh b/t/t5537-fetch-shallow.sh
> > index be951a4..a980574 100755
> > --- a/t/t5537-fetch-shallow.sh
> > +++ b/t/t5537-fetch-shallow.sh
> 
> btw, t5538-push-shallow.sh has the same bug but was not fixed up that I
> can see. (Though I can't see the original fix in the history of master
> either: was it squashed away somehow?)

I don't think so. As far as I can tell, it was never fixed.

> +test_description='push from/to a shallow clone over http'
> +
> +. ./test-lib.sh
> +
> +if test -n "$NO_CURL" -o -z "$GIT_TEST_HTTPD"; then
> +	say 'skipping test, git built without http support'
> +	test_done
> +fi

Ah, this may be why we missed it. We should leave the handling of
$GIT_TEST_HTTPD to lib-httpd.sh. I think the topic to refactor lib-httpd
setup and this shallow topic were developed in isolation, and we never
noticed the semantic conflict during the merge, because there's no
textual conflict.

So when I tested with a broken apache, we silently skipped this test
(but setting GIT_TEST_HTTPD=false does not trigger the above skip).

> +test_expect_success 'push from shallow repo via http' '
> +	mv "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" shallow-upstream.git &&
> +	git clone --bare --no-local full "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
> +	(
> +	cd "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
> +	git config http.receivepack true
> +	) &&
> +	commit 1s0 &&

This is a typo, no? The original is just "commit 10".

With that fix, the test still fails:

    --- expect      2014-05-30 17:18:08.638496558 +0000
    +++ actual      2014-05-30 17:18:08.638496558 +0000
    @@ -1,5 +1,4 @@
     10
    -1
     4
     3
     2
    not ok 3 - push from shallow repo via http

I think we can just drop that "1" from the expected output, though. It
was created in the original by the "push from full to shallow" test (and
is rather confusing, anyway, as it shares a name with the original "1").

-Peff
