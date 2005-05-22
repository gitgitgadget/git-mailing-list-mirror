From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] The diff-raw format updates.
Date: Sun, 22 May 2005 11:35:34 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505221108000.2307@ppc970.osdl.org>
References: <7vwtpsdvgm.fsf@assigned-by-dhcp.cox.net> <7v1x80dluj.fsf@assigned-by-dhcp.cox.net>
 <7vvf5cc779.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 22 20:33:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DZvFR-0000Nj-Ps
	for gcvg-git@gmane.org; Sun, 22 May 2005 20:32:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261339AbVEVSdo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 May 2005 14:33:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261467AbVEVSdo
	(ORCPT <rfc822;git-outgoing>); Sun, 22 May 2005 14:33:44 -0400
Received: from fire.osdl.org ([65.172.181.4]:52907 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261339AbVEVSdg (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 May 2005 14:33:36 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j4MIXVjA012478
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 22 May 2005 11:33:31 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j4MIXTnu023499;
	Sun, 22 May 2005 11:33:29 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vvf5cc779.fsf_-_@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sat, 21 May 2005, Junio C Hamano wrote:
>
> Update the diff-raw format as Linus and I discussed, except that
> it does not use sequence of underscore '_' letters to express
> nonexistence.  All '0' mode is used for that purpose instead.
> 
> The new diff-raw format can express rename/copy

Having looked at this, I have to disagree.

It can _almost_ express rename/copy, but you can't tell the two apart. In 
both cases you have two different modes, two different SHA1's, and two 
different filenames.

Also, while you can trivially tell whether a file is deleted or new (look 
at the 000000... SHA1), it is pretty illogical to give a "filename" for 
the non-existent side, as in the line

:000000 100644 0000000000000000000000000000000000000000 25ab9eda939ad92bb746c2419d083b1e52117a56	diffcore-pathspec.c	diffcore-pathspec.c

Finally, having now looked at it some more, I've come to realize that it's 
actually pretty hard to tell the different cases apart visually (is it a 
rename or just a change), because the full pathnames can be so long that 
it's not at all immediately obvious.

Anyway, I think we can trivially tweak the filename output to handle all 
these problems.

I'd suggest:

 - we'd continue to have two "filename" fields, with the existing
   termination, but they aren't pure filenames any more, they are just
   tab-separated (or zero-separated) "source" and "destination" fields.

 - if no filename exists (ie the source side of a new file, or the 
   destination side of a deleted file), output "/dev/null". In other
   words, a nonexistent file is _always_ associated with mode 000000, SHA1
   00000..  and a "name field" of "/dev/null".

 - ONLY IF HUMAN-READABLE: if the destination filename is the same as the
   source, drop it (and the tab) completely. This just makes things so
   much more readable, and it's still parseable, because the 
   line-termination is different from the inter-file termination.

   NOTE! In the zero-terminated format, you can't do this, since you 
   wouldn't know where the line ended. You might drop the name completely, 
   but you'd have to have two NUL bytes. I'd argue that since this format 
   isn't human-readable anyway, you might just want to keep the filename 
   the same.

 - in all other cases: if the file is new, prepend a "+", if the file is 
   old, prepend a "*", and if the file goes away, prepend a "-". In other 
   words, the actual pathname (if it exists) always starts at the second
   character and is always prepended by _something_ (ie there is no 
   ambiguoity with pathnames that start in -/+/*).

The above hass a few nice properties, notably you can parse the first
character of the name field, and you always know what's up:

 - '/' is always "/dev/null" aka "no file"
 - '+' is always "added file"
 - '-' is always "removed file"
 - '*' is always "existing file"
 - '\0' (ie empty) is always "same filename as source"

So for the above "create" event, it would look like

	:000000 100644 0000.. 25ab..	/dev/null	+diffcore-pathspec.c

which is visually quite obviously a create. Similarly, deletes are also 
visually pretty obvious:

	:100644 000000 25ab.. 0000..	-diffcore-pathspec.c	/dev/null

while a "copy" would be (git-pull-script stays around, so it gets a "*"):

	:100755 100755 bd89.. 17f2..	*git-pull-script	+git-fetch-script

and a "rename" would be:

	:100644 100644 51bb.. 51bb..	-diff-tree-helper.c	+diff-helper.c

(ie the difference is in the source file having a "-" in front of it 
instead of a "*").

A regular modification would be

	:100644 100644 bcd3.. c05b..	*Documentation/git-fsck-cache.txt

which is also very visually distinct from the other cases.

What do you think?

		Linus
