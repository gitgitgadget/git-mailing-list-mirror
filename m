From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-merge segfault in 1.6.6 and master
Date: Thu, 21 Jan 2010 16:38:56 -0800
Message-ID: <7vaaw7j7mn.fsf@alter.siamese.dyndns.org>
References: <hj7abm$5vc$1@ger.gmane.org>
 <7vocko3802.fsf@alter.siamese.dyndns.org>
 <4B577C3F.7040608@brooklynpenguin.com>
 <7vtyugzabq.fsf@alter.siamese.dyndns.org>
 <4B5882BD.3090908@brooklynpenguin.com>
 <7viqavs4xc.fsf@alter.siamese.dyndns.org>
 <7vhbqfj8fy.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tim Olsen <tim@brooklynpenguin.com>,
	Miklos Vajna <vmiklos@frugalware.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 22 01:39:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NY7YS-0008C7-5C
	for gcvg-git-2@lo.gmane.org; Fri, 22 Jan 2010 01:39:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753403Ab0AVAjN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jan 2010 19:39:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752903Ab0AVAjM
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jan 2010 19:39:12 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:43734 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753113Ab0AVAjJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jan 2010 19:39:09 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7F9DB93507;
	Thu, 21 Jan 2010 19:39:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ha6kB4WU/t/4crdQT+vGOA1WSWE=; b=BvXjNh
	plJXIXszpjPKTn/wRgajWa2nR65kHVyWU3M0v3OUtkzHzvYbGR5DF87x2o4UdLi+
	weesucDw+HEs5mNCrNbmzy0f4jzaLmYdlG9fmejTxgCEtrii4pbqx+P5zP+nCRRl
	E3cyeI0GqKsBes2DZyc2uTOvUDNUKq8ovAi+k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nHe+pwK65EhJdQnxAfE2YHtLZ1JihuZI
	oJCY5tJ/jFRzpEXhYBmTvED6NdBfip79tzAfk4HcdVp1Rzu+2R4KEPeTjiUCPdvK
	vOkReMcD0mYV6hcRPDiMO77Y+sKKM26f+puq/1kvvfhKXRa4v+blZKuQLs2m2NR5
	tb+yCF+I4MI=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9ED4593503;
	Thu, 21 Jan 2010 19:39:03 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7DEF0934FE; Thu, 21 Jan
 2010 19:38:58 -0500 (EST)
In-Reply-To: <7vhbqfj8fy.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu\, 21 Jan 2010 16\:21\:21 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 8A45B180-06EE-11DF-950F-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137706>

Junio C Hamano <gitster@pobox.com> writes:

> After I stared at the code for more than two hours, I gave up trying to
> diagnose this by myself.  People more familiar with the merge-recursive
> implementation might be able to help figuring this out and may prove my
> suspicion wrong, but I have a feeling that without a fairly big rewrite
> the code is unsalvageable.

In the meantime, I think applying this patch is the right thing to do.

-- >8 --
Subject: merge-recursive: do not return NULL only to cause segfault

merge-recursive calls write_tree_from_memory() to come up with a virtual
tree, with possible conflict markers inside the blob contents, while
merging multiple common ancestors down.  It is a bug to call the function
with unmerged entries in the index, even if the merge to come up with the
common ancestor resulted in conflicts.  Otherwise the result won't be
expressible as a tree object.

We _might_ want to suggest the user to set GIT_MERGE_VERBOSITY to 5 and
re-run the merge in the message.  At least we will know which part of
process_renames() or process_entry() functions is not correctly handling
the unmerged paths, and it might help us diagnosing the issue.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 merge-recursive.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 1239647..cb53b01 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -202,14 +202,14 @@ struct tree *write_tree_from_memory(struct merge_options *o)
 
 	if (unmerged_cache()) {
 		int i;
-		output(o, 0, "There are unmerged index entries:");
+		fprintf(stderr, "BUG: There are unmerged index entries:\n");
 		for (i = 0; i < active_nr; i++) {
 			struct cache_entry *ce = active_cache[i];
 			if (ce_stage(ce))
-				output(o, 0, "%d %.*s", ce_stage(ce),
-				       (int)ce_namelen(ce), ce->name);
+				fprintf(stderr, "BUG: %d %.*s", ce_stage(ce),
+					(int)ce_namelen(ce), ce->name);
 		}
-		return NULL;
+		die("Bug in merge-recursive.c");
 	}
 
 	if (!active_cache_tree)
