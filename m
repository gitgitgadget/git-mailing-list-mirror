From: Jeff King <peff@peff.net>
Subject: [PATCH 1/7] add sha1_array API docs
Date: Tue, 13 Sep 2011 17:57:34 -0400
Message-ID: <20110913215733.GA24490@sigill.intra.peff.net>
References: <20110913215026.GA26743@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Christian Couder <christian.couder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 13 23:57:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3az7-0001Pb-He
	for gcvg-git-2@lo.gmane.org; Tue, 13 Sep 2011 23:57:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932899Ab1IMV5h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Sep 2011 17:57:37 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:51516
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932834Ab1IMV5g (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Sep 2011 17:57:36 -0400
Received: (qmail 1954 invoked by uid 107); 13 Sep 2011 21:58:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 13 Sep 2011 17:58:28 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 13 Sep 2011 17:57:34 -0400
Content-Disposition: inline
In-Reply-To: <20110913215026.GA26743@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181308>

This API was introduced in 902bb36, but never documented.
Let's be nice to future users of the code.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/technical/api-sha1-array.txt |   79 ++++++++++++++++++++++++++++
 1 files changed, 79 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/technical/api-sha1-array.txt

diff --git a/Documentation/technical/api-sha1-array.txt b/Documentation/technical/api-sha1-array.txt
new file mode 100644
index 0000000..4a4bae8
--- /dev/null
+++ b/Documentation/technical/api-sha1-array.txt
@@ -0,0 +1,79 @@
+sha1-array API
+==============
+
+The sha1-array API provides storage and manipulation of sets of SHA1
+identifiers. The emphasis is on storage and processing efficiency,
+making them suitable for large lists. Note that the ordering of items is
+not preserved over some operations.
+
+Data Structures
+---------------
+
+`struct sha1_array`::
+
+	A single array of SHA1 hashes. This should be initialized by
+	assignment from `SHA1_ARRAY_INIT`.  The `sha1` member contains
+	the actual data. The `nr` member contains the number of items in
+	the set.  The `alloc` and `sorted` members are used internally,
+	and should not be needed by API callers.
+
+Functions
+---------
+
+`sha1_array_append`::
+	Add an item to the set. The sha1 will be placed at the end of
+	the array (but note that some operations below may lose this
+	ordering).
+
+`sha1_array_sort`::
+	Sort the elements in the array.
+
+`sha1_array_lookup`::
+	Perform a binary search of the array for a specific sha1.
+	If found, returns the offset (in number of elements) of the
+	sha1. If not found, returns a negative integer. If the array is
+	not sorted, this function has the side effect of sorting it.
+
+`sha1_array_clear`::
+	Free all memory associated with the array and return it to the
+	initial, empty state.
+
+`sha1_array_for_each_unique`::
+	Efficiently iterate over each unique element of the list,
+	executing the callback function for each one. If the array is
+	not sorted, this function has the side effect of sorting it.
+
+Examples
+--------
+
+-----------------------------------------
+void print_callback(const unsigned char sha1[20],
+		    void *data)
+{
+	printf("%s\n", sha1_to_hex(sha1));
+}
+
+void some_func(void)
+{
+	struct sha1_array hashes = SHA1_ARRAY_INIT;
+	unsigned char sha1[20];
+
+	/* Read objects into our set */
+	while (read_object_from_stdin(sha1))
+		sha1_array_append(&hashes, sha1);
+
+	/* Check if some objects are in our set */
+	while (read_object_from_stdin(sha1)) {
+		if (sha1_array_lookup(&hashes, sha1) >= 0)
+			printf("it's in there!\n");
+
+	/*
+	 * Print the unique set of objects. We could also have
+	 * avoided adding duplicate objects in the first place,
+	 * but we would end up re-sorting the array repeatedly.
+	 * Instead, this will sort once and then skip duplicates
+	 * in linear time.
+	 */
+	sha1_array_for_each_unique(&hashes, print_callback, NULL);
+}
+-----------------------------------------
-- 
1.7.7.rc1.2.gb2409
