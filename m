From: Tor Arvid Lund <torarvid@gmail.com>
Subject: Re: [PATCH v2 7/8] git-p4: decode p4 wildcard characters
Date: Thu, 24 Feb 2011 14:54:56 +0100
Message-ID: <AANLkTik=KWwszN9ETOh11btPvcPXCcoA=evT4Fgxt-Fm@mail.gmail.com>
References: <1298121481-7005-1-git-send-email-pw@padd.com>
	<1298121481-7005-8-git-send-email-pw@padd.com>
	<7vbp25hsk6.fsf@alter.siamese.dyndns.org>
	<20110224121210.GA16475@arf.padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Vitor Antunes <vitor.hda@gmail.com>, git@vger.kernel.org
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Thu Feb 24 14:55:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Psber-0004WL-P0
	for gcvg-git-2@lo.gmane.org; Thu, 24 Feb 2011 14:55:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754479Ab1BXNzA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Feb 2011 08:55:00 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:62605 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753583Ab1BXNy6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Feb 2011 08:54:58 -0500
Received: by eyx24 with SMTP id 24so189667eyx.19
        for <git@vger.kernel.org>; Thu, 24 Feb 2011 05:54:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ZR4WvlLDbUccsE2SnB9Nl084tDxdIwqCOrnlMcrh7/U=;
        b=w4jAbLG/hiYE57MzNJEi3bwA2lEwz5DE93gyjb/04bWS+r/Z9rdONrLDFoKFmtXU6c
         bzZ4tHlZMb25YfnzACxN1xLsx4fSY+U23pJkz7OBDcuwfm6Mnhcp55bzrySjVmmP4rfP
         w+KxYpu5IhKHNW/AogcWa0Tqq98w4omKK5J2A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=C1FPjwpoIrHoe1dTgUtTWSS0qUg8qmD9bjbm5+Krct+cIh7ivaIqqu8e+ov0qqLCF2
         9J1EKja++7RXs35E4lJATmq9IpA+EyojLrY8FL5kfrMdOE8RbthYHYGqLoemzxXw62zO
         irsKPeP2ZHGxB003TfT2GtPp9kSKLlOBDkrzA=
Received: by 10.213.12.200 with SMTP id y8mr1276017eby.52.1298555696163; Thu,
 24 Feb 2011 05:54:56 -0800 (PST)
Received: by 10.213.2.196 with HTTP; Thu, 24 Feb 2011 05:54:56 -0800 (PST)
In-Reply-To: <20110224121210.GA16475@arf.padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167804>

On Thu, Feb 24, 2011 at 1:12 PM, Pete Wyckoff <pw@padd.com> wrote:
> gitster@pobox.com wrote on Mon, 21 Feb 2011 15:32 -0800:
>> Pete Wyckoff <pw@padd.com> writes:
>>
>> > There are four wildcard characters in p4. =C2=A0Files with these
>> > characters can be added to p4 repos using the "-f" option.
>> > They are stored in %xx notation, and when checked out, p4
>> > converts them back to normal.
>> >
>> > This patch does the same thing when importing into git,
>> > converting the four special characters. =C2=A0Without this change,
>> > the files appear with literal %xx in their names.
>> >
>> > Be careful not to produce "*" in filenames on windows. =C2=A0That
>> > will fail.
>>
>> > + =C2=A0 =C2=A0# P4 wildcards are not allowed in filenames. =C2=A0=
P4 complains
>> > + =C2=A0 =C2=A0# if you simply add them, but you can force it with=
 "-f", in
>> > + =C2=A0 =C2=A0# which case it translates them into %xx encoding i=
nternally.
>> > + =C2=A0 =C2=A0# Search for and fix just these four characters. =C2=
=A0Do % last so
>> > + =C2=A0 =C2=A0# that fixing it does not inadvertently create new =
%-escapes.
>> > + =C2=A0 =C2=A0#
>> > + =C2=A0 =C2=A0def wildcard_decode(self, path):
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0# Cannot have * in a filename in wind=
ows; untested as to
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0# what p4 would do in such a case.
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0if not self.isWindows:
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0path =3D path.replace("=
%2A", "*")
>>
>> I'll queue the patch as-is, but perhaps we can ask for help from peo=
ple
>> who have access to P4 on both non-Windows and Windows to run a small=
 test
>> to determine what happens in the native client?
>>
>> =C2=A01. On a non-Windows client, add a path with '*' in it to the d=
epot;
>> =C2=A0 =C2=A0 perhaps "p4 add" might fail at this point, in which ca=
se we don't
>> =C2=A0 =C2=A0 need to worry about this issue at all.
>>
>> =C2=A02. Create a p4 client on Windows against that depot, and sync =
it; unless
>> =C2=A0 =C2=A0 the previous step failed, we will see what happens (I =
would imagine it
>> =C2=A0 =C2=A0 either dies or mangles the pathname and warns), so tha=
t we have
>> =C2=A0 =C2=A0 something to emulate.
>>
>> and then the quoted part can be further refined in a separate patch =
later.
>
> I tried this myself in a VM when Tor Arvid pointed out the
> problem with Windows:
>
> http://article.gmane.org/gmane.comp.version-control.git/166374
>
> 1. =C2=A0"*" is acceptable in filenames, but users must use "p4 add -=
f"
> =C2=A0 =C2=A0to indicate that they really want that wildcard characte=
r in
> =C2=A0 =C2=A0the filename.
>
> 2. =C2=A0Windows clients fail to create the file in "p4 sync". =C2=A0=
The
> =C2=A0 =C2=A0error is:
>
> =C2=A0 =C2=A0open for write: c:\Documents and Settings\Administrator\=
Desktop\file*star:
> =C2=A0 =C2=A0The filename, directory name, or volume label syntax is =
incorrect.
>
> The behavior for git-p4 I chose is to sync the file but leave
> the name with its encoded %2A. =C2=A0If we think it is better to
> duplicate p4's failure, we can simply try to create the file
> and let the OS produce the same error message.

Yeah, I was thinking... what happens now if we do:

1) Create "my*file" in linux, and submit.
2) git-p4 sync from windows, and get my%2Afile on windows.
3) modify my%2Afile and do git commit.
4) git-p4 submit

I haven't had time to test right now, but maybe p4 will not recognise
my%2Afile (or try to check it in as my%252Afile (replacing the '%'
character) or something like that? (Or maybe I just haven't had enough
coffee today :-/ )

    -- Tor Arvid
