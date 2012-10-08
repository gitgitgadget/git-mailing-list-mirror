From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 04/10] attr: more matching optimizations from .gitignore
Date: Mon, 8 Oct 2012 10:26:35 +0700
Message-ID: <CACsJy8DhymVp1ncHvtqd4S7TkBDQvNKBf3A0JTft9bX8_-WX_w@mail.gmail.com>
References: <1349412069-627-1-git-send-email-pclouds@gmail.com>
 <1349412069-627-5-git-send-email-pclouds@gmail.com> <7vy5jku549.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 08 05:27:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TL3zy-0006FK-H7
	for gcvg-git-2@plane.gmane.org; Mon, 08 Oct 2012 05:27:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752229Ab2JHD1I convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 7 Oct 2012 23:27:08 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:35580 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751477Ab2JHD1H convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 7 Oct 2012 23:27:07 -0400
Received: by mail-ie0-f174.google.com with SMTP id k13so8153123iea.19
        for <git@vger.kernel.org>; Sun, 07 Oct 2012 20:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=mv52Sq0cOME4HrT4FpbCeMgdqZ0iEgAGbVKW9fcNL2Y=;
        b=FgyFnCQtFI5bG+DsDh41ih4f94J8xwmT3XibLhiELpoz7NqSerkWhjWNTzHJuwRGIW
         baVZpJECeLZM+LRyv5GVeSvF8Hv86t1N818Ryh/34nkYRWVTeKLzcdTLkakwjhGPUZhe
         j6EZAeRZ2kRlesH7qjTGz/vHW8pa12MGGMOTBvz8/qOUYnRFtf2qzva/X4Z40UWAIxjJ
         2x96R3QhP3/MHdAQkmtsAdj4Kc+wx+kihW0Jg337oFHYS4YmwnYGgv7uK4IO033/LZFw
         vbslTQ9zmbDbYPTg6WokMOCpZ7j935gDVJOLqE3DLQuC5YOjwnUTgtUT0JvzP3GPVGav
         ngTQ==
Received: by 10.50.153.130 with SMTP id vg2mr4701203igb.26.1349666825844; Sun,
 07 Oct 2012 20:27:05 -0700 (PDT)
Received: by 10.64.143.168 with HTTP; Sun, 7 Oct 2012 20:26:35 -0700 (PDT)
In-Reply-To: <7vy5jku549.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207221>

On Sat, Oct 6, 2012 at 1:48 AM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:
>
>> +Unlike `.gitignore`, negative patterns are not supported.
>> +Patterns that match directories are also not supported.
>
> Is "are not supported" the right phrasing?
>
> I think it makes perfect sense not to forbid "!path attr1", because
> it is unclear what it means (e.g. "path -attr1" vs "path !attr1").
> So I would say "Negative patterns are forbidden as they do not make
> any sense".

!path/sub/ alone does not mean anything. It must be used together with
a positive pattern to define the set of paths the same attribute
assignment statement applies to. This makes sense (attr, -attr1 or
!attr1 are all OK):

*.c attr1
!foo.c attr1

But this does not (actually "!foo.c" line has no effects because of
different attribute assignments):

*.c attr1
!foo.c attr2

It could be even more confusing in multiple attribute manipulation:

*.c attr1
*.h -attr2
!foo.[ch] attr1 -attr2

So "not supported" and "forbidden" are equally OK. I just want to
raise a point that it has some use before we go for "forbidden".

> Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:
>
>> On Sat, Oct 6, 2012 at 12:36 PM, Junio C Hamano <gitster@pobox.com> =
wrote:
>>>> Or the user might think "path/ attr1" sets attr1 for all files und=
er
>>>> "path/" because it does not make sense to attach attributes to a
>>>> directory in git.
>>>
>>>    ...
>>>
>>>    We may not have a need to assign a real attribute to a directory
>>>    right now, because nothing in Git asks for an attribute for a
>>>    directory. But that does not necessarily mean we would never nee=
d a
>>>    way to give an attribute to a directory but not to its contents.
>>
>> Exactly why we should not make "path/ attr" no-op. If we want to mak=
e
>> it meaningful some day in future, I don't think we want those no-ops
>> lay around and suddenly cause changes in behavior with a new version
>> of git.
>
> I do not think you understood.  "path/ attr" is a no-op from the
> point of view of the *users* of the current versions of Git.  It is
> perfectly fine to accept and apply attr to "path/"; no codepath in
> Git should be asking about path/ anyway, so it ends up to be a
> no-op.  You shouldn't be erroring out at the syntactic level, i.e.
> when these lines are parsed.

My objection is no-op lines are timed bombs. But users can already do
"dir attr" (no slashes), which is no-op. So yeah, no-op is fine.
--=20
Duy
