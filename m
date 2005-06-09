From: Junio C Hamano <junkio@cox.net>
Subject: Re: git bug?
Date: Thu, 09 Jun 2005 00:55:19 -0700
Message-ID: <7vzmu0otg8.fsf@assigned-by-dhcp.cox.net>
References: <42A7E7AD.5030108@pobox.com>
	<7vy89kq96o.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 09 12:23:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DgHpT-00044p-M5
	for gcvg-git@gmane.org; Thu, 09 Jun 2005 09:51:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262308AbVFIHzw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Jun 2005 03:55:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262318AbVFIHzw
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Jun 2005 03:55:52 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:21426 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S262308AbVFIHzX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jun 2005 03:55:23 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050609075519.OJRI16890.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 9 Jun 2005 03:55:19 -0400
To: Jeff Garzik <jgarzik@pobox.com>
In-Reply-To: <7vy89kq96o.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Thu, 09 Jun 2005 00:30:07 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Jeff, I assume you are talking about this part:

>> diff --git a/arch/arm/mm/minicache.c b/arch/arm/mm/minicache.c
>> deleted file mode 100644
>> diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c

that does not have anything between "deleted file..." and the
next diff about libata-core.c.

In short, this is not really a "bug", but I am open to
suggestions for improvements (but you need to talk Linus into
accepting the changes, because changing this would also affect
his "git-apply" program as well).

The current "diff-patch" format is generated this way:

 (0) if a modification is between different kind of objects
     (e.g. a regular file changed to a symlink), then the
     following steps are done twice; one "deletion" of the
     original, and another "creation" of the result.

 (1) "diff --git a/oldname b/newname" line is shown first and it
     is always shown.  Unless it is a rename/copy diff, oldname
     and newname always match.  We never say /dev/null on this
     line to represent creation/deletion.

 (2) Next, optional "diff --git extended headers" appear.  See
     apply.c for the list of things to expect.

 (3) Next, the output from "diff -u -L<oldname> -L<newname>"
     between the two file contents follows.  Here, oldname and
     newname are usually of the form "a/oldname" and
     "b/oldname", but we _do_ follow /dev/null convention for
     file creation and deletion here.  That is, you would see

         --- /dev/null
         +++ frotz.c
         @@ ...

     for a file creation, and the opposite for a file deletion.

     Unfortunately, if "diff" finds nothing to report, you would
     not even see these ---/+++ lines.  I think that is what
     puzzled you.

By the way, this is all documented (?) behaviour, reported first
by Linus in this message.

  Message-ID: <Pine.LNX.4.58.0505261214140.2307@ppc970.osdl.org>
  From: Linus Torvalds <torvalds@osdl.org>
  Subject: git full diff output issues..
  Date: Thu, 26 May 2005 12:19:21 -0700 (PDT)
  Cc: Git Mailing List <git@vger.kernel.org>

  While testing my "git-apply" thing (coming along quite nicely, thanks for
  asking), I've hit a case that is nasty to parse.

  This is from the 2.6.12-rc4 -> 2.6.12-rc5 patch:

          diff --git a/arch/um/kernel/checksum.c b/arch/um/kernel/checksum.c
          deleted file mode 100644
          diff --git a/arch/um/kernel/initrd.c b/arch/um/kernel/initrd.c
          new file mode 100644
          --- /dev/null
          +++ b/arch/um/kernel/initrd.c
          @@ -0,0 +1,78 @@

  and the magic here is that deleted file that was empty to begin with, so 
  it didn't have a patch, just a note on deletion.

  Why is that nasty? Because we don't have the file _name_ in any good 
  format. The filename only exists int he "diff --git" header, and that one 
  has the space-parsing issue, which makes it less than optimal.

  (the rest omitted)

We had a handful of back-and-forth back then and the resolution
was this:

  Message-ID: <Pine.LNX.4.58.0505261316250.2307@ppc970.osdl.org>
  From: Linus Torvalds <torvalds@osdl.org>
  Subject: Re: git full diff output issues..
  Date: Thu, 26 May 2005 13:33:26 -0700 (PDT)
  Cc: Junio C Hamano <junkio@cox.net>, Git Mailing List <git@vger.kernel.org>

  (some omitted)

  However, I ended up just validating the name parsing by making sure that 
  when I parse the "git --diff" line, I only take the name if I can see it 
  being the same for both the old and the new. ...

  (the rest omitted)

By the way, this is not just "deleting empty files".  Any change
that does not involve content changes you would see something
similar to what you found.

  Message-ID: <Pine.LNX.4.58.0506050806400.1876@ppc970.osdl.org>
  From: Linus Torvalds <torvalds@osdl.org>
  Subject: Re: git full diff output issues..
  Date: Sun, 5 Jun 2005 08:11:02 -0700 (PDT)
  Cc: git@vger.kernel.org

  (some omitted)

  The only case that was special was literally the "same name, no content 
  changes, new mode" case, which looked like

          diff --git a/oldname.c b/oldname.c
          new mode 100755
          old mode 100644

  and thus _only_ had the name in the (normally ambiguous wrt whitepsace)  
  header line.

