From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] t0303: set reason for skipping tests
Date: Mon, 12 Mar 2012 08:30:31 -0400
Message-ID: <20120312123031.GA14456@sigill.intra.peff.net>
References: <1331553907-19576-1-git-send-email-zbyszek@in.waw.pl>
 <1331553907-19576-2-git-send-email-zbyszek@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
X-From: git-owner@vger.kernel.org Mon Mar 12 13:31:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S74PC-00011X-TH
	for gcvg-git-2@plane.gmane.org; Mon, 12 Mar 2012 13:31:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755024Ab2CLMbI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 12 Mar 2012 08:31:08 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:47651
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754978Ab2CLMae (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2012 08:30:34 -0400
Received: (qmail 15768 invoked by uid 107); 12 Mar 2012 12:30:44 -0000
Received: from c-71-206-173-132.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.173.132)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 12 Mar 2012 08:30:44 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Mar 2012 08:30:31 -0400
Content-Disposition: inline
In-Reply-To: <1331553907-19576-2-git-send-email-zbyszek@in.waw.pl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192863>

On Mon, Mar 12, 2012 at 01:05:06PM +0100, Zbigniew J=C4=99drzejewski-Sz=
mek wrote:

> t0300-credential-helpers.sh runs two sets of tests. Each set is
> controlled by an environment variable and is skipped if the variable
> is not defined. If both sets are skipped, prove will say:
>   ./t0303-credential-external.sh .. skipped: (no reason given)
> which isn't very nice.
>=20
> Use skip_all=3D"..." to set the reason when both sets are skipped.

Sounds reasonable. A few nits:

>  if test -z "$GIT_TEST_CREDENTIAL_HELPER"; then
> -	say "# skipping external helper tests (set GIT_TEST_CREDENTIAL_HELP=
ER)"
> +	say "# skipping external helper tests (GIT_TEST_CREDENTIAL_HELPER n=
ot set)"
>  else
> [...]
>  if test -z "$GIT_TEST_CREDENTIAL_HELPER_TIMEOUT"; then
> -	say "# skipping external helper timeout tests"
> +	say "# skipping external helper timeout tests (GIT_TEST_CREDENTIAL_=
HELPER_TIMEOUT not set)"

These don't affect prove at all, do they? I'm OK with the changes, but =
I
was confused to see them after reading the commit message.

Should they actually say "# SKIP ..." to tell prove what's going on? I
don't know very much about TAP.

> +if test -z "$GIT_TEST_CREDENTIAL_HELPER" \
> +    -o -z "$GIT_TEST_CREDENTIAL_HELPER_TIMEOUT"; then
> +    skip_all=3D"used to test external credential helpers"
> +fi

Actually, I think it is not OK to run t0303 with HELPER_TIMEOUT set, bu=
t
HELPER not set. The "helper_test_clean" bits will fail badly. The
documentation given in the commit message is actually wrong (I added th=
e
clean bits to the patch later, and failed to realize the dependency or
update the commit message).

Also, our usual idiom is to check the prerequisites at the top of the
script and bail immediately.

So maybe the whole script should be restructured as:

  if test -z "$GIT_TEST_CREDENTIAL_HELPER"; then
          skip_all=3D"GIT_TEST_CREDENTIAL_HELPER not set"
          test_done
  fi

  pre_test
  helper_test "$GIT_TEST_CREDENTIAL_HELPER"
  if test -z "$GIT_TEST_CREDENTIAL_HELPER_TIMEOUT"; then
          say "# skipping timeout tests (GIT_TEST_CREDENTIAL_HELPER_TIM=
EOUT not set)"
  else
          helper_test_timeout "$GIT_TEST_CREDENTIAL_HELPER_TIMEOUT"
  fi
  post_test

-Peff
