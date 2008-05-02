From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/4] Fix ie_match_stat for non-checked-out submodule
Date: Fri, 02 May 2008 14:57:19 -0700
Message-ID: <7vod7owerk.fsf@gitster.siamese.dyndns.org>
References: <46dff0320804300856w941d948rbcc1cee06f1b41a9@mail.gmail.com>
 <1209735336-4690-1-git-send-email-pkufranky@gmail.com>
 <1209735336-4690-2-git-send-email-pkufranky@gmail.com>
 <1209735336-4690-3-git-send-email-pkufranky@gmail.com>
 <1209735336-4690-4-git-send-email-pkufranky@gmail.com>
 <1209735336-4690-5-git-send-email-pkufranky@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ping Yin <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 02 23:58:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Js3Gi-0001N7-RM
	for gcvg-git-2@gmane.org; Fri, 02 May 2008 23:58:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763691AbYEBV53 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 May 2008 17:57:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758494AbYEBV53
	(ORCPT <rfc822;git-outgoing>); Fri, 2 May 2008 17:57:29 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:45893 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763660AbYEBV52 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 May 2008 17:57:28 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 229305F9A;
	Fri,  2 May 2008 17:57:25 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 6EF215F93; Fri,  2 May 2008 17:57:21 -0400 (EDT)
In-Reply-To: <1209735336-4690-5-git-send-email-pkufranky@gmail.com> (Ping
 Yin's message of "Fri, 2 May 2008 21:35:36 +0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: BFB091B0-1892-11DD-8853-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81037>

Ping Yin <pkufranky@gmail.com> writes:

> For submodules non checked out, ie_match_stat should always return 0.
> So in this case avoid calling is_racy_timestamp.

It is conceptually wrong to have this check in that function, I think.

Look at what ce_match_stat_basic() does.  For S_IFGITLINK entries, we do
not even compare the timestamps, so is_racy_timestamp() check should not
even care and should return Ok for them.

Perhaps this patch would be a better, in that it covers the other caller
on the write_index() callpath as well.

---
diff --git a/read-cache.c b/read-cache.c
index a92b25b..0a0ea3b 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -258,6 +258,7 @@ static int ce_match_stat_basic(struct cache_entry *ce, struct stat *st)
 static int is_racy_timestamp(const struct index_state *istate, struct cache_entry *ce)
 {
 	return (istate->timestamp &&
+		!S_ISGITLINK(ce->ce_mode) &&
 		((unsigned int)istate->timestamp) <= ce->ce_mtime);
 }
 
