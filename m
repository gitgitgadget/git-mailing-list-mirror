From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [Bug] git status -unormal -- 'foo[b]/' won't display content of 'foo[b]/
Date: Mon, 22 Sep 2014 20:01:44 +0700
Message-ID: <CACsJy8Dv9QxFyW32+vFQ+GE2QZyXHzoG-_ABMx3ARW=WSti2ng@mail.gmail.com>
References: <87vbogq293.dlv@gmail.com> <541F2C96.6050101@web.de> <CACsJy8AyUKKhsdij6HAf_G=+v5xhio2-KS7HGAGY-1kzOnhf2w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?Q?R=C3=A9mi_Vanicat?= <vanicat@debian.org>,
	git Maling list <git@vger.kernel.org>
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Mon Sep 22 15:02:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XW3G0-00062I-A9
	for gcvg-git-2@plane.gmane.org; Mon, 22 Sep 2014 15:02:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753994AbaIVNCP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 22 Sep 2014 09:02:15 -0400
Received: from mail-ig0-f180.google.com ([209.85.213.180]:35764 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753877AbaIVNCP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Sep 2014 09:02:15 -0400
Received: by mail-ig0-f180.google.com with SMTP id a13so2622921igq.1
        for <git@vger.kernel.org>; Mon, 22 Sep 2014 06:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=Tf12jfQkMS4paQKOz8RBraozLjme9+0gNoE2WqtRwbs=;
        b=XqVj3EwpE8U2H4L1v3s4DzWSHgsrzT8XMf8Len8KB/j0YVExKVOsC79Fk4b+489Bpj
         d4VfeHfVPmZ8Bsnr4cL+x0WOkKg6i76WH/VKx8n0Jz8p8w1kh0lypS/16oZLKh7oplWS
         z0ihtvsCMcHYEJCFya7E+bdK5iMis9904WEFdSZt+hLxl7Q2+h2rjL+bOofpJG21TX6p
         6hosGOyKBH4kXdYlLSktXplXqhGdIP+pbApJZkqdCTZ451/riBcPnA5lhMyR4YXxlAcl
         vG4rmP6OQaEI8NueucYI/b+2+K0HCEet+yqwLEiTHzODHsU8V0jb+F3jEuFsKwxmNyUR
         +lsA==
X-Received: by 10.51.17.66 with SMTP id gc2mr14464869igd.40.1411390934540;
 Mon, 22 Sep 2014 06:02:14 -0700 (PDT)
Received: by 10.107.131.150 with HTTP; Mon, 22 Sep 2014 06:01:44 -0700 (PDT)
In-Reply-To: <CACsJy8AyUKKhsdij6HAf_G=+v5xhio2-KS7HGAGY-1kzOnhf2w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257362>

On Mon, Sep 22, 2014 at 8:24 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Mon, Sep 22, 2014 at 2:52 AM, Torsten B=C3=B6gershausen <tboegi@we=
b.de> wrote:
>> git status takes a "pathspec" as a parameter, which is not the same =
as a filename.
>> A pathspec can contain wildcards like '*' or '?' or things like "*[c=
h]".
>> This is known as shell glob syntax (or so), and used automatically b=
y all shells.
>>
>> Git allows to use "git add *.[ch]" (where the shell expands the glob=
) or
>> "git add '*.[ch]'" where Git does the expansion.
>
> From the top of my head, pathspec should match as if it's literal
> string too. Not sure if it applies to this case. I'll check later..

=46WIW the "problem" is in dir.c, function common_prefix_len(). We use
this one to determine a shared parent directory, e.g. foo/bar and
foo/baarr share "foo/", so that we could start looking for untracked
files from "foo" instead of ".". The shared directory search only
cares about non-wildcard letters. So in the case of "foo/" it finds
the "shared" dir "foo", but in "foo[b]/" it stops at '[' and decides
the shared dir is ".".

But this difference should not lead to any differences in output
because that's more about traversal optimization. But somehow we treat
the first directory different than subdirs. If a subdir is entirely
untracked/ignored, we show "subdir/" (with -unormal) but if it's the
first examined directory then we show everything inside. This is
something we should fix if you guys really depend on a consistent
behavior. But if it's fixed, then "foo/" case above would show "foo/"
not "foo/bar". Or just call it a quirk of -unormal and magit should
use -uall instead.
--=20
Duy
