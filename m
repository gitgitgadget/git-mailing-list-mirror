From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] revert: actually check for a dirty index
Date: Sun, 2 Mar 2008 11:37:53 +0100
Message-ID: <20080302103753.GB2973@steel.home>
References: <20080302064449.GA6334@coredump.intra.peff.net> <20080302072252.GA14214@coredump.intra.peff.net>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Mar 02 11:38:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVlaT-0004CK-Qu
	for gcvg-git-2@gmane.org; Sun, 02 Mar 2008 11:38:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752348AbYCBKh5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Mar 2008 05:37:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752713AbYCBKh5
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Mar 2008 05:37:57 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:62804 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752348AbYCBKh4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Mar 2008 05:37:56 -0500
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: z4gQVF2k5XWuW3CculzwpJKcp6o=
Received: from tigra.home (Fab7c.f.strato-dslnet.de [195.4.171.124])
	by post.webmailer.de (mrclete mo43) (RZmta 16.8)
	with ESMTP id Q0481dk227PoYR ; Sun, 2 Mar 2008 11:37:54 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 23359277BD;
	Sun,  2 Mar 2008 11:37:54 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id DF57256D24; Sun,  2 Mar 2008 11:37:53 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20080302072252.GA14214@coredump.intra.peff.net>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75773>

Jeff King, Sun, Mar 02, 2008 08:22:52 +0100:
> +static int index_is_dirty(void)
> +{
> +	struct rev_info rev;
> +	int is_dirty = 0;
> +
> +	init_revisions(&rev, NULL);
> +	setup_revisions(0, NULL, &rev, "HEAD");
> +	rev.diffopt.output_format |= DIFF_FORMAT_CALLBACK;
> +	rev.diffopt.format_callback = index_is_dirty_cb;
> +	rev.diffopt.format_callback_data = &is_dirty;
> +	run_diff_index(&rev, 1);
> +
> +	return is_dirty;
> +}

Wouldn't something like what built-commit does more effective?
It does:

	struct rev_info rev;
	unsigned char sha1[20];
	const char *parent = "HEAD";

	if (!active_nr && read_cache() < 0)
		die("Cannot read index");

	if (amend)
		parent = "HEAD^1";

	if (get_sha1(parent, sha1))
		commitable = !!active_nr;
	else {
		init_revisions(&rev, "");
		rev.abbrev = 0;
		setup_revisions(0, NULL, &rev, parent);
		DIFF_OPT_SET(&rev.diffopt, QUIET);
		DIFF_OPT_SET(&rev.diffopt, EXIT_WITH_STATUS);
		run_diff_index(&rev, 1 /* cached */);

		commitable = !!DIFF_OPT_TST(&rev.diffopt, HAS_CHANGES);
	}

Diff-index in this case will stop as soon as the first difference
found, while just using the output method will enforce finding all the
differences, which is just a waste of time, if all you need is just to
know if index is different to HEAD.

