From: Shawn Pearce <spearce@spearce.org>
Subject: Using bitmaps to accelerate fetch and clone
Date: Wed, 26 Sep 2012 17:47:47 -0700
Message-ID: <CAJo=hJstK1tGrWhtBt3s+R1a6C0ge3wMtJnoo43Fjfg5A57eVw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Colby Ranger <cranger@google.com>
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Sep 27 02:48:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TH2HZ-0000I3-Vk
	for gcvg-git-2@plane.gmane.org; Thu, 27 Sep 2012 02:48:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752947Ab2I0AsJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Sep 2012 20:48:09 -0400
Received: from mail-qa0-f46.google.com ([209.85.216.46]:49863 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752845Ab2I0AsI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Sep 2012 20:48:08 -0400
Received: by qadc26 with SMTP id c26so3417073qad.19
        for <git@vger.kernel.org>; Wed, 26 Sep 2012 17:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc:content-type;
        bh=XPzv6aYp2Uy8IuEeQq7jUB1FmPjQnFHdbJxMGf3fVi0=;
        b=J9QnjdN8vRj+0dRrXrTi0WM3wNjZvMmP22ElbWjtZR5rmPOELIZzk9TXoG8bdGBJnL
         MbNyn+kmIpEwLnPCAKL/1JZAeFTBrfwyZa9V9yKzZFozjC5YaxN6HKxSrzbJnRYILGvO
         yo3FYhkdFUVZfoc0c4kxZD840o0raOHsaLiUw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:cc:content-type
         :x-gm-message-state;
        bh=XPzv6aYp2Uy8IuEeQq7jUB1FmPjQnFHdbJxMGf3fVi0=;
        b=Rm71V6XD+0rHcXICjqqzda2kLmV0a39UI15hYW/Z32M9ZjuQ2Xr8PQRPw1FRzkWsvG
         m/6TF2JJ8BWZFGMvaJLcQLJGW4BdxkEGd5bf83wgnd3YTtSLF8H2sGBOGIcZKOd+BPCN
         GfKL8SXbEmV8lFCT80dBGotQaZhXK2alwOPkpLdk0oy3VrA6qW2tl2c2av00gRu5OIo3
         0GfDzZu061JRBEz7pvGs7odC3u8bf9zCpV2cwqGPXLHHW3g4qa60ye2DA2HB44BcW3sM
         GAkJMCcRc4SNjNeQDmtAKN2NPSUOzMsrvaMI53iJvbIE5msTTHyZRn/Hbu4cZ+Kvs/aK
         nm5Q==
Received: by 10.229.136.84 with SMTP id q20mr1519722qct.80.1348706887501; Wed,
 26 Sep 2012 17:48:07 -0700 (PDT)
Received: by 10.49.35.75 with HTTP; Wed, 26 Sep 2012 17:47:47 -0700 (PDT)
X-Gm-Message-State: ALoCoQlwH8lIV7wC4WrxZ5/jvf9Dcm6xnHBHesN6xm/5notaZtZzf6qfpiYSjb+CdUGZE5+krw+H
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206457>

Google has published a series of patches (see links below) to JGit to
improve fetch and clone performance by adding compressed bitmaps to
the pack-*.idx structure.

Operation                   Index V2               Index VE003
Clone                       37530ms (524.06 MiB)     82ms (524.06 MiB)
Fetch (1 commit back)          75ms                 107ms
Fetch (10 commits back)       456ms (269.51 KiB)    341ms (265.19 KiB)
Fetch (100 commits back)      449ms (269.91 KiB)    337ms (267.28 KiB)
Fetch (1000 commits back)    2229ms ( 14.75 MiB)    189ms ( 14.42 MiB)
Fetch (10000 commits back)   2177ms ( 16.30 MiB)    254ms ( 15.88 MiB)
Fetch (100000 commits back) 14340ms (185.83 MiB)   1655ms (189.39 MiB)

In the table the repository tested was Android's
platform/frameworks/base. The time shown is the time spent in the
"Counting objects" phase of creating a pack for a client using the
git:// protocol. The byte size shown is the size of the pack
transferred to the client, and "commits back" describes how far behind
the client was from the server when it started the fetch. In all test
runs the client was git-core and the server was JGit on the same
machine.

The amount of disk space used by the compressed bitmaps is tunable,
but averages 10-15% of the pack-*.idx file size. So about 8 MiB of
additional space for this repository. A repository owner can reduce
the worst case time used in the 100000 commit back case by using
slightly more disk and positioning more bitmaps more frequently
throughout history. The code doesn't do this by default because the
expectation is that a client is probably not 100k commits behind.
Instead it populates bitmaps at all branch and tag tips, and densely
(every few hundred commits) near the tips, and spaces them out more
the further back in history it goes. We assume the older history is
accessed less often, and doesn't need to waste additional disk space
or precious buffer cache.

The basic gist of the implementation is a bitmap has a 1 bit set for
each object that is reachable from the commit the bitmap is associated
with. An index file may have a unique bitmap for hundreds of commits
in the corresponding pack file. The set of objects to send is
performed by doing a simple computation:

  OR (all want lines) AND NOT OR (all have lines)

There are two key patches in the series that implement the file format
change and logic involved:

* https://git.eclipse.org/r/7939

  Defines the new E003 index format and the bit set
  implementation logic.

* https://git.eclipse.org/r/7940

  Uses E003 indexes when available to make packs, and
  the logic required to make E003 format indexes during GC.

:-)
