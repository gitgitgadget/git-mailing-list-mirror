From: Shawn Pearce <spearce@spearce.org>
Subject: Re: blame --reverse selecting wrong commit
Date: Sun, 29 May 2011 19:33:07 -0700
Message-ID: <BANLkTimAij28ibW3DV2HaHPK5z0D-CrDHQ@mail.gmail.com>
References: <BANLkTikuFEg686VH_RojEe-zmBZRBOx6eA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 30 04:33:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QQsIP-0002W8-GC
	for gcvg-git-2@lo.gmane.org; Mon, 30 May 2011 04:33:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752956Ab1E3Cd2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 29 May 2011 22:33:28 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:53614 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751920Ab1E3Cd1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 May 2011 22:33:27 -0400
Received: by vws1 with SMTP id 1so2393079vws.19
        for <git@vger.kernel.org>; Sun, 29 May 2011 19:33:27 -0700 (PDT)
Received: by 10.52.179.161 with SMTP id dh1mr3729100vdc.177.1306722807070;
 Sun, 29 May 2011 19:33:27 -0700 (PDT)
Received: by 10.52.167.228 with HTTP; Sun, 29 May 2011 19:33:07 -0700 (PDT)
In-Reply-To: <BANLkTikuFEg686VH_RojEe-zmBZRBOx6eA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174712>

On Sun, May 29, 2011 at 19:21, Shawn Pearce <spearce@spearce.org> wrote=
:
> Although blame shows Stefan Lay removed the block in commit 05fa1713,
> this isn't what happened. It was actually removed in commit 2302a6d3
> by Christian Halstrick. It looks like blame gets confused around this
> section of the JGit history.
>
> Repository URL: =A0git://egit.eclipse.jgit/jgit.git
>
> $ git blame -L 1080, --reverse 40fa75feb..master --
> org.eclipse.jgit.test/tst/org/eclipse/jgit/storage/file/RefDirectoryT=
est.java

Actually, you can use a narrower history range of 16e810b2..aa05559.

I found this glitch while working on the new JGit implementation of
reverse blame. It just so happens you and I both took the same rule on
a merge commit, follow the parent that has exactly the blob of the
merge itself... passing all blame onto it.

Except that in reverse mode this isn't true. One of the "parents" is
the descendent that deleted this method, so of course its not
identical content. The other parent is a different side-branch that
didn't touch the file at all. Later blame finds these branches merge
together, and lays the blame on the wrong side.

It seems that we may want to avoid "parents" that have identical file
content when in reverse mode if there is another parent that has
different content for the current target path.

--=20
Shawn.
