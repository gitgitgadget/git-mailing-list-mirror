From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 5/7] completion: fix expansion issues in __gitcomp_nl()
Date: Sun, 18 Nov 2012 01:58:27 +0100
Message-ID: <CAMP44s1cskzf4TorLOVWCFtauMsujsQzWAZ5ZbtCuDMs=n=G9g@mail.gmail.com>
References: <1353150353-29874-1-git-send-email-szeder@ira.uka.de>
	<1353150353-29874-6-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Sun Nov 18 01:58:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TZtDe-00067g-2a
	for gcvg-git-2@plane.gmane.org; Sun, 18 Nov 2012 01:58:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752521Ab2KRA62 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 17 Nov 2012 19:58:28 -0500
Received: from mail-ob0-f174.google.com ([209.85.214.174]:50958 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752455Ab2KRA61 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 17 Nov 2012 19:58:27 -0500
Received: by mail-ob0-f174.google.com with SMTP id wc20so3905791obb.19
        for <git@vger.kernel.org>; Sat, 17 Nov 2012 16:58:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=KQCTkpnnotaO8eZEYZYDCJY8r10vuj10Fi86nlSrDNA=;
        b=F9JxENA11iAwe8CI9bT2dajJlHaWCtMOjYD11n10Jwu5sstA4eZ46JJo7KomjIUTTT
         y3VQd4LQQKFMaekRQoA1h5kl4OhU6Ey6yIU0uf4hwlXZ1D9ja1XtzcHIk28tN2FS1zRB
         3gQCuHfugmtsZrZktxLneNghuLdlif+NrMsRZ4kn5+x/0f2WD7yIQHSKxbmNs3BpOu6t
         LoVEX1ldc/o9DSLiqr0QqabVayklUU7DfD21wubgn7HqL9f94zHAidOD2Xb4SwL3in0p
         SzNwr/N0sUtKwxOMKTTQSubaYj7/zZc5W9rS38vT79qDZGSfb5qsqpiLEhA/zyP0AwBf
         bBTw==
Received: by 10.182.194.70 with SMTP id hu6mr7440892obc.4.1353200307169; Sat,
 17 Nov 2012 16:58:27 -0800 (PST)
Received: by 10.60.4.74 with HTTP; Sat, 17 Nov 2012 16:58:27 -0800 (PST)
In-Reply-To: <1353150353-29874-6-git-send-email-szeder@ira.uka.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209989>

On Sat, Nov 17, 2012 at 12:05 PM, SZEDER G=C3=A1bor <szeder@ira.uka.de>=
 wrote:

>  __gitcomp_nl ()
>  {
>         local IFS=3D$'\n'
> -       COMPREPLY=3D($(compgen -P "${2-}" -S "${4- }" -W "$1" -- "${3=
-$cur}"))
> +       COMPREPLY=3D($(awk -v pfx=3D"${2-}" -v sfx=3D"${4- }" -v cur=3D=
"${3-$cur}" '
> +               BEGIN {
> +                       FS=3D"\n";
> +                       len=3Dlength(cur);
> +               }
> +               {
> +                       if (cur =3D=3D substr($1, 1, len))
> +                               print pfx$1sfx;
> +               }' <<< "$1" ))
>  }

This version is simpler and faster:

	local IFS=3D$'\n'
	COMPREPLY=3D($(awk -v cur=3D"${3-$cur}" -v pre=3D"${2-}" -v suf=3D"${4=
- }"
'$0 ~ cur { print pre$0suf }' <<< "$1" ))

=3D=3D 10000 =3D=3D
awk 1:
real	0m0.067s
user	0m0.066s
sys	0m0.001s
awk 2:
real	0m0.057s
user	0m0.055s
sys	0m0.002s

--=20
=46elipe Contreras
