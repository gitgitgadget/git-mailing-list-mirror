From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v4 0/6] Support triangular workflows
Date: Thu, 28 Mar 2013 11:35:47 -0400
Message-ID: <20130328153547.GA3337@sigill.intra.peff.net>
References: <1364477202-5742-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 28 16:36:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULEsJ-0003Jd-0X
	for gcvg-git-2@plane.gmane.org; Thu, 28 Mar 2013 16:36:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754297Ab3C1Pfz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Mar 2013 11:35:55 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:43663 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752615Ab3C1Pfy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Mar 2013 11:35:54 -0400
Received: (qmail 25810 invoked by uid 107); 28 Mar 2013 15:37:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 28 Mar 2013 11:37:41 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 28 Mar 2013 11:35:47 -0400
Content-Disposition: inline
In-Reply-To: <1364477202-5742-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219410>

On Thu, Mar 28, 2013 at 06:56:36PM +0530, Ramkumar Ramachandra wrote:

> Jeff King (1):
>   t5516 (fetch-push): drop implicit arguments from helper functions
> 
> Ramkumar Ramachandra (5):
>   remote.c: simplify a bit of code using git_config_string()
>   t5516 (fetch-push): update test description
>   remote.c: introduce a way to have different remotes for fetch/push
>   remote.c: introduce remote.pushdefault
>   remote.c: introduce branch.<name>.pushremote

Thanks, this iteration looks pretty good. I have one minor nit, which is
that the tests in patches 5 and 6 do things like:

> +	git push &&
> +	test_must_fail check_push_result up_repo $the_commit heads/master &&
> +	check_push_result down_repo $the_commit heads/master

Using test_must_fail here caught my eye, because usually it is meant to
check failure of a single git command. When it (or "!", for that matter)
is used with a compound function, you end up losing robustness in corner
cases.

For example, imagine your function is:

  check_foo() {
          cd "$1" &&
          git foo
  }

and you expect in some cases that "git foo" will succeed and in some
cases it will fail. In the affirmative case (running "check_foo"), this
is robust; if any of the steps fails, the test fails.

But if you run the negative case ("test_must_fail check_foo"), you will
also fail if any of the preparatory steps fail. I.e., you wanted to say:

  cd "$1" && test_must_fail git foo

but you actually said (applying De Morgan's laws):

  test_must_fail cd "$1" || test_must_fail git foo

Now we probably don't expect the "cd" to fail here, but of course the
other steps can be more complicated, too. In your case, I think the
effect you are looking for is that "heads/master != $the_commit". But
note that we would also fail if "git fsck" fails in the pushed
repository, which is not what we want.

Sometimes it's annoyingly verbose to break down a compound function. But
I think in this case, you can make your tests more robust by just
checking the affirmative that the ref is still where we expect it to be,
like:

  check_push_result up_repo $the_first_commit heads/master

Sorry if that was a bit long-winded. I think that practically speaking,
it is not a likely source of problems in this case. But it's an
anti-pattern in our tests that I think is worth mentioning.

-Peff
