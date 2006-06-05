From: Junio C Hamano <junkio@cox.net>
Subject: Re: Horrible re-packing?
Date: Mon, 05 Jun 2006 16:54:28 -0700
Message-ID: <7v8xob2m6j.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0606050951120.5498@g5.osdl.org>
	<Pine.LNX.4.64.0606051140530.5498@g5.osdl.org>
	<Pine.LNX.4.64.0606051155000.5498@g5.osdl.org>
	<7vy7wb4cmy.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0606051256280.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 06 01:54:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FnOu1-00007T-F8
	for gcvg-git@gmane.org; Tue, 06 Jun 2006 01:54:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750880AbWFEXya (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Jun 2006 19:54:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750924AbWFEXya
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Jun 2006 19:54:30 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:53122 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1750880AbWFEXya (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Jun 2006 19:54:30 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060605235429.PZKM11027.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 5 Jun 2006 19:54:29 -0400
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21355>

Linus Torvalds <torvalds@osdl.org> writes:

> On Mon, 5 Jun 2006, Junio C Hamano wrote:
>> 
>> IIRC, sometimes this function is called with path and name split
>> and sometimes with full path in name
>
> Yeah, I was pretty confused by the whole hashing thing. Are you sure that 
> complexity is needed, it seems a bit overkill.

Two issues in the code confuses any reader of that function.

 - The code wants to hash Makefile from different revisions
   together, and Makefile and t/Makefile close to each other.
   The current code did it by treating '/' specially, used
   basename hash as the upper bits of the resulting hash and
   dirname hash as the lower bits.  It's my tendency to treat
   slashes specially too much, which is one of your favorite
   things to pick me on.

   This is not needed by your change anymore -- by only using
   the tail of the filename, and making sure tail part weighs
   more in the resulting group number, the new code gives the
   desired grouping characteristics in a much simpler way.

 - The output from rev-list --objects is fed to the function as
   its name parameter while path is set to NULL.  When we allow
   a thin pack to be generated, rev-list --objects output also
   contains "-<commit-object-name>" lines.  We read trees for
   these commits that are not going to be sent but can be used
   as base objects, and pass the pathname discovered from the
   tree using path and name pair (path is set to the linked list
   of struct name_path that describes the dirname, and name is
   set to the basename).  This was done to reduce the need for
   allocating and copying the pathname in preparation for
   calling name_hash() function.

   If you use only the "name" variable in your group number
   computation, and suppose we are doing send-pack to send
   updates between rev A..B, contrib/git-svn/Makefile from rev B
   will use git-svn/Makefile (tail 16 characters) to compute the
   number, but the blob from rev A (which we are not going to
   send but would want to use as a potential delta base) will
   have contrib/git-svn part in "path" (the element points at
   string "git-svn", and its uplink points at another element
   that points at "contrib" with an uplink that says it is at
   the root level), and Makefile in "name".  They will be hashed
   slightly differently.
