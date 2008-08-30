From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git gui: show diffs with a minimum of 1 context line
Date: Sat, 30 Aug 2008 10:19:14 -0700
Message-ID: <7vtzd2ifot.fsf@gitster.siamese.dyndns.org>
References: <20080830164527.GA25370@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Sat Aug 30 19:20:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZU7f-0004Qe-Uz
	for gcvg-git-2@gmane.org; Sat, 30 Aug 2008 19:20:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752832AbYH3RTW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Aug 2008 13:19:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752887AbYH3RTW
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Aug 2008 13:19:22 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:44190 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752344AbYH3RTV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Aug 2008 13:19:21 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id C82DF67967;
	Sat, 30 Aug 2008 13:19:20 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id C088367965; Sat, 30 Aug 2008 13:19:16 -0400 (EDT)
In-Reply-To: <20080830164527.GA25370@localhost> (Clemens Buchacher's message
 of "Sat, 30 Aug 2008 18:45:27 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: C8A1764E-76B7-11DD-B4C8-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94391>

Clemens Buchacher <drizzd@aon.at> writes:

> git apply does not handle diffs without context correctly.

NAK on this part of the proposed commit log message.

"git-apply" is more anal than other "patch" implementations in that it
tries to make sure that a hunk that touches the trailing end actually
applies to the trailing end of the file.  If a patch is generated with
non-zero context, we can detect by presense of trailing context lines that
a patch is _not_ about modifying the trailing end, but with a -U0 patch,
every hunk will come without trailing context, so you need to disable that
safety by asking for --unidiff-zero option.

> ... Configuring git
> gui to show zero context lines therefore breaks staging.

So another option might be to pass --unidiff-zero iff/when it is feeding
such a patch to fix this particular "user error" of "git-apply" program.

Having said that,

> In reply to this patch I will send a first attempt at fixing this problem
> instead of avoiding it.

I suspect there are some things "git-apply" should be able to _figure out_
that the user is giving it a -U0 patch and automatically flip unidiff_zero
option on.  For example, if the _first_ hunk of a patch does not begin
with "@@ -0,0 +N,M @@" nor with "@@ -1,L +N,M @@" (i.e. the hunk claims to
apply not at the beginning) and the hunk does not have leading context
lines, _and_ if that first hunk does not have trailing context lines, then
it is clearly a -U0 patch (or it could be a corrupt patch, but let's
discount that possibility for now).

Even if the hunk does claim to apply at the beginning, in which case we
cannot determine if it is a -U0 patch by looking at the lack of leading
context, if it has any context lines, we can tell it is _not_ a -U0 patch.
When the first hunk that applies to the beginning lacks any context, we
cannot really tell if it is -U0 or not (the other possibility is a total
rewrite of the file from the beginning to the end).  Even in that case,
you could look at the next hunk --- if you have a hunk that applies to
the same path after looking at such a "first" hunk without context, then
it clearly is a -U0 patch.
