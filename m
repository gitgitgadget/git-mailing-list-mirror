From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git exproll: steps to tackle gc aggression
Date: Tue, 06 Aug 2013 10:39:31 -0700
Message-ID: <7v61vihg6k.fsf@alter.siamese.dyndns.org>
References: <1375756727-1275-1-git-send-email-artagnon@gmail.com>
	<CACsJy8CGWJ07Uk8EBjfejdyshKB1NKk=_7VUoeyZWZgJFqCSkg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Fick <mfick@codeaurora.org>, Git List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 06 19:39:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V6lES-0004Me-PX
	for gcvg-git-2@plane.gmane.org; Tue, 06 Aug 2013 19:39:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756446Ab3HFRjg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Aug 2013 13:39:36 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34777 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756415Ab3HFRjf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Aug 2013 13:39:35 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3CCFA36C57;
	Tue,  6 Aug 2013 17:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XBHFgEYG6G2EZpU+Ql/sd1sa2Vs=; b=kIISHe
	+mvkS3D+4MmnkZHL6VCV15KG90x7hS3ekTS7dlfP0G19+ZSpR2PMPGT/AskZyabU
	Bojm25oVcNXdWH36TbVI6MQHS6Pcws0LbMaHYM0raLchMuLyfbYJJRb0wix+FQux
	4J4NmYOuxWAVyocFjCZA0nPmPGg/sGT7FlpHY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qfVhVXXzUTc540gYH0feB2d+JP9IK1LB
	I4wr6yThP/WSf4cKH0nyG6Z0dsIC2GnyjB+cRJrz3FfbGY84t5uhzO09m9Va/9Y4
	oBomoF8vKdjtk1YBn4fKZx7DPt9BdModAJGeyck9M5T7vy8U1xFFSO3N4W349rk9
	HTeMEzGx5gk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 30AF836C56;
	Tue,  6 Aug 2013 17:39:35 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 18C3B36C54;
	Tue,  6 Aug 2013 17:39:33 +0000 (UTC)
In-Reply-To: <CACsJy8CGWJ07Uk8EBjfejdyshKB1NKk=_7VUoeyZWZgJFqCSkg@mail.gmail.com>
	(Duy Nguyen's message of "Tue, 6 Aug 2013 19:24:50 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 28325256-FEBF-11E2-8CDA-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231767>

Duy Nguyen <pclouds@gmail.com> writes:

> On Tue, Aug 6, 2013 at 9:38 AM, Ramkumar Ramachandra <artagnon@gmail.com> wrote:
>> +               Garbage collect using a pseudo logarithmic packfile maintenance
>> +               approach.  This approach attempts to minimize packfile churn
>> +               by keeping several generations of varying sized packfiles around
>> +               and only consolidating packfiles (or loose objects) which are
>> +               either new packfiles, or packfiles close to the same size as
>> +               another packfile.
>
> I wonder if a simpler approach may be nearly efficient as this one:
> keep the largest pack out, repack the rest at fetch/push time so there
> are at most 2 packs at a time. Or we we could do the repack at 'gc
> --auto' time, but with lower pack threshold (about 10 or so). When the
> second pack is as big as, say half the size of the first, merge them
> into one at "gc --auto" time. This can be easily implemented in
> git-repack.sh.

Another random thought.

Imagine we have a cheap way to enumerate the young objects without
the usual history traversal.  For example, list of all loose objects
and what appears in the .idx files that are young.

We can reconstruct "names" for trees and blobs from such a list of
object names; if a commit in the list refers to a tree, that tree is
the top level, and a blob or a tree that appears in such a top-level
tree can be given a "name" for its place in the tree (recursively).
I suspect we would end up giving names to large majority of trees
and blobs in such a list by doing so.

If these suspicions turn out to be true, then we could:

 - run that enumeration algorithm to come up with a set of object
   names;

 - emit the tag objects in that set in the tagger timestamp order;

 - emit the commit objects in that set in the commit timestamp
   order, while noting the tree objects contained in the set, giving
   them name "";

 - "traverse" the trees and blobs in that set, giving the found ones
   names (do so without stepping outside the set);

 - emit the trees and blobs with their names.  Some objects may not
   have given any name, but that is OK as long as they are in the
   minority.

And feeding it to pack-objects to produce a single pack, and then
prune away the source of these young objects in the end.

The above could turn out to be much cheaper than the traditional
history traversal.
