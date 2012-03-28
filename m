From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v5 2/3] gitweb: refactor If-Modified-Since handling
Date: Wed, 28 Mar 2012 15:13:52 +0100
Message-ID: <201203281613.52624.jnareb@gmail.com>
References: <20120326173646.GA6524@odin.tremily.us> <201203280024.20805.jnareb@gmail.com> <20120328135146.GA3525@odin.tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "W. Trevor King" <wking@drexel.edu>
X-From: git-owner@vger.kernel.org Wed Mar 28 16:14:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCtdW-0001Cg-IO
	for gcvg-git-2@plane.gmane.org; Wed, 28 Mar 2012 16:14:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758114Ab2C1OOB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Mar 2012 10:14:01 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:45383 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757880Ab2C1OOA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Mar 2012 10:14:00 -0400
Received: by wejx9 with SMTP id x9so664463wej.19
        for <git@vger.kernel.org>; Wed, 28 Mar 2012 07:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=jmOKEZ84nHUQFu4npz0lNKcw76nqS8ZqADm5NujzvAs=;
        b=VGkfYcCTg8WUaIt3eFHvgMYWptRw0tXqv3FLEmBHHAYuaJxCnD4LfoFn+uBwrzNbpY
         LgpkUwXxmfzb1dVxThsMtTySd7Yzz1dBaMr67WD+Y+h7MrYjEiHjVBuczicY7x89DQNc
         JAOUkS3H+d1LKaZ2QIcTQ8oU0K8GvVmJwUxlv1tsrp4dTVNxR88+Y3nJLEnPNwKzH5vE
         tOCqhuCCAg6t2H979MQNBGHulTvS9uIDLNKaZSIeyebsIQ2VXev7AU4YfCvYaDz6K1In
         Y7qGLTOwwvrKb5dZ4Y4zmOcU+VsxxOWDWeYe7v2Rult4URMM7fWO5z24yyIUBU3M6MIx
         oWMA==
Received: by 10.180.80.9 with SMTP id n9mr7574511wix.4.1332944039384;
        Wed, 28 Mar 2012 07:13:59 -0700 (PDT)
Received: from [192.168.1.13] (adhb238.neoplus.adsl.tpnet.pl. [79.184.157.238])
        by mx.google.com with ESMTPS id fl2sm13898290wib.4.2012.03.28.07.13.58
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 28 Mar 2012 07:13:58 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20120328135146.GA3525@odin.tremily.us>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194123>

On Wed, 28 Mar 2012, W. Trevor King wrote:
> On Tue, Mar 27, 2012 at 11:24:20PM +0100, Jakub Narebski wrote:
> > On Mon, 26 Mar 2012, W. Trevor King wrote:
> > > +# --------------------------------------------------------------=
--------
> > > +# modification times (Last-Modified and If-Modified-Since)
> > > +
> > > +test_expect_success 'modification: feed last-modified' '
> > > +	gitweb_run "p=3D.git;a=3Datom;h=3Dmaster" &&
> > > +	grep "Status: 200 OK" gitweb.output &&
> > > +	grep "Last-modified: Thu, 7 Apr 2005 22:14:13 +0000" gitweb.out=
put
> > > +'
> >=20
> > All right.
> >=20
> > What's that date from?  Wouldn't it be better to read it from commi=
t
> > object with `git show -s --pretty=3D%cD HEAD` or postprocessed from
> > '%ct' timestamp?
>=20
> That's the date set by the first `test_tick`, which is hardcoded in
> `test-lib-functions.sh`.  Extracting the date dynamically seems
> unnecessary, since I can't imagine anyone changing the `test_tick`
> date. =20

Ah, it's all right then.  I should have checked the test_tick function.

That of course assuming that nobody would add test_tick earlier, but
if he/she does, he/she can deal with fallout...

> It's easy enough to do if you think it is appropriate though=E2=80=A6=
=20

No, it is not needed.

> > > +test_debug 'cat gitweb.headers'
> > > +
> > > +test_expect_success 'modification: feed if-modified-since (modif=
ied)' '
> > > +	export HTTP_IF_MODIFIED_SINCE=3D"Wed, 6 Apr 2005 22:14:13 +0000=
" &&
> > > +	gitweb_run "p=3D.git;a=3Datom;h=3Dmaster" &&
> > > +	unset HTTP_IF_MODIFIED_SINCE &&
> > > +	grep "Status: 200 OK" gitweb.output
> > > +'
> >=20
> > I think it *might* be better solution to use test_when_finished:
> >=20
> >   +test_expect_success 'modification: feed if-modified-since (modif=
ied)' '
> >   +	export HTTP_IF_MODIFIED_SINCE=3D"Wed, 6 Apr 2005 22:14:13 +0000=
" &&
> >   +	test_when_finished "unset HTTP_IF_MODIFIED_SINCE" &&
> >   +	gitweb_run "p=3D.git;a=3Datom;h=3Dmaster" &&
> >   +	grep "Status: 200 OK" gitweb.output
> >   +'
> >=20
> > I don't think we need sane_unset here.
>=20
> Good point.  Sloppy me not reading `t/README` thoroughly enough ;).

--=20
Jakub Narebski
Poland
