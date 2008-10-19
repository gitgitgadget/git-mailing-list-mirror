From: Junio C Hamano <gitster@pobox.com>
Subject: Is XDL_MERGE_ZEALOUS too zealous (or maybe not zealous enough)?
Date: Sun, 19 Oct 2008 15:52:16 -0700
Message-ID: <7v3ais5hb3.fsf_-_@gitster.siamese.dyndns.org>
References: <1224377652.19061.12.camel@mattlaptop2.local>
 <7vhc785izq.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>, Matt McCutchen <matt@mattmccutchen.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Oct 20 10:47:31 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KrhA4-0005Zd-8b
	for gcvg-git-2@gmane.org; Mon, 20 Oct 2008 00:54:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752133AbYJSWwc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Oct 2008 18:52:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752525AbYJSWwc
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Oct 2008 18:52:32 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:44134 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751919AbYJSWwb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Oct 2008 18:52:31 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id CF09D71747;
	Sun, 19 Oct 2008 18:52:28 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 467F471746; Sun, 19 Oct 2008 18:52:23 -0400 (EDT)
In-Reply-To: <7vhc785izq.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sun, 19 Oct 2008 15:15:53 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 9B137B28-9E30-11DD-A693-9CEDC82D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98628>

Junio C Hamano <gitster@pobox.com> writes:

> Again, good eyes.  I think the two lines should go; my fault at cdb22c4
> (Merge branch 'jc/better-conflict-resolution' into next, 2008-09-02).

Hmm, I am somewhat unhappy.  If you run:

	$ git checkout cdb22c4^
        $ git merge cdb22c4^2
	$ git checkout --conflict=diff3 builtin-checkout.c

and look at builtin-checkout.c.  You will find this:

<<<<<<< ours
	/* --track without -b should DWIM */
	if (0 < opts.track && !opts.new_branch) {
		const char *argv0 = argv[0];
	...
		opts.new_branch = argv0 + 1;
	}

	if (opts.track == BRANCH_TRACK_UNSPECIFIED)
		opts.track = git_branch_track;
|||||||
	if (!opts.new_branch && (opts.track != git_branch_track))
		die("git checkout: --track and --no-track require -b");
=======
	if (conflict_style) {
		opts.merge = 1; /* implied */
		git_xmerge_config("merge.conflictstyle", conflict_style, NULL);
	}

	if (!opts.new_branch && (opts.track != git_branch_track))
		die("git checkout: --track and --no-track require -b");
>>>>>>> theirs

The two lines in the middle was from the common ancestor, which was not
touched by the merged branch (that added the "if (conflict_style) {}"
block) and was lost by a rewrite in "ours".

However, the usual simplified merge shows this (run "git checkout --merge
builtin-checkout.c" if you have done the above):

<<<<<<< ours
	/* --track without -b should DWIM */
	if (0 < opts.track && !opts.new_branch) {
		const char *argv0 = argv[0];
	...
		opts.new_branch = argv0 + 1;
	}

	if (opts.track == BRANCH_TRACK_UNSPECIFIED)
		opts.track = git_branch_track;
=======
	if (conflict_style) {
		opts.merge = 1; /* implied */
		git_xmerge_config("merge.conflictstyle", conflict_style, NULL);
	}

	if (!opts.new_branch && (opts.track != git_branch_track))
		die("git checkout: --track and --no-track require -b");
>>>>>>> theirs

Removing the two lines from the simplified "theirs" is not what I would
suggest (it would be actively wrong), but I wonder if we can do something
clever to help users with a merge like this.
