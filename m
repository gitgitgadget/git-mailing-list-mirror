From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Redefine semantics of find_unique_abbrev()
Date: Sat, 01 Mar 2008 23:35:11 -0800
Message-ID: <7vd4qdtw7k.fsf@gitster.siamese.dyndns.org>
References: <7vpruf9q5a.fsf@gitster.siamese.dyndns.org>
 <20080301050641.GB8969@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Mar 02 08:35:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVijm-0001hv-KR
	for gcvg-git-2@gmane.org; Sun, 02 Mar 2008 08:35:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752034AbYCBHfW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Mar 2008 02:35:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751993AbYCBHfW
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Mar 2008 02:35:22 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:61147 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751819AbYCBHfV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Mar 2008 02:35:21 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id CCD8C1819;
	Sun,  2 Mar 2008 02:35:18 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id F32051818; Sun,  2 Mar 2008 02:35:13 -0500 (EST)
In-Reply-To: <20080301050641.GB8969@coredump.intra.peff.net> (Jeff King's
 message of "Sat, 1 Mar 2008 00:06:41 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75740>

Jeff King <peff@peff.net> writes:

> I have been meaning to clean up and submit a similar patch from the
> 1.5.4 freeze period. However, your patch will always print the
> 40-hexdigit version, which looks quite ugly in status output. Instead,
> we can do much better by finding the longest subsequence we _do_ know
> about, and adding one digit to it.

Here is what I ended up with.  Instead of saying "missing", I said
"exists", which I think makes the logic easier to read, at least to me.

That is, "for objects we have, make sure it uniquely identifies,
otherwise, make sure the phoney name is long enough such that it would not
name any existing object".

---

 sha1_name.c |   13 ++++++-------
 1 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index 9d088cc..8358ba2 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -192,26 +192,25 @@ static int get_short_sha1(const char *name, int len, unsigned char *sha1,
 
 const char *find_unique_abbrev(const unsigned char *sha1, int len)
 {
-	int status, is_null;
+	int status, exists;
 	static char hex[41];
 
-	is_null = is_null_sha1(sha1);
+	exists = has_sha1_file(sha1);
 	memcpy(hex, sha1_to_hex(sha1), 40);
 	if (len == 40 || !len)
 		return hex;
 	while (len < 40) {
 		unsigned char sha1_ret[20];
 		status = get_short_sha1(hex, len, sha1_ret, 1);
-		if (!status ||
-		    (is_null && status != SHORT_NAME_AMBIGUOUS)) {
+		if (exists
+		    ? !status
+		    : status == SHORT_NAME_NOT_FOUND) {
 			hex[len] = 0;
 			return hex;
 		}
-		if (status != SHORT_NAME_AMBIGUOUS)
-			return NULL;
 		len++;
 	}
-	return NULL;
+	return hex;
 }
 
 static int ambiguous_path(const char *path, int len)
