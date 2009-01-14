From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [BUG] assertion failure in builtin-mv.c with "git mv -k"
Date: Wed, 14 Jan 2009 15:53:41 +0100
Message-ID: <496DFC75.2000904@drmicha.warpmail.net>
References: <vpqwscy81o8.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Wed Jan 14 15:56:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LN79Z-0004ka-Ep
	for gcvg-git-2@gmane.org; Wed, 14 Jan 2009 15:55:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760815AbZANOxo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2009 09:53:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760848AbZANOxn
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jan 2009 09:53:43 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:60616 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760603AbZANOxm (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Jan 2009 09:53:42 -0500
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id CE9A3210C4B;
	Wed, 14 Jan 2009 09:53:41 -0500 (EST)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Wed, 14 Jan 2009 09:53:41 -0500
X-Sasl-enc: ELfv08zRGEyuS1YTimQcZK6+7KaY045CYYhSJh+5x/nO 1231944821
Received: from [139.174.44.34] (pascal.math.tu-clausthal.de [139.174.44.34])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 3FD876A4B;
	Wed, 14 Jan 2009 09:53:41 -0500 (EST)
User-Agent: Thunderbird 2.0.0.19 (X11/20081209)
In-Reply-To: <vpqwscy81o8.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105634>

Matthieu Moy venit, vidit, dixit 14.01.2009 14:20:
> Hi,
> 
> Just found a bug in builtin-mv.c. Here's a script to reproduce:
> 
> mkdir git
> cd git
> git init
> touch controled
> git add controled && git commit -m "init"
> touch foo1 foo2
> mkdir dir
> git mv -k foo* dir/
> 
> The output is the following:
> 
> Initialized empty Git repository in /tmp/git/.git/
> [master (root-commit)]: created 694563b: "init"
>  0 files changed, 0 insertions(+), 0 deletions(-)
>  create mode 100644 controled
> git: builtin-mv.c:216: cmd_mv: Assertion `pos >= 0' failed.
> ./bug.sh: line 10: 12919 Aborted                 git mv -k foo* dir/
> 
> Apparently, this happens when using "git mv -k" with more than one
> unversionned file. The code ignores the first one, but still goes
> through this
> 
> 	for (i = 0; i < argc; i++) {
> 		const char *src = source[i], *dst = destination[i];
> 		enum update_mode mode = modes[i];
> 		int pos;
> 		if (show_only || verbose)
> 			printf("Renaming %s to %s\n", src, dst);
> 		if (!show_only && mode != INDEX &&
> 				rename(src, dst) < 0 && !ignore_errors)
> 			die ("renaming %s failed: %s", src, strerror(errno));
> 
> 		if (mode == WORKING_DIRECTORY)
> 			continue;
> 
> 		pos = cache_name_pos(src, strlen(src));
> 		assert(pos >= 0); /* <----- this is the one */
> 		if (!show_only)
> 			rename_cache_entry_at(pos, dst);
> 	}
> 
> for the second, and it crashes on the assertion (gdb says "pos" here
> is an unversionned file name).
> 
> If anyone has time to fix this ...
> 
> Thanks,
> 

The problem is actually in the loop before, with just one line missing.
I'll send a patch but I'm not sure if this needs a test case.

Michael
