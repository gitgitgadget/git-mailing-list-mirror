From: Junio C Hamano <gitster@pobox.com>
Subject: [RFD] annnotating a pair of commit objects?
Date: Wed, 02 Jan 2013 23:03:00 -0800
Message-ID: <7vr4m2ycij.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 03 08:03:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tqeps-0008Ia-1a
	for gcvg-git-2@plane.gmane.org; Thu, 03 Jan 2013 08:03:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751625Ab3ACHDI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jan 2013 02:03:08 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61926 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751490Ab3ACHDH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jan 2013 02:03:07 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BD8BA870C;
	Thu,  3 Jan 2013 02:03:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=s
	v8B/I5VBw2dpSN3pOyDy8TEJeQ=; b=h8dEjSEhmJF8Z5NbSmVgCHOpBTILrh7FY
	02M4K6q1ml5zeu7cJXkn94CqFiDqE85NakLpoR846c448gs/eVazeR991IL9125D
	jitPnx8alv2NsdPBXlNDtkrpWCpdSAruv6CAP4XEPUJNyHp5sRfwu6IALZwcJPSV
	TRlTSWQzn8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=d38
	kPTMp6H6a6/Caxddj5HQ7R19iq6s+SrYL1R8lIgsp+pYVsxdwj7IqnuAAOY8Q+3r
	Kw9+sXHd/+Gk/3Bk7tnPMHaSetmwccVaumlfIBQ9MaeVsqEeJtLMfnn9bEPKwfBi
	3DzYI8T4mfbd3Bae/X7Q/oRSc8SDxdH5qbR8hZlw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AE7B68709;
	Thu,  3 Jan 2013 02:03:02 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EE8CC8707; Thu,  3 Jan 2013
 02:03:01 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9D19B514-5573-11E2-AF75-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212570>

I'd like a datastore that maps a pair of commit object names to
another object name, such that:

 * When looking at two commits A and B, efficiently query all data
   associated with a pair of commits <X,Y> where X is contained in
   the range A..B and not in B..A, and Y is contained in the range
   B..A and not in A..B.

 * When <X,Y> is registered in the datastore, and X is rewritten to
   X' and/or Y is rewritten to Y', the mapping is updated so that it
   can be queried with <X',Y'> as a new key, similar to the way a
   notes tree that maps object X can be updated to map object X'
   when such a rewrite happens.

The intended use case is to "go beyond rerere".  Given a history of
this shape:

    o---o---o---I      mainline
   / 
  O---o---X---o---A    topic A
   \
    o---Y---o---o---B  topic B

Suppose in the original O we had a function "distimmed_doshes()" to
tell if doshes are already distimmed, with some call sites.  On the
branch leading to A, at commit X, this function was renamed to
"doshes_are_distimmed()", and all existing call sites were adjusted.
On the side branch leading to B, however, at commit Y, a new call
site to the old function was added in a file that was not touched
between O..A at all.

When merging either the topic A or the topic B (but not both) to the
integration branch that did not touch this function or use of it, no
special care needs to be taken, but when merging the second topic
after merging the other one, we need to resolve a semantic conflict.
Namely, the callsite to "distimmed_doshes()" introduced by commit Y
needs to be adjusted to call "doshes_are_distimmed()" instead.

The first step is to recognize the potential issue.  When queuing
the topic that contains X and the other topic that contains Y,
suppose I could register <X,Y> to the datastore I am dreaming.  When
I merge A to the integration branch, I can notice that there is no
such pair <M,N> in the datastore that:

 * M is in A..I and not in I..A
 * N is in I..A and not in A..I

and can create a merge J without semantic adjustment.

    o---o---o---I---J      mainline
   /               /  
  O---o---X---o---A        topic A
   \
    o---Y---o---o---B      topic B

When I later merge topic B to the integration branch, however, there
is <X,Y> in the datastore such that:

 * X is in B..J and not in J..B
 * Y is in J..B and not in B..J

to notice that we need to be careful when creating the merge K:

    o---o---o---I---J---K  mainline
   /               /   /
  O---o---X---o---A   /    topic A
   \                 /
    o---Y---o---o---B      topic B

Of course, the next step is to store not just one bit "<X,Y> exists
in the datastore--be careful", but what semantic adjustment needs to
be applied [*1*]

Obviously, with O(cnt(A..B))*O(cnt(B..A)) complexity, this can be
trivially coded, by trying all pairs in symmetric difference.

But I am hoping we can do better than that.

Ideas?


[Footnote]

*1* We could do it in multiple ways and the details are not
interesting. A blob object that records a patch that can be applied
with "git apply -3", or a commit object that represents necessary
"evil" change that can be cherry-pick'ed, would be two possible
implementations.
