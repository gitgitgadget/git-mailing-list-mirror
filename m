From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 2/3] format-patch: pick up branch description when no ref
 is specified
Date: Wed, 2 Jan 2013 08:25:55 +0700
Message-ID: <CACsJy8C_rpJrfZLESB8dva4RXrVgcf_Fsnv3zkTw=rhN0JOGog@mail.gmail.com>
References: <1357032655-21103-1-git-send-email-pclouds@gmail.com>
 <1357032655-21103-2-git-send-email-pclouds@gmail.com> <7v38ykbpv3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 02 02:29:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TqD9S-0001tw-0s
	for gcvg-git-2@plane.gmane.org; Wed, 02 Jan 2013 02:29:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752233Ab3ABB02 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Jan 2013 20:26:28 -0500
Received: from mail-oa0-f42.google.com ([209.85.219.42]:55524 "EHLO
	mail-oa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751794Ab3ABB00 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Jan 2013 20:26:26 -0500
Received: by mail-oa0-f42.google.com with SMTP id j1so12670332oag.15
        for <git@vger.kernel.org>; Tue, 01 Jan 2013 17:26:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=mGQh328g8RdREc5Zh242kzSYJWI0UcLLJT+TCv/FZxs=;
        b=YHGaVqRGVxRw6ZiFK4gRhXzrUk9hLCix1zGv7wvT/5P7bBSWZ0d/pKA7Md/UovFWUq
         kGRQmAQc37f6dgbDqz0dez06qIDeeWwNGRBWY2dpZ8yRYU0rI7fJirxV2+mpYAyLcZp+
         6XXYq66pWTZ5pPPm68lqcz2WkZ+NzkWv+j7u8ttRXAUO26Kv8v1y1+sQ6u2uoI73Mxnl
         UheUZTtH4cjxpa9ASnQG+R3tXg52bXptz+7RPXDlsReuamYDcDgWfdbze9ffIMx79mwl
         ytE4fFexfRicpkV2oTGCkK6LEpLN7DExvJzdlOQZauPX0iyfr5QuwC6wixKCcnjgiwtV
         GPgw==
Received: by 10.182.207.8 with SMTP id ls8mr33740069obc.65.1357089985929; Tue,
 01 Jan 2013 17:26:25 -0800 (PST)
Received: by 10.182.27.168 with HTTP; Tue, 1 Jan 2013 17:25:55 -0800 (PST)
In-Reply-To: <7v38ykbpv3.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212482>

On Wed, Jan 2, 2013 at 3:38 AM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes=
:
>
>> find_branch_name() fails to detect "format-patch --cover-letter -3"
>> where no command line arguments are given and HEAD is automatically
>> added.
>
> Nicely spotted.
>
> That is not the only case that takes this codepath, though.
>
>     $ git format-patch --cover-letter master..
>
> will also give you the same (if you say it without "..", which is
> the more normal invocation of the command, then the caller already
> know you meant the current branch and this function is not called).
>
> And in that case you will have two tokens on cmdline.nr, one for
> "master.."  to show where he bottom is, and the other for the
> implied "HEAD";

Interesting. find_brach_name() handles this case wrong because
rev->cmdline[positive].name is "HEAD" and it goes ahead prepending
"refs/heads/" anyway. I'll fix it in the reroll. I was avoiding tests
with an excuse that you did not write tests when you added this
function either. But with this change, I think tests are required.

> I do not think this patch is a sufficient solution
> for the more general cases, but on the other hand I do not know how
> much it matters.

I think the best place to handle this is setup_revisions() for general
cases. But we do not need branch detection anywhere else yet, I guess
it's ok to fix it case by case here. We can move the code back to
revisions.c when there are more use cases for it.

>> -     if (positive < 0)
>> +     if (positive < 0) {
>> +             /*
>> +              * No actual ref from command line, but "HEAD" from
>> +              * rev->def was added in setup_revisions()
>> +              * e.g. format-patch --cover-letter -12
>> +              */
>
> That comment does not describe "positive < 0" case, but belongs to
> the conditional added in this patch, no?

It's meant as the comment for the following block, yes. I'll move it
into the block for clarity.

>> +             if (!rev->cmdline.nr &&
>> +                 rev->pending.nr =3D=3D 1 &&
>> +                 !strcmp(rev->pending.objects[0].name, "HEAD")) {
>> +                     const char *ref;
>> +                     ref =3D resolve_ref_unsafe("HEAD", branch_sha1=
, 1, NULL);
>> +                     if (ref && !prefixcmp(ref, "refs/heads/"))
>> +                             return xstrdup(ref + strlen("refs/head=
s/"));
>> +             }
>>               return NULL;
>> +     }
>>       strbuf_addf(&buf, "refs/heads/%s", rev->cmdline.rev[positive].=
name);
>>       branch =3D resolve_ref_unsafe(buf.buf, branch_sha1, 1, NULL);
>>       if (!branch ||
--=20
Duy
