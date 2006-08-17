From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [Possible bug] diff-tree --stat info does not count copies
Date: Thu, 17 Aug 2006 12:54:15 +0200
Message-ID: <e5bfff550608170354i45104458h3b7e2ec8c668fb9c@mail.gmail.com>
References: <e5bfff550608170219q12fcb34ewf93a195eabe0b94a@mail.gmail.com>
	 <7vveorsnt3.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 17 12:54:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GDfVz-0006Dx-JA
	for gcvg-git@gmane.org; Thu, 17 Aug 2006 12:54:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964794AbWHQKyQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 Aug 2006 06:54:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932475AbWHQKyQ
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Aug 2006 06:54:16 -0400
Received: from py-out-1112.google.com ([64.233.166.183]:5955 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932474AbWHQKyP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Aug 2006 06:54:15 -0400
Received: by py-out-1112.google.com with SMTP id z74so1390791pyg
        for <git@vger.kernel.org>; Thu, 17 Aug 2006 03:54:15 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HgVWgMK/+e2LZ3hYhPIPokwjw+GFarJP1dgnWJfk7zR0qkyMACm/G8Bwid8S5PdYMv36/++3NQORPajYWmfsmZwhno6j1zoPY/WZKhOM+hWexKuoeBaYI5Cl7aGMxPjRgdyYyBwfYWpDyMR6mYzvEIvGezZyxPYuHyfKMFh1xvo=
Received: by 10.35.63.2 with SMTP id q2mr3328141pyk;
        Thu, 17 Aug 2006 03:54:15 -0700 (PDT)
Received: by 10.35.95.9 with HTTP; Thu, 17 Aug 2006 03:54:14 -0700 (PDT)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7vveorsnt3.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25581>

On 8/17/06, Junio C Hamano <junkio@cox.net> wrote:
> "Marco Costalba" <mcostalba@gmail.com> writes:
>
> > While testing qgit with the new rename/copy support  I found this
> > (possible) bug playing on git tree.
> >
> > $ git-diff-tree -r --stat 6973dca
> > 6973dcaee76ef7b7bfcabd2f26e76205aae07858
> >  Makefile                      |    2
> > diff-files.c                  |  212 +----
> > diff-lib.c                    | 1862 ++---------------------------------------
> > diff.c                        | 1795 ++++++++++++++++++++++++++++++++++++++++
> > diff.h                        |    7
> > t/t1001-read-tree-m-2way.sh   |    2
> > t/t1002-read-tree-m-u-2way.sh |    2
> > 7 files changed, 1929 insertions(+), 1953 deletions(-)
> >
> > $ git-diff-tree -r --stat -C 6973dca
> > 6973dcaee76ef7b7bfcabd2f26e76205aae07858
> >  Makefile                      |    2
> > diff-files.c                  |  212 +----
> > diff-lib.c                    | 1862 ++---------------------------------------
> > diff-lib.c => diff.c          |    0
> > diff.h                        |    7
> > t/t1001-read-tree-m-2way.sh   |    2
> > t/t1002-read-tree-m-u-2way.sh |    2
> > 7 files changed, 134 insertions(+), 1953 deletions(-)
> >
> > IMHO the bug is
> >
> >   "diff-lib.c => diff.c          |    0"
> >
> > instead of
> >
> >   "diff-lib.c => diff.c          |    1795"
> >
> > because, after the patch applied, in the repository we have
> > 1953-1929=24 lines of code more, not 1953-134= 1819 less.
>
> Interesting.  That's really a matter of taste and interpretation.
>
> If it were a straight rename without changing a single line,
> then would you say 1795 lines were removed (from the LHS file)
> and 1795 lines were added (to the RHS file)?
>
> I personally find that output would be useless and would prefer
> it to say "I renamed file A to file B.  Content-wise, there were
> N lines added and M lines removed, compared to the straight
> rename case, by the way".
>
> And that is what the current output does.  I do not see why it
> should be different in the case of a copy instead of a rename.
>

Because after a copy you have 2 files, not still one. And the 'after
copied' file cannot be the original, but a new file, because the
original is still alive.

Perhaps I can explain better myself taking in account the _couple_ of
files involved in both cases:

Without -C we have

diff-lib.c                    | 1862 ++---------------------------------------
diff.c                        | 1795 ++++++++++++++++++++++++++++++++++++++++

With -C option is

 diff-lib.c                    | 1862 ++---------------------------------------
 diff-lib.c => diff.c          |    0

If it was a rename we had something like:

diff-lib.c                  | 1795 -----------------------------------------
diff.c                        | 1795 ++++++++++++++++++++++++++++++++++++++++

and, with -C

diff-lib.c => diff.c          |    0

and _this_ is correct. But with copy  diff-lib.c => diff.c  should not
stay at zero lines changed because diff.c is not the same of
diff-lib.c, but it's a _new_ file created with the same content of
diff-lib.c and _then_ the original and only diff-lib.c file is further
modified on his own (in our case changing 1862 lines).

Please tell me where I get wrong.

Thanks
Marco
