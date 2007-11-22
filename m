From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/4] Teach git-add--interactive to accept a file path to patch
Date: Thu, 22 Nov 2007 03:29:03 -0800
Message-ID: <7vlk8q5xj4.fsf@gitster.siamese.dyndns.org>
References: <1195648601-21736-1-git-send-email-win@wincent.com>
	<1195648601-21736-2-git-send-email-win@wincent.com>
	<1195648601-21736-3-git-send-email-win@wincent.com>
	<20071121152118.GG24108@sigill.intra.peff.net>
	<7vejejfi28.fsf@gitster.siamese.dyndns.org>
	<C6E820C8-91E9-48B2-9219-377CA83163A7@wincent.com>
	<7vk5obb09a.fsf@gitster.siamese.dyndns.org>
	<20071122091356.GD7153@sigill.intra.peff.net>
	<7v8x4q7gns.fsf@gitster.siamese.dyndns.org>
	<887C3CB1-D21B-4143-8D4E-BF37709FA102@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Thu Nov 22 12:29:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IvAFN-0001ah-29
	for gcvg-git-2@gmane.org; Thu, 22 Nov 2007 12:29:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751429AbXKVL3L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Nov 2007 06:29:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751506AbXKVL3L
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Nov 2007 06:29:11 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:58106 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751073AbXKVL3K (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Nov 2007 06:29:10 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id C82B42F2;
	Thu, 22 Nov 2007 06:29:30 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 3488395243;
	Thu, 22 Nov 2007 06:29:27 -0500 (EST)
In-Reply-To: <887C3CB1-D21B-4143-8D4E-BF37709FA102@wincent.com> (Wincent
	Colaiuta's message of "Thu, 22 Nov 2007 11:44:54 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65799>

Wincent Colaiuta <win@wincent.com> writes:

> If I wanted to add entire files I would have just typed:
>
> 	git add foo
>
> So I don't think the proposal to add "-p" (jump to "patch" subcommand)  
> and "-a" (jump to "add untracked" subcommand) are a very good idea,  
> seeing as we already have builtin-add for adding entire files.

It is quite valid for users to run:

	git add -i \*.sh

and be able to choose from a list which paths to stage (as a
whole), as well as choose from a list which files to run the
per-hunk staging interface.  "git add \*.sh" won't give you any
chance to choose which ones to stage, and that's what we have
"-i" (interactive) mode in "git add" for.

I think you can massage "git add --partial foo" given by the
user internally into "git-add--interactive -i --patch foo".  I
strongly suspect that "direct to patch subcommand" mode needs
more than just initially jumping into the subcommand (for
example, you would want to exit when the patch selection
interaction ends, without going back to the main menu), and we
would want a signal stronger than mere presense of pathspecs to
trigger such a specialized behaviour.

By the way, the arguments on the command line to git commands
after "--" are generally pathspecs, iow, patterns to specify
groups of files.  Please do not introduce unnecessary
inconsistencies to the UI by requiring them to be exact pathname
only in this particular mode of the command and nowhere else.

There was one funny thing I fixed up.  The arguments to the
interactive_add() function in builtin-add.c was like this:

	int interactive_add(const char **argv, int argc)

Anybody who writes a function with such a signature and do not
notice its craziness before sending it out either (1) has never
programmed in C, (2) did not review the code before submitting,
or (3) worked too hard and was too tired.

I suspect, judging from the timestamp of your message, it was
(3) this time.  The collaborative development is not a race ---
don't work too hastily and too hard; please relax and review
after a good night's sleep before sending things out.
