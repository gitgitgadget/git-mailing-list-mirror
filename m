From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 7/7] unpack-trees: free cache_entry array members for merges
Date: Sun, 2 Jun 2013 17:38:38 -0500
Message-ID: <CAMP44s3cqa-jETHX+ftbAVMx+oV6PMcVkdH63P93ER-4fH28Hw@mail.gmail.com>
References: <1370188017-24672-1-git-send-email-rene.scharfe@lsrfire.ath.cx>
	<1370188017-24672-8-git-send-email-rene.scharfe@lsrfire.ath.cx>
	<CAMP44s2ym5UEPo8kr6YKf1x_P_0L+o_9vWdCTA6MPDQsRy7d1A@mail.gmail.com>
	<51AB86BB.3080203@lsrfire.ath.cx>
	<CAMP44s0Af90Sfi47_mxEGRFHAsAhaoO6T1jjbj7SptucNO-k0w@mail.gmail.com>
	<51ABAA84.8090301@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>,
	Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Mon Jun 03 00:38:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjGvF-0003jz-2k
	for gcvg-git-2@plane.gmane.org; Mon, 03 Jun 2013 00:38:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755253Ab3FBWil convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 2 Jun 2013 18:38:41 -0400
Received: from mail-la0-f46.google.com ([209.85.215.46]:53050 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755181Ab3FBWij convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 2 Jun 2013 18:38:39 -0400
Received: by mail-la0-f46.google.com with SMTP id fl20so959301lab.33
        for <git@vger.kernel.org>; Sun, 02 Jun 2013 15:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=2VrzyUVNMeq/SFj+lm6i1py7O/u0OgeSdrLNUdBxjg4=;
        b=frqWxAC86uMCVbBZCDxGWo1HhYwCh+l2nwp19DakeahTrYMa3aO420F6La0MPAdmqU
         hiHYCEzjVcXAPVA8OF9/7rlwqXP0u0MdA6ypEBhqsfnIiwevd9D6NpQltczf9ZShzSiF
         ocMZ6PduPI4rmyHdEy5WV9LieeCgtWSJaq5uonybLK+WbrjFwNn1duNykbqC3kCNdZFc
         eBKkIMLkwVKtu9xh1oDDin/oTZJTcZTRrni0RYF7C4tGq02w+5zkl4ytHiyiqBCiUE7F
         l6T7dCJ/IAKtvdMoCvDtGmwAwe5a3ljHjpyGafpoCXYnaSfTmBkGXXNncXToNPaRXHGr
         MGHg==
X-Received: by 10.112.160.105 with SMTP id xj9mr7108176lbb.11.1370212718159;
 Sun, 02 Jun 2013 15:38:38 -0700 (PDT)
Received: by 10.114.177.164 with HTTP; Sun, 2 Jun 2013 15:38:38 -0700 (PDT)
In-Reply-To: <51ABAA84.8090301@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226188>

On Sun, Jun 2, 2013 at 3:26 PM, Ren=C3=A9 Scharfe
<rene.scharfe@lsrfire.ath.cx> wrote:
> Am 02.06.2013 19:59, schrieb Felipe Contreras:
>
>> On Sun, Jun 2, 2013 at 12:54 PM, Ren=C3=A9 Scharfe
>> <rene.scharfe@lsrfire.ath.cx> wrote:
>>>
>>> Am 02.06.2013 19:25, schrieb Felipe Contreras:
>>>>
>>>>
>>>> On Sun, Jun 2, 2013 at 10:46 AM, Ren=C3=A9 Scharfe
>>>> <rene.scharfe@lsrfire.ath.cx> wrote:
>>>>>
>>>>>
>>>>> +               for (i =3D 0; i < n; i++) {
>>>>> +                       struct cache_entry *ce =3D src[i + o->mer=
ge];
>>>>> +                       if (ce !=3D o->df_conflict_entry)
>>>>
>>>>
>>>>
>>>> It's possible that ce is NULL, but you didn't add that check becau=
se
>>>> free(NULL) still works? Or because ce cannot be NULL?
>>>>
>>>> If it's the former, I think it's clearer if we check that ce is no=
t
>>>> NULL either way.
>>>
>>>
>>>
>>> It is NULL if one tree misses an entry (e.g. a new or removed file)=
=2E free
>>> handles NULL and we generally avoid duplicating its NULL-check.
>>
>>
>> Yeah, but I can see somebody adding code inside that 'if' clause to
>> print the cache entry, and see a crash only to wonder what's going o=
n.
>> And to save what? 5 characters?
>
>
> The person adding code that depends on ce not being NULL needs to add=
 that
> check as well.  Let's not worry too much about future changes that ma=
y or
> (more likely IMHO) may not be done.  The test suite covers this case
> multiple times, so such a mistake doesn't have a realistic chance to =
hit
> master.

What do we gain by not doing this? 5 less characters?

--=20
=46elipe Contreras
