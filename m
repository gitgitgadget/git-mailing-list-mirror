From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [RFC] Speed up "git status" by caching untracked file info
Date: Fri, 18 Apr 2014 06:27:44 +0700
Message-ID: <CACsJy8BrPZ8LDwN5cK9MgBcbtP0rK-TZ3wo=Jpc0V9YyaSyuXg@mail.gmail.com>
References: <1397713918-22829-1-git-send-email-pclouds@gmail.com> <xmqqy4z3d9t0.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 18 01:28:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WavjC-0005aX-Cn
	for gcvg-git-2@plane.gmane.org; Fri, 18 Apr 2014 01:28:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751177AbaDQX2S convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Apr 2014 19:28:18 -0400
Received: from mail-qg0-f47.google.com ([209.85.192.47]:46104 "EHLO
	mail-qg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750736AbaDQX2P convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Apr 2014 19:28:15 -0400
Received: by mail-qg0-f47.google.com with SMTP id i50so1110513qgf.34
        for <git@vger.kernel.org>; Thu, 17 Apr 2014 16:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=xNDf1A1h2NdAvdpYLcZ7IQXxZxRiLmgo+VBuGF3aNCA=;
        b=o9vu0zznydKxIstncR6CCuDO0s4X0nG47PF8hl/9gXnXEWTDA46KRP63hxkZJh0iU6
         uezJ/4C7f665T5N+O3SHREpBM6ihAF7+GaQoQr7mgDOTXFlwkTZDAii1EMiS/KV04uYO
         sJU55eN0ZSWVrOK5pupFik8fuWJWx/jfuh7+DoFT3Gk0ow9T9I7u4cAPVoYtPKavpDnw
         08s15NoHORWklZ4ZHwCrLW/kx7qzdslY6knwvNfqbNDuCHSkrUxolyYFeaq1rlRshIcj
         ZH1Z7WOPhKiyJvNIVF/lf6Lt7FE4EYBKdQtS+2ImsGn9huZr0IK8YSRT9DwBfuUbt5+B
         VMfQ==
X-Received: by 10.224.36.129 with SMTP id t1mr13940800qad.88.1397777295027;
 Thu, 17 Apr 2014 16:28:15 -0700 (PDT)
Received: by 10.96.138.9 with HTTP; Thu, 17 Apr 2014 16:27:44 -0700 (PDT)
In-Reply-To: <xmqqy4z3d9t0.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246459>

On Fri, Apr 18, 2014 at 2:40 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes=
:
>
>>            first run  second (cached) run
>> gentoo-x86    500 ms             71.6  ms
>> wine          140 ms              9.72 ms
>> webkit        125 ms              6.88 ms
>> linux-2.6     106 ms             16.2  ms
>>
>> Basically untracked time is cut to one tenth in the best case
>> scenario. The final numbers would be a bit higher because I haven't
>> stored or read the cache from index yet. Real commit message follows=
=2E.
>
> As you allude to later with "if you recompile a single file, the
> whole hierarchy in that directory is lost", two back-to-back runs of
> "git status" is not very interesting.

No, if you recompile in directory A, then we need to recompute exclude
files for A only, not A/B, A/B/C... We only need to invalidate the
whole hierarchy when A/.gitignore (or worse $GIT_DIR/info/exclude) is
changed.

>> The second one can be hooked from read-cache.c. Whenever a file (or =
a
>> submodule) is added or removed from a directory, we invalidate that
>> directory. This will be done in a later patch.
>
> I would imagine that it would be done at the same places as we
> invalidate cache-trees, with the same "invalidation percolates up"
> logic.

Yep yep.

>> On subsequent runs, read_directory_recursive() reads stat info of th=
e
>> directory in question and verifies if files/dirs have been added or
>> removed.
>
> Hmph.  If you have a two-level hierarchy D1/D2 and you change the
> list of crufts in D2 but not in D1, the mtime of D1/D2 changes but
> not the mtime of D1, as you observed below.
>
>> With the help of prep_exclude() to verify .gitignore chain,
>> it may decide "all is well" and enable the fast path in
>> treat_path(). read_directory_recursive() is still called for
>> subdirectories even in fast path, because a directory mtime does not
>> cover all subdirs recursively.
>
> I wonder if you can avoid recursing into D1 when no cached mtime
> (and .gitignore) information has changed in any subdirectory of it
> (e.g. both D1 and D1/D2 match the cache).

The problem if when we need to decide to recurse into D1, we have no
idea if any of its subdirs is changed. So we need to recurse in anyway
(at least in the cache; if D1 is unchanged, we will not try to
opendir() it, just get the exclude list from the cache and move on).
--=20
Duy
