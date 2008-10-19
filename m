From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH/RFR&A] Do not rename read-only files during a push
Date: Sun, 19 Oct 2008 00:07:03 -0700
Message-ID: <7v63np83mw.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>,
	Johannes Sixt <johannes.sixt@telecom.at>,
	"Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Oct 19 09:08:32 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KrSOt-00011H-Cg
	for gcvg-git-2@gmane.org; Sun, 19 Oct 2008 09:08:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751171AbYJSHHT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Oct 2008 03:07:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751156AbYJSHHT
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Oct 2008 03:07:19 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:37035 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751168AbYJSHHN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Oct 2008 03:07:13 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 9F0B571063;
	Sun, 19 Oct 2008 03:07:12 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 56E6D71060; Sun, 19 Oct 2008 03:07:04 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 8D96D58C-9DAC-11DD-ADC1-1E1F86D30F62-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98596>

This is on the "merged to 'master' soon" list, but has a small amend by me
(namely, chmod of final pack is done only when we are writing the final
pack, i.e. reading from stdin) to fix breakages observed in tests.  It
would be nice to get a final Ack before moving it to 'master'.

-- >8 --

From: Petr Baudis <pasky@suse.cz>

Win32 does not allow renaming read-only files (at least on a Samba
share), making push into a local directory to fail. Thus, defer
the chmod() call in index-pack.c:final() only after
move_temp_to_file() was called.

Signed-off-by: Petr Baudis <pasky@suse.cz>
Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 index-pack.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/index-pack.c b/index-pack.c
index d3a4d31..aec11cb 100644
--- a/index-pack.c
+++ b/index-pack.c
@@ -790,7 +790,6 @@ static void final(const char *final_pack_name, const char *curr_pack_name,
 		err = close(output_fd);
 		if (err)
 			die("error while closing pack file: %s", strerror(errno));
-		chmod(curr_pack_name, 0444);
 	}
 
 	if (keep_msg) {
@@ -824,8 +823,9 @@ static void final(const char *final_pack_name, const char *curr_pack_name,
 		if (move_temp_to_file(curr_pack_name, final_pack_name))
 			die("cannot store pack file");
 	}
+	if (from_stdin)
+		chmod(final_pack_name, 0444);
 
-	chmod(curr_index_name, 0444);
 	if (final_index_name != curr_index_name) {
 		if (!final_index_name) {
 			snprintf(name, sizeof(name), "%s/pack/pack-%s.idx",
@@ -835,6 +835,7 @@ static void final(const char *final_pack_name, const char *curr_pack_name,
 		if (move_temp_to_file(curr_index_name, final_index_name))
 			die("cannot store index file");
 	}
+	chmod(final_index_name, 0444);
 
 	if (!from_stdin) {
 		printf("%s\n", sha1_to_hex(sha1));
-- 
1.6.0.2.767.g8f0e
