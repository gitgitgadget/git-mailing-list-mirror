From: Juliusz Chroboczek <Juliusz.Chroboczek@pps.jussieu.fr>
Subject: Re: [darcs-users] Re: Git-aware Darcs: a tutorial
Date: Mon, 09 May 2005 21:41:39 +0200
Message-ID: <7ihdhc426k.fsf@lanthane.pps.jussieu.fr>
References: <7i4qdc8isd.fsf@lanthane.pps.jussieu.fr>
	<427FA400.2060408@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: darcs-devel@abridgegame.org, darcs-users@abridgegame.org,
	Git Mailing List <git@vger.kernel.org>
X-From: darcs-devel-bounces@darcs.net Mon May 09 21:35:05 2005
Return-path: <darcs-devel-bounces@darcs.net>
Received: from www.abridgegame.org ([66.179.181.159] helo=abridgegame.org)
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DVE1V-0001j8-9j
	for gcvdd-darcs-devel@m.gmane.org; Mon, 09 May 2005 21:34:37 +0200
Received: from localhost ([127.0.0.1] helo=www.abridgegame.org)
	by abridgegame.org with esmtp (Exim 4.50)
	id 1DVE8O-0004Nr-BJ; Mon, 09 May 2005 15:41:44 -0400
Received: from shiva.jussieu.fr ([134.157.0.129])
	by abridgegame.org with esmtp (Exim 4.50)
	id 1DVE8M-0004Ne-2S; Mon, 09 May 2005 15:41:42 -0400
Received: from hydrogene.pps.jussieu.fr (hydrogene.pps.jussieu.fr
	[134.157.168.1])
	by shiva.jussieu.fr (8.12.11/jtpda-5.4) with ESMTP id j49JfQUj052577
	; Mon, 9 May 2005 21:41:26 +0200 (CEST)
X-Ids: 164
Received: from lanthane.pps.jussieu.fr (lanthane.pps.jussieu.fr
	[134.157.168.57])
	by hydrogene.pps.jussieu.fr (8.13.3/jtpda-5.4) with ESMTP id
	j49JfdO4022130 ; Mon, 9 May 2005 21:41:39 +0200
Received: from jch by lanthane.pps.jussieu.fr with local (Exim 4.34)
	id 1DVE8J-0007Bi-HK; Mon, 09 May 2005 21:41:39 +0200
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <427FA400.2060408@zytor.com> (H. Peter Anvin's message of "Mon,
	09 May 2005 10:55:12 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.2
	(shiva.jussieu.fr [134.157.0.164]);
	Mon, 09 May 2005 21:41:27 +0200 (CEST)
X-Antivirus: scanned by sophie at shiva.jussieu.fr
X-Miltered: at shiva.jussieu.fr with ID 427FBCE6.001 by Joe's j-chkmail
	(http://j-chkmail.ensmp.fr)!
X-BeenThere: darcs-devel@darcs.net
X-Mailman-Version: 2.1.5
Precedence: list
List-Id: "List for darcs-related development discussion."
	<darcs-devel.darcs.net>
List-Unsubscribe: <http://www.abridgegame.org/cgi-bin/mailman/listinfo/darcs-devel>,
	<mailto:darcs-devel-request@darcs.net?subject=unsubscribe>
List-Archive: <http://www.abridgegame.org/pipermail/darcs-devel>
List-Post: <mailto:darcs-devel@darcs.net>
List-Help: <mailto:darcs-devel-request@darcs.net?subject=help>
List-Subscribe: <http://www.abridgegame.org/cgi-bin/mailman/listinfo/darcs-devel>,
	<mailto:darcs-devel-request@darcs.net?subject=subscribe>
Sender: darcs-devel-bounces@darcs.net
Errors-To: darcs-devel-bounces@darcs.net

>> Darcs-git is a branch of Darcs that can work with Git repositories.

> How is it, performance-wise?

It depends very much on the command, but in general it's no faster
than plain Darcs right now, except for accessing the working
directory when you have an up-to-date cache.  The nice thing, of
course, is that since Darcs-git works on pure Git repositories, you
can always switch to using plain Git commands when an operation is
likely to be too slow, as I've done in the example above.

(Editor's note: ``Patch'' is Darcs-speak for what BK calls a Changeset.)

Commands that only touch the working dir and the top of the history --
darcs what, darcs record, and so on -- are relatively fast; unlike the
native Git equivalents, they stat every file in your tree (I'll be
fixing this RSN), but they don't touch the contents of unchanged
files.  Darcs whatsnew on a full kernel takes 4s on my machine.

Commands that read history (darcs changes, darcs send, darcs push) are
very fast until they encounter a merge, as they need to read the full
contents of one of the two branches (just the changed files, of
course).  In practice, that means that doing |darcs whatsnew| gets me
the last 90 patches in Linux' history in a few seconds, then stalls.
I've tried to track the problem down, but after an afternoon of work I
had gotten no further.  (I've explained the issue in excruciating
detail on Darcs-Devel, if you're interested.)

Commands that push patches around scale rather badly with the amount
of files touched by a patch.  In practice, this means that you'll be
able to push around all patches in a kernel tree in a reasonable time,
except for the initial commit (220MB of touched files), which you can
only push using the native Git tools.

And then there is what I consider as the actual showstopper: darcs diff
is completely brain-damaged (very much so in plain Darcs, even more so
in Darcs-git).  It needs a complete rewrite.

                                        Juliusz
