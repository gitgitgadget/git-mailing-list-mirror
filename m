From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] test-lib-functions: fix logic error in test_must_fail
Date: Tue, 24 Nov 2015 16:08:22 -0500
Message-ID: <20151124210822.GG7174@sigill.intra.peff.net>
References: <5654895C.2000909@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Lars Schneider <larsxschneider@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
X-From: git-owner@vger.kernel.org Tue Nov 24 22:08:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a1KpA-0000Wj-Dx
	for gcvg-git-2@plane.gmane.org; Tue, 24 Nov 2015 22:08:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754804AbbKXVI0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Nov 2015 16:08:26 -0500
Received: from cloud.peff.net ([50.56.180.127]:33421 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753961AbbKXVIZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Nov 2015 16:08:25 -0500
Received: (qmail 23022 invoked by uid 102); 24 Nov 2015 21:08:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 24 Nov 2015 15:08:24 -0600
Received: (qmail 18262 invoked by uid 107); 24 Nov 2015 21:08:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 24 Nov 2015 16:08:23 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 24 Nov 2015 16:08:22 -0500
Content-Disposition: inline
In-Reply-To: <5654895C.2000909@ramsayjones.plus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281631>

On Tue, Nov 24, 2015 at 03:59:24PM +0000, Ramsay Jones wrote:

> After commit 710eb805 ("implement test_might_fail using a refactored
> test_must_fail", 19-11-2015) several tests now unexpectedly pass:

Thanks. I noticed there were some new passes, but I hadn't investigated
yet (I assumed it was "yay, we fixed a bug" not "oops, we broke the test
suite).

> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> index 1fdc58c..9061742 100644
> --- a/t/test-lib-functions.sh
> +++ b/t/test-lib-functions.sh
> @@ -593,24 +593,22 @@ test_must_fail () {
>  	esac
>  	"$@"
>  	exit_code=$?
> -	if ! case ",$_test_ok," in *,success,*) false;; esac &&
> -		test $exit_code = 0
> +	if test $exit_code -eq 0 && test x$_test_ok != xsuccess

I don't think this is quite right. I had the impression the original was
trying to allow something like:

  test_must_fail ok=success,sigpipe

And that's what the commas were for in the case statement.

If I understand the logic bug correctly, we simply need to flip the "!"
at the start of the case statement. But we could do something like:

  list_contains () {
	case ",$1," in
	*,$2,*)
		return 0
		;;
	esac
	return 1
  }
  ...
  if ! list_contains "$_test_ok" success && test "$exit_code" -eq 0
  then
	return 0
  fi

which is perhaps a bit more clear, as it encapsulates the funny
negative.

> Since I cannot test this second change (t5516 and t5504 don't
> fail for me), I don't know if this change is correct - please
> test and confirm. (No, it's not clear to me exactly what this
> commit is supposed to do! :-D ).

They don't fail consistently. It's a SIGPIPE race.

> [I didn't have time to go look what value would be returned by
> a case statement where there is no 'default' limb - I suspect
> that it is undefined behaviour. Even if it is defined, do all
> shells behave properly? In any event, it is much simpler to
> compare the strings directly!]

Yeah, I wondered that. We wouldn't depend on it in the example I gave
above.

> I have to say, I'm not keen on either of these commits, but Jeff
> and Junio seem OK with it, so ... (the tests being flaky implies
> that the git client is flaky - we should fix that).

I was actually reasonably happy with just having test_must_fail ignore
SIGPIPE, for the second one. But the infrastructure added by the first
patch does fix real issues in test_might_fail (e.g., that it should
complain of a valgrind failure but doesn't). And once you have that
infrastructure, the second patch becomes trivial.

I don't think the git client is actually flaky here in a way that we can
fix. If I understand the issue correctly, it is that the server side
hangs up in an error case while the client is still writing. So we might
get one of two outcomes:

  1. If the client has finished writing, it will do a read, see the
     hang up, and die().

  2. If the client is still writing, it will get SIGPIPE and die.

There's no solution outside of ignoring SIGPIPE and handling the write()
error ourselves. We've been loathe to do that in the past because
SIGPIPE applies globally, and missing a write() anywhere in the program
means we may spin on bogus writes longer than we need to.

-Peff
