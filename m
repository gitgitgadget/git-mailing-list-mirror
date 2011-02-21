From: Tor Arvid Lund <torarvid@gmail.com>
Subject: Re: [PATCH v2 1/2] git-p4: Improve rename detection support
Date: Mon, 21 Feb 2011 10:40:32 +0100
Message-ID: <AANLkTi=NOOaf+peRgCA3X4AY7oRL-8Md=91KNa=a_fJV@mail.gmail.com>
References: <1298164705-5366-1-git-send-email-vitor.hda@gmail.com>
	<1298164705-5366-2-git-send-email-vitor.hda@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Pete Wyckoff <pw@padd.com>,
	git@vger.kernel.org
To: Vitor Antunes <vitor.hda@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 21 10:40:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PrSFy-000147-FP
	for gcvg-git-2@lo.gmane.org; Mon, 21 Feb 2011 10:40:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754124Ab1BUJkd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 21 Feb 2011 04:40:33 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:49076 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753889Ab1BUJkd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Feb 2011 04:40:33 -0500
Received: by yxs7 with SMTP id 7so228493yxs.19
        for <git@vger.kernel.org>; Mon, 21 Feb 2011 01:40:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=e+F3PLFbVuuR1L/1CBo96FTqAahxjUBcKn1aKsrjWGY=;
        b=YGSfVEW+Og7zhQtq8r4ushr42SU0wNAtwQFeJGxG/8Hc5LGVj2DbnBgQcRJs1rG/GR
         olyaQwgrbCJnhuQkFmh5udX5HOTuVzCv7xlVjv3Zmkv37DGgfnk6Fk0PeTMYZC4zTfJu
         0m/xcCd6PMil59Jw4bXRVaC07p8ZaDUTtoKsg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=mfoF/dyN96IVuOgT9BKy58oq2tUNl4fY9rHmapVSaqS6694U538T5bOYGBvWAoOWr1
         OPWvwyAaUvvF3k74e9f2EmObmAIoI60ZJYsdiUznHODFZBLnT2VBE9tRFzEqPziww5sH
         jGJUD0SHZUxJK7CcUyQZUJuecMbo7LMH99FsU=
Received: by 10.90.166.18 with SMTP id o18mr1516187age.95.1298281232488; Mon,
 21 Feb 2011 01:40:32 -0800 (PST)
Received: by 10.90.54.1 with HTTP; Mon, 21 Feb 2011 01:40:32 -0800 (PST)
In-Reply-To: <1298164705-5366-2-git-send-email-vitor.hda@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167452>

On Sun, Feb 20, 2011 at 2:18 AM, Vitor Antunes <vitor.hda@gmail.com> wr=
ote:
> Only open files for edit after integrating if the SHA1 of source and =
destination
> differ from each other.
> Add git config option detectRenames to allow permanent rename detecti=
on. This
> options should be set to a true/false value.
> Rename "detectRename" variable to "detectRenames" to make it more coh=
erent with
> the description in git man pages, which always use plural.
>
> Signed-off-by: Vitor Antunes <vitor.hda@gmail.com>
> Acked-by: Pete Wyckoff <pw@padd.com>

Acked-by: Tor Arvid Lund <torarvid@gmail.com>

> ---
> =C2=A0contrib/fast-import/git-p4 | =C2=A0 19 +++++++++++++++----
> =C2=A01 files changed, 15 insertions(+), 4 deletions(-)
>
> diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
> index a92beb6..b0da28a 100755
> --- a/contrib/fast-import/git-p4
> +++ b/contrib/fast-import/git-p4
> @@ -543,13 +543,13 @@ class P4Submit(Command):
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.options =3D [
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 optparse.make=
_option("--verbose", dest=3D"verbose", action=3D"store_true"),
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 optparse.make=
_option("--origin", dest=3D"origin"),
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0optparse.mak=
e_option("-M", dest=3D"detectRename", action=3D"store_true"),
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0optparse.mak=
e_option("-M", dest=3D"detectRenames", action=3D"store_true"),
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 ]
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.description =3D "Submit changes from=
 git to the perforce depot."
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.usage +=3D " [name of git branch to =
submit into perforce depot]"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.interactive =3D True
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.origin =3D ""
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0self.detectRename =3D False
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0self.detectRenames =3D False
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.verbose =3D False
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.isWindows =3D (platform.system() =3D=
=3D "Windows")
>
> @@ -613,7 +613,16 @@ class P4Submit(Command):
>
> =C2=A0 =C2=A0 def applyCommit(self, id):
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 print "Applying %s" % (read_pipe("git log=
 --max-count=3D1 --pretty=3Doneline %s" % id))
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0diffOpts =3D ("", "-M")[self.detectRenam=
e]
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0if not self.detectRenames:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# If not explicitly set ch=
eck the config variable
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.detectRenames =3D git=
Config("git-p4.detectRenames").lower() =3D=3D "true"
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0if self.detectRenames:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0diffOpts =3D "-M"
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0else:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0diffOpts =3D ""
> +
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 diff =3D read_pipe_lines("git diff-tree -=
r %s \"%s^\" \"%s\"" % (diffOpts, id, id))
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 filesToAdd =3D set()
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 filesToDelete =3D set()
> @@ -640,8 +649,10 @@ class P4Submit(Command):
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 elif modifier =3D=3D "R":
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 src, dest =3D=
 diff['src'], diff['dst']
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 p4_system("in=
tegrate -Dt \"%s\" \"%s\"" % (src, dest))
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0p4_system("e=
dit \"%s\"" % (dest))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if diff['src=
_sha1'] !=3D diff['dst_sha1']:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
p4_system("edit \"%s\"" % (dest))
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if isModeExec=
Changed(diff['src_mode'], diff['dst_mode']):
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
p4_system("edit \"%s\"" % (dest))
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 filesToChangeExecBit[dest] =3D diff['dst_mode']
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 os.unlink(des=
t)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 editedFiles.a=
dd(dest)
> --
> 1.7.4.1
>
>
