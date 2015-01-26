From: Josh Boyer <jwboyer@fedoraproject.org>
Subject: Re: patch-2.7.3 no longer applies relative symbolic link patches
Date: Mon, 26 Jan 2015 16:07:22 -0500
Message-ID: <CA+5PVA5RdtLyRiYerG=u--bRZQ87qU0EGf7kGPMiQs9_KB3hRw@mail.gmail.com>
References: <CA+5PVA7rVy6Li_1haj1QmGG0D6avLB5Xej=2YGt6K-11kKHR5A@mail.gmail.com>
	<CA+5PVA4bs6CYU8MHn1JqBjnb-5wYJT2Tjqa65=v2uSPL8c7dYw@mail.gmail.com>
	<CA+55aFxbY21vBbPs5qCFPT1HSBbaeS+Z2Fr9So1r3rXrMWe_ZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>,
	"Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
	twaugh@redhat.com, Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: linux-kernel-owner@vger.kernel.org Mon Jan 26 22:07:30 2015
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1YFqsc-00014Q-0y
	for glk-linux-kernel-3@plane.gmane.org; Mon, 26 Jan 2015 22:07:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756956AbbAZVHZ (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Mon, 26 Jan 2015 16:07:25 -0500
Received: from mail-oi0-f51.google.com ([209.85.218.51]:59730 "EHLO
	mail-oi0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754076AbbAZVHX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2015 16:07:23 -0500
Received: by mail-oi0-f51.google.com with SMTP id x69so9264143oia.10;
        Mon, 26 Jan 2015 13:07:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=7bLcwpkdDTOOg3QnMvb9kXk9M8TBYcM0XnJ8QXcZsXY=;
        b=EvGKnlQkyFTHIT/mW27qzHg6Q1zBBZ59cT4aCpaxc7S5zaalvB9dN6UkUCQoVussqV
         s7DkafyZmPUGTFjHyVq3Fw+yKtwUBq5TXg+Y0/xNRg5OVt9fYAoGHF4jWCP5fkEs27PF
         xDf88kwDFACWeCRbHDIqHGjJ/W7HZYWhCAeyJQH/kOuoIucAzSoyEppY25WOHywx3mYJ
         oRP6KQhVmUKFm7ueSrC/G7po6chlWpeMs4WUgRH+puf56X+ClzQYAxG4zWoXuxJE7eMW
         pr0lBRSY2QBUIkTX+E1YOATYezRVUvp50m1GwuZFATuUO8tqk06Nn/1Ap9qP4OlW0ibu
         XXvg==
X-Received: by 10.182.68.68 with SMTP id u4mr14226009obt.82.1422306442445;
 Mon, 26 Jan 2015 13:07:22 -0800 (PST)
Received: by 10.76.50.70 with HTTP; Mon, 26 Jan 2015 13:07:22 -0800 (PST)
In-Reply-To: <CA+55aFxbY21vBbPs5qCFPT1HSBbaeS+Z2Fr9So1r3rXrMWe_ZQ@mail.gmail.com>
X-Google-Sender-Auth: fsXPlgojHkkgh-rhnWsd3Jk8L20
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263045>

On Mon, Jan 26, 2015 at 3:44 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Mon, Jan 26, 2015 at 8:32 AM, Josh Boyer <jwboyer@fedoraproject.org> wrote:
>>
>> I went to do the Fedora 3.19-rc6 build this morning and it failed in
>> our buildsystem with:
>>
>> + '[' '!' -f /builddir/build/SOURCES/patch-3.19-rc6.xz ']'
>> + case "$patch" in
>> + unxz
>> + patch -p1 -F1 -s
>> symbolic link target '../../../../../include/dt-bindings' is invalid
>> error: Bad exit status from /var/tmp/rpm-tmp.mWE3ZL (%prep)
>
> Ugh. I don't see anything we can do about this on the git side, and I
> do kind of understand why 'patch' would be worried about '..' files.
> In a perfect world, patch would parse the filename and see that it
> stays within the directory structure of the project, but that is a
> rather harder thing to do than just say "no dot-dot files".
>
> The short-term fix is likely to just use "git apply" instead of "patch".

Well, that's one fix anyway.  I just removed the hunk from the local
copy of patch-3.19-rc6.xz and added the symlink manually.  See why
below.

> The long-term fix? I dunno. I don't see us not using symlinks, and a
> quick check says that every *single* symlink we have in the kernel
> source tree is one that points to a different directory using ".."
> format. And while I could imagine that "patch" ends up counting the
> dot-dot entries and checking that it's all inside the same tree it is
> patching, I could also easily see patch *not* doing that. So using
> "git apply" _might_ end up being the long-term fix too.

It could, but from a distro perspective that requires either doing
'untar linux-3.N.tar.xz; cd linux-3.N; git add .; git apply
patch-3.N+1-rcX' , or just using a git tree to begin with, which then
makes all of this unnecessary anyway.  Creating a git repo from a
tarball for each build is kind of silly.  Some might say not just
using a git tree to build from to begin with in 2015 is also kind of
silly.

Or did I miss a way that git-apply can take a git patch and apply it
to a tree that isn't a git repo?

> I suspect that if "patch" cannot apply even old-style kernel patches
> due to the symlinks we have in the tree, and people end up having to
> use "git apply" for them, I might end up starting to just use
> rename-patches (ie using "git diff -M") for the kernel.

I'm kind of wondering why we'd generate patches at all if you have to
apply them to a git repo, but maybe people like doing things the
old-fashioned way just for the hell of it.

> I've considered that for a while already, because "patch" _does_ kind
> of understand them these days, although I think it gets the
> cross-rename case wrong because it fundamentally works on a
> file-by-file basis. But if "patch" just ends up not working at all,
> the argument for trying to maintain backwards compatibility gets
> really weak.

Yeah.  I mostly wanted to give people a heads up on the issue.  I'm
sure it's going to impact more than just the kernel.  I think for us
it's mostly limited to the -rcX patches, because once the tarball for
the final release is out the symlink should be created by tar just
fine.

josh
