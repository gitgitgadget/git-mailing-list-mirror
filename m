From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH v2] mergetool: use more conservative temporary filenames
Date: Fri, 10 Oct 2014 11:48:36 -0700
Message-ID: <20141010184834.GB78117@gmail.com>
References: <1412929187-57936-1-git-send-email-davvid@gmail.com>
 <5437C0CC.7030102@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Sergio Ferrero <sferrero@ensoftcorp.com>,
	Charles Bailey <charles@hashpling.org>
To: Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 10 20:48:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XcfF0-000153-1I
	for gcvg-git-2@plane.gmane.org; Fri, 10 Oct 2014 20:48:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754554AbaJJSsd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Oct 2014 14:48:33 -0400
Received: from mail-pd0-f179.google.com ([209.85.192.179]:48619 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754503AbaJJSsc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Oct 2014 14:48:32 -0400
Received: by mail-pd0-f179.google.com with SMTP id r10so2135058pdi.38
        for <git@vger.kernel.org>; Fri, 10 Oct 2014 11:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=09udqAbf43jJY0p6AB2gwA5g8tnNFoLs3OgYEshrfx0=;
        b=i/u1INZlr1dzFkhxZQNLywhRO3Zn16BxW9tiN6xKnePd2x7EBPo8mCghSxd98SJRP8
         Hsncl264brlyholFlPmETAiu/UjX84AP/Yny6SyH7Y2sai11MUL3V11oSw9OqaADZM+z
         +Dge5IocHSGwXuSQOFVuERyMMwSZyYUvnwR1PD/qMuRwuI8ZxpPI+r7vItzlVKqioqzO
         iaDutF8KI6oPpOrMSywaR5Kdl9dexUerSIcyKVQFtR7EIFJ53+OhmI8VHMgUrm+GFUsm
         E/xr1ft67Nd8/Q1QCnbzbydouvQEfi0eqWiJn2XMqlGPEaofl25Y2sA4wJ02uDoY6uaO
         oeWw==
X-Received: by 10.68.219.104 with SMTP id pn8mr4510617pbc.152.1412966911941;
        Fri, 10 Oct 2014 11:48:31 -0700 (PDT)
Received: from gmail.com (remote-11.disneyanimation.com. [198.187.190.11])
        by mx.google.com with ESMTPSA id ms3sm4194432pdb.19.2014.10.10.11.48.30
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 10 Oct 2014 11:48:31 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <5437C0CC.7030102@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 10, 2014 at 01:19:40PM +0200, Jakub Nar=C4=99bski wrote:
> David Aguilar wrote:
> >Avoid filenames with multiple dots so that overly-picky tools do
> >not misinterpret their extension.
> >
> >Previously, foo/bar.ext in the worktree would result in e.g.
> >
> >	./foo/bar.ext.BASE.1234.ext
> >
> >This can be improved by having only a single .ext and using
> >underscore instead of dot so that the extension cannot be
> >misinterpreted.  The resulting path becomes:
> >
> >	./foo/bar_BASE_1234.ext
> >
> >Suggested-by: Sergio Ferrero <sferrero@ensoftcorp.com>
> >Helped-by: Junio C Hamano <gitster@pobox.com>
> >Signed-off-by: David Aguilar <davvid@gmail.com>
> >---
>=20
> >+	if BASE=3D$(expr "$MERGED" : '\(.*\)\.[^/]*$')
> >+	then
> >+		ext=3D$(expr "$MERGED" : '.*\(\.[^/]*\)$')
> >+	else
> >+		BASE=3D$MERGED
> >+		ext=3D
> >+	fi
>=20
> Why use expr and not POSIX shell parameter substitution?
>=20
> BASE=3D${MERGED%.*}
> ext=3D.${MERGED##*.}
>=20
> Or something like that...

Thanks for the sug.

My POSIX shell parameter expansion-fu is not super advanced, but
if you can help me rework it I'd be happy to reroll.

It does seem simple and robust with expr, though.  Extending the
parameter expansion approach to work in all cases may end up
with more complexity than with the expr method, it seems.

Here are the use cases:

	$ MERGED=3Dfoo.bar.baz && echo ${MERGED%.*} ${MERGED##*.}
	foo.bar baz

Good.

	$ MERGED=3Dfoo && echo ${MERGED%.*} ${MERGED##*.}
	foo foo

Bad.
There's no extension and the substitution doesn't handle it.

	$ MERGED=3Dfoo.bar/baz && echo ${MERGED%.*} ${MERGED##*.}
	foo bar/baz

Bad.
There's no extension but the substitution thinks the parent directory's
extension-less name is the basename, and thinks that bar/baz is the ext=
ension.

I am curious to know whether there's a nice and elegant way to do it
with shell expansions.  Let me know what you think.

cheers,
--=20
David
