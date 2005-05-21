From: Junio C Hamano <junkio@cox.net>
Subject: Re: updated design for the diff-raw format.
Date: Sat, 21 May 2005 16:17:33 -0700
Message-ID: <7vll68dv8y.fsf@assigned-by-dhcp.cox.net>
References: <7vwtpsdvgm.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun May 22 01:16:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DZdCl-000452-Sg
	for gcvg-git@gmane.org; Sun, 22 May 2005 01:16:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261339AbVEUXRk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 May 2005 19:17:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261556AbVEUXRk
	(ORCPT <rfc822;git-outgoing>); Sat, 21 May 2005 19:17:40 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:31687 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S261339AbVEUXRf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 May 2005 19:17:35 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050521231734.VDFB20235.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 21 May 2005 19:17:34 -0400
To: git@vger.kernel.org
In-Reply-To: <7vwtpsdvgm.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Sat, 21 May 2005 16:12:57 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

(second of the replayed message, with blessing from Linus)

Date: Sat, 21 May 2005 11:24:31 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 3/3] Diff overhaul, adding the other half of copy detection.
Message-ID: <Pine.LNX.4.58.0505211107160.2206@ppc970.osdl.org>

On Sat, 21 May 2005, Junio C Hamano wrote:
> 
> Once we start to think of it this way, it becomes quite tempting
> to change the diff-raw format to actually match the above
> concept.

I agree, and I was going to suggest changing the "raw" diff output for all
the same reasons. So I think you should do it, as the old format was based
on not really knowing where this all would take us. I think your proposed
format is visually nicer, and it's obviously more flexible.

Small suggestion on termination of the thing:
 - add a "inter_name_termination" variable, which defaults to '\t' (the 
   same way "line_termination" defaults to '\n')
 - make "-z" set both "inter_name_termination" _and_ "line_termination" to 
   0.
 - make the spacing be fixed (and add a test for it, so that there is 
   never any confusion): regular spaces between the non-file-names, and 
   "inter_name_termination" before the filenames, and "line_termination" 
   after the second filename.

This has a few results:

 - the default output is perfectly readable, if long

 - "cut" (which defaults to TAB delimeter) can directly pick up the
   three fields from a line: "state", "file1" and "file2"

 - even if you use the "readable" output (as opposed to the "-z" 
   machine-readable one), spaces in filenames are unambiguous, and we only 
   screw up on TAB and NL.

   Spaces in names are normal in many things. NL/TAB really _are_ unusual, 
   and I could imagine that some porcelain could actually disallow them 
   (and if that happens, we could support that by add a flag to
   "update-cache" to refuse to touch such files, the same way we refuse 
   non-canonical filenames now).

 - the -z flag results in fairly unreadable output, but is at least 
   totally parseable with all filename characters allowed.

With that in place, the new format would be a lot _easier_ to parse than 
the old one, I think. And will be more flexible, and since it's a 
fixed-column format, it's actually pretty readable for humans too, as long 
as the terminal line is wide enough.

>     100644 100644 233a250... 66818b4... file0 file0
>     100755 100755 fc77389... 7b72d3d... file1 file1
>     ______ 100644 _______... 233a250... file2 file2
>     100755 ______ fc77389... _______... file3 file3
>     100644 100644 233a250... 233a250... file4 file4
> 
> Again, I am not even advocating this.  It is more like me
> still thinking aloud.

No, I think it's really good. The _one_ thing I'd do is to maybe put a 
special character at the beginning of the line, so that "diff-helper" has 
an ever easier time to know whether it should care or not. Something that 
normally wouldn't show up at the beginning of a line, like ':'.

(This would have the secondary advantage that yuou could run "diff-helper"  
multiple times and not care whether it was already expanded or not. Right
now that is impossible: diff-helper can't know the difference between an
already-expanded diff that has a line that begins with a '+' or '-' and a
eleted/new object line).

		Linus




