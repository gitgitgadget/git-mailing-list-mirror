From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC] Hacky version of a glob() driven config include
Date: Sat, 8 May 2010 01:06:32 -0400
Message-ID: <20100508050632.GE14998@coredump.intra.peff.net>
References: <u2i51dd1af81004060115t5f837840z5adcf83622fa8882@mail.gmail.com>
 <1273180440-8641-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Eli Barzilay <eli@barzilay.org>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 08 07:06:49 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OAcFV-00005q-5v
	for gcvg-git-2@lo.gmane.org; Sat, 08 May 2010 07:06:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751113Ab0EHFGh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 8 May 2010 01:06:37 -0400
Received: from peff.net ([208.65.91.99]:40071 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751095Ab0EHFGg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 May 2010 01:06:36 -0400
Received: (qmail 2730 invoked by uid 107); 8 May 2010 05:06:50 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 08 May 2010 01:06:50 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 08 May 2010 01:06:32 -0400
Content-Disposition: inline
In-Reply-To: <1273180440-8641-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146637>

On Thu, May 06, 2010 at 09:14:00PM +0000, =C3=86var Arnfj=C3=B6r=C3=B0 =
Bjarmason wrote:

> This is not ready for inclusion in anything. Commiting for RFC on
> whether this way of doing it is sane in theory.

I think the goal of having globbing include files is reasonable.

>   * It relies on the GNU GLOB_TILDE extension with no
>     alternative. That can be done by calling getenv("HOME") and
>     s/~/$home/.

We already have expand_user_path which handles ~ properly (it is used
for the values of some config entries). You could then glob the result.

> +cat > .git/config << EOF
> +[some]
> +	variable =3D blah
> +[voodoo]
> +	include =3D .git/more_config_*
> +EOF

My eyes! The goggles do nothing!

That syntax is horrid. Wouldn't it be much simpler to introduce some
top-level syntax for "include this file here", with some very simple
semantics:

  - the included file starts with no section. It should have its own
    section header.

  - after returning from the included file, we are in no section. You
    need a new section header.

Yes, there are some complex tricks those semantics won't allow, but the=
y
are simple to read and understand, simple to use, and simple to
implement.

And really, what is the point in supporting crap like:

   $ cat .gitconfig
   [diff]
   #include foo

   $ cat foo
   rename =3D true

-Peff
