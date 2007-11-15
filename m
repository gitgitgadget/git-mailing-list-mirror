From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [StGit RFC] A more structured way of calling git
Date: Thu, 15 Nov 2007 18:28:16 +0000
Message-ID: <b0943d9e0711151028y22b37e04y87a6bc74dc4c5031@mail.gmail.com>
References: <20071026192418.GA19774@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "=?ISO-8859-1?Q?David_K=E5gedal?=" <davidk@lysator.liu.se>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Yann Dirson" <ydirson@altern.org>
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Thu Nov 15 19:28:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsjSA-0008KZ-KU
	for gcvg-git-2@gmane.org; Thu, 15 Nov 2007 19:28:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751632AbXKOS2V convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 15 Nov 2007 13:28:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758958AbXKOS2V
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Nov 2007 13:28:21 -0500
Received: from el-out-1112.google.com ([209.85.162.182]:55452 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751632AbXKOS2U convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Nov 2007 13:28:20 -0500
Received: by el-out-1112.google.com with SMTP id j27so319086elf
        for <git@vger.kernel.org>; Thu, 15 Nov 2007 10:28:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=6XYrbyRUn/KtZcePPiIoSZxwP+IfBX/SYu8i9xUo2ss=;
        b=b1bJnINLE64dv50KqVh2qM/FxGGLy6fX4CW50H5RpaYHJbuth0q6Ay7t7tKCj7aL83VA4TGe9F4G8dsxstddrwlLmYbAOCVRzHtQ3nlgRL+5zkmhFbBJdcgGk7Fai+qzJ9981IwsG49ppFbV/QuJbz5Y7NR5kX+BmTphRtP0R64=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=T4YVjwmVDrt0nxXRfIA9tZKaudkzwKnln287JqY6kG2kcbYmukM3EQ0B3F4CHI/WvgsSW7utcHGuJteIT4kZsBnDX0eCXxR1I/Dvo2QGoKQ2fC/yH+0mdCNQ7JGlY+ZfaCsICOTsn/bzvEcIeJbtPMpWiZNpivn/C28g0btUMGY=
Received: by 10.143.160.1 with SMTP id m1mr267299wfo.1195151296265;
        Thu, 15 Nov 2007 10:28:16 -0800 (PST)
Received: by 10.142.230.10 with HTTP; Thu, 15 Nov 2007 10:28:16 -0800 (PST)
In-Reply-To: <20071026192418.GA19774@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65146>

On 26/10/2007, Karl Hasselstr=F6m <kha@treskal.com> wrote:
> I wanted to build an StGit command that coalesced adjacent patches to
> a single patch. Because the end result tree would still be the same,
> this should be doable without ever involving HEAD, the index, or the
> worktree. StGit's existing infrastructure for manipulating patches
> didn't lend itself to doing this kind of thing, though: it's not
> modular enough. So I started to design a replacement low-level
> interface to git, and things got slightly out of hand ... and I ended
> up with a much bigger refactoring than I'd planned.

I eventually managed to have a (not so in-depth) look at this and I am
OK with it (but merging after 0.14). As you said the current structure
and the new one will work in parallel for some time. It would even be
possible to implement unit testing.

Some random comments below:

Commitdata maybe should be written as CommitData (as in the e-mail text=
).

The Repository.head property is not cached and it is probably OK to
avoid some problems I had. We could run profiling afterwards to see
how often it is called.

> Transactions (translib.py)
> ---------------------------------------------------------------------=
-
>
> I started to implement a few StGit commands on top of gitlib.py and
> stacklib.py, and then realized something very appealing:
>
>   Just about every StGit command can be accomplished by first creatin=
g
>   a bunch of new commit objects with gitlib.py, then trying to check
>   out the new HEAD, and then rewriting refs with stacklib.py. Only th=
e
>   first and second steps can possibly fail, and if they do, they do s=
o
>   without leaving any user-visible junk behind. This can be used to
>   make all commands either succeed completely, or do nothing at all.

As you said, that's a bit difficult for 'push' as it is made of a
series of separate individual patch pushes. Can we not use a temporary
index by setting GIT_INDEX_FILE during the whole transaction and
freely update the working copy. Only if the transaction fails, we
clean the working copy and check out the default index? This might
slow down some operations though.

In the future, it would be nice to record the stack state before
transactions in a git object (via pickle) together with HEAD id and
provide unlimited undo.

Thanks.

--=20
Catalin
