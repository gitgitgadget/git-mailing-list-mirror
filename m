From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [1.7.9] usage regression when merging annotated tag objects
Date: Fri, 03 Feb 2012 15:54:36 -0800
Message-ID: <7vd39vlbgj.fsf@alter.siamese.dyndns.org>
References: <CADeLxZTsq1M5oEb1u5Oqfxq3dYXL6E_uN9bXaTqaOZiA0fgdJQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Bart Trojanowski <bart@jukie.ca>
X-From: git-owner@vger.kernel.org Sat Feb 04 00:55:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RtSyE-0004kw-Vg
	for gcvg-git-2@plane.gmane.org; Sat, 04 Feb 2012 00:55:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753884Ab2BCXyk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Feb 2012 18:54:40 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59225 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753312Ab2BCXyj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Feb 2012 18:54:39 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D24AB738F;
	Fri,  3 Feb 2012 18:54:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=I9VHu1x0hXy7OEoHWwVeRmZ0CqA=; b=nY+C4N
	Nmm3zV3E5ofEgoTyjx1odThIStKxEZgPNs6Vsw1WRT6wMjxYO4ro8hJ9rV960hUH
	zU6a2OjMfY1fbD0VuoTxgdDUZkngq+59QH68P4sXEAHoSZjQ3luzOTC4INGWJt6m
	ko340GUNDF5xAWvSTntg6DMdogBzaJppdUTsc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=W4JsAjTsCe+8p+E4TlGfvtC7HCgkYod1
	wIxxmlQexV2e3xWaRA1mT2DTCOYIGYIYFpWhzVJsmffBL9dpYcDh7Ryg+zcP59Yh
	EPnljWsZDTHMt4iqGDbb9mbGibDVY0y8jcjmm5Mv+tT82q/HmNBE76SnBmcfl10z
	sXI4KjzN7Uw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C94BB738E;
	Fri,  3 Feb 2012 18:54:38 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4C218738D; Fri,  3 Feb 2012
 18:54:38 -0500 (EST)
In-Reply-To: <CADeLxZTsq1M5oEb1u5Oqfxq3dYXL6E_uN9bXaTqaOZiA0fgdJQ@mail.gmail.com> (Bart
 Trojanowski's message of "Fri, 3 Feb 2012 18:08:06 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6E8DBF00-4EC2-11E1-BB90-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189832>

Some examples you gave were irrelevant, so I'd give an updated version.

Here are the facts of the day, without judging if the behaviour is good or
bad.

   1) If you are at Linux v3.2.2 and do not have any development on top, 

        $ git merge v3.2.3

      historically would have fast-forwarded. Git v1.7.9 would now create a
      merge commit, authored by you (who is unlikely to be Linus).

   2) You do not want such a merge, so try to work it around by this:

        $ git merge --ff-only v3.2.3
	fatal: Not possible to fast-forward, aborting.

      which is refused because merging a tag object requires a new merge
      commit.

Here are my assessments.

1. I do not think the first one is a real issue. 99% of the people who are
   merely following along the upstream will never say "git merge v3.2.3".
   They will instead say "git pull" and this _will_ fast-forward.  No
   merging of tag objects involved.  Also when they want to check out that
   specific version, they won't be using "git merge".  It will be "git
   checkout v3.2.3".  So I do not think this is an issue for the case
   where it used to result in a fast-forward.

1.5 A variant of the first one is when you have forked and are trying to
   synchronize with the latest stable. In that case, you _do_ want a merge
   to happen. It is possible that you may not want to get the "mergetag"
   header in the resulting merge commit, and "git merge v3.2.3^0" is a new
   way to do so.

   Strictly speaking, this _is_ a usage regression caused by the new
   meaning "git merge" gained in v1.7.9.  Recording the tag in the a merge
   commit, however, is the whole point of "git merge v3.2.3" that is given
   a tag; this behaviour is not going to to change.

2. This is somewhat problematic. "git merge --ff-only v2.6.29" to people
   who merely follow Linus has always been possible, and I would expect it
   to be the case.

   But again, the reason they said --ff-only in the first place is because
   they feared that they might have some unexpected commits in their
   history, and asked "git merge" to error out if the command has to
   create a merge to let them know.  So at that point, they could be
   trained to run "git merge --ff-only v3.2.3^0" instead, *given enough
   clue*.

   The problem is that we are not giving enough clue.  We just say "Not
   possible to fast-forward" without explaining why.

   We could solve this in one of two ways. We could tell them to merge
   v3.2.3^0 instead. Or we could just go ahead and do that for them
   automatically ourselves.  I am inclined to say that we should unwrap
   the tag given from the command line when --ff-only was given, i.e. we
   do the latter.
