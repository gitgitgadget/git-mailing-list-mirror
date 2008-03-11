From: Junio C Hamano <gitster@pobox.com>
Subject: "git diff-index" broken in 'next'
Date: Mon, 10 Mar 2008 19:41:33 -0700
Message-ID: <7vk5kagexu.fsf_-_@gitster.siamese.dyndns.org>
References: <7vmyp7j8ui.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.1.00.0803100735530.5896@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Mar 11 03:42:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JYuRY-00011M-8C
	for gcvg-git-2@gmane.org; Tue, 11 Mar 2008 03:42:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754702AbYCKCll (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2008 22:41:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754222AbYCKCll
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Mar 2008 22:41:41 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:42002 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752661AbYCKClk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Mar 2008 22:41:40 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id CE94522F2;
	Mon, 10 Mar 2008 22:41:38 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 334DF22F1; Mon, 10 Mar 2008 22:41:36 -0400 (EDT)
In-Reply-To: <alpine.LFD.1.00.0803100735530.5896@woody.linux-foundation.org>
 (Linus Torvalds's message of "Mon, 10 Mar 2008 07:38:25 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76786>

When you are in the middle of conflicted merge, it is useful to view "git
diff" that compares the stage #2 and your work tree (which has conflict
markers and both sides of the changes).  This still works.

However, with the unpack_trees() update, another form of useful sanity
check seems to be totally broken:

      $ git diff HEAD -- $conflicted_file

This used to show the diff between the HEAD and the work tree, but not
anymore.  It shows a diff as if the whole file is gone, and that is
because diff-lib.c::oneway_diff() gets idx==NULL from the caller for
unmerged entries. It never reaches show_modified() codepath.

I think it is somewhere around ll. 280 in unpack_callback() that causes
this, but I don't have time to dig this further for now.
