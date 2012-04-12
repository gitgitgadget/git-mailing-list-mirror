From: Tim Henigan <tim.henigan@gmail.com>
Subject: Re: [PATCH 8/9 v12] difftool: teach difftool to handle directory diffs
Date: Thu, 12 Apr 2012 15:10:45 -0400
Message-ID: <CAFouetg6Ot8sKiNi45A0QRv6YYdL3Mwrb3tkVkajQQuZukSp3g@mail.gmail.com>
References: <1334236726-18393-1-git-send-email-tim.henigan@gmail.com>
	<7viph46c1t.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, davvid@gmail.com, ramsay@ramsay1.demon.co.uk
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 12 21:10:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SIPPv-00063p-B5
	for gcvg-git-2@plane.gmane.org; Thu, 12 Apr 2012 21:10:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761193Ab2DLTKq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Apr 2012 15:10:46 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:60197 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754456Ab2DLTKq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Apr 2012 15:10:46 -0400
Received: by iagz16 with SMTP id z16so3170990iag.19
        for <git@vger.kernel.org>; Thu, 12 Apr 2012 12:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=Mf1vW6X8CFZh4SUg8vNnfwko9ArqUStNTtIgfRRO6K4=;
        b=wWgoGagOOYHks3NDQkg89ARC92cwHqCOpi/mDZ9ef7L+z2SDfq2GLratmqTV/nxXXu
         OnNy0/I6VqNjKDTNAURn8M+D8YtvfuRdsyZ6wHjDFnapjNOV7jmNSMM3v36wgTRFlZkf
         MyIEcEEKuGvxIaXoGPEDwiiOkeVHFT4cJ2mUrZkHABHbljzg26q6v0ou7R1XAVvFiXfq
         3YrHrwcFfIaoMDdis3AX6MF0gi3gTbZ00H+kdFcTwLmHssPpNLtLMYzN2Xy3n7Jdq/9w
         jz81xBdGFQwMb2oFU06ATvwQWRAI6FFIF1vpKNjVTY9ZHqQ2fXXwNRvYRJ7qrXU78LTU
         FcBg==
Received: by 10.42.97.194 with SMTP id p2mr3086354icn.36.1334257845661; Thu,
 12 Apr 2012 12:10:45 -0700 (PDT)
Received: by 10.42.225.193 with HTTP; Thu, 12 Apr 2012 12:10:45 -0700 (PDT)
In-Reply-To: <7viph46c1t.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195355>

On Thu, Apr 12, 2012 at 2:27 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Tim Henigan <tim.henigan@gmail.com> writes:
>
>> +sub setup_dir_diff
>> +{
>> + =C2=A0 =C2=A0 # Run the diff; exit immediately if no diff found
>> + =C2=A0 =C2=A0 my $cmd =3D "git diff --raw --no-abbrev -z " . join(=
" ", @ARGV);
>> + =C2=A0 =C2=A0 my $diffrtn =3D `$cmd` or die $!;
>
> Why this change? =C2=A0It looks like a rather unpleasant regression c=
ompared to
> the previous one that used "command_oneline", so that each element of
> @ARGV was given as a single argument to the command. =C2=A0Now, you a=
re
> splitting any argument that has $IFS in it.

The 'Git->repository->command*' functions all override the
$GIT_WORK_TREE set by the user on the command line with 'pwd'.  They
also override the 'core.worktree' setting, if it is used.

So without this change, the following fails:

  $ GIT_DIR=3D<dir> GIT_WORK_TREE=3D<dir> git difftool -d

Would the following change be better?

- =C2=A0 =C2=A0 my $cmd =3D "git diff --raw --no-abbrev -z " . join(" "=
, @ARGV);
+ =C2=A0 =C2=A0 my $cmd =3D "git diff --raw --no-abbrev -z @ARGV";
