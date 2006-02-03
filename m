From: Junio C Hamano <junkio@cox.net>
Subject: Re: [Attn - repository browser authors] diff-tree combined format.
Date: Fri, 03 Feb 2006 11:55:35 -0800
Message-ID: <7vacd8fc94.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0602012212200.21884@g5.osdl.org>
	<7v8xsuuto5.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0602012334360.21884@g5.osdl.org>
	<Pine.LNX.4.64.0602012353130.21884@g5.osdl.org>
	<Pine.LNX.4.64.0602020002110.21884@g5.osdl.org>
	<7voe1qtbr5.fsf_-_@assigned-by-dhcp.cox.net>
	<7vvevyrtn9.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0602021454060.21884@g5.osdl.org>
	<7v64nxmhqn.fsf@assigned-by-dhcp.cox.net>
	<7v1wylkn54.fsf_-_@assigned-by-dhcp.cox.net>
	<e5bfff550602030417w290c12b6yc4406f890acadc73@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Mackerras <paulus@samba.org>,
	Marco Costalba <mcostalba@yahoo.it>,
	Aneesh Kumar <aneesh.kumar@gmail.com>,
	Kay Sievers <kay.sievers@suse.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 03 20:56:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F5720-00026z-4d
	for gcvg-git@gmane.org; Fri, 03 Feb 2006 20:55:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945926AbWBCTzl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Feb 2006 14:55:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945930AbWBCTzl
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Feb 2006 14:55:41 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:25301 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1945926AbWBCTzk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Feb 2006 14:55:40 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060203195229.TCKT20050.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 3 Feb 2006 14:52:29 -0500
To: Marco Costalba <mcostalba@gmail.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15543>

Marco Costalba <mcostalba@gmail.com> writes:

> This is just, as said above, a note to avoid someone else falls in the
> same bug assuming
>
> @ -1,87 -1,3 +1,93 @
>
> is the only possible header format.

When you parse normal unidiff, you may need to watch out for
things like these:

    --- a/H          --- a/H            --- a/H            
    +++ b/H          +++ b/H            +++ b/H            
    @@ -1 +1 @@      @@ -2,2 +1,0 @@    @@ -1 +0,0 @@      
    -A               -2                 -1                 
    +1               -3                                    

 * When a hunk affects only one line, the line count is omitted.

 * When a hunk is only removal of lines, the line count of the
   result is zero.

 * When such a hunk removes lines from the beginning of the file,
   the line offset in the result is also zero.

I do not do the "omit 1" optimizatino in combined output format
(yet -- should I???), so that would not be a problem.  The other
two you would see only when you do not have context, and
combined output format has its own context length you cannot
override, so they probably may not matter (I do not know offhand
what 'diff-tree -c' would do in such cases).
