From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Move stripspace() and launch_editor() to strbuf.c
Date: Sun, 11 Nov 2007 13:52:03 -0800
Message-ID: <7vtznsbgcc.fsf@gitster.siamese.dyndns.org>
References: <Pine.LNX.4.64.0711111728380.4362@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Nov 11 22:55:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrKlt-0003HN-DK
	for gcvg-git-2@gmane.org; Sun, 11 Nov 2007 22:55:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754587AbXKKVwM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2007 16:52:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754565AbXKKVwL
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Nov 2007 16:52:11 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:55345 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754547AbXKKVwJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2007 16:52:09 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 70FBF2F0;
	Sun, 11 Nov 2007 16:52:30 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id EAACF94733;
	Sun, 11 Nov 2007 16:52:26 -0500 (EST)
In-Reply-To: <Pine.LNX.4.64.0711111728380.4362@racer.site> (Johannes
	Schindelin's message of "Sun, 11 Nov 2007 17:29:12 +0000 (GMT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64521>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> These functions are already declared in strbuf.h, so it is only
> logical to move their implementations to the corresponding file.
> Particularly, since strbuf.h is in LIB_H, but both functions
> were missing from libgit.a.

I think this makes sense for stripspace(), but I have trouble
with launch_editor().

I do not object to have a function in strbuf API that takes a
buffer, allows the end user to interactively edit its content
and returns the updated content.  The function was perfectly
fine as a special purpose helper for git-commit and git-tag, but
if you look at the current launch_editor(), it is not suitable
as a generic strbuf library function:

 * "Launch" feels as if we are initiating an async operation and
   returning from the function without waiting for its
   completion, but this is not "launch" but "launch, wait and
   return the resulting string".  Probably this should be called
   edit_buffer() or something like that.

 * Instead of dying, it should return exit code and have the
   caller choose to die or take any alternative action.  The
   library function definitely should not say "if you are in an
   environment where we cannot let you interactively edit, use
   -F or -m option".
