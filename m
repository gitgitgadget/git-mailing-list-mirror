From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v4 2/2] version-gen: fix versions
Date: Mon, 14 Oct 2013 00:29:23 -0500
Message-ID: <CAMP44s3PfRVV5V4=iddR2AOdnqhOt5oi8Wx9nS=2x=z_kN2wjw@mail.gmail.com>
References: <1381561628-20665-1-git-send-email-felipe.contreras@gmail.com>
	<1381561628-20665-3-git-send-email-felipe.contreras@gmail.com>
	<CAJDDKr5K0UjcbhUpAjHjGcEk6=E2+cAVC8-RpxY+C1atSVj-Tg@mail.gmail.com>
	<20131014050104.GA25344@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: David Aguilar <davvid@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 14 07:29:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VVaif-0002IO-NW
	for gcvg-git-2@plane.gmane.org; Mon, 14 Oct 2013 07:29:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751441Ab3JNF30 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Oct 2013 01:29:26 -0400
Received: from mail-la0-f53.google.com ([209.85.215.53]:48590 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750806Ab3JNF3Z (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Oct 2013 01:29:25 -0400
Received: by mail-la0-f53.google.com with SMTP id el20so5160341lab.26
        for <git@vger.kernel.org>; Sun, 13 Oct 2013 22:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=lema+kc6uBN53JlRTzeJ016YSlHHrWqP48x2VHCqSH8=;
        b=t6izvdlkOKBu4is8881Jqu8bWl7Utf7jvfcTdkgzblmyiuN0IFFYojaB8RyjT3m0Tc
         CSqCPD5FS7DtGgqtvmRqd/UB0fno+rybviKTskXcfmbF+vRuWV/47oi/XvdCLv2c211l
         YnhstUjcTUO/T6NiZIDQEtL58qOrHyT9QyNwwxNvPm/zH2vhpD79vTr5Qg96YG2+n/vm
         mKLQa26HJwgGmsfcMVnEZvmzqdqPFfZdcXHPGSoZHdDYtOOLSYhLgDZ/moK1AolHTgkx
         XHffH9OUVaU6D0L/MhFHLGrvMqe3HXU/ErNTTCU/KgqBr2+0jtmiB7WOJTKj3woOwzQT
         LbMQ==
X-Received: by 10.152.171.72 with SMTP id as8mr294455lac.33.1381728563598;
 Sun, 13 Oct 2013 22:29:23 -0700 (PDT)
Received: by 10.114.91.230 with HTTP; Sun, 13 Oct 2013 22:29:23 -0700 (PDT)
In-Reply-To: <20131014050104.GA25344@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236094>

On Mon, Oct 14, 2013 at 12:01 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Hi,
>
> David Aguilar wrote:
>> Felipe Contreras <felipe.contreras@gmail.com> wrote:
>
>>> Virtually all packaging guidelines would prefer 1.8.4~rc1, over
>>> 1.8.4.rc1 or 1.8.4-rc1, so it makes sense to use that instead.
>>>
>>> In particular, the only packaging we provide, git.spec, generates a
>>> wrong version, because git-1.8.4 < git-1.8.4.rc1, changing to ~rc1 fixes
>>> the problem as it's considered newer.
>
> A more conservative fix would be to tweak the .spec generation in the
> Makefile to follow whatever the appropriate Red Hat convention is.
> For example, something like this:

It's not Red Hat's convention, it's RPM, and dpkg, so basically every
package manager that most distributions out there use.

And I already sent a patch for that which was ignored:

http://article.gmane.org/gmane.comp.version-control.git/234794

> -- >8 --
> diff --git i/Makefile w/Makefile
> index 0f931a2..73bd89d 100644
> --- i/Makefile
> +++ w/Makefile
> @@ -2385,8 +2385,9 @@ quick-install-html:
>
>  ### Maintainer's dist rules
>
> +GIT_VERSION_RPM = $(subst -rc,~rc,$(GIT_VERSION))

That wouldn't work; VERSION doesn't have '-rc', it has '.rc'. and
what's the point of creating a new variable? It's a was of space.

>  git.spec: git.spec.in GIT-VERSION-FILE
> -       sed -e 's/@@VERSION@@/$(GIT_VERSION)/g' < $< > $@+
> +       sed -e 's/@@VERSION@@/$(GIT_VERSION_RPM)/g' < $< > $@+
>         mv $@+ $@
>
>  GIT_TARNAME = git-$(GIT_VERSION)
> -- 8< --
>
> That way, programs that parse the git version by splitting at '.'
> (there are more than a few, unfortunately) would continue to work,

Do you have any evidence that such programs exist? Specifically,
programs that work with 1.8.4.rc1, but not 1.8.4-rc1 or 1.8.4~rc1. I
find that very very very unlikely.

Anyway, in the very very very unlikely scenario that somebody's script
does break they can report that, and we can revert. What's the
problem?

> but
> the packaging system would get the benefit of the proposed versioning
> style change.
>
>>> The same happens in dpkg.
>
> Have you tested this?

% dpkg --compare-versions 1.8.4 gt 1.8.4~rc1 && echo yes || echo no
yes
 % dpkg --compare-versions 1.8.4 gt 1.8.4-rc1 && echo yes || echo no
no

> I thought the Debian packaging did not use the
> GIT-VERSION-GEN generated version in this way.

It doesn't matter. The name of the package would be git-1.8.4~rc1, and
'git --version' would return 1.8.4.rc1, that's inconsistent.

Why be inconsistent when we can be consistent?

> [...]
>> This seems related:
>>
>> http://lintian.debian.org/tags/rc-version-greater-than-expected-version.html
>
> If I understand correctly, that page has an exhaustive list of affected
> packages in the Debian archive and doesn't include git.

Because a) they don't package release candidates, and b) they use a
different version (s/\./~/).

-- 
Felipe Contreras
