From: Junio C Hamano <gitster@pobox.com>
Subject: On (re)packing
Date: Mon, 04 Feb 2013 22:35:48 -0800
Message-ID: <7vbobzw9mj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: peff@peff.net, spearce@spearce.org
X-From: git-owner@vger.kernel.org Tue Feb 05 07:36:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2c8i-0001dT-Bp
	for gcvg-git-2@plane.gmane.org; Tue, 05 Feb 2013 07:36:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751118Ab3BEGfx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2013 01:35:53 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37924 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750747Ab3BEGfw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2013 01:35:52 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4702C7BC4;
	Tue,  5 Feb 2013 01:35:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=y
	lKDTNSgdPav48kPzXLjjLjv0TM=; b=s2f0Xsyv+90og1Ze6LjNnK+0w6Lm6FHqP
	VVq0hRaR+lt03PCrwzAnh8SLzZ7wJ+umPTUUBmdo1weV8Rfw+Au5mP+sh+xIrLuq
	BZTc6sm4ts+LJtZuRHm/3HPAoP85uyICxwi2YbbY4qbjZ9X4QFoS6nAecbsT7Jvq
	zNU2ujYrXQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; q=dns; s=
	sasl; b=byIjjRMtky/RoXQKOHFw0P+9xme7WDQVdHPzGnCX+0Wpzk4HoF2ZSqQ/
	WgdLVH/j51jO4B+D/PEu5PybDVJTt8oDBmTV+iJrV7F/NELK7IjjhY+pn4dFdaRe
	rDmb/wZ4S/7gvOasUke0ywHdKGCPXRGRgvpcft+s1uYzLsV2SY8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3C8CB7BB9;
	Tue,  5 Feb 2013 01:35:51 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7C7F57BB8; Tue,  5 Feb 2013
 01:35:50 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 484D6E7C-6F5E-11E2-BCAC-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215462>

Just a random thought...

"git pack-objects" runs "rev-list --objects" to obtain three
different kinds of information about objects:

 * Reachability.  Objects that appear in the output of rev-list are
   relevant, and those that do not are not;

 * Recency, aka closeness in the time dimension.  Objects that
   appear in the output of rev-list close together appear in the
   history nearby (a commit and its parents, a commit and its tree,
   a tree and its subtree and blob);

 * Paths, aka closeness in the space dimension.  Trees and blobs are
   labelled with paths they are first discovered at.

All of these are necessary for reasonable packing.  We choose only
the reachable objects to pack.  We place objects close in the time
dimension together in the output pack stream.  And we delta objects
close in the space dimension against each other.

Now, we are planning to use object reachability bitmap to speed up
the object enumeration phase of repacking.  This primarily gives us
the reachability information.  Placing objects that are packed close
in existing packs close to each other in the output stream hopefully
may give us good enough approximation of the recency order.  And
reusing the delta will keep good existing delta if both deltified
object and its delta base object are included in the output.

What should happen when we repack two or more packs?  Placing an
object that appears near the beginning of one pack close to another
object that appears near the beginning of the other pack would
probably not make much sense, so the natural extension of emulating
recency order by pack offset would be to place all objects from one
pack together (in their original in-pack offset orde) and then
objects from the other pack together.

More problematic is how to coalesce one delta chain from one pack
with another delta chain from the other pack.  Without having the
path information, we cannot efficiently do this.  Especially if we
are to repack 50 small packs into one, it would be desirable if we
can avoid packing 50 similar objects in their undeltified form.

Assuming that we would want some extra information, in addition to
the bitmaps, to help repacking, and also with the recent "commit
metadata" topic in mind, lets do a back-of-the-envelope enumeration
of what we would want.  Here is a list off the top of my head.

* commits

  99.9% of all commits have no more than two parents.  Assuming that
  we keep this information per-pack, and we will not be packing more
  than 2^32 objects in a pack, we can represent up to two parent
  commits by two int32s to represent their position in the table of
  SHA-1's in the .idx file.  Also we can store another uint32 for
  the commit timestamp (compute the timestamp of the oldest commit
  in the pack and store it as uint64, and represent the commmit
  timestamp of each commit with uint32 (we can represent a pack that
  spans 68 years with this scheme).  Give up storing metainformation
  for any commit whose information cannot fit this scheme (e.g. an
  octopus, or a commit with timestamp way out of line).

  That costs 12 bytes per commit (plus 8-byte for the oldest
  timestamp in the pack).

* tags

  The timestamp can be expressed with a uint32 in the same way as
  commit's timestamp, and the tagged object can be expressed with a
  uint32 in the same way as commit's parent.  Two uint32s

* trees and blobs

  The name hash value is uint32.

If we have other information that are needed for trees and blobs
that fit in two more uint32s, then we can just build a table of
12-byte entries for all objects in the pack.  

Otherwise, we would need a way to have separate table that can be
quickly accessed, going from an object name to either 3 uint32 tuple
(if it is a commit), 2 uint32 tuple (if it is a tag), or a uint32
(others).

Whether we can do a table with uniform entry size or split tables,
once we locate an entry, we can find out the object number in the
SHA-1 table the object refers to (e.g. parents, or tagged) so I do
not think it is a good idea to express object pointer with an
abbreviated SHA-1.  But if we have to build commit-only table, we
may need to use a table with 16-byte entry size, that has 8
hexdigits (i.e. 4-bytes) abbreviated object name of a commit,
followed by the 12 byte commit metainformation, and sort it by the
abbreviated object name.  With the same scheme, another table for
trees and blobs will cost 4-bytes for abbreviated object name as key
and 4-bytes for name-hash payload.  That sounds a bit too wasteful
to my taste.
