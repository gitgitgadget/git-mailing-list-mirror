From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] init-db: remove unused #includes
Date: Thu, 15 Jan 2015 05:55:59 -0500
Message-ID: <20150115105558.GA13536@peff.net>
References: <1421258367-8483-1-git-send-email-kuleshovmail@gmail.com>
 <xmqq61c99o25.fsf@gitster.dls.corp.google.com>
 <xmqqwq4p86i6.fsf@gitster.dls.corp.google.com>
 <CANCZXo5UY80327pvjzYkJXroH_WZdW36LhSANK0O7GGVQLF=AA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Alexander Kuleshov <kuleshovmail@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 15 11:56:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YBi5w-00058F-He
	for gcvg-git-2@plane.gmane.org; Thu, 15 Jan 2015 11:56:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752107AbbAOK4E convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 15 Jan 2015 05:56:04 -0500
Received: from cloud.peff.net ([50.56.180.127]:34884 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751737AbbAOK4C (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2015 05:56:02 -0500
Received: (qmail 5072 invoked by uid 102); 15 Jan 2015 10:56:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 15 Jan 2015 04:56:02 -0600
Received: (qmail 12157 invoked by uid 107); 15 Jan 2015 10:56:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 15 Jan 2015 05:56:23 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 15 Jan 2015 05:55:59 -0500
Content-Disposition: inline
In-Reply-To: <CANCZXo5UY80327pvjzYkJXroH_WZdW36LhSANK0O7GGVQLF=AA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262474>

On Thu, Jan 15, 2015 at 04:13:00PM +0600, Alexander Kuleshov wrote:

> yes right, missed system_path usage. But it's strange, code still
> compiles successfully without exec_cmd.h.

Sort of. With your patch I get:

builtin/init-db.c: In function =E2=80=98copy_templates=E2=80=99:
builtin/init-db.c:127:3: warning: implicit declaration of function =E2=80=
=98system_path=E2=80=99 [-Wimplicit-function-declaration]
   template_dir =3D to_free =3D system_path(DEFAULT_GIT_TEMPLATE_DIR);
   ^
builtin/init-db.c:127:26: warning: assignment makes pointer from intege=
r without a cast
   template_dir =3D to_free =3D system_path(DEFAULT_GIT_TEMPLATE_DIR);

Those are just warnings, and on some platforms the resulting code will
be fine, but it does violate the C standard to not have a valid
declaration in this case (it defaults to an int return type, which is
wrong; but simply as a matter of style we do not like implicit
declarations even when they are technically correct).

If you are going to be doing refactoring, I'd recommend building with
"-Werror" in your CFLAGS to catch such problems.

=46WIW, the full set of CFLAGS I use (which I specify in config.mak) is=
:

    CFLAGS +=3D -Wall -Werror
    CFLAGS +=3D -Wno-format-zero-length
    CFLAGS +=3D -Wdeclaration-after-statement
    CFLAGS +=3D -Wpointer-arith
    CFLAGS +=3D -Wstrict-prototypes
    CFLAGS +=3D -Wold-style-declaration

-Peff
