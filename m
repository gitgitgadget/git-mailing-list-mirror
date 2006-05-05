From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] binary patch.
Date: Fri, 05 May 2006 12:23:19 -0700
Message-ID: <7vac9wxom0.fsf@assigned-by-dhcp.cox.net>
References: <7vodyd2vqn.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0605042241240.28543@localhost.localdomain>
	<7vwtd10xyd.fsf@assigned-by-dhcp.cox.net>
	<7vy7xgzsiu.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0605051128100.28543@localhost.localdomain>
	<7vejz8z80p.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0605051431390.24505@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 05 21:23:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fc5tg-0003jn-VJ
	for gcvg-git@gmane.org; Fri, 05 May 2006 21:23:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751164AbWEETX0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 5 May 2006 15:23:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751724AbWEETX0
	(ORCPT <rfc822;git-outgoing>); Fri, 5 May 2006 15:23:26 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:24457 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1750993AbWEETXZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 May 2006 15:23:25 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060505192323.YKD9215.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 5 May 2006 15:23:23 -0400
To: Nicolas Pitre <nico@cam.org>
In-Reply-To: <Pine.LNX.4.64.0605051431390.24505@localhost.localdomain>
	(Nicolas Pitre's message of "Fri, 05 May 2006 14:33:01 -0400 (EDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19634>

Nicolas Pitre <nico@cam.org> writes:

> On Fri, 5 May 2006, Junio C Hamano wrote:
>
>> The delta is going to be deflated and hopefully gets a bit
>> smaller, so if we really care that level of detail, it might be
>> worth to do (deflate_size*3/2) or something like that here, use
>> delta with or without deflate whichever is smaller, and mark the
>> uncompressed delta with a different tag ("uncompressed delta"?).
>> And for symmetry, to deal with uncompressible data, we may want
>> to have "uncompressed literal" as well.
>
> Nah...  Please just forget that.  ;-)

I was serious about the above actually.

BTW, this "binary patch" opens a different can of worms.

Currently, the diff uses a heuristic borrowed from GNU diff 
(I did not look at the code when I did it, but it is described
in its documentation) to decide if a file is binary (look at the
first few bytes and find NUL).  I am sure people will want to
have a way to say "that heuristic fails but this _is_ a binary
file and please treat it as such".

There are two, both valid, I think, ways to do it.

 - give an option to "diff" that says "treat this path as binary
   for this invocation of the program".

 - give an attribute to blob object that says "this blob is
   binary and should be treated as such".

The latter is probably the right way to go in the longer term.

A blob being binary or not is a property of the content and does
not depend on where it sits in the history, so unlike "recording
renames as a hint in commit objects", the attribute is at the
blob level, not at the commit nor the tree that points at the
blob.

But "binaryness" affects only certain operations that extract
the data (e.g. diff and grep) and not others (e.g. fetch).
Also, it makes sense to being able to retroactively mark a blob,
which was not marked as such originally, is a binary.  So I do
not think it should be recorded in the object header.

Which suggests that we may perhaps want to have notes that can
be attached to existing objects to augment them without changing
the contents of the data, and have tools notice these notes when
they are available.  Another example is to associate correct
MIME types to blobs so, gitweb _blob_ links can do sensible
things to them.

These external notes are purely for Porcelains (in the context
of this sentence "diff" and "grep" are Porcelain), but we would
also want a way to propagate them across repositories somehow.
In a sense, "grafts" information is similar to the external
notes in that it augments existing commit objects, but its
effect is a bit more intrusive; it affects the way the core
operates.
