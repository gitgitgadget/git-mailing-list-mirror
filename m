From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH v2 2/2] receive-pack: detect aliased updates which can 
	occur with symrefs
Date: Mon, 19 Apr 2010 16:57:06 -0400
Message-ID: <z2s76718491004191357gf4783770i84308e930d9adb22@mail.gmail.com>
References: <1271694343-31876-2-git-send-email-jaysoffian@gmail.com>
	 <1271695179-32131-1-git-send-email-jaysoffian@gmail.com>
	 <7veiibqirf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Shawn O . Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 19 22:57:16 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3y1s-000539-2W
	for gcvg-git-2@lo.gmane.org; Mon, 19 Apr 2010 22:57:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751581Ab0DSU5K convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 19 Apr 2010 16:57:10 -0400
Received: from mail-iw0-f197.google.com ([209.85.223.197]:53849 "EHLO
	mail-iw0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751201Ab0DSU5I convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Apr 2010 16:57:08 -0400
Received: by iwn35 with SMTP id 35so2522940iwn.21
        for <git@vger.kernel.org>; Mon, 19 Apr 2010 13:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=PQfNuMAjfkUUgvoqLR07N0vRfjOnRz5UU+2eGdODj/Y=;
        b=p+gfSDtkiPEUIUpSR4suox01ydIy1LknAIiqeEzuy0d1mYVUSVZkMJugq5vclBHxpV
         YCC+PoZ8w65fJZsWAyO6SZq6dTtcA680CoKGpEDUiOOKNN8OSkRTsqCGCVMlGpWF6f+y
         smjQKsZT3oGMDbOJiVO/J3n9zi92/Yi3SQ9Ho=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=YYlS7Ey96ixBXQiflxu5bKKKWhNITLJGC9M34qCZu1HccABkfgl88mJLI7j59sdksS
         9IzihdRxoMAWPYyLH6bCaxc2Kc/hyvMGlVJOYIVI8yaScWFX1+n2dag4drb3mqIltAEf
         crS81ZJRb2JJYGUa+zEVC5HfS20+V2uomy1Ps=
Received: by 10.231.36.9 with HTTP; Mon, 19 Apr 2010 13:57:06 -0700 (PDT)
In-Reply-To: <7veiibqirf.fsf@alter.siamese.dyndns.org>
Received: by 10.231.152.79 with SMTP id f15mr1352328ibw.19.1271710626141; Mon, 
	19 Apr 2010 13:57:06 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145329>

On Mon, Apr 19, 2010 at 4:39 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
>> - =C2=A0 =C2=A0 for (cmd =3D commands; cmd; cmd =3D cmd->next)
>> + =C2=A0 =C2=A0 for (cmd =3D commands; cmd && !cmd->skip_update; cmd=
 =3D cmd->next)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cmd->error_string =3D=
 update(cmd);
>> =C2=A0}
>
> Do you really mean to have "skip-update" check as the loop terminatio=
n
> condition like this (i.e. "upon seeing any skip-update, abandon the r=
est
> of the update queue"), or is this a typo of "skip this entry but keep
> going, processing the rest" that should have been a separate "if" in =
the
> body of the loop?

Oh wow, the perils of coding before coffee. I wish I could call it a
typo, it's a thinko which is much worse.

>> @@ -545,6 +606,7 @@ static struct command *read_head_info(void)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 hashcpy(cmd->old_sh=
a1, old_sha1);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 hashcpy(cmd->new_sh=
a1, new_sha1);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 memcpy(cmd->ref_nam=
e, line + 82, len - 81);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cmd->skip_update =3D 0;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cmd->error_string =3D=
 NULL;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cmd->next =3D NULL;
>
> It would make sense to do xcalloc(nmemb, size) of one member of that
> length to allocate cmd at this point, instead of adding yet another
> assignment like this.

Okay.

> It also would help me a slight bit if you compared what has been queu=
ed
> with what you sent to catch minor differences between my expectation =
from
> this series and what you have (e.g. I'd like to keep this as a fix th=
at is
> back-mergeable to 'maint' and also I have already done some style fix=
es to
> the test).

I didn't realize you'd queued it before I sent out v2. But I'm not
sure what you're asking for beyond what I already said in the email:

- Reformatted commit message; minor rewording.
- Detect situation where there is an inconsistent aliased update and
 give a better diagnostic than "failed to lock"
- Add additional test case for inconsistent update situation

j.
