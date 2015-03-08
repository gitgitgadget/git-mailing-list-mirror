From: Dongcan Jiang <dongcan.jiang@gmail.com>
Subject: Re: [GSoC/RFC] Ideas on git fetch --deepen
Date: Sun, 8 Mar 2015 18:14:43 +0800
Message-ID: <CABwkPcoQRSFySYy+DvQ4TJJEDmMi+FPHhRumBgxdTVDdwvjAjg@mail.gmail.com>
References: <CABwkPcoHPyid0gKjjg0NiXY4TYtCbeSJe6XK5HEDFNKR+-_tFQ@mail.gmail.com>
 <CABwkPcoWUcK2vzqUBcEcuNzizYMtP=qUiew2HmDgqtivfDXbDg@mail.gmail.com> <CACsJy8B5HwwZei+ao6Z4dt1eG27Mj4z2_QDKzVPTLphm6JrVWA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 08 11:15:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YUYEq-0004Os-5u
	for gcvg-git-2@plane.gmane.org; Sun, 08 Mar 2015 11:15:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752095AbbCHKPH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Mar 2015 06:15:07 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:39920 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752091AbbCHKPE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 Mar 2015 06:15:04 -0400
Received: by pabrd3 with SMTP id rd3so31138449pab.6
        for <git@vger.kernel.org>; Sun, 08 Mar 2015 03:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=tvkRaHXKoF3HWb1PtVZI983KhfBN97cZgDtDT+RYK/k=;
        b=dqEpvBkhEUcb6bpnbEWWhahyxcwBhMl7v6ljFuIy0a4y23BU3yhJ9gGGc58sHlTqcd
         1TyPZRUoMEllpNQc9kMlB94UBgJEFAYMJzFXr9CvZs0kwSoCyJCRfmmww2djuK996oZ/
         /QrnKJeqdBxPj7F7mQLNZfZvyMWOxepQ5VFZitGEf5aSJYQnF3kwG/18IqJc6n/CC6ly
         jToBbIReecXHqOYuApXhSuWHMUlf/u03Dl1d6v0JEGHDYUi3m/62otLGN2X2592ag1Ur
         NYJB1G8gXgjQ+UE+mA/PYXiK8sBFcIoFQn1wxN1kp8l1UycuP92JfYsuC7yphpwY8Fw/
         C0aw==
X-Received: by 10.70.124.166 with SMTP id mj6mr30233780pdb.97.1425809703710;
 Sun, 08 Mar 2015 03:15:03 -0700 (PDT)
Received: by 10.70.78.225 with HTTP; Sun, 8 Mar 2015 03:14:43 -0700 (PDT)
In-Reply-To: <CACsJy8B5HwwZei+ao6Z4dt1eG27Mj4z2_QDKzVPTLphm6JrVWA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265074>

It is really helpful. Thanks a lot!

2015-03-08 17:34 GMT+08:00 Duy Nguyen <pclouds@gmail.com>:
> On Sun, Mar 8, 2015 at 3:57 PM, Dongcan Jiang <dongcan.jiang@gmail.co=
m> wrote:
>> Hi, all
>>
>> After digging into how "git fetch" works, I have found that my previ=
ous
>> understanding was too rash. I'm sorry for that.
>>
>> I find that the current workflow of "git fetch --depth" is as follow=
s:
>>
>>   1. 'fetch module' calls 'git-upload-pack service' via 'transport m=
odule'
>>      to fetch ref with `depth`.
>>   2. Such call is finished by pipe I/O.
>>   3. git-upload-pack receives arguments such as 'depth' to fetch com=
mits,
>>      and send back to the caller.
>>
>> Therefore, if we want to implement "--deepen" for "git fetch", we ha=
ve to
>> modify the arguments protocol of git-upload-pack service by adding t=
he
>> 'shallow commit' hash.
>> Then, we can fetch `depth` commits before the 'shallow commit' in
>> git-upload-pack service.
>> Apparently, we have to output error message when the 'shallow commit=
' hash
>> is not in the repository.
>
> Close. You can't figure this shallow commit hash from client side
> (client repo is shortened). So you can't send it. What you send is
> exactly what the user gives you (e.g. --deepen=3D5, then you send
> "deepen 5" or similar). The server side (git-upload-pack) knows about
> the shallow boundary of the client and can walk its (i.e. server-side=
)
> commit graph to find out the new, deepened boundary. Then the server
> sends necessary objects plus instructions to update shallow boundary
> to the client.
>
> Also, I think  this work would include support for smart-http
> protocol. It goes a slightly different route, "git fetch" ends up at
> transport.c, but then transport-helper.c and calls git-remote-http(s)
> which is implemented by remote-curl.c. This one handles http stuff
> then passes control to git-fetch-pack.c. It's fetch-pack that talks t=
o
> upload-pack.c
>
> Have a look at Documentation/technical/pack-protocol.txt and
> protocol-capabilities.txt (and http-protocol.txt for smart-http). The
> function that "draws" shallow boundary based on --depth is
> get_shallow_commits() in shallow.c. I suspect you need to improve it =
a
> bit to use with --deepen. I guess you can look at these [1]. Those
> changes touch shallow repo in a bit different way, but the main code
> path is more or less the same (smart-http not touched).
>
> [1] https://github.com/pclouds/git/commits/7edde8b83a20abb3cd404e2c5f=
07e3c29a2891f7
> --
> Duy



--=20
=E6=B1=9F=E4=B8=9C=E7=81=BF=EF=BC=88Dongcan Jiang=EF=BC=89
Team of Search Engine & Web Mining
School of Electronic Engineering & Computer Science
Peking University, Beijing, 100871, P.R.China
