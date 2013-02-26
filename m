From: Junio C Hamano <gitster@pobox.com>
Subject: Re: two-way merge corner case bug
Date: Tue, 26 Feb 2013 13:41:54 -0800
Message-ID: <7vwqtulplp.fsf@alter.siamese.dyndns.org>
References: <7v7glun8kt.fsf@alter.siamese.dyndns.org>
 <20130226201820.GD13830@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 26 22:42:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UASI3-0008TH-OV
	for gcvg-git-2@plane.gmane.org; Tue, 26 Feb 2013 22:42:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753851Ab3BZVl6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Feb 2013 16:41:58 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37723 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753029Ab3BZVl5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Feb 2013 16:41:57 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B9E17ADFE;
	Tue, 26 Feb 2013 16:41:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dNJs+VjcN6yBEpGBvTSXY9Db1aQ=; b=jAY19r
	9jRpzPCjTw3w8dXaTfoFRlDvMGnyfocTIy8c26d2kFCJ6BAAGdN54Wk+YJJ1drIH
	rOnkob5vZzgvJheFKvrJC0/QJGtoOlDkgn/NprwHLnHgWj2ZP711613vgaTPmQXv
	sIhJzSWBV9Bkrcr9joVjyVGJXK6SzBRfQVJfg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TE1FOdQ6qu15aVhbjCXcOHINtcb2B0qx
	/7H+Es2FzAT9qVXzfB/5W8C+cnjlqRKxJtZysAYyJoAwGdzrgijiHwUoOHm1bUSn
	xOMQcoTuEvoVR/CFBw6V+cjXWBxX/R7pugh0YeodGEeFM0ELjAT5vICc7rt+vbdv
	bYLtuIQsewU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AE190ADFD;
	Tue, 26 Feb 2013 16:41:56 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1132DADFB; Tue, 26 Feb 2013
 16:41:55 -0500 (EST)
In-Reply-To: <20130226201820.GD13830@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 26 Feb 2013 15:18:20 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 57604DD4-805D-11E2-83DE-F3C82E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217183>

Jeff King <peff@peff.net> writes:

> On Tue, Feb 26, 2013 at 12:06:42PM -0800, Junio C Hamano wrote:
>
>> It seems that we have a corner case bug in two-way merge to reset
>> away the conflicts with "read-tree -u --reset HEAD ORIG_HEAD".
>
> Isn't this a repeat of:
>
>   http://thread.gmane.org/gmane.comp.version-control.git/202440/focus=212316
>
> whose fix never got finalized? It's on my todo list, but it seems that
> items keep sinking further down on that list, rather than getting
> completed. :-/

Yeah, I think the patch in your message is a good starting point to
solve a half of the issue (i.e. unmerged current one should be
replaced with the version from the "going to" tree).  Attached is
with a slight update.

The other half that is not solved by this patch is that we will lose
Z because merge-recursive removed it when it renamed it and left
three stages for A in the index, and to "read-tree --reset -u HEAD
ORIG_HEAD", it looks as if you removed Z yourself while on HEAD and
want to carry your local change forward to ORIG_HEAD.

I think this too needs to be fixed.  We are saying "-u --reset" to
mean "I want to go there no matter what", not "-u -m" that means "I
am carrying my changes forward while checking out another branch".

 unpack-trees.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index 09e53df..3d17108 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1748,14 +1748,23 @@ int twoway_merge(struct cache_entry **src, struct unpack_trees_options *o)
 		newtree = NULL;
 
 	if (current) {
-		if ((!oldtree && !newtree) || /* 4 and 5 */
-		    (!oldtree && newtree &&
-		     same(current, newtree)) || /* 6 and 7 */
-		    (oldtree && newtree &&
-		     same(oldtree, newtree)) || /* 14 and 15 */
-		    (oldtree && newtree &&
-		     !same(oldtree, newtree) && /* 18 and 19 */
-		     same(current, newtree))) {
+		if (current->ce_flags & CE_CONFLICTED) {
+			if (same(oldtree, newtree) || o->reset) {
+				if (!newtree)
+					return deleted_entry(current, current, o);
+				else
+					return merged_entry(newtree, current, o);
+			}
+			return o->gently ? -1 : reject_merge(current, o);
+		}
+		else if ((!oldtree && !newtree) || /* 4 and 5 */
+			 (!oldtree && newtree &&
+			  same(current, newtree)) || /* 6 and 7 */
+			 (oldtree && newtree &&
+			  same(oldtree, newtree)) || /* 14 and 15 */
+			 (oldtree && newtree &&
+			  !same(oldtree, newtree) && /* 18 and 19 */
+			  same(current, newtree))) {
 			return keep_entry(current, o);
 		}
 		else if (oldtree && !newtree && same(current, oldtree)) {
