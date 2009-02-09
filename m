From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/6] t5400: allow individual tests to fail
Date: Mon, 9 Feb 2009 13:46:26 -0500
Message-ID: <20090209184625.GA27037@coredump.intra.peff.net>
References: <1234170565-6740-1-git-send-email-gitster@pobox.com> <1234170565-6740-2-git-send-email-gitster@pobox.com> <1234170565-6740-3-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 09 19:47:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWbAj-0005FE-Jb
	for gcvg-git-2@gmane.org; Mon, 09 Feb 2009 19:47:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752243AbZBISqa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Feb 2009 13:46:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751898AbZBISqa
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Feb 2009 13:46:30 -0500
Received: from peff.net ([208.65.91.99]:53070 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751801AbZBISq3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Feb 2009 13:46:29 -0500
Received: (qmail 4229 invoked by uid 107); 9 Feb 2009 18:46:43 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 09 Feb 2009 13:46:43 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 09 Feb 2009 13:46:26 -0500
Content-Disposition: inline
In-Reply-To: <1234170565-6740-3-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109100>

On Mon, Feb 09, 2009 at 01:09:21AM -0800, Junio C Hamano wrote:

> Each test chdir'ed around and ended up in a random place if any of the
> test in the sequence failed but the entire test script was allowed to
> run.  This wrapps each in a subshell as necessary.

Certainly a good cleanup, but...

> -test_expect_success \
> -        'push can be used to delete a ref' '
> +test_expect_success 'push can be used to delete a ref' '
> +    (
>  	cd victim &&
>  	git branch extra master &&
>  	cd .. &&
>  	test -f victim/.git/refs/heads/extra &&
>  	git send-pack ./victim/.git/ :extra master &&
>  	! test -f victim/.git/refs/heads/extra
> +    )
>  '

Wouldn't this be cleaner as:

  (
    cd victim &&
    git branch extra master
  ) &&
  ...

That is, it is not only safer but (IMHO) a bit easier to see which parts
are happening in which directory.

> +test_expect_success 'pushing a delete should be denied with denyDeletes' '
> +    (
>  	cd victim &&
>  	git config receive.denyDeletes true &&
>  	git branch extra master &&
>  	cd .. &&
>  	test -f victim/.git/refs/heads/extra &&
>  	test_must_fail git send-pack ./victim/.git/ :extra master
> +    )

Ditto (and there are more, but I won't quote each one).

> +test_expect_success 'pushing with --force should be denied with denyNonFastforwards' '
> +    (
>  	cd victim &&
>  	git config receive.denyNonFastforwards true &&
>  	cd .. &&
>  	git update-ref refs/heads/master master^ || return 1
>  	git send-pack --force ./victim/.git/ master && return 1
>  	! test_cmp .git/refs/heads/master victim/.git/refs/heads/master
> +    )

And here I don't know what in the world is going on with those "return
1" lines. Shouldn't this be a chain of &&'s with a test_must_fail?
I.e.,:

  ( cd victim && git config receive.denyNonFastforwards true ) &&
  git update-ref refs/heads/master master^ &&
  test_must_fail git send-pack --force ./victim/.git/ master &&
  ! test_cmp .git/refs/heads/master victim/.git/refs/heads/master

Not to mention that the final test_cmp would be more robust if written
to make sure the victim's master ref stayed the same (instead of just
making sure we didn't screw it up in one particular way). And it should
probably use a git command rather than looking at the refs files (to be
future-proof against any automatic ref-packing), but that is just
nit-picking.


All minor things, of course, but while we're cleaning up... :)

-Peff
