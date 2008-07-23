From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] sort_in_topological_order(): avoid setting a commit
 flag
Date: Wed, 23 Jul 2008 12:02:30 -0700
Message-ID: <7vprp4ctkp.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.00.0807230148130.8986@racer>
 <alpine.DEB.1.00.0807230150480.8986@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: pasky@suse.cz, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jul 23 21:03:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLjco-0006ql-Ti
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 21:03:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753860AbYGWTCj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2008 15:02:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753661AbYGWTCj
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 15:02:39 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:60624 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752649AbYGWTCj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 15:02:39 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 4CEAA3765A;
	Wed, 23 Jul 2008 15:02:37 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 8806837657; Wed, 23 Jul 2008 15:02:33 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: EA546D64-58E9-11DD-9217-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89741>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> @@ -494,7 +493,8 @@ void sort_in_topological_order(struct commit_list ** list, int lifo)
>  			 * when all their children have been emitted thereby
>  			 * guaranteeing topological order.
>  			 */
> -			if (!--parent->indegree) {
> +			if (--parent->indegree == 1) {
> +				parent->indegree = 0;
>  				if (!lifo)
>  					insert_by_date(parent, &work);
>  				else
> @@ -505,7 +505,6 @@ void sort_in_topological_order(struct commit_list ** list, int lifo)
>  		 * work_item is a commit all of whose children
>  		 * have already been emitted. we can emit it now.
>  		 */
> -		commit->object.flags &= ~TOPOSORT;
>  		*pptr = work_item;
>  		pptr = &work_item->next;
>  	}

These two hunks look suspicious.

The "tips" used to enter that while() loop with zero indegree, its parents
examined and then entered the final list pointed by pptr with the toposort
scratch variables removed and indegree set to zero.  Now with the new +1
based code, they enter the while() loop with 1 indegree, and enter the
final list with indegree set to 1.

A parent that has only one child that is "tip" is discovered in the
while() loop, its indegree decremented (so it goes down to zero in the
original code and 1 in yours) and enters work queue to be processed.  It
used to have the toposort scratch variable removed in the second hunk
above, but that is done in the first hunk in your version.

So after this patch, indegree will be all zero for non-tip commits but
will be one for tip commits.  Is this intended?

I'd suggest dropping the "parent->indegree = 0" assignment and turn the
second hunk into "commit->indgree = 0" assignment.
