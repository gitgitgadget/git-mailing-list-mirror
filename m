From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC 2/2] Automatically transform .git/{branches,remotes} into .git/config
Date: Mon, 21 Nov 2005 14:26:38 -0800
Message-ID: <7vpsotmych.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0511211455120.13775@wbgn013.biozentrum.uni-wuerzburg.de>
	<200511211644.16789.Josef.Weidendorfer@gmx.de>
	<Pine.LNX.4.63.0511211653420.2569@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 21 23:28:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EeK7Y-0003Wj-Lj
	for gcvg-git@gmane.org; Mon, 21 Nov 2005 23:26:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751120AbVKUW0l (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 Nov 2005 17:26:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751149AbVKUW0l
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Nov 2005 17:26:41 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:7834 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1751120AbVKUW0k (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Nov 2005 17:26:40 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051121222534.MBCE26964.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 21 Nov 2005 17:25:34 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0511211653420.2569@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Mon, 21 Nov 2005 16:57:07 +0100
	(CET)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12498>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Mon, 21 Nov 2005, Josef Weidendorfer wrote:
>
>> On Monday 21 November 2005 14:56, Johannes Schindelin wrote:
>> > With this patch, git automatically extracts the information from 
>> > .git/branches and .git/remotes, puts it into .git/config, and renames the 
>> > directories to .git/branches.old and .git/remotes.old, respectively.
>> 
>> Please... don't trash .git/branches.
>> This is about Cogito, not about Git. You will render every repository cloned
>> with Cogito useless, as it expects a per-branch configuration with the same
>> name as heads.
>> 
> I was aware that .git/branches was introduced by Pasky, but as it is 
> handled in git-parse-remote.sh, I thought that it may be a bit more 
> general than just cogito.

What Josef said is correct in that I was not aware of the fact
that Cogito branches/ are *per-branch* configuration when I did
parse-remote.  remotes/ are deliberately *per-remote*
configuration, because it is more efficient when you are
downloading more than one refs from the same remote over a
git-aware protocol.  Arguably, it is optimizing for the wrong
case, because it may well be a minority case to keep track of
more than one remote head.  I dunno.

I am not sure if it is a good idea to automatically convert what
is stored in .git/branches to .git/remotes (or the equivalent of
the latter in .git/config), but if somebody wanted to do it, the
right thing would be:

 - grab the URL without optional fragment '#rembranch' part from
   all branches/* file;

 - group the ones that fetch from the same URL into one
   remotes/$file (what to call that file is very debatable
   because the original branches/* is in different namespace and
   we cannot tell what the user wants to call the remote),
   giving appropriate head mapping.  branches/$branch file with
   the fragment part '#$rembranch' translates to "Pull:
   $rembranch:$branch".
