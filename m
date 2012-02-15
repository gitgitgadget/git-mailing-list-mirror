From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: [StGit PATCH] Parse commit object header correctly
Date: Wed, 15 Feb 2012 12:24:34 +0000
Message-ID: <CAHkRjk451=_XaQuUXmxAvB3sRRz6-J+c7A2ZrfLwfGz=z05Lag@mail.gmail.com>
References: <4F3120D4.1050604@warmcat.com> <7vvcni1r5u.fsf@alter.siamese.dyndns.org>
 <7vd39pzsmq.fsf_-_@alter.siamese.dyndns.org> <4F3247CA.1020904@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?ISO-8859-1?Q?Karl_Hasselstr=F6m?= <kha@treskal.com>,
	=?UTF-8?B?IkFuZHkgR3JlZW4gKOael+WuieW7uCki?= <andy@warmcat.com>,
	git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Feb 15 13:25:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rxdux-0005fV-CC
	for gcvg-git-2@plane.gmane.org; Wed, 15 Feb 2012 13:25:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755699Ab2BOMY6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 15 Feb 2012 07:24:58 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:41089 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751277Ab2BOMY5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Feb 2012 07:24:57 -0500
Received: by qadc10 with SMTP id c10so2979747qad.19
        for <git@vger.kernel.org>; Wed, 15 Feb 2012 04:24:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=fgba/JyUgqHXpHIl14kkBN2OxX4PWuTw9Rhk9LDeEsI=;
        b=jUoqdZprSyaO+yb3Bxfhvkivfbx0F5tlTv6xPNcOFPgSf6Vu07Ib/FnZaO03tvETa8
         CzOXiYckWedSUJKMh3/B1OMq27eVLqZNawBT6msaNNHiMswOpx/o1/pJFcodpacRWG1g
         hD2AXQ6mNq2vNGNQhHfPQxc7HzogIrOa3srSc=
Received: by 10.229.114.210 with SMTP id f18mr1827854qcq.54.1329308694277;
 Wed, 15 Feb 2012 04:24:54 -0800 (PST)
Received: by 10.229.164.8 with HTTP; Wed, 15 Feb 2012 04:24:34 -0800 (PST)
In-Reply-To: <4F3247CA.1020904@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190828>

On 8 February 2012 10:00, Michael Haggerty <mhagger@alum.mit.edu> wrote=
:
> On 02/08/2012 08:33 AM, Junio C Hamano wrote:
>> To allow parsing the header produced by versions of Git newer than t=
he
>> code written to parse it, all commit parsers are expected to skip un=
known
>> header lines, so that newer types of header lines can be added safel=
y.
>> The only three things that are promised are:
>>
>> =A0(1) the header ends with an empty line (just an LF, not "a blank =
line"),
>> =A0(2) unknown lines can be skipped, and
>> =A0(3) a header "field" begins with the field name, followed by a si=
ngle SP
>> =A0 =A0 =A0followed by the value.
>>
>> The parser used by StGit, introduced by commit cbe4567 (New StGit co=
re
>> infrastructure: repository operations, 2007-12-19), was accidentally=
 a bit
>> too loose to lose information, and a bit too strict to raise excepti=
on
>> when dealing with a line it does not understand.
=2E..
> All in all, I would recommend something like (untested):
>
> =A0 =A0 =A0 =A0@return: A new L{CommitData} object
> =A0 =A0 =A0 =A0@rtype: L{CommitData}"""
> =A0 =A0 =A0 =A0cd =3D cls(parents =3D [])
> =A0 =A0 =A0 =A0lines =3D []
> =A0 =A0 =A0 =A0raw_lines =3D s.split('\n')
> =A0 =A0 =A0 =A0# Collapse multi-line header lines
> =A0 =A0 =A0 =A0for i, line in enumerate(raw_lines):
> =A0 =A0 =A0 =A0 =A0 =A0if not line:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cd.set_message('\n'.join(raw_lines[i+1=
:]))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break
> =A0 =A0 =A0 =A0 =A0 =A0if line.startswith(' '):
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0# continuation line
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0lines[-1] +=3D '\n' + line[1:]
> =A0 =A0 =A0 =A0 =A0 =A0else:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0lines.append(line)
>
> =A0 =A0 =A0 =A0for line in lines:
> =A0 =A0 =A0 =A0 =A0 =A0if ' ' in line:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0key, value =3D line.split(' ', 1)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if key =3D=3D 'tree':
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cd =3D cd.set_tree(repository.=
get_tree(value))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0elif key =3D=3D 'parent':
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cd =3D cd.add_parent(repositor=
y.get_commit(value))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0elif key =3D=3D 'author':
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cd =3D cd.set_author(Person.pa=
rse(value))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0elif key =3D=3D 'committer':
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cd =3D cd.set_committer(Person=
=2Eparse(value))
> =A0 =A0 =A0 =A0return cd

Thank you all for comments and patches. I used a combination of
Junio's patch with the comments from Michael and a fix from me. I'll
publish it to the 'master' branch shortly and release a 0.16.1
hopefully this week.

--=20
Catalin
