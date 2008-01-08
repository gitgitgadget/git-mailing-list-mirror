From: Junio C Hamano <gitster@pobox.com>
Subject: An interaction with ce_match_stat_basic() and autocrlf
Date: Tue, 08 Jan 2008 04:12:24 -0800
Message-ID: <7vfxx8tt1z.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: torvalds@linux-foundation.org
X-From: git-owner@vger.kernel.org Tue Jan 08 13:13:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCDKJ-0005po-4a
	for gcvg-git-2@gmane.org; Tue, 08 Jan 2008 13:13:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751411AbYAHMMd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jan 2008 07:12:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752015AbYAHMMc
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jan 2008 07:12:32 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:41416 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751339AbYAHMMb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jan 2008 07:12:31 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 4999FCB21;
	Tue,  8 Jan 2008 07:12:29 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id A42ABCB20;
	Tue,  8 Jan 2008 07:12:26 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69869>

There is an interesting interaction with the stat matching and
autocrlf.

    $ git init
    $ git config core.autocrlf true
    $ echo a >a.txt
    $ git add a.txt
    $ unix2dos a.txt
    $ git diff
    diff --git a/a.txt b/a.txt

At this point, the index records a blob with LF line ending,
while the work tree file has the same content with CRLF line
ending.  And the funny thing is that once you get into this
situation it is unfixable short of "git add a.txt".  Most
notably, "git update-index --refresh" (and the equilvalent
auto-refresh that is implicitly run by "git diff" Porcelain)
will not update the cached stat information.

This is caused partly by the breakage in size_only codepath of
diff.c::diff_populate_filespec().  When taking the file contents
from the work tree, it just gets stat data and thinks it got the
final size, but it should actually convert the blob data into
canonical format.  diff.c::diffcore_skip_stat_unmatch() is
fooled by this and declares that the path is modified.

This can be fixed by not returning early even when size_only is
asked in the codepath.  It will make everything quite a lot more
expensive, as there currently is not a cheap way to ask "is this
path going to be munged by autocrlf or clean filter", but
getting the correct result is more important than getting a
quick but wrong result.

But that is just a half of the story.

 (1) It won't make the entry stat clean, as refresh_index()
     later called from builtin-diff.c to clean up the stat
     dirtiness works without paying attention to the autocrlf
     conversion.

 (2) It won't help lower-level diff-files and internal callers
     to ce_match_stat() that checks if the path were touched.
     The "read-tree -m -u" codepath uses it to avoid touching
     the path with local modifications.  The standard way to
     clear the stat-dirtiness with "git update-index --refresh"
     still needs to be fixed anyway.

I was going to conclude this message by saying "I need to sleep
on this to see if I can come up with a clean solution", but it
appears I do not have much time left for actually sleeping X-<.
