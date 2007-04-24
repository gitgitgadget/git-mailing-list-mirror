From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Fix handle leak in write_tree
Date: Mon, 23 Apr 2007 22:16:43 -0700
Message-ID: <7vps5u9wsk.fsf@assigned-by-dhcp.cox.net>
References: <20070423194925.GA5163@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 24 07:16:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HgDOS-0007v7-NI
	for gcvg-git@gmane.org; Tue, 24 Apr 2007 07:16:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753507AbXDXFQp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Apr 2007 01:16:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753917AbXDXFQp
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Apr 2007 01:16:45 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:60848 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753732AbXDXFQo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Apr 2007 01:16:44 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070424051643.UIWK1257.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Tue, 24 Apr 2007 01:16:43 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id qtGj1W00Z1kojtg0000000; Tue, 24 Apr 2007 01:16:44 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45411>

Alex Riesen <raa.lkml@gmail.com> writes:

> This is a quick and dirty fix for the broken "git cherry-pick -n" on
> some broken OS, which does not remove the directory entry after unlink
> succeeded(!) if the file is still open somewher.
> The entry is left but "protected": no open, no unlink, no stat.
> Very annoying.
>
> Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
> ---
>
> That should be enough to get going, but I have to say that the
> interface to lockfiles is really troublesome. Why has the caller close
> a handle it didn't open? Especially if there are perfect matches for
> the opening function (hold_locked_index) in form of commit and
> rollback?
>
> How about something like this (just interface):
>
> struct lock_file
> {
> 	struct lock_file *next;
> 	pid_t owner;
> 	int fd;
> 	char on_list;
> 	char filename[PATH_MAX];
> };
>
> struct lock_file *open_locked(const char *path, int die_on_error);
> struct lock_file *open_index_locked(int die_on_error);
> void commit_lock_file(struct lock_file *); /* always assuming .lock */
> void rollback_lock_file(struct lock_file *);

I agree that making commit and rollback close the file
descriptor and lock holders to use lock->fd for write() makes
more sense, although it is a bit unclear from the above set of
function signatures what your plan on the lifetime rule for
"struct lock_file" is.  If it will be linked to the list given
to the atexit() handler and the caller of open_locked() never
frees it, I think I am fine with the interface.
