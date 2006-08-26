From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 19/19] gitweb: Remove creating directory for temporary files
Date: Sat, 26 Aug 2006 12:25:40 -0700
Message-ID: <7vpsen1eq3.fsf@assigned-by-dhcp.cox.net>
References: <200608240015.15071.jnareb@gmail.com>
	<200608252135.27894.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 26 21:25:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GH3mV-0005Vf-Mb
	for gcvg-git@gmane.org; Sat, 26 Aug 2006 21:25:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750719AbWHZTZU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 26 Aug 2006 15:25:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750732AbWHZTZU
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Aug 2006 15:25:20 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:61095 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1750719AbWHZTZT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Aug 2006 15:25:19 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060826192519.KZYI4015.fed1rmmtao09.cox.net@fed1rmimpo01.cox.net>;
          Sat, 26 Aug 2006 15:25:19 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
	by fed1rmimpo01.cox.net with bizsmtp
	id EjRH1V0074Noztg0000000
	Sat, 26 Aug 2006 15:25:17 -0400
To: Jakub Narebski <jnareb@gmail.com>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26065>

Jakub Narebski <jnareb@gmail.com> writes:

> Remove $git_temp variable which held location for temporary files
> needed by git_diff_print, and removed creating $git_temp directory.

Very good.  Not writing into the filesystem even in the
temporary location is a very good thing.

Other things I noticed in this 19 series (note that I've applied
them more or less intact already, expecting that any issues will
be fixed in-tree):

 * Overall

   Your MUA configuration seems to have improved and stabilized
   quite a bit.  I did not see any corruption this time around.

 * 01/19 gitweb: Use git-diff-tree patch output for commitdiff

   This was a bit large for me to review during work-day, and
   seemed a bit scary.  It initially did not give me a good
   feeling to see that a large series that followed depended on
   something that was marked RFC, but it turned out mostly Ok.

 * 02/19 gitweb: Replace git_commitdiff_plain by anonymous subroutine
   03/19 gitweb: Show information about incomplete lines in commitdiff
         Revert "gitweb: Replace git_commitdiff_plain by anonymous
                 subroutine"

   I've commented on these.

 * 06/19 gitweb: Add git_get_{following,preceding}_references functions
   07/19 gitweb: Return on first ref found when
         git_get_preceding_references is called in scalar context

   This looks *VERY* expensive.  Does git_get_references()
   cache and reuse its result?  How many times during a single
   invocation are these subs called?

   Also I am not sure about the correctness of "get-following".

            B------D------F
           /              base
	--A------C------E
                        hash

   You read from "rev-list $base", stop when you see $hash, and
   grab all the refs that point at the rev you have seen before
   stopping as "following".  But in the above picture, you will
   follow from F down to the very initial commit without
   stopping and there actually is _no_ rev that follows E so
   your result would contain B D A (if they are tagged) but none
   of them follows E.  There is something wrong here.

   At least you should read from "rev-list $hash..$base"; then
   traversal would go F D B and stop at A; you probably would
   want --boundary to force showing of A as well, but even then
   I am not sure how well the result would work.

   "get-preceding" also wants to go down to the initial commit.

   "get-following" is inherently a very expensive operation, so
   I would suggest not doing this.  It seems that nobody uses
   these two subs yet, so probably it is better to yank them
   before they cause damages.

 * 08/19 gitweb: Add git_get_rev_name_tags function
   09/19 gitweb: Use git_get_name_rev_tags for commitdiff_plain 
         X-Git-Tag: header

   I suspect these make the generation of the header extremely
   expensive.  I'd suggest reverting them to the original.

 * 13/19 gitweb: Add invisible hyperlink to from-file/to-file diff header

   You seem to have forgotten esc_html() on the patch-line
   before sending it to the browser.  Careful.

 * 14/19 gitweb: Always display link to blobdiff_plain in git_blobdiff

   Need justification why this change is needed (or why previous
   logic to avoid showing it in certain cases is wrong).

 * 16/19 gitweb: Use git-diff-tree or git-diff patch output for blobdiff

   Is git_to_hash sub always called with object names and
   nothing else?  "git rev-parse no-such" would die with an
   error message, and "git rev-parse Makefile" in populated
   working tree would say "Makefile" without complaints.
   Perhaps you want --revs-only --no-flags here.

   I think it is a bad style to return [] or $ in scalar context
   depending on the number of results.  It forces the caller to
   do a conditional depending on the type of the stuff returned.

   I would suggest just removing if (wantarray) and always
   return @hashes.  A caller who is interested in a single
   element can say "($it) = your_sub(...)", a caller who wants
   the number of elements can say "$cnt = your_sub(...)", and a
   caller who wants to know all can say "(@them) = your_sub(...)".

   I think that is the usual thing to do in Perl.  Unless there
   is a compelling reason that is so important that it is worth
   to deviate from that norm and confusing the programmer, that
   is.

   I think "# try to find filename from $hash" part would
   misbehave if $hash returned by git_to_hash($hash) becomes
   undef.

   You seem to spell out '-M', '-C' everywhere.  I suspect
   fixing them all to just '-C' (or perhaps '-B', '-C') would be
   tedious but probably is a good idea.

 * 17/19 gitweb: git_blobdiff_plain is git_blobdiff('plain')

   Needs justification why commitdiff and blobdiff plain needs
   to behave differently.
