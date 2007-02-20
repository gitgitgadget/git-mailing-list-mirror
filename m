From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/4] Mechanical conversion to use prefixcmp()
Date: Tue, 20 Feb 2007 02:19:47 -0800
Message-ID: <7vk5ydw2po.fsf@assigned-by-dhcp.cox.net>
References: <200702191839.05784.andyparkins@gmail.com>
	<7vlkit7vy5.fsf@assigned-by-dhcp.cox.net>
	<200702200942.18654.andyparkins@gmail.com>
	<7v3b51xihy.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 20 11:20:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJS6D-0005lq-I4
	for gcvg-git@gmane.org; Tue, 20 Feb 2007 11:19:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932820AbXBTKTt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Feb 2007 05:19:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932842AbXBTKTs
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Feb 2007 05:19:48 -0500
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:46352 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932820AbXBTKTs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Feb 2007 05:19:48 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070220101948.GBBE21177.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Tue, 20 Feb 2007 05:19:48 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id RmKn1W0011kojtg0000000; Tue, 20 Feb 2007 05:19:47 -0500
In-Reply-To: <7v3b51xihy.fsf_-_@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Tue, 20 Feb 2007 01:53:29 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40226>

Junio C Hamano <junkio@cox.net> writes:

> This mechanically converts strncmp() to use prefixcmp(),
> ...
>  * This was done by using this script in px.perl
>
>    #!/usr/bin/perl -i.bak -p
>    if (/strncmp\(([^,]+), "([^\\"]*)", (\d+)\)/ && (length($2) == $3)) {
>            s|strncmp\(([^,]+), "([^\\"]*)", (\d+)\)|prefixcmp($1, "$2")|;
>    }
>    if (/strncmp\("([^\\"]*)", ([^,]+), (\d+)\)/ && (length($1) == $3)) {
>            s|strncmp\("([^\\"]*)", ([^,]+), (\d+)\)|(-prefixcmp($2, "$1"))|;
>    }
>
>    and running:
>
>    $ git grep -l strncmp -- '*.c' | xargs perl px.perl

Two useless comments to add.

 (1) Yes, I have seen the "Oh, I lost my data doing this silly
     thing" thread that mentioned the risk of using xargs ;-).
     In general, piping output from git commands that give list
     of paths (e.g. "grep", "ls-files", "diff --name-only" and
     "ls-tree -r --name-only") to xargs should be a much safer
     practice, and people should get into the habit of doing so,
     instead of using "find | xargs".

 (2) This multi-step "mechanical conversion followed by manual
     fixup" is a trick I picked up from Linus.  The replacement
     regexp quoted above are designed to be stricter than
     necessary to catch only the safe conversion target, while
     accepting false negatives.  Doing the conversion this way,
     I do not have to worry too much about auditing 1800 lines
     of diff in [PATCH 2/4], as long as I make sure the above
     regexp is strict enough (although I did look at all 1800
     lines of diff before committing this).  Manual conversions
     in later steps do need to be looked at much more carefully
     than the result of this step, of course.
