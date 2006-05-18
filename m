From: Junio C Hamano <junkio@cox.net>
Subject: Re: Do "git add" as a builtin
Date: Thu, 18 May 2006 01:13:46 -0700
Message-ID: <7v64k3698l.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0605170927050.10823@g5.osdl.org>
	<7vhd3ocvyy.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0605171321020.10823@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 18 10:14:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fgde2-0004aN-KZ
	for gcvg-git@gmane.org; Thu, 18 May 2006 10:14:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751319AbWERINs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 May 2006 04:13:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751318AbWERINs
	(ORCPT <rfc822;git-outgoing>); Thu, 18 May 2006 04:13:48 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:49572 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1751319AbWERINr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 May 2006 04:13:47 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060518081347.XLFS15069.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 18 May 2006 04:13:47 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0605171321020.10823@g5.osdl.org> (Linus Torvalds's
	message of "Wed, 17 May 2006 13:23:19 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20273>

Linus Torvalds <torvalds@osdl.org> writes:

> On Wed, 17 May 2006, Junio C Hamano wrote:
>> 
>> By "not seeing the point", do you mean you do not agree with
>> what bba319b5 and 45e48120 tried to do to help users?
>
> Naah, I just didn't see why, and didn't bother to go exploring.
>
> How about this patch on top of the previous one?

Well, not good as-is.  This makes it barf on this sequence:

	$ rm -f junk
        $ cd junk
        $ git init-db
        $ date >frotz
        $ mkdir nitfol
        $ date >nitfol/rezrov
	$ git add .		;# OK up to this point - added everything.

	$ git add .		;# This is bogus because...
        fatal: pathspec '' did not match any files
	$ git add nitfol	;# ...this does not barf.

I admit I did not spot it when I read the code, but this part
gets an empty string for 'match' when pathspec is '.'.

> +		/* Existing file? We must have ignored it */
> +		match = pathspec[i];
> +		if (!lstat(match, &st))
> +			continue;
> +		die("pathspec '%s' did not match any files", match);

That's why '.' barfs but nitfol doesn't.
