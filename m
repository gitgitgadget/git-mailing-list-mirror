From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v6 6/6] Add Travis CI support
Date: Thu, 19 Nov 2015 09:35:29 -0500
Message-ID: <20151119143528.GC9353@sigill.intra.peff.net>
References: <1447923491-15330-1-git-send-email-larsxschneider@gmail.com>
 <1447923491-15330-7-git-send-email-larsxschneider@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, luke@diamand.org, sunshine@sunshineco.com,
	gitster@pobox.com
To: larsxschneider@gmail.com
X-From: git-owner@vger.kernel.org Thu Nov 19 15:35:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZzQJE-00082s-Ov
	for gcvg-git-2@plane.gmane.org; Thu, 19 Nov 2015 15:35:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933836AbbKSOfc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Nov 2015 09:35:32 -0500
Received: from cloud.peff.net ([50.56.180.127]:59727 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933732AbbKSOfb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Nov 2015 09:35:31 -0500
Received: (qmail 18109 invoked by uid 102); 19 Nov 2015 14:35:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 19 Nov 2015 08:35:31 -0600
Received: (qmail 17074 invoked by uid 107); 19 Nov 2015 14:36:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 19 Nov 2015 09:36:03 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 19 Nov 2015 09:35:29 -0500
Content-Disposition: inline
In-Reply-To: <1447923491-15330-7-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281478>

On Thu, Nov 19, 2015 at 09:58:11AM +0100, larsxschneider@gmail.com wrote:

> From: Lars Schneider <larsxschneider@gmail.com>
> 
> The tests are currently executed on "Ubuntu 12.04 LTS Server Edition
> 64 bit" and on "OS X Mavericks" using gcc and clang.
> 
> Perforce and Git-LFS are installed and therefore available for the
> respective tests.

My overall impression is that this is a lot more complicated than I was
expecting. Can we start with something simpler to gain experience with
Travis?  And then we can add in more complexity later.

For example:

> +addons:
> +  apt:
> +    packages:
> +    - language-pack-is

I doubt most people are running the t0204 right now. Maybe we should
start without it.

> +env:
> +  global:
> +    - P4_VERSION="15.1"
> +    - GIT_LFS_VERSION="1.0.2"

I know p4 is your area of interest, but from a project perspective, it
seems like an odd choice for the initial set of tests.

> +    - DEFAULT_TEST_TARGET=prove
> +    - GIT_PROVE_OPTS="--timer --jobs 3"
> +    - GIT_TEST_OPTS="--verbose --tee"

These all make sense, I guess.

> +    - GETTEXT_ISO_LOCALE=YesPlease
> +    - GETTEXT_LOCALE=YesPlease

What are these? I don't think we have any such Makefile knobs. These
look like variables that get used internally by the test suite, but we
shouldn't need to set them.

> +    # - GETTEXT_POISON=YesPlease

I'm assuming the "#" means this is commented out. Can we just drop such
cruft?

> +    - GIT_TEST_CHAIN_LINT=YesPlease

This is the default, and we don't need to specify it.

> +    - GIT_TEST_CLONE_2GB=YesPlease

Is it a good idea to run such an expensive test?

> +  matrix:
> +    -
> +      # NO_ICONV=YesPlease

Ditto here on the commenting.

> +    - >
> +      NO_CURL=YesPlease

So if I understand correctly, the point of this list is to test
alternate configurations. So compiling without curl makes some sense, I
guess. Though mostly it will just shut off a bunch off tests.

> +      NO_D_INO_IN_DIRENT=YesPlease

But setting platform compat knobs like this seems weird. Nobody sets
this manually. Either your platform has it, or it does not. And we are
already testing on alternate platforms to cover such things.

If there's a specific config setup of interest, it makes sense to me to
try to increase test coverage there. But it feels like you've just
picked a random laundry list of Makefile knobs and tweaked them, without
any sense of whether they even make sense together, or match the
platform.

For instance:

> +      NO_STRCASESTR=YesPlease
> +      NO_STRLCPY=YesPlease

I wouldn't not be surprised if these cause problems building on some
platforms that _do_ have these functions.

> +    echo "$(tput setaf 6)Perfoce Server Version$(tput sgr0)";
> +    p4d -V | grep Rev.;
> +    echo "$(tput setaf 6)Perfoce Client Version$(tput sgr0)";
> +    p4 -V | grep Rev.;

s/Perfoce/Perforce/ :)

> +before_script: make configure && ./configure && make --jobs=2

Hmm. I wonder if we actually want to use autoconf here at all; most devs
do not use it, and Git should generally compile out of the box based on
config.mak.uname (and if it doesn't, it would be nice to know).

There may be some optional packages that autoconf helps with, though.


So overall, I dunno. I do not want to create a bunch of work for you in
splitting it up. But I'm hesitant to merge something that has a bunch of
lines that I'm not sure I understand the reasoning for. :-/

I was hoping the first cut could just be telling Travis to run "make
test", without much fanfare beyond that. Maybe that's not realistic.

-Peff
