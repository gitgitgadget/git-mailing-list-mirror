From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 00/11] writing out a huge blob to working tree
Date: Sun, 15 May 2011 17:30:20 -0700
Message-ID: <1305505831-31587-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 16 02:30:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QLlhy-00047D-VF
	for gcvg-git-2@lo.gmane.org; Mon, 16 May 2011 02:30:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751603Ab1EPAag (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 May 2011 20:30:36 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:33588 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751369Ab1EPAae (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 May 2011 20:30:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2A20A5F6D
	for <git@vger.kernel.org>; Sun, 15 May 2011 20:32:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id; s=sasl; bh=jjXPOUTgpcjlwiIXhgpa46/e2OI
	=; b=pB86WB1fieDg7t5Ebin9O+TRH+YKFz947HwWhLxIPEPLe14OTy5DByJN0dV
	y1tJICKf33i3WuaNtxVk9O8YeGcMyLM7YXBodsP+RD0o5TRBu5MGHbBMup9MrDFZ
	xL83XZJNa0WWYeaodW5hAqiV97Nf6kH3eEBtvq9D49etgJIE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id; q=dns; s=sasl; b=bKgT9+VEe7NAiwYdUlUEzLuz3uqf2
	H+Ch5EpcRRm4uuXqsPNNFqWCzYg6tvKDpLjAiB1SQleargBc4IAhZb0E2S3QW7nG
	Ht5VDNyColOyEAMduEQ1IEtLkYMiqzdVgvY+EL5TfaLl2AFNCf6qhoiqLwkZknZA
	D5d87N2pYyXtfI=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 263E15F6C
	for <git@vger.kernel.org>; Sun, 15 May 2011 20:32:41 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 6731A5F6B for
 <git@vger.kernel.org>; Sun, 15 May 2011 20:32:40 -0400 (EDT)
X-Mailer: git-send-email 1.7.5.1.365.g32b65
X-Pobox-Relay-ID: 021FD2F6-7F54-11E0-8D98-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173685>

Traditionally, git always read the full contents of an object in memory
before performing various operations on it, e.g. comparing for diff,
writing it to the working tree, etc.  A huge blob that you cannot fit
in memory was very cumbersome to handle.

Recently "diff" learned to avoid reading the contents only to say "Binary
files differ" when these large blobs are marked as binary. Also there is a
topic cooking to teach "git add" to stream a large file directly to a
packfile without keeping the whole thing in core.

The "checkout" codepath is to learn the trick next, and this is the series
to attempt to do so.  These would apply cleanly on top of three other
topics still in 'next' or 'pu', namely:

 - jc/convert that cleans up the conversion;
 - jc/replacing that cleans up the object replacement;
 - jc/bigfile that teaches "git add" to handle large files.

Patch 1 and 5 are trivial clean-ups and refactoring. These could be
separated out of the series and applied much earlier, but nothing other
than this series directly benefit from these changes, so they are here in
the series.

Patch 2, 3, and 4 enhances the sha1_file layer.

Patch 6 introduces a new API that takes an object name and gives back a
"handle" you can read from (think: FILE *) the contents of the object.
The implementation at this step is deliberately kept simple: it just calls
read_sha1_file() to read everything in memory.

Patch 7 then uses the new API in the "git checkout" codepath, namely, in
entry.c::write_entry() function.  At this point, any blob that does not
require smudge filters including crlf conversion would pass through this
new codepath and used the 'incore' case of the streaming API, which means
that (1) "hold everything in memory and process" limitation is not lifted
yet, and that (2) breakage detected in here would have meant either the
simple 'incore' implementation of the streaming API is broken (not likely),
or its caller streaming_write_entry() is broken (more likely).

Patch 8 teaches the new write-out codepath to detect and make holes in the
resulting file. This is primarily meant to help testing---when you add a
large test file that weighs 1GB with "git add" (see how it is done in the
test t/t1050-large.sh on jc/bigfile topic) and check it out, you do not
want to end up with 1GB file fully populated with real blocks in your
working tree.

Patch 9 teaches the streaming API how to read a non-delta object directly
from packfile, without holding the entire result in the memory. This is
the representation jc/bigfile topic creates for a huge file, and the
primary interest of this topic.

Patch 10 and 11 teaches the streaming API how to read a loose object,
without holding the entire result in the memory. This is not strictly
necessary for the purpose of handling the output from jc/bigfile, but not
having to hold everything in core by itself may be a plus.

Interested parties may want to measure the performance impact of the last
three patches. The series deliberately ignores core.bigfileThreashold and
let small and large blobs alike go through the streaming_write_entry()
codepath, but it _might_ turn out that we would want to use the new code
only for large-ish blobs.


Junio C Hamano (11):
  packed_object_info_detail(): do not return a string
  sha1_object_info_extended(): expose a bit more info
  sha1_object_info_extended(): hint about objects in delta-base cache
  unpack_object_header(): make it public
  write_entry(): separate two helper functions out
  streaming: a new API to read from the object store
  streaming_write_entry(): use streaming API in write_entry()
  streaming_write_entry(): support files with holes
  streaming: read non-delta incrementally from a pack
  sha1_file.c: expose helpers to read loose objects
  streaming: read loose objects incrementally

 Makefile              |    2 +
 builtin/verify-pack.c |    4 +-
 cache.h               |   36 +++++-
 convert.c             |   23 +++
 entry.c               |  111 ++++++++++++---
 sha1_file.c           |   71 ++++++++--
 streaming.c           |  376 +++++++++++++++++++++++++++++++++++++++++++++++++
 streaming.h           |   12 ++
 8 files changed, 600 insertions(+), 35 deletions(-)
 create mode 100644 streaming.c
 create mode 100644 streaming.h

-- 
1.7.5.1.365.g32b65
