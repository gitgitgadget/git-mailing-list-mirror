From: Alex Chiang <achiang@hp.com>
Subject: Re: [PATCH 3/6] stg mail: make __send_message do more
Date: Mon, 30 Nov 2009 16:59:35 -0700
Message-ID: <20091130235935.GK12733@ldl.fc.hp.com>
References: <20091128194056.949.88791.stgit@bob.kio> <20091128195026.949.1772.stgit@bob.kio> <b8197bcb0911291323l35cb3624td3cbc393bf4513b3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: catalin.marinas@gmail.com, git@vger.kernel.org
To: Karl Wiberg <kha@treskal.com>
X-From: git-owner@vger.kernel.org Tue Dec 01 00:59:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFG9e-0005Ko-6Y
	for gcvg-git-2@lo.gmane.org; Tue, 01 Dec 2009 00:59:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754024AbZK3X7a convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Nov 2009 18:59:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753933AbZK3X7a
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Nov 2009 18:59:30 -0500
Received: from g4t0015.houston.hp.com ([15.201.24.18]:31167 "EHLO
	g4t0015.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753307AbZK3X73 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Nov 2009 18:59:29 -0500
Received: from g5t0029.atlanta.hp.com (g5t0029.atlanta.hp.com [16.228.8.141])
	by g4t0015.houston.hp.com (Postfix) with ESMTP id 2755081F6;
	Mon, 30 Nov 2009 23:59:36 +0000 (UTC)
Received: from ldl (linux.corp.hp.com [15.11.146.101])
	by g5t0029.atlanta.hp.com (Postfix) with ESMTP id B1DCD20009;
	Mon, 30 Nov 2009 23:59:35 +0000 (UTC)
Received: from localhost (ldl.fc.hp.com [127.0.0.1])
	by ldl (Postfix) with ESMTP id 858B9CF000D;
	Mon, 30 Nov 2009 16:59:35 -0700 (MST)
Received: from ldl ([127.0.0.1])
	by localhost (ldl.fc.hp.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ueJkVNbDzHj9; Mon, 30 Nov 2009 16:59:35 -0700 (MST)
Received: by ldl (Postfix, from userid 17609)
	id 6F9F4CF0007; Mon, 30 Nov 2009 16:59:35 -0700 (MST)
Content-Disposition: inline
In-Reply-To: <b8197bcb0911291323l35cb3624td3cbc393bf4513b3@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134150>

* Karl Wiberg <kha@treskal.com>:
> On Sat, Nov 28, 2009 at 8:50 PM, Alex Chiang <achiang@hp.com> wrote:
>=20
> > Factor out the common code required to send either a cover mail
> > or patch, and implement it in __send_message.
>=20
> Nice code size reduction.

Thanks.

> > + =A0 =A0msg_id =3D email.Utils.make_msgid('stgit')
> > + =A0 =A0build =3D { 1: __build_cover, 4: __build_message }
> > + =A0 =A0msg =3D build[len(args)](tmpl, msg_id, options, *args)
> > +
> > + =A0 =A0from_addr, to_addrs =3D __parse_addresses(msg)
> > + =A0 =A0msg_str =3D msg.as_string(options.mbox)
> > + =A0 =A0if options.mbox:
> > + =A0 =A0 =A0 =A0out.stdout_raw(msg_str + '\n')
> > + =A0 =A0 =A0 =A0return msg_id
> > +
> > + =A0 =A0outstr =3D { 1: 'the cover message', 4: 'patch "%s"' % arg=
s[0] }
> > + =A0 =A0out.start('Sending ' + outstr[len(args)])
>=20
> You could consolidate the two dictionaries like this, to avoid making
> the same choice twice and make the code more pleasant to read:
>=20
>   (build, outstr) =3D { 1: (__build_cover, 'the cover message'), 4:
> (__build_message, 'patch "%s"' % args[0]) }

Hm, I don't think that's valid. I ended up doing something like
this:

    d =3D { 'cover': (__build_cover, 'the cover message'),
          'patch': (__build_message, 'patch "%s"' % args[0]) }
   =20
    (build, outstr) =3D d[type]

> > + =A0 =A0# give recipients a chance of receiving related patches in=
 correct order
> > + =A0 =A0# =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 patch_nr < total_nr
> > + =A0 =A0if len(args) =3D=3D 1 or (len(args) =3D=3D 4 and args[1] <=
 args[2]):
> > + =A0 =A0 =A0 =A0sleep =3D options.sleep or config.getint('stgit.sm=
tpdelay')
> > + =A0 =A0 =A0 =A0time.sleep(sleep)
>=20
> Hmm. I must say I find all the args[x] a bit hard to read. I'd prefer
> symbolic names.

Ok, I changed this up.

Thanks for the review.
/ac
