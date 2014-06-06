From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] revision: parse "git log -<count>" more carefully
Date: Fri, 06 Jun 2014 15:33:25 -0700
Message-ID: <xmqqk38tpt1m.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 07 00:33:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wt2hb-0004Pe-Rj
	for gcvg-git-2@plane.gmane.org; Sat, 07 Jun 2014 00:33:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752242AbaFFWdc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2014 18:33:32 -0400
Received: from smtp.pobox.com ([208.72.237.35]:65283 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752183AbaFFWdb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2014 18:33:31 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A5FA71CB8B;
	Fri,  6 Jun 2014 18:33:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=m
	wezg8uKh9N6id046S8Kt6mpai4=; b=mArwuYFtwWbGmaKEjKYgDqXsW41GPFfUP
	Ogr5+K4tnSdWYV0Z4Vp4KHURczN0wrJdiOXjBeH4NFValX1Qs6FtR5e03ZW10/yI
	Slc/DRfnrHhZMs39R6xw+2PJ0+yj//B/2cJ2o+yGiP+w84YVzY5CfQYmBZRKeqKO
	TnR0uiaHG4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=pG2
	C7WSsd+YQzqtTw/LqiFp+/OaMhH5GN2JePXcZmhX9HDvoSTIW5OpVw9oYG+NPqFZ
	7EfApBlUXz4rMjjf4zP4HN5qoe7jdKRB1SzNKUCtIu5gu5LdtL6NZxnVau67XkCI
	HcH/8LSexVkQd0nNBHx+3sOObjwwOAW0E1jFOsqY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9E2701CB89;
	Fri,  6 Jun 2014 18:33:30 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id DABC91CB83;
	Fri,  6 Jun 2014 18:33:26 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 93BD0A98-EDCA-11E3-8865-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251013>

This mistyped command line simply ignores "master" and ends up
showing two commits from the current HEAD:

    $ git log -2master

because we feed "2master" to atoi() without making sure that the
whole string is parsed as an integer.

Use the strtol_i() helper function instead.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * We may want to wage a war on atoi(), which we sort-of did back
   when strtol_i() and strtoul_ui() helpers were introduced.  Also I
   suspect that many call sites of strtol() and strtoul() may become
   simpler if they are updated to use these helper functions.  Hint,
   hint...

 revision.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/revision.c b/revision.c
index 71e2337..f6a1088 100644
--- a/revision.c
+++ b/revision.c
@@ -1648,8 +1648,10 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		revs->skip_count = atoi(optarg);
 		return argcount;
 	} else if ((*arg == '-') && isdigit(arg[1])) {
-	/* accept -<digit>, like traditional "head" */
-		revs->max_count = atoi(arg + 1);
+		/* accept -<digit>, like traditional "head" */
+		if (strtol_i(arg + 1, 10, &revs->max_count) < 0 ||
+		    revs->max_count < 0)
+			die("'%s': not a non-negative integer", arg + 1);
 		revs->no_walk = 0;
 	} else if (!strcmp(arg, "-n")) {
 		if (argc <= 1)
