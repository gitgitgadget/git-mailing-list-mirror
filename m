From: Junio C Hamano <junio@pobox.com>
Subject: unpack-trees traversing with index quite broken...
Date: Fri, 04 Sep 2009 23:40:13 -0700
Message-ID: <7vr5ul99o2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Sep 05 08:41:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MjoxW-0003FC-UB
	for gcvg-git-2@lo.gmane.org; Sat, 05 Sep 2009 08:41:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754985AbZIEGk2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Sep 2009 02:40:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754398AbZIEGk2
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Sep 2009 02:40:28 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:58049 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751057AbZIEGkT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Sep 2009 02:40:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0691D26749;
	Sat,  5 Sep 2009 02:40:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:from:date:message-id:mime-version:content-type; s=sasl; bh=1Yio
	jKUgzsXxFjfSUfMfOMA7O90=; b=w5OYn7bce6wXW3sB4Y5EMM9bdduzTxkXeXGY
	HVC0FqI5FspyvGb6WkC3/6/D0DZaFxhGtjeXMhMSTEqvM5lawV4sx+i9vk5VB1PB
	m446RmgHsQHsHx+lPC5R7vi9q6FivQvbxZJhDrqnBTRjLwmJq2teiWqubT18+m4M
	SNQU9nE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:from:date:message-id:mime-version:content-type; q=dns; s=sasl; b=
	leIwKyCX7fSRHpZazVrju6zB8sDMWlh7Pf2WglRe9UyIZRXLAagWYeXNs1NbRBWJ
	xc6CYCGzuOtF7cE3K1Cm2XnPTXSjYt72CAxpAfymgAFEqFKZrktfmHNVnUmodhoD
	P7UvJK1B+dV+qyyLhdYSufkExfu1nUFD/MmVi19vL6g=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id DE78926744;
	Sat,  5 Sep 2009 02:40:17 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2813126743; Sat,  5 Sep
 2009 02:40:15 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: F9B8AB28-99E6-11DE-94E5-A13518FFA523-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127783>

Linus,

I found an issue I do not know how to resolve.

Suppose you try to merge these three trees:

 - Tree #1 (ancestor)
   t   tree, in which there is an entry f that is a blob
   t/f blob

 - Tree #2 (ours)
   t   blob
   t-f blob

 - Tree #3 (theirs)
   t-f blob

The index matches our tree.

The callchain that causes "read-tree -m -u #1 #2 #3" misbehave looks like this.

unpack_trees()
->traverse_trees()
  entry[0] = "t" (tree taken from Tree #1)
  entry[1] = "t" (blob taken from Tree #2)
  entry[2] = nothing
  ->unpack_callback()
    ce = "t" (blob taken from the index)
    ->unpack_nondirectories()
      src[0] = "t" (blob from the index)
      src[1] = conflict (tree taken from Tree #1)
      src[2] = "t" (blob taken from Tree #2)
      src[3] = NULL
    ->call_unpack_fn()
      This callback is perfectly fine.
    /* Now handle any directories.. unpack-trees.c, ll.336- */
    ->traverse_trees_recursive()
      Now we stepped into tree "t".
      ->traverse_trees()
        entry[0] = "f" (blob from "t/" tree in Tree #1)
        entry[1] = nothing (Tree #2 does not have "t/" subtree)
        entry[2] = nothing (Tree #3 does not have "t/" subtree)
        ->unpack_callback()
          ce = "t-f" (blob taken from the index)
          ->compare_entry(ce, entry[])
          <- "t-f" comes anything in "t/" directory, return negative

          Because we are processing "t/something" at this level, and
          "t-f" that should come earlier than any "t/something", we
          assume that there is no matching entries in the trees.
          ->unpack_index_entry(ce = "t-f")
            ->call_unpack_fn()
              This callback is utterly wrong.  "t-f" from the index
              has a matching entry in Tree #2 and Tree #3, but we
              haven't seen them yet!

At first, I thought that we could fudge this particular example by
noticing that "t-f" is earlier only because "t-f" sorts before "t/", the
path-prefix of the problematic level, and pretend the negative return from
compare_entry() as if it was positive (i.e. deferring the processing of
the index entry).  While this approach lets the problematic level
correctly feed only "t/f" to call_unpack_fn() and come back, and the rest
may proceed cleanly for this particular case, I do not think it is the
right solution.

If Tree #3 had another tree "t/" in it, the situation would look like this
instead:

 - Tree #1 (ancestor)
   t   tree, in which there is an entry f that is a blob
   t/f blob

 - Tree #2 (ours, matches the index)
   t   blob
   t-f blob

 - Tree #3 (theirs)
   t-f blob
   t   tree, in which there is an entry f that is a blob    

Since traverse_trees() wants to walk the trees in parallel, never seeking
back, I do not think it would feed t-f from Tree #2 and Tree #3 to the
unpack_callback() sanely.  Worse yet, the logic to walk the index in
parallel while this is happening (i.e. "Are we supposed to look at the
index too?" part) does not want to seek o->pos pointer back either, so I
am stuck X-<...
