From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Rebase/cherry-picking idea
Date: Mon, 26 Nov 2007 17:25:38 -0800
Message-ID: <7vhcj8eay5.fsf@gitster.siamese.dyndns.org>
References: <109026BC-408F-451A-8F7C-A4012DD8DBDF@wincent.com>
	<C3971B37-F75A-40EE-B30A-E88E5DAFAD55@lrde.epita.fr>
	<D21294CA-6FD0-40F5-B0D6-5155865DA69A@wincent.com>
	<CDF48716-F198-4B33-A5F5-8A2DE1F177EB@wincent.com>
	<474AC136.8060906@viscovery.net>
	<7vy7ckgbpf.fsf@gitster.siamese.dyndns.org>
	<20071127010801.GF14735@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Wincent Colaiuta <win@wincent.com>,
	Benoit Sigoure <tsuna@lrde.epita.fr>,
	Git Mailing List <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Nov 27 02:26:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IwpDD-0000bN-7i
	for gcvg-git-2@gmane.org; Tue, 27 Nov 2007 02:26:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751643AbXK0BZs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2007 20:25:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751849AbXK0BZs
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Nov 2007 20:25:48 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:40376 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751596AbXK0BZr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2007 20:25:47 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 2405D2F0;
	Mon, 26 Nov 2007 20:26:08 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 704D89A2AD;
	Mon, 26 Nov 2007 20:26:02 -0500 (EST)
In-Reply-To: <20071127010801.GF14735@spearce.org> (Shawn O. Pearce's message
	of "Mon, 26 Nov 2007 20:08:01 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66153>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> So I guess we could rename those two "internal" environment variables
> to use a leading _ to make them different from "user level" variables,
> but why change them now?  I really don't see a compelling reason to
> break that part of the "API" between porcelain/plumbing.

I don't either, which means I do not see a compelling reason to have
underscore in front of that cherry-pick message environment either.

About the patch itself, I think replacing the whole message, not just
"and commit the result." part, might make more sense.

	help_message = getenv("_GIT_CHERRY_PICK_HELP");
	fprintf(stderr, "Automatic %s failed.  "
		"After resolving the conflicts,\n"
		"mark the corrected paths with 'git add <paths>' "
		"and %s.\n", me,
		help_message ? help_message : "commit the result");
	if (action == CHERRY_PICK && !help_message) {
		fprintf(stderr, "When commiting, use the option "
			"'-c %s' to retain authorship and message.\n",
			find_unique_abbrev(commit->object.sha1,
			...

Some other caller can be written to guide the user resolving and do the
"git add" part for the user, and "mark the corrected paths with 'git add
<paths>'" may not suit the need for such a caller.

Which would mean:

	help_message = getenv("GIT_CHERRY_PICK_HELP");
        if (!help_message) {
        	static char helpbuf[1024];
                help_message = helpbuf;
                sprintf(help_message,
                	"  After resolving the conflits,\n"
			"mark the corrected paths with 'git add <paths>' "
			"and commit the result.\n"
			"When commiting, use the option "
			"'-c %s' to retain authorship and message.\n",
			find_unique_abbrev(commit->object.sha1,
						DEFAULT_ABBREV));
        }
	fprintf(stderr, "Automatic %s failed.%s", help_message);
	exit(1);

But I do not care too deeply either way.
