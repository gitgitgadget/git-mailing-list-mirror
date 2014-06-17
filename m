From: Jeremiah Mahler <jmmahler@gmail.com>
Subject: Re: [PATCH v2 0/3] add strnncmp() function
Date: Tue, 17 Jun 2014 08:49:53 -0700
Message-ID: <20140617154953.GC5162@hudson.localdomain>
References: <cover.1402990051.git.jmmahler@gmail.com>
 <53A02195.8080202@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue Jun 17 17:50:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wwve5-0006ER-7j
	for gcvg-git-2@plane.gmane.org; Tue, 17 Jun 2014 17:50:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933177AbaFQPt5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 Jun 2014 11:49:57 -0400
Received: from mail-pd0-f182.google.com ([209.85.192.182]:56627 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933084AbaFQPt4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2014 11:49:56 -0400
Received: by mail-pd0-f182.google.com with SMTP id y13so5759647pdi.27
        for <git@vger.kernel.org>; Tue, 17 Jun 2014 08:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=CUjUkc9g3TvCysY3cFVO0kH9PYecdal5KWd5fg37COI=;
        b=V4Mc7MDFePqpxCQXgfuM8QobUV1rrAkLRxhJFjwxsDegpA3aTcmIiBwnx25rIKkaDD
         GTllwZ32SyRCw89BRal0Dq8luv1SAJ3OoFCvBha++KgXFdzXn6J+rNXKd08MysBhLELp
         SKDHUZhlGdwggDxHebq2/UhIR3dWOHHLkaXwA11oa9xoDnNIgmeMVgEH/eTzUJw0NPso
         SumzjKZOzjq2kiuM/Fxg3H3Y9/cI/wyi+FvV0h47x2roXdkSxl0ej9DnmXjOG7j6sgys
         J4F0mWyEgBna2jrcWh7TzzzcFA+egeJ6Qw4n7V2v3uc+6EW1E0vwNTF/nucl84Uxb9h3
         oF7A==
X-Received: by 10.68.178.194 with SMTP id da2mr33227727pbc.151.1403020196458;
        Tue, 17 Jun 2014 08:49:56 -0700 (PDT)
Received: from localhost (108-76-185-60.lightspeed.frokca.sbcglobal.net. [108.76.185.60])
        by mx.google.com with ESMTPSA id fl6sm86832596pab.43.2014.06.17.08.49.54
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Jun 2014 08:49:55 -0700 (PDT)
Mail-Followup-To: Jeremiah Mahler <jmmahler@gmail.com>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <53A02195.8080202@web.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251869>

Torsten,

On Tue, Jun 17, 2014 at 01:08:05PM +0200, Torsten B=C3=B6gershausen wro=
te:
> On 2014-06-17 09.34, Jeremiah Mahler wrote:
> > Add a strnncmp() function which behaves like strncmp() except it ta=
kes
> > the length of both strings instead of just one.
> >=20
> > Then simplify tree-walk.c and unpack-trees.c using this new functio=
n.
> > Replace all occurrences of name_compare() with strnncmp().  Remove
> > name_compare(), which they both had identical copies of.
> >=20
> > Version 2 includes suggestions from Jonathan Neider [1]:
> >=20
> >   - Fix the logic which caused the new strnncmp() to behave differe=
ntly
> > 	from the old version.  Now it is identical to strncmp().
> >=20
> >   - Improve description of strnncmp().
> >=20
> > Also, strnncmp() was switched from using memcmp() to strncmp()
> > internally to make it clear that this is meant for strings, not
> > general buffers.
> I don't think this is a good change, for 2 reasons:
> - It changes the semantics of existing code, which should be carefull=
y
>   reviewed, documented and may be put into a seperate commit.
> - Looking into the code for memcmp() and strncmp() in libc,
>   I can see that memcmp() is written in 13 lines of assembler,
>   (on a 386 system) with a fast
>     repz cmpsb %es:(%edi),%ds:(%esi)
>   working as the core engine.
>  =20
>   strncmp() uses 83 lines of assembler, because after each comparison
>   the code needs to check of the '\0' in both strings.
> - I can't see a reason to replace efficient code with less efficient =
code,
>   so moving the old function "as is" into a include file, and declare
>   it "static inline" could be the first step.
>=20
>   Having code inline may open the door for the compiler to decide,
>   "Oh, I know exactly what memcmp() does, so I through in a handfull
>   of lines assembly code, instead of calling memcmp() from libc".
>=20
Thanks for explaining the benefits of memcmp() over strcmp(), I will
switch it back.

The only case I can imagine where it would make a difference is when
there is a '\0' in the middle of the string.  But that would be an
unlikely case since it probably meant the lengths were mis-calculated.

>=20
> And another thing:
>  What does cache_name_compare(name, namelen, ce->name, len))
>  in name-hash.c do?
>  Isn't that the same function ?
>=20
cache_name_compare() is the same except it returns -1, +1 instead of -N=
,
+N.  However, none of the cases where name_compare() is used need the
magnitude so this function could be used.

> I like strnncmp() better than=20
> cache_name_compare() or name_compare(),
> but I agree with Erik here that strnncmp() has the potential to
> become a name clash some day, so that git_strnncmp() may be better.
>=20
Agreed.

> Thanks for the effort, cleaning up is needed.
>=20

Thanks for the feedback :-)

--=20
Jeremiah Mahler
jmmahler@gmail.com
http://github.com/jmahler
