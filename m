From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] Respecting core.autocrlf when showing objects
Date: Thu, 12 Jun 2008 12:33:01 -0700
Message-ID: <7vtzfy8n4i.fsf@gitster.siamese.dyndns.org>
References: <7vprqqdwh7.fsf@gitster.siamese.dyndns.org>
 <cover.1213084587.git.marius@trolltech.com>
 <alpine.DEB.1.00.0806101632570.1783@racer>
 <7vk5gxc4gz.fsf@gitster.siamese.dyndns.org> <484F6A27.1040602@trolltech.com>
 <alpine.DEB.1.00.0806112000400.1783@racer> <4850E647.7050602@trolltech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marius Storm-Olsen <marius@trolltech.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>, git <git@vger.kernel.org>
To: "J. Bruce Fields" <bfields@citi.umich.edu>
X-From: git-owner@vger.kernel.org Thu Jun 12 21:34:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6sYs-0004fW-JU
	for gcvg-git-2@gmane.org; Thu, 12 Jun 2008 21:34:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754260AbYFLTdY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2008 15:33:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754283AbYFLTdY
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jun 2008 15:33:24 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:33512 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754241AbYFLTdX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2008 15:33:23 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 747F431C2;
	Thu, 12 Jun 2008 15:33:21 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 6B9C031C1; Thu, 12 Jun 2008 15:33:15 -0400 (EDT)
In-Reply-To: <4850E647.7050602@trolltech.com> (Marius Storm-Olsen's message
 of "Thu, 12 Jun 2008 11:03:03 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 6A99A95C-38B6-11DD-92D3-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84777>

Marius Storm-Olsen <marius@trolltech.com> writes:

> Johannes Schindelin said the following on 11.06.2008 21:06:
>> On Wed, 11 Jun 2008, Marius Storm-Olsen wrote:
>>> Well, consider this:
>>>
>>> Say you are merging two branches, and know that you want to just
>>> use the parts which conflict from the branch being merged in. Then
>>> you simply do:
>>>
>>> 	git merge side
>>> 	git show :3:file.txt > file.txt
>>
>> This is not really how I would do things.  I would do
>>
>> 	git checkout side file.txt here.
>
> Uhm, 'git checkout side file.txt' is not the same file content
> (ignoring EOLs please) as 'git show :3:file.txt'.
> Ref: user-manual.html#conflict-resolution

Bruce, I think the comment in this quoted section is wrong.

True, the combined diff can show only the interesting differences between
the three, but that is not because we munge stage #2 and #3.  They contain
verbatim copies from the HEAD and the MERGE_HEAD respectively, and the
combining logic runs three-way diffs between the three stages to discard
the hunks that the result comes solely from either stage #2 or stage #3.

So perhaps something like this is in order...

---

 Documentation/user-manual.txt |   15 +++++++--------
 1 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index bfde507..64a820b 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -1254,16 +1254,15 @@ these three "file stages" represents a different version of the file:
 
 -------------------------------------------------
 $ git show :1:file.txt	# the file in a common ancestor of both branches
-$ git show :2:file.txt	# the version from HEAD, but including any
-			# nonconflicting changes from MERGE_HEAD
-$ git show :3:file.txt	# the version from MERGE_HEAD, but including any
-			# nonconflicting changes from HEAD.
+$ git show :2:file.txt	# the version from HEAD.
+$ git show :3:file.txt	# the version from MERGE_HEAD.
 -------------------------------------------------
 
-Since the stage 2 and stage 3 versions have already been updated with
-nonconflicting changes, the only remaining differences between them are
-the important ones; thus linkgit:git-diff[1] can use the information in
-the index to show only those conflicts.
+When you ask linkgit:git-diff[1] to show the conflicts, it runs a
+three-way diff between the conflicted merge results in the work tree with
+stages 2 and 3 to show only hunks whose contents come from both sides,
+mixed (in other words, when a hunk's merge results come only from stage 2,
+that part is not conflicting and is not shown.  Same for stage 3).
 
 The diff above shows the differences between the working-tree version of
 file.txt and the stage 2 and stage 3 versions.  So instead of preceding
