From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: gc --aggressive
Date: Tue, 17 Apr 2012 13:53:37 -0400
Message-ID: <CAG+J_DyqvCxwd6+gzixQEk6SxMZF0qsXKcJPaU6imsJdFQ-64g@mail.gmail.com>
References: <CAG+J_DzO=UZ56PjnSCRaTdj8pBSYc5PFofw1QHy42c5pHMK_HQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Shawn Pearce <spearce@spearce.org>, Jeff King <peff@peff.net>
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 17 19:53:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKCb1-0008DT-TJ
	for gcvg-git-2@plane.gmane.org; Tue, 17 Apr 2012 19:53:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754872Ab2DQRxi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Apr 2012 13:53:38 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:40514 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753824Ab2DQRxh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2012 13:53:37 -0400
Received: by mail-yx0-f174.google.com with SMTP id l12so3235785yen.19
        for <git@vger.kernel.org>; Tue, 17 Apr 2012 10:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=lXB1vK4jY9+IWw0zu+8rY4iw1JVW6fhFurjn5I4lfxY=;
        b=rg/J8IfIwwelUKeW0A76EO9k3F3wm1RS7vQtCBRQ6bFFAzj8eaiPrq3LshT76VNPG6
         CCv4vLn9lFKod8Yih6NxfVjs2avAgFNh1MMnSMDO8dq/jiW7Bhrh2he8yrlnNprg9UE3
         LOfuz7iq2gIsuvgwjsHEZUc2Wg/OSwUvvAwDoCfNNsMYjxqp0SElKudGgMEamXPajsMF
         mCFHnXqSoWyElFIZCLLLKGvUEDBBcPOAKASNOEVcq7WuxLVtsuFOLm5Wk6zcGeyhRVt2
         x4a4ufapA9AO6AyphrlWE4a9TRC91GNk8AOH1Gb2qyPgKEN6JLA45LACPHSW48A8YBEI
         a1AQ==
Received: by 10.236.134.211 with SMTP id s59mr16485484yhi.131.1334685217297;
 Tue, 17 Apr 2012 10:53:37 -0700 (PDT)
Received: by 10.147.47.19 with HTTP; Tue, 17 Apr 2012 10:53:37 -0700 (PDT)
In-Reply-To: <CAG+J_DzO=UZ56PjnSCRaTdj8pBSYc5PFofw1QHy42c5pHMK_HQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195777>

On Tue, Apr 17, 2012 at 12:16 PM, Jay Soffian <jaysoffian@gmail.com> wrote:
> This has worked fine on repos large and small. However, starting a
> couple days ago git started running out of memory on a relatively
> modest repo[*] while repacking on a Linux box with 12GB memory (+ 12GB
> swap). I am able to gc the repo by either removing --aggressive or
> .keep'ing the oldest pack.

Experimentally, setting pack.windowMemory = 256m keeps git memory
usage < 4.5 GB during an aggressive repack.

Ironically I end up with a slightly worse pack (63115590 bytes vs
61518628 bytes) than not using --aggressive. I assume this is because
pack-objects found a better delta chain during the previous aggressive
repack when windowMemory was not set.

> 1) If --aggressive does not generally provide a benefit, should it be
> made a no-op?

I guess I'll revise this question: perhaps --aggressive should be
better explained/discouraged. I found a message from Jeff last month
and stole his words for this patch:

<snip>
diff --git i/Documentation/git-gc.txt w/Documentation/git-gc.txt
index 815afcb922..ca5bf8b51e 100644
--- i/Documentation/git-gc.txt
+++ w/Documentation/git-gc.txt
@@ -37,9 +37,8 @@ OPTIONS
 	Usually 'git gc' runs very quickly while providing good disk
 	space utilization and performance.  This option will cause
 	'git gc' to more aggressively optimize the repository at the expense
-	of taking much more time.  The effects of this optimization are
-	persistent, so this option only needs to be used occasionally; every
-	few hundred changesets or so.
+	of taking much more time and potentially using greater memory. This
+	option is rarely needed. See Repacking below.

 --auto::
 	With this option, 'git gc' checks whether any housekeeping is
@@ -138,6 +137,39 @@ If you are expecting some objects to be collected
and they aren't, check
 all of those locations and decide whether it makes sense in your case to
 remove those references.

+Repacking
+---------
+
+Under the covers 'git gc' calls several commands to optimize the repository.
+The most significant of these with respect to repository size and general
+performance is linkgit:git-repack[1]. There are basically three levels of
+'gc' with respect to repacking:
+
+ 1. `git gc --auto`; if there are too many loose objects (`gc.auto`), they
+    all go into a new incremental pack. If there are already too many
+    packs (`gc.autopacklimit`), all of the existing packs are re-packed
+    together.
+
+    Making an incremental pack is by far the fastest because the speed is
+    independent of the existing repository history. If git packs
+    everything together, it should be more or less the same as (2).
+
+ 2. `git gc`; this packs everything into a single pack. It uses default
+    window and depth parameters, but importantly, it reuses existing
+    deltas. Doing so makes the delta compression phase much faster, and it
+    often makes the writing phase faster (because for older objects, git
+    is primarily streaming them right out of the existing pack). On a big
+    repository though, this does do a lot of I/O, because git has to
+    rewrite the whole pack.
+
+ 3. `git gc --aggressive`; this is often much slower than (2) because git
+    throws out all of the existing deltas and recomputes them from
+    scratch. It uses a higher window parameter meaning it will spend
+    more time computing, and it may end up with a smaller pack. However,
+    unless the repository is known to have initially been poorly packed,
+    this option is not needed and will just cause git to perform
+    extra work.
+
 HOOKS
 -----

@@ -147,6 +179,7 @@ linkgit:githooks[5] for more information.

 SEE ALSO
 --------
+linkgit:git-pack-refs[1]
 linkgit:git-prune[1]
 linkgit:git-reflog[1]
 linkgit:git-repack[1]
</snip>

Thoughts?
