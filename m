From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 0/8] Make C-level operable from subdirectories
Date: Sat, 26 Nov 2005 02:59:51 -0800
Message-ID: <7vzmnr1xp4.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0511201748440.14258@wbgn013.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.64.0511200935081.13959@g5.osdl.org>
	<200511210026.30280.Josef.Weidendorfer@gmx.de>
	<200511221831.03954.Josef.Weidendorfer@gmx.de>
	<Pine.LNX.4.63.0511221854120.27872@wbgn013.biozentrum.uni-wuerzburg.de>
	<438371E8.2030701@op5.se>
	<Pine.LNX.4.63.0511231553390.8191@wbgn013.biozentrum.uni-wuerzburg.de>
	<7viruj3q7z.fsf@assigned-by-dhcp.cox.net> <4384FB61.40506@op5.se>
	<Pine.LNX.4.63.0511240042350.11106@wbgn013.biozentrum.uni-wuerzburg.de>
	<43857430.7060103@op5.se> <7vsltmwiky.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0511241127020.12985@wbgn013.biozentrum.uni-wuerzburg.de>
	<7v8xveth4l.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0511241419390.14297@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vmzjtn3h1.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0511242252080.26485@wbgn013.biozentrum.uni
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 26 12:01:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Efxmr-0003Kd-0o
	for gcvg-git@gmane.org; Sat, 26 Nov 2005 12:00:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750817AbVKZK7y (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 26 Nov 2005 05:59:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750824AbVKZK7y
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Nov 2005 05:59:54 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:64950 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1750817AbVKZK7x (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Nov 2005 05:59:53 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051126105924.ZTEI3131.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 26 Nov 2005 05:59:24 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7voe477n4i.fsf_-_@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sat, 26 Nov 2005 01:51:41 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12779>

Junio C Hamano <junkio@cox.net> writes:

> Linus Torvalds <torvalds@osdl.org> writes:
>
>> On Fri, 25 Nov 2005, Junio C Hamano wrote:
>>>
>>> I once advocated for an environment to name the top of working
>>> tree directory --- it might make sense to resurrect that one.
>>
>> Please don't. 
>>
>> We should just make the scripts do it automatically instead.
>
> Here comes an 8-patch series.
>
>   [PATCH 1/8] git-apply: work from subdirectory.
>   [PATCH 2/8] peek-remote: honor proxy config even from subdirectory.
>   [PATCH 3/8] fsck-objects: work from subdirectory.
>   [PATCH 4/8] checkout-index: work from subdirectory.
>   [PATCH 5/8] hash-object: work within subdirectory.
>   [PATCH 6/8] ls-tree: work from subdirectory.
>   [PATCH 7/8] Make networking commands to work from a subdirectory.
>   [PATCH 8/8] Make the rest of commands work from a subdirectory.

In case it was not obvious,...

I think your GIT_DIR=`git-rev-parse --git-dir` patch would make
things work better on top of these changes, while making many of
them silently do funny things as you warned.

For example, among the ones I mentioned in my previous message:

 - git-checkout with or without -b to switch branches work.
   This is because "git-read-tree -u" is not constrained by the
   current directory and operates on the whole working tree.

 - git-checkout <ent> <path>... works as expected.  It takes cwd
   relative paths and updates the index and working tree for
   only specified paths from the named ent.

 - git-checkout -f works in a confusing way; only the files
   under the current directory is updated.  This is because
   "git-checkout-index -a" behaves that way.  git-checkout -f to
   revert to the current HEAD is probably good to work this way,
   but doing this while switching branches is too confusing.

 - git-reset --hard also works in a funny way.  It leaves paths
   outside the current directory intact, because ls-tree reports
   only the files in the current directory while ls-files
   reports all.

 - git-prune works.  git-tag works as before.

It could be argued that it was a mistake that [PATCH 4/8] and
[PATCH 6/8] changed checkout-index and ls-tree to limit their
scope to the current directory, but that is consistent with what
rev-list (log and whatchanged) and diff do, and might be
debatably useful.  Which suggests that things like git-checkout
and git-reset whose normal mode of operation should be
whole-tree should chdir up and do the path prefixing to convert
original cwd relative paths to repository relative.
