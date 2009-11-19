From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] git am/mailinfo: Don't look at in-body headers when
 rebasing
Date: Thu, 19 Nov 2009 10:36:23 -0500
Message-ID: <20091119153622.GC6877@coredump.intra.peff.net>
References: <aa2993680911180620g151d8a07t11144d150cd6e29e@mail.gmail.com>
 <20091118155154.GA15184@coredump.intra.peff.net>
 <20091118164208.GB15184@coredump.intra.peff.net>
 <4B0478ED.30306@gmail.com>
 <aa2993680911181547p4cbbf12cq74b482f63e59d007@mail.gmail.com>
 <4B050718.8070506@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Philip Hofstetter <phofstetter@sensational.ch>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Lukas =?utf-8?Q?Sandstr=C3=B6m?= <luksan@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 19 16:36:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NB93g-0005Hr-Cu
	for gcvg-git-2@lo.gmane.org; Thu, 19 Nov 2009 16:36:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753430AbZKSPgV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 Nov 2009 10:36:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753287AbZKSPgU
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Nov 2009 10:36:20 -0500
Received: from peff.net ([208.65.91.99]:47775 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752490AbZKSPgU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Nov 2009 10:36:20 -0500
Received: (qmail 19326 invoked by uid 107); 19 Nov 2009 15:40:15 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 19 Nov 2009 10:40:15 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 19 Nov 2009 10:36:23 -0500
Content-Disposition: inline
In-Reply-To: <4B050718.8070506@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133235>

On Thu, Nov 19, 2009 at 09:51:36AM +0100, Lukas Sandstr=C3=B6m wrote:

> When we are rebasing we know that the header lines in the
> patch are good and that we don't need to pick up any headers
> from the body of the patch.
>=20
> This makes it possible to rebase commits whose commit message
> start with "From" or "Date".
>=20
> Test vectors by Jeff King.

Thanks, it did end up being a pretty small change. Though I think we ma=
y
be better off with _both_ patches. Your patch protects the message
absolutely during rebasing, and my patch improves the heuristic when
applying non-rebase patches.

> @@ -771,6 +772,8 @@ static int handle_commit_msg(struct strbuf *line)
>  		return 0;
>=20
>  	if (still_looking) {
> +		if (!use_inbody_headers)
> +			still_looking =3D 0;
>  		strbuf_ltrim(line);
>  		if (!line->len)
>  			return 0;

Hmm. But we still end up in this conditional for the very first line.
Which I guess happens to work because the first line we feed is
presumably the empty blank line (but I didn't check). Still, wouldn't i=
t
be more clear as:

  if (use_inbody_headers && still_looking) {
     ...

in which case still_looking simply becomes irrelevant when the feature
is disabled?

> +From nobody Mon Sep 17 00:00:00 2001
> +From: A U Thor <a.u.thor@example.com>
> +Subject: check bogus body header (from)
> +Date: Fri, 9 Jun 2006 00:44:16 -0700
> +
> +From: bogosity
> +  - a list
> +  - of stuff
> +---

Since your feature is meant to prevent us looking at inbody headers no
matter if they are valid-looking or not, wouldn't a better test be to
actually have:

  From: Other Author <other@example.com>

Otherwise, you don't know if it is your feature blocking it, or my patc=
h
(if it gets applied on top).

> +From nobody Mon Sep 17 00:00:00 2001
> +From: A U Thor <a.u.thor@example.com>
> +Subject: check bogus body header (date)
> +Date: Fri, 9 Jun 2006 00:44:16 -0700
> +
> +Date: bogus
> +
> +and some content
> +

And ditto for the Date here.

-Peff
