From: Junio C Hamano <junkio@cox.net>
Subject: Re: print errors from git-update-ref
Date: Fri, 28 Jul 2006 00:26:12 -0700
Message-ID: <7vejw6mbqj.fsf@assigned-by-dhcp.cox.net>
References: <81b0412b0607180613t603551b8t865b407c40ab8aef@mail.gmail.com>
	<7vk663h6zi.fsf@assigned-by-dhcp.cox.net>
	<20060727012856.GB32492@spearce.org>
	<Pine.LNX.4.63.0607271302150.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	<20060728062720.GC30783@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jul 28 09:26:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G6Mjj-0008B8-3X
	for gcvg-git@gmane.org; Fri, 28 Jul 2006 09:26:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750841AbWG1H0P (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 28 Jul 2006 03:26:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932177AbWG1H0O
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Jul 2006 03:26:14 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:32424 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1750841AbWG1H0O (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Jul 2006 03:26:14 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060728072613.OVSI6711.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 28 Jul 2006 03:26:13 -0400
To: Shawn Pearce <spearce@spearce.org>
In-Reply-To: <20060728062720.GC30783@spearce.org> (Shawn Pearce's message of
	"Fri, 28 Jul 2006 02:27:20 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24373>

Shawn Pearce <spearce@spearce.org> writes:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>> Hi,
>> 
>> On Wed, 26 Jul 2006, Shawn Pearce wrote:
>> 
>> > This change adds a test for trying to create a ref within a directory
>> > that is actually currently a file, and adds error printing within
>> > the ref locking routine should the resolve operation fail.
>> 
>> Why not just print an error message when the resolve operation fails, 
>> instead of special casing this obscure corner case? It is way shorter, 
>> too. The test should stay, though.
>
> Did you read the patch?  If resolve_ref returns NULL then this
> change prints an error (from errno) no matter what.  If errno is
> ENOTDIR then it tries to figure out what part of the ref path wasn't
> a directory (but was attempted to be used as such) and prints an
> ENOTDIR error about that path instead of the one actually given
> to the ref lock function
>
> So I think I'm doing what you are suggesting...

Not quite.

+		int last_errno = errno;
+		if (errno == ENOTDIR) {
+			char* p = not_a_directory(orig_path);
+			error("unable to resolve reference %s: %s",
+				p, strerror(errno));
+			free(p);
+		} else
+			error("unable to resolve reference %s: %s",
+				orig_path, strerror(errno));
 		unlock_ref(lock);
+		errno = last_errno;

I know you are trying to be nice by pinpointing which component
of the directory hierarchy is offending, but at the same time
the nicety is hiding the orig_path given to the program from the
user.  Maybe showing orig_path _and_ p would be nicer.

But I suspect there is even more serious problem here.

 - lock_ref_sha1_basic() gets "path" from the user; you stash it
   away in "orig_path".

 - resolve_ref() tries to resolve both symbolic links and
   symrefs.  If it fails, it returns NULL.

 - When it returns NULL, you use orig_path (say, "a/b/c/d") to
   see which path component is not a directory (say, "a/b/c" is
   a file).

But the last step does not take into account what resolve_ref()
does, doesn't it?  What if orig_path is "HEAD", which is a
symref, which contained "ref: refs/heads/myhack/one" and
"refs/heads/myhack" is a file?  Ideally you may want to say
something like:

     '''while resolving %s, which points at %s,
        we found out %s is not a directory''' %
        ("HEAD", "refs/heads/myhack/one", "refs/heads/myhack")

So I tend to agree with Johannes's "why bother?" reaction.
