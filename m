From: Carlos =?ISO-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
Subject: Re: [PATCH 2/3] setup_path(): Free temporary buffer
Date: Mon, 14 Mar 2011 23:18:49 +0100
Message-ID: <1300141129.4320.48.camel@bee.lab.cmartin.tk>
References: <1300130318-11279-1-git-send-email-cmn@elego.de>
	 <1300130318-11279-3-git-send-email-cmn@elego.de>
	 <20110314200958.GC22602@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Mar 14 23:19:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PzG6Q-0006pH-2k
	for gcvg-git-2@lo.gmane.org; Mon, 14 Mar 2011 23:19:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757384Ab1CNWS4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Mar 2011 18:18:56 -0400
Received: from mx0.elegosoft.com ([88.198.54.133]:34207 "EHLO
	mx0.elegosoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757361Ab1CNWS4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Mar 2011 18:18:56 -0400
Received: from localhost (localhost [127.0.0.1])
	by mx0.elegosoft.com (Postfix) with ESMTP id 70ADF1B4B52;
	Mon, 14 Mar 2011 23:18:55 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at mx0.elegosoft.com
Received: from mx0.elegosoft.com ([127.0.0.1])
	by localhost (mx0.elegosoft.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id w7OHlzVWqCTz; Mon, 14 Mar 2011 23:18:50 +0100 (CET)
Received: from [192.168.1.16] (brln-4dbc728c.pool.mediaWays.net [77.188.114.140])
	by mx0.elegosoft.com (Postfix) with ESMTPSA id B59A51B4B8D;
	Mon, 14 Mar 2011 23:18:49 +0100 (CET)
In-Reply-To: <20110314200958.GC22602@sigill.intra.peff.net>
X-Mailer: Evolution 2.91.92 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169030>

On lun, 2011-03-14 at 16:09 -0400, Jeff King wrote:
> On Mon, Mar 14, 2011 at 08:18:37PM +0100, Carlos Mart=C3=ADn Nieto wr=
ote:
>=20
> > Make sure the pointer git_exec_path() returns is in the heap and fr=
ee
> > it after it's no longer needed.
>=20
> Could you explain the motivation a bit more? From looking at the code=
,
> it looks like the situation is that git_exec_path sometimes returns a
> newly allocated string and sometimes not, so the caller may leak in t=
he
> former case.

 I mostly wanted valgrind to shut up, but it seems there are a lot of
small leaks we don't really care about.

>=20
> That seems to be the fault of system_path, which sometimes allocates =
and
> sometimes does not. Should we also be fixing system_path, which is a
> source of leaks? Or instead converting system_path to use a static
> buffer?

 Converting system_path() to use a static buffer would also work, and
would probably be an easier solution. I'll look at that tomorrow and
resend.

>=20
> > @@ -99,10 +99,13 @@ void setup_path(void)
> >  {
> >  	const char *old_path =3D getenv("PATH");
> >  	struct strbuf new_path =3D STRBUF_INIT;
> > +	char *exec_path =3D (char *) git_exec_path();
>=20
> Ick. If it is now returning an allocated buffer that the caller is
> responsible for free-ing, then its declaration should drop the const =
in
> the return value.

 Yeah... I meant to delete that. It seems I've completely botched this
patch.

>=20
> What about other callers of git_exec_path? Aren't load_command_list a=
nd
> list_commands leaking, too (and possibly worse, since we now always
> allocated memory)?

 Test-suite-induced tunnel vision. I only tested what reported a failur=
e
(under valgrind) without the patch.

   cmn
