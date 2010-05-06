From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] test-lib: some shells do not let $? propagate into an
 eval
Date: Thu, 6 May 2010 04:57:20 -0400
Message-ID: <20100506085720.GA31873@coredump.intra.peff.net>
References: <7vaaselxe8.fsf@alter.siamese.dyndns.org>
 <20100506055236.GA16151@coredump.intra.peff.net>
 <20100506064428.GA29360@progeny.tock>
 <20100506065419.GA21009@coredump.intra.peff.net>
 <20100506084045.GA25917@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 06 10:57:45 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O9wtp-0007dd-CY
	for gcvg-git-2@lo.gmane.org; Thu, 06 May 2010 10:57:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756350Ab0EFI5Z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 May 2010 04:57:25 -0400
Received: from peff.net ([208.65.91.99]:57569 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756320Ab0EFI5Y (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 May 2010 04:57:24 -0400
Received: (qmail 5057 invoked by uid 107); 6 May 2010 08:57:38 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 06 May 2010 04:57:38 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 06 May 2010 04:57:20 -0400
Content-Disposition: inline
In-Reply-To: <20100506084045.GA25917@progeny.tock>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146462>

On Thu, May 06, 2010 at 03:41:10AM -0500, Jonathan Nieder wrote:

> I tried the cleanup_ret idea; test_run_ ended up looking like this:
>=20
> 	test_cleanup=3D:
> 	eval >&3 2>&4 "$1"
> 	eval_ret=3D$?
> 	eval >&3 2>&4 ":; $test_cleanup"
> 	cleanup_ret=3D?
> 	(exit "$test_ret") && (exit "$cleanup_ret")
> 	eval_ret=3D$?

Maybe it is just me, but those last two lines would be much more
readable as:

  if test "$eval_ret" =3D 0; then
    eval_ret=3D$cleanup_ret
  fi

assuming your "$test_ret" was supposed to be $eval_ret.

> That breaks the principle of keeping the ugliness in test_when_finish=
ed.
> So here=E2=80=99s the minimal fix.

I don't know that we have necessarily have that principle. The most
important thing is that ugliness not escape to the test scripts
themselves, where we have to write many thousands of (hopefully
readable) lines.

But...

> -- 8< --
> Subject: test-lib: some shells do not let $? propagate into an eval

This fix looks fine to me, and I tested it on FreeBSD 8.0. So:

 Acked-by: Jeff King <peff@peff.net>

> I was also surprised to see this migrate to maint so quickly, but I
> was happy to see it broke early and loudly.

I think Junio is much more carefree with changes that only touch test
infrastructure, as they cannot possibly be breaking git itself for
anybody.

> Because there is some unhappiness with the feature[1], it might make

To clarify my position, I am not that negative on the feature. I just
think it is a bit of a fool's errand, and I don't want to personally
spend any time on making it happen. If you think it is worth proceeding
and you can do so without breaking anything[1], I won't object.

[1] Yes, I am teasing you. But probably the complex part is now done,
and you and others can use test_when_finished() at will now, and we can
see if it actually makes anybody's life better.

-Peff
