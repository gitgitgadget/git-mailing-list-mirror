From: Junio C Hamano <gitster@pobox.com>
Subject: [RFC/PATCH] git-merge: forbid fast-forward and up-to-date when
 --no-commit is given
Date: Wed, 21 Oct 2009 14:41:49 -0700
Message-ID: <7vpr8g1l2a.fsf_-_@alter.siamese.dyndns.org>
References: <200910201947.50423.trast@student.ethz.ch>
 <alpine.LNX.2.00.0910201912390.14365@iabervon.org>
 <20091021030608.GA18997@atjola.homenet>
 <7vk4ypb71j.fsf@alter.siamese.dyndns.org> <20091021172123.GB27495@localhost>
 <7v3a5c2zrr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Clemens Buchacher <drizzd@aon.at>,
	=?utf-8?Q?Bj=C3=B6rn?= Steinbrink <B.Steinbrink@gmx.de>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Thomas Rast <trast@student.ethz.ch>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 21 23:42:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0iwe-0001Dd-Ss
	for gcvg-git-2@lo.gmane.org; Wed, 21 Oct 2009 23:42:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755032AbZJUVmC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Oct 2009 17:42:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754816AbZJUVmB
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Oct 2009 17:42:01 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:53811 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754805AbZJUVmA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Oct 2009 17:42:00 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1F19380E39;
	Wed, 21 Oct 2009 17:42:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TzGZSlA7n5tbio8thGoLTB0YKto=; b=Wl4tqL
	Lm8TzWVQDyCfiNcFFqQWMEXN1rMShqb9lm/Apgkn6/ZywKwU9GrgIpzt7h5quNL5
	NGmJ524Oli0gXvO+2aLFIlKq71br2TVbtTCMQEjAxY7bqpsLvDwid8zqgZ+8bgsX
	V0bps28KbqPJ2iUpqH1iHWi8cVX/cIxeuK16s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ktjU87lpL82YSsOD8NuMVGWCU/1DyCuu
	dXEvtddE4dxJrW4YVDe3YiyfU/OputPluudGEzJgttIaI8wcIIin9sdAafJj8G8P
	+ZnAWRdf6xdkfpshcnl+drwC5VuUIj9syvzPod4uH2mnxIVKBgRSXGQt0pz4N8x6
	zHgP89IiU5w=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8A98080E35;
	Wed, 21 Oct 2009 17:41:58 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 1CFA680E34; Wed, 21 Oct 2009
 17:41:50 -0400 (EDT)
In-Reply-To: <7v3a5c2zrr.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed\, 21 Oct 2009 14\:38\:48 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 8F36B718-BE8A-11DE-8A01-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130972>

Traditionally "git merge --no-commit" meant just that: do not create a new
commit even when a merge succeeds.  But this leads to confusion when the
merged commit is a descendant of the current commit, in which case we
succeed the merge by fast-forwarding and without creating a new commit.
Also when the merged commit is already a part of the history, we succeeded
without doing anything.

Error out when --no-commit is given but the merge would result in a
fast-forward or an up-to-date.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * This is the first alternative.  I think it makes more sense than the
   other one, but I am unsure, as I obviously do not get confused when
   --no-commit becomes no-op due to a fast-forward nor an up-to-date and
   am rather happy with the current behaviour.

 builtin-merge.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/builtin-merge.c b/builtin-merge.c
index b6b8428..4cfdf75 100644
--- a/builtin-merge.c
+++ b/builtin-merge.c
@@ -829,6 +829,12 @@ static int evaluate_result(void)
 	return cnt;
 }
 
+static void check_no_commit(const char *msg)
+{
+	if (!option_commit)
+		die("The merge will %s but --no-commit was given.", msg);
+}
+
 int cmd_merge(int argc, const char **argv, const char *prefix)
 {
 	unsigned char result_tree[20];
@@ -996,6 +1002,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		 * If head can reach all the merge then we are up to date.
 		 * but first the most common case of merging one remote.
 		 */
+		check_no_commit("be a no-op because you are up-to-date");
 		finish_up_to_date("Already up-to-date.");
 		return 0;
 	} else if (allow_fast_forward && !remoteheads->next &&
@@ -1006,6 +1013,9 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		struct object *o;
 		char hex[41];
 
+		if (allow_fast_forward)
+			check_no_commit("fast forward");
+
 		strcpy(hex, find_unique_abbrev(head, DEFAULT_ABBREV));
 
 		if (verbosity >= 0)
@@ -1074,6 +1084,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 			}
 		}
 		if (up_to_date) {
+			check_no_commit("fast forward");
 			finish_up_to_date("Already up-to-date. Yeeah!");
 			return 0;
 		}
-- 
1.6.5.1.107.gba912
