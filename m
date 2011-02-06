From: Vitor Antunes <vitor.hda@gmail.com> (by way of Vitor Antunes
	<vitor.hda@gmail.com>)
Subject: Re: [PATCH 1/2] git-p4: Improve rename detection support.
Date: Sun, 6 Feb 2011 12:39:25 +0000
Message-ID: <AANLkTikd+rGpfy9x35SA0g4F8uYpjp_+GK4m9pagu8Nn@mail.gmail.com>
References: <1296429563-18390-1-git-send-email-vitor.hda@gmail.com>
 <20110206002113.GA31245@arf.padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Sun Feb 06 18:32:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pm8Tb-00034e-Fj
	for gcvg-git-2@lo.gmane.org; Sun, 06 Feb 2011 18:32:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753378Ab1BFRci convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 6 Feb 2011 12:32:38 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:59923 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752744Ab1BFRch convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 Feb 2011 12:32:37 -0500
Received: by wyb28 with SMTP id 28so3854878wyb.19
        for <git@vger.kernel.org>; Sun, 06 Feb 2011 09:32:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:from:to:content-type:content-transfer-encoding
         :resent-date:resent-from:subject:resent-message-id:resent-to
         :resent-cc;
        bh=oa8WtV9YhzeO1VVurweRa6Iyrn6t0kzYa+K3Kz6rHvs=;
        b=XB5wQNtdvrYpioOLOA2By9Lay1ERGuhU2OzfXoHN97UG8vI8vz+65aoiCod3yIt1Ze
         Xs1Csx8hZ70mxQ0UE8zxY36iMaGw+dRwFFPyNwMHfCottIq39/SAe4HqnB+BK2sI1WSU
         YsarARtrhUwp5nUG+U7GRThBapHFi5i4sk5Go=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:from:to
         :content-type:content-transfer-encoding:resent-date:resent-from
         :subject:resent-message-id:resent-to:resent-cc;
        b=rvlgGp73MpVFHumHH8H4Ki8uyxVU4wOWzPoWgNlwEifEC4i+zJoL5sy/daBX0tlJAD
         84p8i2T0b+1BPVPTpUA6g+iPvbqBbOx/N7JIHYyUCCa0fh4HVJ73xdgCr4UhdVtV2g4p
         qEkVNA9e0xCeb9aLYbIWZ3B9e60kRhQ6Lbm9U=
Received: by 10.216.162.84 with SMTP id x62mr12485687wek.106.1297013556096;
        Sun, 06 Feb 2011 09:32:36 -0800 (PST)
Received: from fenix.utopia.dhis.org (111.216.54.77.rev.vodafone.pt [77.54.216.111])
        by mx.google.com with ESMTPS id t5sm1673647wes.33.2011.02.06.09.32.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 06 Feb 2011 09:32:35 -0800 (PST)
In-Reply-To: <20110206002113.GA31245@arf.padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166158>

Hi Pete,

On Sun, Feb 6, 2011 at 12:21 AM, Pete Wyckoff <pw@padd.com> wrote:
> The comparisons confuse me. =A0detectRenames !=3D "false" > 0 =A0?
> How about just detectRenames =3D=3D "true"?

The "> 0" was for the length check. I somehow (*feeling embarrassed*)
misplaced that code...

> You could rename the existing self.detectRename to add an "s" so
> it all makes a bit more sense.
>
> =A0 =A0if not self.detectRenames:
> =A0 =A0 =A0 =A0# not explicitly set, check the config variable
> =A0 =A0 =A0 =A0b =3D gitConfig("git-p4.detectRenames")
> =A0 =A0 =A0 =A0if b =3D=3D "true":
> =A0 =A0 =A0 =A0 =A0 =A0self.detectRenames =3D "-M"
>
> =A0 =A0if self.detectRenames:
> =A0 =A0 =A0 =A0diffOpts =3D "-M"
> =A0 =A0else:
> =A0 =A0 =A0 =A0diffOpts =3D ""

Seems like a better idea. I kind of like the original code to set
diffOpts, so I would prefer to keep it. What do you think of (didn't
test it):

        if not self.detectRenames:
            # If not explicitly set check the config variable
            self.detectRenames =3D
gitConfig("git-p4.detectRenames").lower() =3D=3D "true"

        diffOpts =3D ("", "-M")[self.detectRenames]

>> =A0 =A0 =A0 =A0 =A0diff =3D read_pipe_lines("git diff-tree -r %s \"%=
s^\" \"%s\"" % (diffOpts, id, id))
>> =A0 =A0 =A0 =A0 =A0filesToAdd =3D set()
>> =A0 =A0 =A0 =A0 =A0filesToDelete =3D set()
>> @@ -640,7 +646,8 @@ class P4Submit(Command):
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0elif modifier =3D=3D "R":
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0src, dest =3D diff['src'], diff['=
dst']
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0p4_system("integrate -Dt \"%s\" \=
"%s\"" % (src, dest))
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0p4_system("edit \"%s\"" % (dest))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if diff['src_sha1'] !=3D diff['dst_=
sha1']:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0p4_system("edit \"%s\"" % (=
dest))
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if isModeExecChanged(diff['src_mo=
de'], diff['dst_mode']):
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0filesToChangeExecBit[dest=
] =3D diff['dst_mode']
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0os.unlink(dest)
>
> If you rename the file and also cause its perms to change (say
> add +x), does it still work if dest is not open?

This is a very good point. I will also open the file for edit when
there is a mode change.

Thanks!

--=20
Vitor Antunes
