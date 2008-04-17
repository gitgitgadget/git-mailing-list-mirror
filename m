From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] git-branch: add support for --merged and --no-merged
Date: Thu, 17 Apr 2008 14:07:19 -0700
Message-ID: <7vzlrsmbqw.fsf@gitster.siamese.dyndns.org>
References: <7vr6d4nvkm.fsf@gitster.siamese.dyndns.org>
 <1208463890-2870-1-git-send-email-hjemli@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 17 23:25:41 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JmbL5-0003TF-HO
	for gcvg-git-2@gmane.org; Thu, 17 Apr 2008 23:08:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753816AbYDQVHa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Apr 2008 17:07:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753828AbYDQVH3
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Apr 2008 17:07:29 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:57996 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753736AbYDQVH2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Apr 2008 17:07:28 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id A67581A0D;
	Thu, 17 Apr 2008 17:07:27 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id D277A1A0B; Thu, 17 Apr 2008 17:07:22 -0400 (EDT)
In-Reply-To: <1208463890-2870-1-git-send-email-hjemli@gmail.com> (Lars
 Hjemli's message of "Thu, 17 Apr 2008 22:24:50 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79826>

Lars Hjemli <hjemli@gmail.com> writes:

> Junio C Hamano wrote:
>> If the existing --contains implemenation can be extended to allow negative
>> selection, we do not have to introduce yet another mechanism that is very
>> similar.
>
> Very true, so here's an updated version which reuses has_commit(). Thanks
> for the feedback.

> +	if (mergefilter > -1) {
> +		branch.item = lookup_commit_reference_gently(sha1, 1);
> +		if (!branch.item)
> +			die("Unable to lookup HEAD of branch %s", refname);
> +		if (mergefilter == 0 && has_commit(head_sha1, &branch))
> +			return 0;
> +		if (mergefilter == 1 && !has_commit(head_sha1, &branch))
> +			return 0;
> +	}

You did not answer my question as to how --contains and --merged relate to
each other.  I'll answer it myself (please add a documentation updates, as
this would be confusing).  The output from the former is "branches I need
to be careful about, if I were to rewind and rebuild this branch" (that is
what I invented the option for).  The output from the latter is "branches
I can remove with 'git branch -d'".

 * --contains (aka with_commit) gets a single commit; only the branches
   that are descendant of that named commit will be shown (iow, these
   branches contain the commit), with the expression:

	/* Filter with with_commit if specified */
	if (!has_commit(sha1, ref_list->with_commit))
		return 0;

   where "sha1" is the commit at the tip of the branch in question in this
   round of the loop.

 * --merged is the opposite way.  Only the branches whose tips are
   ancestors of the HEAD will be shown (iow, the HEAD contains these
   branches), with the expression:

   	if (has_commit(head_sha1, &branch))

   where "head_sha1" is the HEAD, and "branch" is the branch in question
   in this round of the loop.  i.e. it asks the same question as
   --contains but in the opposite way.
