From: Jeff King <peff@peff.net>
Subject: [PATCHv3 0/6] duplicate objects and delta cycles
Date: Fri, 23 Aug 2013 20:01:11 -0400
Message-ID: <20130824000111.GA20255@sigill.intra.peff.net>
References: <20130822231215.GA16978@sigill.intra.peff.net>
 <20130822231404.GB17060@sigill.intra.peff.net>
 <xmqqob8opdey.fsf@gitster.dls.corp.google.com>
 <20130823182409.GA30130@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Duy Nguyen <pclouds@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Nicolas Pitre <nico@fluxnic.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 24 02:01:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VD1IC-0008BJ-0v
	for gcvg-git-2@plane.gmane.org; Sat, 24 Aug 2013 02:01:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754296Ab3HXABO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Aug 2013 20:01:14 -0400
Received: from cloud.peff.net ([50.56.180.127]:41465 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754044Ab3HXABN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Aug 2013 20:01:13 -0400
Received: (qmail 29888 invoked by uid 102); 24 Aug 2013 00:01:14 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 23 Aug 2013 19:01:14 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 23 Aug 2013 20:01:11 -0400
Content-Disposition: inline
In-Reply-To: <20130823182409.GA30130@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232842>

On Fri, Aug 23, 2013 at 02:24:10PM -0400, Jeff King wrote:

> > This is somewhat tricky and may deserve an in-code comment.
> 
> Do you want me to re-roll[...]

Since there were a few things to fix, I went ahead and re-rolled. Here's
v3, which changes:

  1. Move "edge of run" logic description into the in-code comment
     rather than the commit message.

  2. Include space between shell function names and parentheses.

  3. Use $TEST_DIRECTORY to find lib-pack so that "--root" works.

I added in Nicolas's acks, too, as this version makes no changes of
substance from the previous ack'd version. Interdiff is below.

 sha1-lookup.c                     | 24 ++++++++++++++++++++++++
 t/lib-pack.sh                     | 12 ++++++------
 t/t5308-pack-detect-duplicates.sh |  4 ++--
 t/t5309-pack-delta-cycles.sh      |  2 +-
 4 files changed, 33 insertions(+), 9 deletions(-)

diff --git a/sha1-lookup.c b/sha1-lookup.c
index 614cbb6..2dd8515 100644
--- a/sha1-lookup.c
+++ b/sha1-lookup.c
@@ -215,6 +215,30 @@ int sha1_entry_pos(const void *table,
 			 * Either one of these entries is it (and
 			 * we do not care which), or we do not have
 			 * it.
+			 *
+			 * Furthermore, we know that one of our
+			 * endpoints must be the edge of the run of
+			 * duplicates. For example, given this
+			 * sequence:
+			 *
+			 *     idx 0 1 2 3 4 5
+			 *     key A C C C C D
+			 *
+			 * If we are searching for "B", we might
+			 * hit the duplicate run at lo=1, hi=3
+			 * (e.g., by first mi=3, then mi=0). But we
+			 * can never have lo > 1, because B < C.
+			 * That is, if our key is less than the
+			 * run, we know that "lo" is the edge, but
+			 * we can say nothing of "hi". Similarly,
+			 * if our key is greater than the run, we
+			 * know that "hi" is the edge, but we can
+			 * say nothing of "lo".
+			 *
+			 * Therefore if we do not find it, we also
+			 * know where it would go if it did exist:
+			 * just on the far side of the edge that we
+			 * know about.
 			 */
 			if (ofs == 20) {
 				mi = lo;
diff --git a/t/lib-pack.sh b/t/lib-pack.sh
index e028c40..7e8685b 100644
--- a/t/lib-pack.sh
+++ b/t/lib-pack.sh
@@ -10,7 +10,7 @@
 #   pack_trailer foo.pack
 
 # Print the big-endian 4-byte octal representation of $1
-uint32_octal() {
+uint32_octal () {
 	n=$1
 	printf '\%o' $(($n / 16777216)); n=$((n % 16777216))
 	printf '\%o' $(($n /    65536)); n=$((n %    65536))
@@ -19,12 +19,12 @@ uint32_binary() {
 }
 
 # Print the big-endian 4-byte binary representation of $1
-uint32_binary() {
+uint32_binary () {
 	printf "$(uint32_octal "$1")"
 }
 
 # Print a pack header, version 2, for a pack with $1 objects
-pack_header() {
+pack_header () {
 	printf 'PACK' &&
 	printf '\0\0\0\2' &&
 	uint32_binary "$1"
@@ -36,7 +36,7 @@ pack_header() {
 # Doing this on the fly (especially picking your deltas) is quite tricky, so we
 # have hardcoded some well-known objects. See the case statements below for the
 # complete list.
-pack_obj() {
+pack_obj () {
 	case "$1" in
 	# empty blob
 	e69de29bb2d1d6434b8b29ae775ad8c2e48c5391)
@@ -86,7 +86,7 @@ pack_obj() {
 }
 
 # Compute and append pack trailer to "$1"
-pack_trailer() {
+pack_trailer () {
 	test-sha1 -b <"$1" >trailer.tmp &&
 	cat trailer.tmp >>"$1" &&
 	rm -f trailer.tmp
@@ -95,6 +95,6 @@ pack_trailer() {
 # Remove any existing packs to make sure that
 # whatever we index next will be the pack that we
 # actually use.
-clear_packs() {
+clear_packs () {
 	rm -f .git/objects/pack/*
 }
diff --git a/t/t5308-pack-detect-duplicates.sh b/t/t5308-pack-detect-duplicates.sh
index e982095..e0ba5e1 100755
--- a/t/t5308-pack-detect-duplicates.sh
+++ b/t/t5308-pack-detect-duplicates.sh
@@ -2,7 +2,7 @@ test_description='handling of duplicate objects in incoming packfiles'
 
 test_description='handling of duplicate objects in incoming packfiles'
 . ./test-lib.sh
-. ../lib-pack.sh
+. "$TEST_DIRECTORY"/lib-pack.sh
 
 # The sha1s we have in our pack. It's important that these have the same
 # starting byte, so that they end up in the same fanout section of the index.
@@ -22,7 +22,7 @@ MISSING_SHA1='e69d000000000000000000000000000000000000'
 # $1 is the name of the packfile to create
 #
 # $2 is the number of times to duplicate each object
-create_pack() {
+create_pack () {
 	pack_header "$((2 * $2))" >"$1" &&
 	for i in $(test_seq 1 "$2"); do
 		pack_obj $LO_SHA1 &&
diff --git a/t/t5309-pack-delta-cycles.sh b/t/t5309-pack-delta-cycles.sh
index 38e1809..3e7861b 100755
--- a/t/t5309-pack-delta-cycles.sh
+++ b/t/t5309-pack-delta-cycles.sh
@@ -2,7 +2,7 @@ test_description='test index-pack handling of delta cycles in packfiles'
 
 test_description='test index-pack handling of delta cycles in packfiles'
 . ./test-lib.sh
-. ../lib-pack.sh
+. "$TEST_DIRECTORY"/lib-pack.sh
 
 # Two similar-ish objects that we have computed deltas between.
 A=01d7713666f4de822776c7622c10f1b07de280dc
