From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-commit goes awry after git-add -u
Date: Wed, 15 Aug 2007 13:49:30 -0700
Message-ID: <7v643gplph.fsf@gitster.siamese.dyndns.org>
References: <f9v1t6$uph$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Salikh Zakirov <salikh@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 15 22:50:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ILPp1-0007LR-Vp
	for gcvg-git@gmane.org; Wed, 15 Aug 2007 22:50:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762346AbXHOUtj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 15 Aug 2007 16:49:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936160AbXHOUti
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Aug 2007 16:49:38 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:44800 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936091AbXHOUtg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Aug 2007 16:49:36 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id F2606121F0F;
	Wed, 15 Aug 2007 16:49:53 -0400 (EDT)
In-Reply-To: <f9v1t6$uph$1@sea.gmane.org> (Salikh Zakirov's message of "Wed,
	15 Aug 2007 23:16:59 +0900")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55945>

Salikh Zakirov <salikh@gmail.com> writes:

> I have observed incorret behaviour of git-commit after git-add -u, where
> it records deletions of files not related to the files touched by commit.

Does this fix the issue?

Ideally remove_file_from_cache() should have the invalidate call
inside just like add_file_to_cache() does, but there was a
technical reason it couldn't that I do not recall offhand, so I
am playing it safe here with this tentative patch to see if the
cause is a cache-tree corruption.

---
 builtin-add.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/builtin-add.c b/builtin-add.c
index 1591171..a5fae7c 100644
--- a/builtin-add.c
+++ b/builtin-add.c
@@ -115,6 +115,7 @@ static void update_callback(struct diff_queue_struct *q,
 			break;
 		case DIFF_STATUS_DELETED:
 			remove_file_from_cache(path);
+			cache_tree_invalidate_path(active_cache_tree, path);
 			if (verbose)
 				printf("remove '%s'\n", path);
 			break;
