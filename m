From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 02/10] revert: Propogate errors upwards from do_pick_commit
Date: Thu, 26 May 2011 15:04:16 +0530
Message-ID: <BANLkTi==NG2mTARtVC4vBD8BebMpdRv6tg@mail.gmail.com>
References: <1306333025-29893-1-git-send-email-artagnon@gmail.com>
 <1306333025-29893-3-git-send-email-artagnon@gmail.com> <7v62oy1juh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Christian Couder <christian.couder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 26 11:34:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPWxn-0002x2-QG
	for gcvg-git-2@lo.gmane.org; Thu, 26 May 2011 11:34:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757270Ab1EZJei convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 26 May 2011 05:34:38 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:45372 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755905Ab1EZJeh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 May 2011 05:34:37 -0400
Received: by wya21 with SMTP id 21so345891wya.19
        for <git@vger.kernel.org>; Thu, 26 May 2011 02:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=YFSizMFMr55Qc6NzRqqMD/o5mCW8KRAIA7jpHfRMdyQ=;
        b=BUq/IOeQzYiUlohVynjoOBogFH5KcpLMZP7jezI1997IIWnQH6KSFdsx0bVHaUIGxI
         uGNAX0Yk3KH08fBgeOLvS/yBFr/x67G9UcD2E1Q8NRlyAYec7yHtWZFZZDjbkAmYTE83
         MiYBZnAvj0dNC/0x4EDk5Br5efB/vpdKo1bkY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=Nruqw+pxKc8hb2wbcB63tcPR897duIUmshm/8eCVnJjzm1P4hnNNWcV2V1fhnWvQIx
         /ZSWPPMzET+q5NaB/kr6fknbGce+4LhUfsgXIPm7PpHbljfvzRfMELtvY0H/mu7Js5Bh
         AVWO42PB27GCzBF+Jv95aJM48M/vOUa4db5JI=
Received: by 10.216.234.80 with SMTP id r58mr542964weq.109.1306402476190; Thu,
 26 May 2011 02:34:36 -0700 (PDT)
Received: by 10.216.158.70 with HTTP; Thu, 26 May 2011 02:34:16 -0700 (PDT)
In-Reply-To: <7v62oy1juh.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174503>

Hi Junio,

Junio C Hamano writes:
> Ramkumar Ramachandra <artagnon@gmail.com> writes:
>> +static int error_dirty_index(const char *me)
>> =C2=A0{
>> + =C2=A0 =C2=A0 if (read_cache_unmerged())
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return error_resolve_con=
flict(me);
>> +
>> + =C2=A0 =C2=A0 int ret =3D error(_("Your local changes would be ove=
rwritten by %s.\n"), me);
>> + =C2=A0 =C2=A0 if (advice_commit_before_merge)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 advise(_("Please, commit=
 your changes or stash them to proceed."));
>> + =C2=A0 =C2=A0 return ret;
>> =C2=A0}
>
> I like this rewrite whose result is short-and-sweet, but you do not e=
ven
> need the "ret" variable. error() always yields -1, no?

Okay; I didn't do this in the first place because I thought it would
be inelegant to hardcode '-1'. Fixed anyway.

>> @@ -594,14 +584,28 @@ static int revert_or_cherry_pick(int argc, con=
st char **argv)
>>
>> =C2=A0int cmd_revert(int argc, const char **argv, const char *prefix=
)
>> =C2=A0{
>> + =C2=A0 =C2=A0 int res =3D 0;
>> =C2=A0 =C2=A0 =C2=A0 if (isatty(0))
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 edit =3D 1;
>> =C2=A0 =C2=A0 =C2=A0 action =3D REVERT;
>> - =C2=A0 =C2=A0 return revert_or_cherry_pick(argc, argv);
>> + =C2=A0 =C2=A0 res =3D revert_or_cherry_pick(argc, argv);
>> + =C2=A0 =C2=A0 if (res > 0)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Exit status from conf=
lict */
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return res;
>> + =C2=A0 =C2=A0 if (res < 0)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Other error */
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(128);
>> + =C2=A0 =C2=A0 return 0;
>> =C2=A0}
>>
>> =C2=A0int cmd_cherry_pick(int argc, const char **argv, const char *p=
refix)
>> =C2=A0{
>> + =C2=A0 =C2=A0 int res =3D 0;
>> =C2=A0 =C2=A0 =C2=A0 action =3D CHERRY_PICK;
>> - =C2=A0 =C2=A0 return revert_or_cherry_pick(argc, argv);
>> + =C2=A0 =C2=A0 res =3D revert_or_cherry_pick(argc, argv);
>> + =C2=A0 =C2=A0 if (res > 0)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return res;
>> + =C2=A0 =C2=A0 if (res < 0)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(128);
>> + =C2=A0 =C2=A0 return 0;
>> =C2=A0}
>
> This hunk is dubious.
>
> =C2=A0- Why initialize res to zero if it always is assigned the retur=
n value of
> =C2=A0 revert_or_cherry_pick() before it is used?

Okay. Fixed.

> =C2=A0- The called function seems to return errors from various place=
s but as
> =C2=A0 far as I see they are all return value of error(), so it would=
 be
> =C2=A0 equivalent to
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (r_o_c_p(...))
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0exit(128);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
>
> If you are going to introduce different return values from r-o-c-p() =
in a
> later patch, these functions should be updated in that patch, I think=
=2E

revert_or_cherry_pick *does* return different values in this patch! As
I've pointed out in the comment, positive exit status indicates a
conflict, while a negative one indicates an error. To prove to myself
that this is case, I applied this diff temporarily and ran all tests
-- and viola, t3505-cherry-pick-empty.sh broke. Is there something I'm
not understanding correctly?

Thanks for the review.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>

diff --git a/builtin/revert.c b/builtin/revert.c
index 523d41a..9c7921b 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -584,28 +584,22 @@ static int revert_or_cherry_pick(int argc, const
char **argv)

 int cmd_revert(int argc, const char **argv, const char *prefix)
 {
-	int res =3D 0;
+	int res;
 	if (isatty(0))
 		edit =3D 1;
 	action =3D REVERT;
 	res =3D revert_or_cherry_pick(argc, argv);
-	if (res > 0)
-		/* Exit status from conflict */
-		return res;
-	if (res < 0)
-		/* Other error */
+	if (res)
 		exit(128);
 	return 0;
 }

 int cmd_cherry_pick(int argc, const char **argv, const char *prefix)
 {
-	int res =3D 0;
+	int res;
 	action =3D CHERRY_PICK;
 	res =3D revert_or_cherry_pick(argc, argv);
-	if (res > 0)
-		return res;
-	if (res < 0)
+	if (res)
 		exit(128);
 	return 0;
 }
