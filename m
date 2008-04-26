From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Simplify and fix --first-parent implementation
Date: Fri, 25 Apr 2008 17:11:53 -0700
Message-ID: <7viqy5o4om.fsf@gitster.siamese.dyndns.org>
References: <20080425234556.D60FD5461@aristoteles.cuci.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Stephen R. van den Berg" <srb@cuci.nl>
X-From: git-owner@vger.kernel.org Sat Apr 26 02:12:49 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JpY25-000263-4x
	for gcvg-git-2@gmane.org; Sat, 26 Apr 2008 02:12:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756011AbYDZAMA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Apr 2008 20:12:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754875AbYDZAMA
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Apr 2008 20:12:00 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:57290 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754056AbYDZAL7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Apr 2008 20:11:59 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 851924258;
	Fri, 25 Apr 2008 20:11:58 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id B73194256; Fri, 25 Apr 2008 20:11:55 -0400 (EDT)
In-Reply-To: <20080425234556.D60FD5461@aristoteles.cuci.nl> (Stephen R. van
 den Berg's message of "Fri, 25 Apr 2008 20:10:46 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80361>

"Stephen R. van den Berg" <srb@cuci.nl> writes:

> ---

No explanation of what the patch does, nor justification of why it is a
good change?

Please also sign your patch.

> @@ -462,19 +461,18 @@ static int add_parents_to_list(struct rev_info *revs, struct commit *commit, str
>  
>  	left_flag = (commit->object.flags & SYMMETRIC_LEFT);
>  
> -	rest = !revs->first_parent_only;
> -	for (parent = commit->parents, add = 1; parent; add = rest) {
> +	for (parent = commit->parents; parent; parent = parent->next) {
>  		struct commit *p = parent->item;
>  
> -		parent = parent->next;
>  		if (parse_commit(p) < 0)
>  			return -1;
>  		p->object.flags |= left_flag;
>  		if (p->object.flags & SEEN)
>  			continue;
>  		p->object.flags |= SEEN;
> -		if (add)
> -			insert_by_date(p, list);
> +		insert_by_date(p, list);
> +		if(revs->first_parent_only)
> +			break;
>  	}

The original code makes sure all the parents of the given commits are
marked as SEEN (and SYMMETRIC_LEFT if needed), even when only it traverses
the first parent.  By leaving the loop early, you are changing the
semantics of the code.  Other parents, when reached from other paths while
traversing the commit ancestry chain, will behave differently between the
version with your patch and without.

You would need to explain how and why that behaviour change is a "fix" in
the proposed commit log message.  "Before the change, traversing a history
of this shape behaves like this, but that is wrong for such and such
reasons, and I identified the culprit to be this code.  With this patch,
the same traversal will instead behave this way, which is what I expect to
be the right behaviour".
