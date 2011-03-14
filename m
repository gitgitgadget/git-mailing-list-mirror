From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/3] setup_path(): Free temporary buffer
Date: Mon, 14 Mar 2011 16:09:58 -0400
Message-ID: <20110314200958.GC22602@sigill.intra.peff.net>
References: <1300130318-11279-1-git-send-email-cmn@elego.de>
 <1300130318-11279-3-git-send-email-cmn@elego.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
X-From: git-owner@vger.kernel.org Mon Mar 14 21:10:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PzE5e-0007TK-Pp
	for gcvg-git-2@lo.gmane.org; Mon, 14 Mar 2011 21:10:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752328Ab1CNUKA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Mar 2011 16:10:00 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:59987
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751660Ab1CNUKA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Mar 2011 16:10:00 -0400
Received: (qmail 13329 invoked by uid 107); 14 Mar 2011 20:10:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 14 Mar 2011 16:10:33 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 14 Mar 2011 16:09:58 -0400
Content-Disposition: inline
In-Reply-To: <1300130318-11279-3-git-send-email-cmn@elego.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169022>

On Mon, Mar 14, 2011 at 08:18:37PM +0100, Carlos Mart=C3=ADn Nieto wrot=
e:

> Make sure the pointer git_exec_path() returns is in the heap and free
> it after it's no longer needed.

Could you explain the motivation a bit more? From looking at the code,
it looks like the situation is that git_exec_path sometimes returns a
newly allocated string and sometimes not, so the caller may leak in the
former case.

That seems to be the fault of system_path, which sometimes allocates an=
d
sometimes does not. Should we also be fixing system_path, which is a
source of leaks? Or instead converting system_path to use a static
buffer?

> @@ -99,10 +99,13 @@ void setup_path(void)
>  {
>  	const char *old_path =3D getenv("PATH");
>  	struct strbuf new_path =3D STRBUF_INIT;
> +	char *exec_path =3D (char *) git_exec_path();

Ick. If it is now returning an allocated buffer that the caller is
responsible for free-ing, then its declaration should drop the const in
the return value.

What about other callers of git_exec_path? Aren't load_command_list and
list_commands leaking, too (and possibly worse, since we now always
allocated memory)?

-Peff
