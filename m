From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [test failure] Re: t4114 binary file becomes symlink
Date: Sat, 18 Jul 2009 11:46:42 -0700
Message-ID: <7veisd3k31.fsf@alter.siamese.dyndns.org>
References: <20090718134551.GC16708@vidovic>
 <20090718135649.GA6759@sigill.intra.peff.net>
 <20090718141658.GE16708@vidovic>
 <20090718153148.GA9367@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Jul 18 20:47:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MSEw2-0000FN-AJ
	for gcvg-git-2@gmane.org; Sat, 18 Jul 2009 20:47:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753415AbZGRSqx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Jul 2009 14:46:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753111AbZGRSqw
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Jul 2009 14:46:52 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:32862 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753383AbZGRSqv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Jul 2009 14:46:51 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 96673A60C;
	Sat, 18 Jul 2009 14:46:48 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 23850A60B; Sat, 18 Jul 2009
 14:46:43 -0400 (EDT)
In-Reply-To: <20090718153148.GA9367@sigill.intra.peff.net> (Jeff King's
 message of "Sat\, 18 Jul 2009 11\:31\:49 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 598F9D50-73CB-11DE-8950-AEF1826986A2-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123531>

Jeff King <peff@peff.net> writes:

> On Sat, Jul 18, 2009 at 04:16:58PM +0200, Nicolas Sebrecht wrote:
>
>> It fails on:
>>   - next
>>   - v1.6.3
>>   - b67b9612e1a90ae093445abeaeff930e9f4cf936
>>   - (other I don't remember, but does it really matter?)
>
> Hmm. So it is clearly reproducible on your system, but not on mine. I
> wonder what the difference could be.
>
> Are you compiling with any special options? I usually compile with just
> "-g -Wall -Werror", but I also tried with "-O2" and couldn't reproduce.

Me neither, but I found an unrelated anomaly in the output from the test
nearby.

    Switched to branch 'foo-baz-renamed-from-foo'
    *   ok 3: file renamed from foo/baz to foo

    * expecting success:
            git checkout -f foo-becomes-a-directory &&
            git diff-tree -p HEAD initial > patch &&
            git apply --index < patch

    error: Invalid path ''
    Switched to branch 'foo-becomes-a-directory'
    *   ok 4: directory becomes file

Notice the "error"?

This is coming from the oneway_merge() codepath in unpack-trees.c.

When we switch branches with "checkout -f", unpack_trees() feeds two 
cache_entries to oneway_merge() function in its src[] array argument.  The
zeroth entry comes from the current index, and the first entry represents
what the merge result should be, taken from the tree recorded in the
commit we are switching to.

When we have a blob (either regular file or a symlink) in the index and in
the work tree at path "foo", and the switched-to tree has "foo/bar",
i.e. "foo" becomes a directory, src[0] is obviously that blob currently
registered at "foo".  Even though we do not have anything at "foo" in the
switched-to tree, src[1] is _not_ NULL.

The unpack_trees() machinery places a special marker df_conflict_entry
to signal that no blob exists at "foo", but it will become a directory
that may have somthing underneath it, namely "foo/bar".

Passing that df_conflict_entry marker to merged_entry() happens to remove
the "foo" in the end because the df_conflict_entry does not have any name
(hence the "error" message) and its addition in add_index_entry() is
rejected, but it is wrong.

 unpack-trees.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index 48d862d..720f7a1 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -999,7 +999,7 @@ int oneway_merge(struct cache_entry **src, struct unpack_trees_options *o)
 		return error("Cannot do a oneway merge of %d trees",
 			     o->merge_size);
 
-	if (!a)
+	if (!a || a == o->df_conflict_entry)
 		return deleted_entry(old, old, o);
 
 	if (old && same(old, a)) {
