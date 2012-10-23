From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: The config include mechanism doesn't allow for overwriting
Date: Tue, 23 Oct 2012 16:13:44 +0200
Message-ID: <CACBZZX5mOb7_i9r8AqNK5V3r-gVnzN+rkeY9xrhecGv1rS-anA@mail.gmail.com>
References: <CACBZZX4cu9XuS5AtduWrNeXNUeZ4rqDUzRdmyz2b3cXtmo1nqQ@mail.gmail.com>
 <20121022211505.GA3301@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Oct 23 16:14:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TQfFM-0006u5-Cb
	for gcvg-git-2@plane.gmane.org; Tue, 23 Oct 2012 16:14:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753540Ab2JWOOI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Oct 2012 10:14:08 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:47326 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751836Ab2JWOOF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Oct 2012 10:14:05 -0400
Received: by mail-oa0-f46.google.com with SMTP id h16so3572104oag.19
        for <git@vger.kernel.org>; Tue, 23 Oct 2012 07:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=o8+1wRK9C4XZ0kv8y/x4iwJb03xDNHtRQZz/1FKSj2g=;
        b=nuKHMJKH2QUAhhRypdJaAFXjlv/EADy+zXVbxEXUk9V1NQagbO+4exEA/5mWDcGoeF
         rySu/F1QD3qH119GYxLMduEfIUem/xlH4DiQ9YqxerSF6lhXaI1aNZizA3wvymBSk6Cl
         QOTGWycJpI5XRfPXjK7R78f5mYljUfJKg94Yx/ht6j2BPLGaZMDzeiFJzwgdeSE8VYAn
         E9c9fiP/IBv9uS044t4Z321EyYyGmwZbr+czdePu4Fcp6t5R78N70r7O4GLglC0Ih/Q0
         +0FTnzCOuXT04wv0hiZGk/5xqIaif/wBQjjRQOLvGIuCJWWt+rzhSWccWZB/1yOB0+lQ
         kN0A==
Received: by 10.182.124.102 with SMTP id mh6mr9927851obb.48.1351001645157;
 Tue, 23 Oct 2012 07:14:05 -0700 (PDT)
Received: by 10.60.94.225 with HTTP; Tue, 23 Oct 2012 07:13:44 -0700 (PDT)
In-Reply-To: <20121022211505.GA3301@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208229>

On Mon, Oct 22, 2012 at 11:15 PM, Jeff King <peff@peff.net> wrote:
> On Mon, Oct 22, 2012 at 05:55:00PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0=
 Bjarmason wrote:
>
>> I was hoping to write something like this:
>>
>>     [user]
>>         name =3D Luser
>>         email =3D some-default@example.com
>>     [include]
>>         path =3D ~/.gitconfig.d/user-email
>>
>> Where that file would contain:
>>
>>     [user]
>>         email =3D local-email@example.com
>
> The intent is that it would work as you expect, and produce
> local-email@example.com.
>
>> But when you do that git prints:
>>
>>     $ git config --get user.email
>>      some-default@example.com
>>      error: More than one value for the key user.email: local-email@=
example.com
>
> Ugh. The config code just feeds all the values sequentially to the
> callback. The normal callbacks within git will overwrite old values,
> whether from earlier in the file, from a file with lower priority (e.=
g.,
> /etc/gitconfig versus ~/.gitconfig), or from an earlier included. Whi=
ch
> you can check with:
>
>   $ git var GIT_AUTHOR_IDENT
>   Luser <local-email@example.com> 1350936694 -0400
>
> But git-config takes it upon itself to detect duplicates in its
> callback. Which is just silly, since it is not something that regular
> git would do. git-config should behave as much like the internal git
> parser as possible.
>
>> I think config inclusion is much less useful when you can't clobber
>> previously assigned values.
>
> Agreed. But I think the bug is in git-config, not in the include
> mechanism. I think I'd like to do something like the patch below, whi=
ch
> just reuses the regular config code for git-config, collects the valu=
es,
> and then reports them. It does mean we use a little more memory (for =
the
> sake of simplicity, we store values instead of streaming them out), b=
ut
> the code is much shorter, less confusing, and automatically matches w=
hat
> regular git_config() does.
>
> It fails a few tests in t1300, but it looks like those tests are test=
ing
> for the behavior we have identified as wrong, and should be fixed.

I think this patch looks good.

One other thing I think is worth clarifying (and I think should be
broken) is if you write a configuration like:

    [foo]
        bar =3D one
    [foo]
        bar =3D two
    [foo]
        bar =3D three

"git-{config,var} -l" will both give you:

    foo.bar=3Done
    foo.bar=3Dtwo
    foo.bar=3Dthree

And git config --get foo.bar will give you:

    $ git config -f /tmp/test --get foo.bar
    one
    error: More than one value for the key foo.bar: two
    error: More than one value for the key foo.bar: three

I think that it would be better if the config mechanism just silently
overwrote keys that clobbered earlier keys like your patch does.

But in addition can we simplify things for the consumers of
"git-{config,var} -l" by only printing:

    foo.bar=3Dthree

Or are there too many variables like "include.path" that can
legitimately appear more than once.
