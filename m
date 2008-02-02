From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH/RFC 00/13] git-apply --whitespace=fix updates
Date: Sat,  2 Feb 2008 02:54:06 -0800
Message-ID: <1201949659-27725-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 02 11:55:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLG1h-0005A3-7X
	for gcvg-git-2@gmane.org; Sat, 02 Feb 2008 11:55:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761041AbYBBKy1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Feb 2008 05:54:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761392AbYBBKy0
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Feb 2008 05:54:26 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:43736 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761041AbYBBKyZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Feb 2008 05:54:25 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 3197650E8
	for <git@vger.kernel.org>; Sat,  2 Feb 2008 05:54:22 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 8BD3B50E7
	for <git@vger.kernel.org>; Sat,  2 Feb 2008 05:54:21 -0500 (EST)
X-Mailer: git-send-email 1.5.4.2.g41ac4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72248>

This mini-series teaches "git-apply --whitespace=fix" to cope
better with the whitespace changes it introduces to the context.

[PATCH 01/13] builtin-apply.c: refactor small part that matches context
[PATCH 02/13] builtin-apply.c: restructure "offset" matching
[PATCH 03/13] builtin-apply.c: push match-beginning/end logic down

These three are preparatory clean-ups to isolate the parts the
later patches need to update.

[PATCH 04/13] builtin-apply.c: make it more line oriented
[PATCH 05/13] builtin-apply.c: optimize match_beginning/end processing a bit.
[PATCH 06/13] builtin-apply.c: mark common context lines in lineinfo structure.

These introduce an array of hash values for each line in the
patch preimage, postimage and the target file, and simplifies
the code to find the place that the hunk applies.  The ultimate
motivation is to allow applying patches with whitespace
differences, but this step does not do that yet.

The matching logic that uses hash code of lines could also make
it faster to find the place the hunk applies to, but that is not
the primary purpose of the change.  We would however need to
bench it so that this does not at least slow it down too much.
I haven't done that yet.

[PATCH 07/13] builtin-apply.c: clean-up apply_one_fragment()

This reduces 3 variables (old, oldlines, oldsize) that keep
track of the preimage being built (and their "new" counterparts
for the postimage) to 2 variables (old, oldlines).  This cannot
be done cleanly without the conversion to a line oriented data
structure introduced by 04/13 (remove_first_line() is the most
problematic one).

[PATCH 08/13] builtin-apply.c: simplify calling site to apply_line()
[PATCH 09/13] builtin-apply.c: do not feed copy_wsfix() leading '+'
[PATCH 10/13] builtin-apply.c: move copy_wsfix() function a bit higher.

The function apply_line() reads one line of a patch and makes
whitespace corrections.  These three are preparatory steps to
make the function usable for correcting whitespaces in context
lines.  The function is renamed to copy_wsfix().

[PATCH 11/13] builtin-apply.c: pass ws_rule down to match_fragment()
[PATCH 12/13] git-apply --whitespace=fix: fix whitespace fuzz introduced by previous run

This actually implements the application of a patch whose
preimage context lines do not match the target file but do match
if the whitespace breakages in them are corrected.  The fixing
goes the other way as well.  We may still have files with
whitespace breakages, and the submitter may have based the patch
on a tree whose whitespace breakages have been fixed.  In such a
case, the lines in the target file needs to be cleaned up and
compared with the cleaned-up context lines from the preimage of
the patch.

[PATCH 13/13] core.whitespace: cr-at-eol

This introduces a new error mode "cr-at-eol" which tells git not
to treat a CR at the end of line as a trailing whitespace error.
This is from my earlier patch sent to the list, and does not
depend on "the whitespace correction in the context" topic
above, but rebased because it textually conflicts with the
series.
