From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [PATCH RFC] cherry: support --abbrev option
Date: Tue, 16 Mar 2010 00:50:07 +0100
Message-ID: <40aa078e1003151650m549bafdbwdd849e23349ce6a9@mail.gmail.com>
References: <1268668999-4188-1-git-send-email-kusmabite@gmail.com>
	 <4B9E69A4.2080304@lsrfire.ath.cx>
	 <40aa078e1003151530y19f10bf1l852a0e5230b11cb6@mail.gmail.com>
	 <4B9EBFEB.5070108@lsrfire.ath.cx>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Tue Mar 16 00:50:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrK35-0005fG-5t
	for gcvg-git-2@lo.gmane.org; Tue, 16 Mar 2010 00:50:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965836Ab0COXuK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Mar 2010 19:50:10 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:40498 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965819Ab0COXuJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Mar 2010 19:50:09 -0400
Received: by wwe15 with SMTP id 15so267762wwe.19
        for <git@vger.kernel.org>; Mon, 15 Mar 2010 16:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Tkfn95MyelaV0srnAfubygnrVRLp41jeuNHJHN887cA=;
        b=WBRlbjQKVLnORkjr4O8V8vRx+Ts+gY7/NnFcMAbnKSCIAztSQnyJ4jcHlKJNHXfmvs
         s09ucYkuj+FZVx8zhCdOe6mPgWAuQ3PN5L7pFduhaBwz6NKCo0Azgu6FZee0Yc8MpSy9
         /2srR+ATq2RppTkAovF9hnbMHepGUMuMsHVwA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        b=XQzYni0mDAYK7YqFm7iN7zT6Z4lIfbC6fPn7I/cnUSWpFBfMhUHuNf72+aRpNRipGz
         LKMQnAO/MX7McnIovj9L3mLYbvKldTA5CX+GWNHbUmA5DI/xez0g9K665DRYVKm6dA+/
         QpZtmB7IelR8q02HGG/uDvRu/XZJaX+kTSEVU=
Received: by 10.216.86.16 with SMTP id v16mr159351wee.162.1268697007127; Mon, 
	15 Mar 2010 16:50:07 -0700 (PDT)
In-Reply-To: <4B9EBFEB.5070108@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142282>

On Tue, Mar 16, 2010 at 12:16 AM, Ren=E9 Scharfe
<rene.scharfe@lsrfire.ath.cx> wrote:
> Am 15.03.2010 23:30, schrieb Erik Faye-Lund:
>> On Mon, Mar 15, 2010 at 6:08 PM, Ren=E9 Scharfe
>>> If I use --no-abbrev, do I get 0 or 40 hash chars? =A0I didn't actu=
ally
>>> test it, but I suspect an "if (!abbrev) abbrev =3D 40;" is needed s=
omewhere.
>>
>> "abbrev" is initialized to 40 when declared, so you get the same
>> behavior as before by default.
>
> Yes, but --no-abbrev sets it to zero. =A0Which is OK, though, as I fo=
und
> out after actually testing your patch this time. =A0A closer look at
> find_unique_abbrev() in sha1_name.c reveals that the function returns
> the full hash if len is either 40 or 0.
>

Ah yes, sorry. I misread your initial comment. That's what I get for
answering e-mail after coming home from a pub-quiz ;)

> So you could initialize abbrev to zero and avoid the magic constant 4=
0
> there altogether. =A0(Is this still nitpicking or already bikesheddin=
g? ;)
>

It's still just nitpicking, and I appreciate the feed-back. I'm a
little bit hesitant here though, for the following reasons:
- All other users of OPT__ABBREV (with the exception of ls-files,
ls-tree and show-ref) initialize abbrev to it's default value (but
they all use DEFAULT_ABBREV).
- ls-files and ls-tree (but not show-ref) both does the following,
when using abbrev: "abbrev ? find_unique_abbrev(ce->sha1,abbrev) :
sha1_to_hex(ce->sha1)".
- ls-files, ls-tree and show-ref, all seems to default "abbrev" to
zero (by making it a static global).
- I want to be consistent with the existing code.

So, basically, ls-files and ls-tree seems to think
find_unique_abbrev() does not correctly (for this purpose) handle
abbrev=3D0. However, show-ref does seem to assume so. Looking at the
implementation of find_unique_abbrev(), it is clear that it does. But
as I said: I want to be consistent, and the variation from show-ref
(basically what you're suggesting) is the least common one.

So I guess I can either:
1) Change the code to be consistent with show-ref, and submit an
additional patch to make ls-files and ls-tree consistent with this.
This might have a performance-impact though, since
find_unique_abbrev() does some extra work (checking the sha1 for
existence and an extra buffer-copy).
2) Change the code as you suggest, and not care so much about consisten=
cy.
3) Leave the code to be functionally consistent with those who
initialize abbrev to DEFAULT_ABBREV (but with a different default,
which in itself is slightly inconsistent).

I'm leaning towards 3) for now, but I don't have any strong feelings.

--=20
Erik "kusma" Faye-Lund
