From: John Szakmeister <john@szakmeister.net>
Subject: Re: Bug on OS X...
Date: Fri, 28 Jun 2013 09:51:05 -0400
Message-ID: <CAEBDL5V3eAJGs-CTVZd8wVxKV3b+Gbk26E1rFaKjk-xBhSu31Q@mail.gmail.com>
References: <CAEBDL5VeE7dyo_A7904SBNSvf834xdGyyuk=vE44wXoRVJ-nkg@mail.gmail.com>
	<9DD46E0F-FA9C-4C60-A1CE-03EAAD823967@quendi.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Max Horn <max@quendi.de>
X-From: git-owner@vger.kernel.org Fri Jun 28 15:51:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UsZ51-0000A9-VM
	for gcvg-git-2@plane.gmane.org; Fri, 28 Jun 2013 15:51:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754134Ab3F1NvK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 28 Jun 2013 09:51:10 -0400
Received: from mail-wg0-f46.google.com ([74.125.82.46]:61905 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751313Ab3F1NvI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Jun 2013 09:51:08 -0400
Received: by mail-wg0-f46.google.com with SMTP id c11so1593593wgh.1
        for <git@vger.kernel.org>; Fri, 28 Jun 2013 06:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=veWTmjJ1DZjgWKAcNojz08qRv6jP9E80FfzFQhOz2Ng=;
        b=zvUfg3eWRSQLxa/hACbEqAK0qbp9/zx1o8qzmKToMU0TMMTCWhVf93mBzCBfClArd5
         5so6TTYMj7uzsyhbimAcbWdj9sCjFCv8t1Uh3fcI488GfOxahxgsRtseSg4KYSkihsHL
         AoNJuHsOHcHGznrMBDs/x2Yn4bbgGYPoWNvSFHL6j3TImzS17QFUve6pSJDo4C26fMmS
         ryRNzbiwBbxqDX/yh2J6bma0bxlmqyLVIIPTeS6o7ua26TP75sjfyoL1fpqQuPHz6yem
         Ix8qvnVe6xjQAhWde9YvNLzwE8Mg5OfhKt8k0x8fiIg418vA3Lhp/dJ4dlckH4AFWLYD
         FBdw==
X-Received: by 10.194.103.73 with SMTP id fu9mr9854277wjb.70.1372427465360;
 Fri, 28 Jun 2013 06:51:05 -0700 (PDT)
Received: by 10.180.144.37 with HTTP; Fri, 28 Jun 2013 06:51:05 -0700 (PDT)
In-Reply-To: <9DD46E0F-FA9C-4C60-A1CE-03EAAD823967@quendi.de>
X-Google-Sender-Auth: M-nYYACbD_59m_uBTnhD4oy-jhE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229198>

On Fri, Jun 28, 2013 at 8:44 AM, Max Horn <max@quendi.de> wrote:
[snip]
> I am unable to reproduce this on Mac OS X 10.7.5 with git 1.8.3.1 nor=
 with current git maint. Command run inside /tmp, which is on a normal =
HFS+ volume (using the default settings, i.e. the FS is case insensitiv=
e).
>
>
> $ git --version
> git version 1.8.3.1.42.ge2652c0
> $ git clone --depth 1 git://nbd.name/packages.git
> Cloning into 'packages'...
> remote: Counting objects: 4711, done.
> remote: Compressing objects: 100% (3998/3998), done.
> remote: Total 4711 (delta 157), reused 3326 (delta 94)
> Receiving objects: 100% (4711/4711), 3.85 MiB | 0 bytes/s, done.
> Resolving deltas: 100% (157/157), done.

OK, so I finally tracked it down.  Commit
6035d6aad8ca11954c0d7821f6f3e7c047039c8f fixes it:

    commit 6035d6aad8ca11954c0d7821f6f3e7c047039c8f
    Author: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.co=
m>
    Date:   Sun May 26 08:16:15 2013 +0700

        fetch-pack: prepare updated shallow file before fetching the pa=
ck

        index-pack --strict looks up and follows parent commits. If sha=
llow
        information is not ready by the time index-pack is run, index-p=
ack may
        be led to non-existent objects. Make fetch-pack save shallow fi=
le to
        disk before invoking index-pack.

        git learns new global option --shallow-file to pass on the alte=
rnate
        shallow file path. Undocumented (and not even support --shallow=
-file=3D
        syntax) because it's unlikely to be used again elsewhere.

        Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclou=
ds@gmail.com>
        Signed-off-by: Junio C Hamano <gitster@pobox.com>

It looks like I was hitting the race condition.  It's fixed on master,
so I assume it will be in 1.8.3.2.

Thanks for taking a look though!

-John
