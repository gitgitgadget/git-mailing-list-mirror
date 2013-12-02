From: Amit Bakshi <ambakshi@gmail.com>
Subject: [BUG] Core dump w/ bus error on bad mmap'd packfile
Date: Mon, 2 Dec 2013 14:20:08 -0800
Message-ID: <CAFGOX=WsGqmgxps64mWKPJ_Anj0tNTz8nQwpyDOpfCVQ_5HXow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 02 23:20:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vnbqw-0005Zg-Mu
	for gcvg-git-2@plane.gmane.org; Mon, 02 Dec 2013 23:20:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753977Ab3LBWUK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Dec 2013 17:20:10 -0500
Received: from mail-pb0-f42.google.com ([209.85.160.42]:54706 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753039Ab3LBWUI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Dec 2013 17:20:08 -0500
Received: by mail-pb0-f42.google.com with SMTP id uo5so19986764pbc.15
        for <git@vger.kernel.org>; Mon, 02 Dec 2013 14:20:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=7cbFpPlWsBn/VqEIB8idA+A7Jw24tw5/Bg0RXm0PxwE=;
        b=TTSEDboPljmRHhZiG3Ac9Hez34nW8rpP5qUPtPwysEBptpxbPyHsdF5yjl1GyzRGQJ
         kvsvLE8UQeMJqj64h8/BOyncXLyRy2g7XsAafMnfHHh7Mhs9+e0VfuvLDlbEd5HjAUUE
         KHIGrTvFdrFWommzGaI/aFYUj8U6NL2/IgS0DlVoAsMZGhzoZ/dfI5UYvyGzBsz9Iuhq
         e2EBDXSdxUnkxVZj7+7JJnXpkPzd1iNG/gfwcdknuAQYD6DLR37oB3UfgG5+EXnv/Rkt
         fyuigDifBg0piQBdZMqGKuUIHl6mz31JaMXB7QDzI24pPfJfBSr6EXYUaz00NGt2e3RR
         qJew==
X-Received: by 10.68.170.225 with SMTP id ap1mr34302580pbc.117.1386022808096;
 Mon, 02 Dec 2013 14:20:08 -0800 (PST)
Received: by 10.70.35.140 with HTTP; Mon, 2 Dec 2013 14:20:08 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238657>

Hi,

 I was getting core dumps (bus error 7) with git 1.7.1 when doing a
git checkout. I tried git fsck, and same thing. I got the same with
precompiled rpms of 1.7.12, and with a locally compiled version of git
1.8.5.

 The simplest/quickest repro I got is using git-fsck. The stacktrace
blames SHA1_Update in verify_packfile. Upon further investigation all
the in/offsets/remaining seemed ok. I traced it to a 17mb packfile
that gets an i/o error when attempting to read it past 13mb.  It looks
like it's xmmap'ing the file and passing that pointer to
SHA1_Update(). I don't know why in some paths it gives an i/o error
and in other paths it segfaults (I added the extra debug output to
git-fsck).

$ git fsck
Checking pack-0ccb5ee4f60003a7ea47d6904633cce5973efa60.pack
in: 0x7f9070507000 remain: 17345210 offset: 17345230
Bus error (core dumped)

git verify-pack correctly shows the error, without a bus error.

$ git verify-pack -v pack-0ccb5ee4f60003a7ea47d6904633cce5973efa60.pack
fatal: read error on input: Input/output error
pack-0ccb5ee4f60003a7ea47d6904633cce5973efa60.pack: bad

Not sure what the right solution is without impacting perf, but it
took me a while to track down and having an error message indicating
the bad file would've been a great help.

Amit
