From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] run_diff_files(): clarify computation of sha1 validity
Date: Wed, 04 Feb 2015 14:17:00 -0800
Message-ID: <xmqqtwz1mieb.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 04 23:17:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YJ8G2-0007As-0Z
	for gcvg-git-2@plane.gmane.org; Wed, 04 Feb 2015 23:17:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966935AbbBDWRH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Feb 2015 17:17:07 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:50340 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S966761AbbBDWRF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2015 17:17:05 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DB50B35336;
	Wed,  4 Feb 2015 17:17:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=V
	ACvMfv39xtZSlsxNCgWcWj1EO0=; b=u3MB6lOIoX1DT+GMXtoikW3GWEmDlKp1k
	qLyMpoPCl08oUTdWR227RKFeTng00xWN1J0Rm04VjZh4lA/eyj/12YtgruZj7PXb
	fV2Rw1v6CBGxk5QLPKdn5C2lVFeqb2b8ItqXU3hF4od+JwYVGXpRo+gcPZRCxv5p
	bRKvduIK6w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=naD
	TTr01YmkwA7S/6s5IDOIbEsgKnE753wkDrndal3SOgz/iG4BCCPY3RgBcQGj/r9g
	xrvTatn8xqNdx2yzB8coQfvfhrvuSkw6T3h+DZifuqYqRtObdKM5M9h9ctUGQiSh
	Swyi6zWVg0r4iuDTSsx8i5ziIjNwcQKGZH9n39NI=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D35D735335;
	Wed,  4 Feb 2015 17:17:04 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B570135332;
	Wed,  4 Feb 2015 17:17:01 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 8AEB82FE-ACBB-11E4-8837-7BA29F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263359>

Remove the need to have duplicated "if there is a change then feed
null_sha1 and otherwise sha1 from the cache entry" for the "new"
side of the diff by introducing two temporary variables to point
at the object name of the old and the new side of the blobs.

This does not intend to change the meaning of the code in any way;
just makes the result a bit easier to read.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * A random thing I noticed while reading existing code...

 diff-lib.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/diff-lib.c b/diff-lib.c
index 875aff8..a85c497 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -101,6 +101,7 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 		struct cache_entry *ce = active_cache[i];
 		int changed;
 		unsigned dirty_submodule = 0;
+		const unsigned char *old_sha1, *new_sha1;
 
 		if (diff_can_quit_early(&revs->diffopt))
 			break;
@@ -224,9 +225,12 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 				continue;
 		}
 		oldmode = ce->ce_mode;
+		old_sha1 = ce->sha1;
+		new_sha1 = changed ? null_sha1 : ce->sha1;
 		diff_change(&revs->diffopt, oldmode, newmode,
-			    ce->sha1, (changed ? null_sha1 : ce->sha1),
-			    !is_null_sha1(ce->sha1), (changed ? 0 : !is_null_sha1(ce->sha1)),
+			    old_sha1, new_sha1,
+			    !is_null_sha1(old_sha1),
+			    !is_null_sha1(new_sha1),
 			    ce->name, 0, dirty_submodule);
 
 	}
-- 
2.3.0-rc2-170-g6029c0c
