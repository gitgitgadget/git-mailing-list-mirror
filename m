From: Karl Wiberg <kha@treskal.com>
Subject: Re: [PATCH 5/6] stg mail: add basic support for git send-email
Date: Sun, 29 Nov 2009 22:54:25 +0100
Message-ID: <b8197bcb0911291354m674d3698m929a1d542a59ed9f@mail.gmail.com>
References: <20091128194056.949.88791.stgit@bob.kio>
	 <20091128195037.949.63611.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: catalin.marinas@gmail.com, git@vger.kernel.org
To: Alex Chiang <achiang@hp.com>
X-From: git-owner@vger.kernel.org Sun Nov 29 22:54:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NEriz-0007I3-JI
	for gcvg-git-2@lo.gmane.org; Sun, 29 Nov 2009 22:54:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753258AbZK2VyW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 29 Nov 2009 16:54:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752941AbZK2VyV
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Nov 2009 16:54:21 -0500
Received: from mail1.space2u.com ([62.20.1.135]:58750 "EHLO mail1.space2u.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752180AbZK2VyV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 Nov 2009 16:54:21 -0500
Received: from mail-bw0-f227.google.com (mail-bw0-f227.google.com [209.85.218.227])
	(authenticated bits=0)
	by mail1.space2u.com (8.14.3/8.14.3) with ESMTP id nATLs7l1018711
	(version=TLSv1/SSLv3 cipher=DES-CBC3-SHA bits=168 verify=NOT)
	for <git@vger.kernel.org>; Sun, 29 Nov 2009 22:54:07 +0100
Received: by bwz27 with SMTP id 27so2120350bwz.21
        for <git@vger.kernel.org>; Sun, 29 Nov 2009 13:54:25 -0800 (PST)
Received: by 10.204.48.131 with SMTP id r3mr3620704bkf.195.1259531665814; Sun, 
	29 Nov 2009 13:54:25 -0800 (PST)
In-Reply-To: <20091128195037.949.63611.stgit@bob.kio>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134039>

On Sat, Nov 28, 2009 at 8:50 PM, Alex Chiang <achiang@hp.com> wrote:

> + =C2=A0 =C2=A0# XXX: yuck, there's gotta be a more pythonic way. Ide=
ally we'd like
> + =C2=A0 =C2=A0# to use the git_opts dictionary as our mapping betwee=
n stg mail and
> + =C2=A0 =C2=A0# git send-email; extract k, v pairs from git_opts, an=
d use those
> + =C2=A0 =C2=A0# to iterate across options somehow.
> + =C2=A0 =C2=A0git_opts =3D { 'to': '--to=3D', 'cc': '--cc=3D', 'bcc'=
: '--bcc=3D' }
> + =C2=A0 =C2=A0if options.to:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0for a in options.to:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cmd.append("--to=3D%s" % a=
)
> + =C2=A0 =C2=A0if options.cc:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0for a in options.cc:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cmd.append("--cc=3D%s" % a=
)
> + =C2=A0 =C2=A0if options.bcc:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0for a in options.bcc:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cmd.append("--bcc=3D%s" % =
a)
> + =C2=A0 =C2=A0if not options.auto:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0cmd.append("--suppress-cc=3Dbody")

Like this?

for x in ['to', 'cc', 'bcc']:
    if getattr(options, x):
        cmd.extend('--%s=3D%s' % (x, a) for a in getattr(options, x))

> + =C2=A0 =C2=A0(fd, path) =3D mkstemp()
> + =C2=A0 =C2=A0os.write(fd, msg.as_string(options.mbox))
> + =C2=A0 =C2=A0os.close(fd)
> +
> + =C2=A0 =C2=A0try:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0cmd.append(path)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0call(cmd)
> + =C2=A0 =C2=A0except Exception, err:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0os.unlink(path)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0raise CmdException, str(err)
> +
> + =C2=A0 =C2=A0os.unlink(path)

To avoid having to remember to call unlink in all paths, you can write

try:
    try:
        cmd.append(path)
        call(cmd)
    except Exception, e:
        raise CmdException(str(e))
finally:
    os.unlink(path)

(The combined try...except...finally statement didn't appear until
python 2.5, but we'd like to stay compatible with 2.4.)

--=20
Karl Wiberg, kha@treskal.com
   subrabbit.wordpress.com
   www.treskal.com/kalle
