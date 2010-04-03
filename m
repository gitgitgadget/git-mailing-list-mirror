From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: [PATCH v2 4/4] git status: refresh the index if possible
Date: Sat, 3 Apr 2010 11:33:46 +0100
Message-ID: <201004031233.46258.markus.heidelberg@web.de>
References: <1270211241-10795-5-git-send-email-markus.heidelberg@web.de> <1270244661-24173-1-git-send-email-markus.heidelberg@web.de> <7v1vex9mur.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 03 12:32:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ny0eE-0001gK-Ry
	for gcvg-git-2@lo.gmane.org; Sat, 03 Apr 2010 12:32:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753227Ab0DCKb4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Apr 2010 06:31:56 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:47192 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752761Ab0DCKby (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Apr 2010 06:31:54 -0400
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate03.web.de (Postfix) with ESMTP id B00AE14B1F426;
	Sat,  3 Apr 2010 12:31:52 +0200 (CEST)
Received: from [91.19.4.230] (helo=pluto.localnet)
	by smtp06.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #4)
	id 1Ny0ds-0007cO-00; Sat, 03 Apr 2010 12:31:52 +0200
User-Agent: KMail/1.12.4 (Linux/2.6.30-gentoo-r8; KDE/4.3.5; i686; ; )
In-Reply-To: <7v1vex9mur.fsf@alter.siamese.dyndns.org>
Jabber-ID: markus.heidelberg@web.de
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX18UEKQdsYGbEM2lEQ7Zh4/YOL+FjHu2ypvnaBWw
	TDEC0Z8tnc1SuS4JZER4XUtzBPz3H3mMdhBZElhX+w0oFTikAv
	SID+/pLCfJcxKM/+FyVg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143886>

Junio C Hamano, 2010-04-03 06:33:
> Markus Heidelberg <markus.heidelberg@web.de> writes:
> 
> > Is rollback_lock_file(&index_lock) necessary? It isn't used in
> > "git commit --dry-run" when commit_style is COMMIT_AS_IS.
> 
> That is because AS_IS commit does not even lock anything for writing, as
> AS_IS means just that: "git commit" does not touch the index but just
> writes tree out of the index.

Hmm, it does lock and write the index, doesn't it?

	/*
	 * As-is commit.
	 *
	 * (1) return the name of the real index file.
	 *
	 * The caller should run hooks on the real index,
	 * and create commit from the_index.
	 * We still need to refresh the index here.
	 */
	if (!pathspec || !*pathspec) {
		fd = hold_locked_index(&index_lock, 1);
		refresh_cache_or_die(refresh_flags);
		if (write_cache(fd, active_cache, active_nr) ||
		    commit_locked_index(&index_lock))
			die("unable to write new_index file");
		commit_style = COMMIT_AS_IS;
		return get_index_file();
	}

$ stat .git/index
Access: 2010-04-03 12:31:11.000000000 +0200
Modify: 2010-04-03 12:31:11.000000000 +0200
Change: 2010-04-03 12:31:11.000000000 +0200
$ git commit --dry-run
$ stat .git/index
Access: 2010-04-03 12:31:52.000000000 +0200
Modify: 2010-04-03 12:31:52.000000000 +0200
Change: 2010-04-03 12:31:52.000000000 +0200

$ chmod a-w .git
$ git commit --dry-run
fatal: Unable to create '/home/markus/git/git/.git/index.lock': Permission denied

> Upon program exit (unless you get an uncontrolled crash), the lockfile API
> arranges atexit(3) to roll back the lockfiles, so it probably may not make
> much of a difference if you omitted rollback_lock_file(&index_lock)
> yourself, but it is a good idea to clean up the mess you made after you
> are done, especially if the mess is not something the operating system
> will clean up for us (e.g. open file descriptors, malloc'ed region of
> memory etc.)

Thanks for the explanation!

> To make sure that the failure case is covered, you may also want to add a
> test case where you run "chmod a-w $GIT_DIR" and then run status (but that
> test needs to be conditional on POSIXPERM).

Patch has been sent.

Markus
