From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 00/22] Refactor to accept NUL in commit messages
Date: Sun, 23 Oct 2011 12:24:25 +1100
Message-ID: <CACsJy8B=TsC4A=R6b3jyYBCvorEDBYHQ8uA864WrB0-3pgNyKA@mail.gmail.com>
References: <1319277881-4128-1-git-send-email-pclouds@gmail.com> <7vobx863v3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, peff@peff.net,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Oct 23 03:25:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RHmoA-0006Vi-5E
	for gcvg-git-2@lo.gmane.org; Sun, 23 Oct 2011 03:25:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753078Ab1JWBY4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 22 Oct 2011 21:24:56 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:53641 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752589Ab1JWBYz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 22 Oct 2011 21:24:55 -0400
Received: by mail-bw0-f46.google.com with SMTP id zt19so6528133bkb.19
        for <git@vger.kernel.org>; Sat, 22 Oct 2011 18:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=4sWC4oF2O2mYvjhuNtfR7ndxD16wIr115FD+cghqtOI=;
        b=gBoYRwZ7PunYD7fKN7PD5m0Atw4D83it/lE7riI5corQzxOershNN2pbNXyMsVZ+/K
         fFgxB4tJ/agjD+9L7mkeOwHBhGf8TFolV4z6gaJo9ETyGvzG2yLuAZAS+BYI3Q0/9SFw
         SHmiEjZXdlj5QGzzcg6rAz9VxMqNQ7Nt0YN5g=
Received: by 10.223.6.25 with SMTP id 25mr34016238fax.14.1319333095115; Sat,
 22 Oct 2011 18:24:55 -0700 (PDT)
Received: by 10.223.124.73 with HTTP; Sat, 22 Oct 2011 18:24:25 -0700 (PDT)
In-Reply-To: <7vobx863v3.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184124>

2011/10/23 Junio C Hamano <gitster@pobox.com>:
> I do not think we want to go this route.
>
> There are two possible approaches to attack this.
>
> =C2=A0- If we want to show everything after a potential and rare NUL =
in the log
> =C2=A0 message most of the time, then "struct commit" should just sto=
re
> =C2=A0 <ptr,len> pair. This grows "struct commit" with one extra ulon=
g.
>
> =C2=A0- If we want to give us a way to notice and show these "funnily=
, this
> =C2=A0 commit log message has a NUL in it" case as an exception in on=
ly
> =C2=A0 selected codepaths, then "struct commit" should just gain "fla=
gs"
> =C2=A0 4-byte int field between "indegree" and "date", and
> =C2=A0 parse_commit_buffer() should set one bit in the flags when the=
 log
> =C2=A0 message has NUL in it. And teach only these selected codepaths=
 to find
> =C2=A0 the length from the object name with sha1_object_info() as nee=
ded. This
> =C2=A0 grows "struct commit" with one 4-byte int, with runtime overhe=
ad only
> =C2=A0 where it matters.
>
> The approach taken by the patch wastes two malloc() blocks with their=
 own
> allocation overhead, and unused "alloc" field in the strbuf that does=
 not
> have to be there.

We could allocate just one block with length as the first field:

struct commit_buffer {
        unsigned long len;
        char buf[FLEX_ARRAY];
};

The downside is commit_buffer field type in struct commit changes,
which impacts many codepaths. If we agree to allow NUL in commit
objects, then all codepaths should be aware of that fact, otherwise
funny things may happen because string processing in this function
stops early due to NUL, but others run fine..

Jeff's low-level normalization approach sounds much simpler, but
probably trickier because we need to identify where to normalize and
denormalize. At least with type change, the compiler spots all the
places for me.

I would not worry about runtime processing overhead. The string end
check is basically converted from "if (*msg)" to "if (msg < msg_end)".
There will one more pointer (msg_end) in stack for each call. Unless
we do deep recursion, we should be fine. Memory overhead is still
something to profile.
--=20
Duy
