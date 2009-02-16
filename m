From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Improving CRLF error message; also, enabling autocrlf and
 safecrlf by default
Date: Sun, 15 Feb 2009 19:08:53 -0800
Message-ID: <7vljs7f58a.fsf@gitster.siamese.dyndns.org>
References: <loom.20090216T022524-78@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jason Spiro <jasonspiro4@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 16 04:10:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYtsg-00047d-2R
	for gcvg-git-2@gmane.org; Mon, 16 Feb 2009 04:10:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755765AbZBPDJB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Feb 2009 22:09:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755751AbZBPDJA
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Feb 2009 22:09:00 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:64966 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755729AbZBPDI7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Feb 2009 22:08:59 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 32C5C9ADA8;
	Sun, 15 Feb 2009 22:08:58 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 0BDE59ADA7; Sun,
 15 Feb 2009 22:08:54 -0500 (EST)
In-Reply-To: <loom.20090216T022524-78@post.gmane.org> (Jason Spiro's message
 of "Mon, 16 Feb 2009 02:45:43 +0000 (UTC)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 26FFED20-FBD7-11DD-9AD9-0433C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110121>

Jason Spiro <jasonspiro4@gmail.com> writes:

> One of the pre-commit hooks detects trailing whitespace:

All sample hooks are shipped disabled by default, so it shouldn't be
triggering unless you enabled it yourself.  The only known exception is
the binary packaged one for Cygwin, which we do not have much control over
here.

> if (/\s$/) {
> bad_line("trailing whitespace", $_);
> }
>
> Unfortunately, when I try to check in a file with DOS (CR+LF) line endings, 
> this hook triggers on every line.  This happens on Cygwin.  I haven't checked, 
> but I bet it happens on other platforms as well, as long as this hook runs.
>
> But the error message "trailing whitespace" doesn't clearly tell me what's 
> wrong.

I and other people agreed with your analysis above wholeheartedly several
months ago, and as a result, v1.6.0 and later version of git use a
different implementation for this check in the sample hook.  It does know
your CRLF line endings and therefore it should behave much better.

The fix to your situation might be just the matter of taking a copy of
templates/hooks--pre-commit.sample from the current git source code and
replacing .git/hooks/pre-commit in your repository.

The sample hook looks like the attached one these days.  It relies on an
enhancement 346245a (hard-code the empty tree object, 2008-02-13) that
appeared first in v1.5.5 so it may not work if your copy of git is older
than that version.

-- >8 -- cut here -- >8 --
#!/bin/sh
#
# An example hook script to verify what is about to be committed.
# Called by git-commit with no arguments.  The hook should
# exit with non-zero status after issuing an appropriate message if
# it wants to stop the commit.
#
# To enable this hook, rename this file to "pre-commit".

if git-rev-parse --verify HEAD 2>/dev/null
then
	against=HEAD
else
	# Initial commit: diff against an empty tree object
	against=4b825dc642cb6eb9a060e54bf8d69288fbee4904
fi

exec git diff-index --check --cached $against --
