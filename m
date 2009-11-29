From: Karl Wiberg <kha@treskal.com>
Subject: Re: [PATCH 3/6] stg mail: make __send_message do more
Date: Sun, 29 Nov 2009 22:23:00 +0100
Message-ID: <b8197bcb0911291323l35cb3624td3cbc393bf4513b3@mail.gmail.com>
References: <20091128194056.949.88791.stgit@bob.kio>
	 <20091128195026.949.1772.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: catalin.marinas@gmail.com, git@vger.kernel.org
To: Alex Chiang <achiang@hp.com>
X-From: git-owner@vger.kernel.org Sun Nov 29 22:23:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NErEk-00054H-1r
	for gcvg-git-2@lo.gmane.org; Sun, 29 Nov 2009 22:23:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752505AbZK2VW5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 29 Nov 2009 16:22:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752381AbZK2VW4
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Nov 2009 16:22:56 -0500
Received: from mail1.space2u.com ([62.20.1.135]:56985 "EHLO mail1.space2u.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752306AbZK2VW4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 Nov 2009 16:22:56 -0500
Received: from mail-bw0-f227.google.com (mail-bw0-f227.google.com [209.85.218.227])
	(authenticated bits=0)
	by mail1.space2u.com (8.14.3/8.14.3) with ESMTP id nATLMgGI017941
	(version=TLSv1/SSLv3 cipher=DES-CBC3-SHA bits=168 verify=NOT)
	for <git@vger.kernel.org>; Sun, 29 Nov 2009 22:22:42 +0100
Received: by bwz27 with SMTP id 27so2108999bwz.21
        for <git@vger.kernel.org>; Sun, 29 Nov 2009 13:23:00 -0800 (PST)
Received: by 10.204.26.147 with SMTP id e19mr3556877bkc.149.1259529780959; 
	Sun, 29 Nov 2009 13:23:00 -0800 (PST)
In-Reply-To: <20091128195026.949.1772.stgit@bob.kio>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134038>

On Sat, Nov 28, 2009 at 8:50 PM, Alex Chiang <achiang@hp.com> wrote:

> Factor out the common code required to send either a cover mail
> or patch, and implement it in __send_message.

Nice code size reduction.

> + =C2=A0 =C2=A0msg_id =3D email.Utils.make_msgid('stgit')
> + =C2=A0 =C2=A0build =3D { 1: __build_cover, 4: __build_message }
> + =C2=A0 =C2=A0msg =3D build[len(args)](tmpl, msg_id, options, *args)
> +
> + =C2=A0 =C2=A0from_addr, to_addrs =3D __parse_addresses(msg)
> + =C2=A0 =C2=A0msg_str =3D msg.as_string(options.mbox)
> + =C2=A0 =C2=A0if options.mbox:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0out.stdout_raw(msg_str + '\n')
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0return msg_id
> +
> + =C2=A0 =C2=A0outstr =3D { 1: 'the cover message', 4: 'patch "%s"' %=
 args[0] }
> + =C2=A0 =C2=A0out.start('Sending ' + outstr[len(args)])

You could consolidate the two dictionaries like this, to avoid making
the same choice twice and make the code more pleasant to read:

  (build, outstr) =3D { 1: (__build_cover, 'the cover message'), 4:
(__build_message, 'patch "%s"' % args[0]) }

> + =C2=A0 =C2=A0# give recipients a chance of receiving related patche=
s in correct order
> + =C2=A0 =C2=A0# =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 patch_nr < total_nr
> + =C2=A0 =C2=A0if len(args) =3D=3D 1 or (len(args) =3D=3D 4 and args[=
1] < args[2]):
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0sleep =3D options.sleep or config.getint=
('stgit.smtpdelay')
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0time.sleep(sleep)

Hmm. I must say I find all the args[x] a bit hard to read. I'd prefer
symbolic names.

--=20
Karl Wiberg, kha@treskal.com
   subrabbit.wordpress.com
   www.treskal.com/kalle
