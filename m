From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] git-clone.txt: remove the restriction on pushing from a
 shallow clone
Date: Sun, 14 Jul 2013 09:28:55 +0700
Message-ID: <CACsJy8ATX8aJJ40sF5XSoVpy=X1ZTLj5qpthrTQ52fv40QNn7w@mail.gmail.com>
References: <1373607462-12836-1-git-send-email-pclouds@gmail.com> <20130713212541.GA10951@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 14 04:29:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UyC4H-00040A-FL
	for gcvg-git-2@plane.gmane.org; Sun, 14 Jul 2013 04:29:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752165Ab3GNC32 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 13 Jul 2013 22:29:28 -0400
Received: from mail-oa0-f53.google.com ([209.85.219.53]:32936 "EHLO
	mail-oa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752158Ab3GNC31 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 13 Jul 2013 22:29:27 -0400
Received: by mail-oa0-f53.google.com with SMTP id k14so14276442oag.40
        for <git@vger.kernel.org>; Sat, 13 Jul 2013 19:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=7nOTp63Lo/uIztNsKBs4SUPmLdX2WvTLza1Dk52jh/M=;
        b=RrwEdXxhq0Fp7UqbaIaJXB0j38+UOXsoilKR90hz2G87Y891SveiK3irEucO3JeFkk
         uqBf8w26OZtTFV+60GhoMGtwft3CQzzzg+9+F4X2dTLIYHgBoIz89dpzk9h8p2DTuDox
         8eGuTD9qrHZz+T83M+uLTcb8m9omHlLvAt/Mo8d9A1iRMZklhZVuFpQSPELedRl8yhgF
         AuD5LXWyGLxMQpiT/s39glgIFPzXaWX5n6fibdNpDNTfIsxGoF3G7oJepbE0orjLkZRp
         xqxC/ITMmFNFFIgPG2fa7+qt1XJVczZEoUl3RI6b7NB991zJCHzWv2fUkKjzHoeE+5oj
         4HUQ==
X-Received: by 10.60.47.41 with SMTP id a9mr39351027oen.78.1373768966436; Sat,
 13 Jul 2013 19:29:26 -0700 (PDT)
Received: by 10.76.88.230 with HTTP; Sat, 13 Jul 2013 19:28:55 -0700 (PDT)
In-Reply-To: <20130713212541.GA10951@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230298>

On Sun, Jul 14, 2013 at 4:25 AM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> Hi,
>
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
>
>> Since 52fed6e (receive-pack: check connectivity before concluding "g=
it
>> push" - 2011-09-02), receive-pack is prepared to deal with broken
>> push, a shallow push can't cause any corruption. Update the document
>> to reflect that.
>
> Hmm, what happens when pushing to servers without that commit?  Do yo=
u
> think it should be applied to Debian squeeze for server operators tha=
t
> haven't upgraded yet to the current stable release?

This is pushing _from_ a shallow repo, where the sender repo's old
objects is a subset of the receiver's. Such a push may be safe even
without the above commit, if I don't miss anything. The commit is in
case I do miss something.

The situation is different when we push _to_ a shallow repo. The
sender in this case may have more old objects than the receiver. The
sender may choose to not send such old objects in the push, not
knowing that the receiver does not have them due to its shallow
nature. So incomplete push and could only be caught be the commit
above.

I don't know about Debian porting strategy, but I think that commit
should be back ported to the stable release. There are more git
clients out there than just C Git and some of them may have bugs. The
commit should help protect the server against buggy clients. If you
back port it, do d21c463 (fetch/receive: remove over-pessimistic
connectivity check - 2012-03-15) too to avoid performance regression
in large pushes/fetches.

>
> [...]
>> --- a/Documentation/git-clone.txt
>> +++ b/Documentation/git-clone.txt
>> @@ -182,11 +182,13 @@ objects from the source repository into a pack=
 in the cloned repository.
>>  --depth <depth>::
>>       Create a 'shallow' clone with a history truncated to the
>>       specified number of revisions.  A shallow repository has a
>> -     number of limitations (you cannot clone or fetch from
>> -     it, nor push from nor into it), but is adequate if you
>> -     are only interested in the recent history of a large project
>> -     with a long history, and would want to send in fixes
>> -     as patches.
>> +     number of limitations (you cannot clone or fetch from it, nor
>> +     push into it), but is adequate if you are only interested in
>> +     the recent history of a large project with a long history.
>> ++
>> +Pushing from a shallow clone should be avoided if the git version o=
n
>> +the receiver end is older than v1.7.10, or any other git
>> +implementation that does not perform connectivity check.
>
> "git name-rev --tags" tells me 52fed6e was applied during 1.7.8-rc0,
> so it might make sense to s/1.7.10/1.7.8/ here.

Yeah! I thought "git tag --contains" output was sorted and did not
read past the first few tags. Need to implement version sort for
--tags, or at least commit date sort..

> Aside from that nit,
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
>
> Thanks,
> Jonathan
--
Duy
