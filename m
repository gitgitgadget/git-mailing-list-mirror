From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add a configuration option to control diffstat after merge
Date: Wed, 23 May 2007 13:18:05 -0700
Message-ID: <7v646j2t1e.fsf@assigned-by-dhcp.cox.net>
References: <81b0412b0705230828s7fcdd836gf3bb92000d8ebd79@mail.gmail.com>
	<7vhcq32yda.fsf@assigned-by-dhcp.cox.net>
	<20070523195823.GA2554@steel.home> <20070523200223.GB2554@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 23 22:18:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HqxHf-0007NL-Ms
	for gcvg-git@gmane.org; Wed, 23 May 2007 22:18:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756000AbXEWUSJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 23 May 2007 16:18:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756173AbXEWUSJ
	(ORCPT <rfc822;git-outgoing>); Wed, 23 May 2007 16:18:09 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:48301 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756000AbXEWUSI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 May 2007 16:18:08 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070523201806.ZHXG22040.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Wed, 23 May 2007 16:18:06 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 2kJ61X0061kojtg0000000; Wed, 23 May 2007 16:18:06 -0400
In-Reply-To: <20070523200223.GB2554@steel.home> (Alex Riesen's message of
	"Wed, 23 May 2007 22:02:23 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48171>

Alex Riesen <raa.lkml@gmail.com> writes:

> The diffstat can be controlled either with command-line options
> (--summary|--no-summary) or with merge.diffstat. The default is
> left as it was: diffstat is active by default.
>
> Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
> ---
>
> I have to explain the implementation a bit: in Windows, every exec is
> *very* expensive, so I tried to avoid a call to git-config as long as
> possible. The stupid OS is my reason for this change, actually:
> diffstat not just takes too long. It also takes a *long* while before
> the diffstat even starts!

Even on Linux, if your project is well modularized and your
workflow is "merge small and merge often" like the kernel is, it
is not unusual that the final diffstat takes much longer than a
merge.  But the diffstat is not an eye-candy but is an important
safety measure from the workflow point of view.

> @@ -168,6 +169,11 @@ do
>  	shift
>  done
>  
> +if test -z "$show_diffstat"; then
> +    test "$(git-config merge.diffstat)" = false && show_diffstat=false
> +    test -z "$show_diffstat" && show_diffstat=t
> +fi

Isn't this hunk wrong?

[merge]
	diffstat = 0
        diffstat = false

should both mean "merge.diffstat is set to false".
"git config --bool" does that.

And when merge.diffstat does not appear in the configuration
file, "git config --bool merge.diffstat" exits non-zero.

if test -z "$show_diffstat"; then
    test "$(git-config --bool merge.diffstat)" = false && show_diffstat=false
    test -z "$show_diffstat" && show_diffstat=t
fi
