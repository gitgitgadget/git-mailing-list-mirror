From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] cleans up builtin-mv
Date: Fri, 18 Aug 2006 12:33:21 -0700
Message-ID: <7vbqqh96v2.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0608172230470.25827@chino.corp.google.com>
	<Pine.LNX.4.63.0608172301520.25827@chino.corp.google.com>
	<Pine.LNX.4.63.0608181137000.28360@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Rientjes <rientjes@google.com>
X-From: git-owner@vger.kernel.org Fri Aug 18 21:33:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GEA5v-000348-R2
	for gcvg-git@gmane.org; Fri, 18 Aug 2006 21:33:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161095AbWHRTdY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Aug 2006 15:33:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932246AbWHRTdY
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Aug 2006 15:33:24 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:61153 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S932243AbWHRTdX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Aug 2006 15:33:23 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060818193322.IGYW2704.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 18 Aug 2006 15:33:22 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25690>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> What you cleverly did not mention: It was inside a
>
> 	if (!bad &&
> 		(length = strlen(source[i])) >= 0 &&
> 		!strncmp(destination[i], source[i], length) &&
> 		(destination[i][length] == 0 || destination[i][length] == '/'))
>
> construct. So, we assign the "length" variable only if we have to. And the 
> ">= 0" trick is a common one. I could have done
>
> 		!strncmp(destination[i], source[i], (length = strlen(source[i])))
>
> but even I find that ugly.

I usually side with you but on this I can't.

There are 2 ways to generate branch instructions in C.

 - compound statements specifically designed for expressing
   control structure: if () ... else ..., for (), while (),
   switch (), etc.

 - expressions using conditional operators or logical operators
   that short circuit: ... ? ... : ..., ... && ... || ...

The latter form may still be readable even with simple side
effects inside its terms, but "(l = strlen(s)) >= 0" is done
solely for the side effect, and its computed value does not have
anything to do with the logical operation &&.

THIS IS UGLY.  And do not want to live in a world where this
ugliness is a "common one", as you put it.

And this avoiding one call to strlen(source[i]) is unnecessary
even as an optimization -- you end up calling strlen() on it
later in the code anyway, as David points out.

I think this part is far easier to read if you did it like this:
 
		length = strlen(source[i]);
		if (lstat(source[i], &st) < 0)
			bad = "bad source";
		else if (!strncmp(destination[i], source[i], length) &&
			 (destination[i][length] == 0 ||
			  destination[i][length] == '/'))
			bad = "can not move directory into itself";

		if (S_ISDIR(st.st_mode)) {
			...

Note that the above is an absolute minimum rewrite.  Other
things I noticed are:

 - source[i] and destination[i] are referenced all the time; the
   code would be easer to read if you had something like this
   upfront:

                /* Checking */
                for (i = 0; i < count; i++) {
                        const char *bad = NULL;
			const char *src = source[i];
                        const char *dst = destination[i];
                        int srclen = strlen(src);
                        int dstlen = strlen(dst);

   You might end up not using dstlen in some cases, but I think
   this would be far easier to read.  Micro-optimizing by saying
   "this is used only in this branch of this later if()
   statement but in that case it is always set in that branch of
   that earlier if() statement" makes unmaintainably confusing
   code.

 - I do not think you need "const char *dir, *dest_dir" inside
   the "source is directory" branch; I would just use src and dst
   consistently;

 - You muck with dest_dir by calling add_slash(dest_dir) but
   call prefix_path() with dst_len you computed earlier;
   prefix_path() may know what to do, but is this intended?
