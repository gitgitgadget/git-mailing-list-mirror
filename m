From: Jeff King <peff@peff.net>
Subject: Re: Hardcoded #!/bin/sh in t5532 causes problems on Solaris
Date: Mon, 11 Apr 2016 13:32:25 -0400
Message-ID: <20160411173224.GE4011@sigill.intra.peff.net>
References: <570965B9.9040207@jupiterrise.com>
 <20160409210429.GB18989@sigill.intra.peff.net>
 <57098259.1060608@jupiterrise.com>
 <20160409223738.GA1738@sigill.intra.peff.net>
 <xmqqmvp2ti20.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Tom G. Christensen" <tgc@jupiterrise.com>,
	Elia Pinto <gitter.spiros@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 11 19:32:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1apfhQ-0003kG-DE
	for gcvg-git-2@plane.gmane.org; Mon, 11 Apr 2016 19:32:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751360AbcDKRc2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Apr 2016 13:32:28 -0400
Received: from cloud.peff.net ([50.56.180.127]:47573 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751085AbcDKRc1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Apr 2016 13:32:27 -0400
Received: (qmail 9195 invoked by uid 102); 11 Apr 2016 17:32:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 11 Apr 2016 13:32:27 -0400
Received: (qmail 27725 invoked by uid 107); 11 Apr 2016 17:32:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 11 Apr 2016 13:32:31 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 11 Apr 2016 13:32:25 -0400
Content-Disposition: inline
In-Reply-To: <xmqqmvp2ti20.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291225>

On Sat, Apr 09, 2016 at 05:37:43PM -0700, Junio C Hamano wrote:

> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> index b79f442..d96d0e4 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -555,10 +555,9 @@ test_expect_success 'rebase a detached HEAD' '
>  test_expect_success 'rebase a commit violating pre-commit' '
>  
>  	mkdir -p .git/hooks &&
> -	PRE_COMMIT=.git/hooks/pre-commit &&
> -	echo "#!/bin/sh" > $PRE_COMMIT &&
> -	echo "test -z \"\$(git diff --cached --check)\"" >> $PRE_COMMIT &&
> -	chmod a+x $PRE_COMMIT &&
> +	write_script .git/hooks/pre-commit <<-\EOF &&
> +	test -z "$(git diff --cached --check)"
> +	EOF

Looks good and is the minimal change. I kind of wonder if the example
would be more clear, though, as just:

  write_script .git/hooks/pre-commit <<-\EOF &&
  exit 1
  EOF
  echo whatever >file1 &&
  ...

I don't think we ever actually need the pre-commit check to pass, as we
simply override it with --no-verify. But I dunno. Maybe people find it
easier to read with a pseudo-realistic example (it took me a minute to
realize the trailing whitespace in the content was important).

It could also stand to clean up its hook with test_when_finished. The
next test resorts to "rm -rf" on the hooks directory at the beginning.
Yuck.

-Peff
