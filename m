From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] Make default expiration period of reflog used for stash
 infinite
Date: Sun, 29 Jun 2008 01:50:28 -0700
Message-ID: <7v3amweiaz.fsf@gitster.siamese.dyndns.org>
References: <7vlk4snpj3.fsf@gitster.siamese.dyndns.org>
 <7v8x0992hy.fsf@gitster.siamese.dyndns.org>
 <7vd4pf7h9y.fsf@gitster.siamese.dyndns.org>
 <7vwsnjl21c.fsf@gitster.siamese.dyndns.org>
 <7vhcehzdeg.fsf@gitster.siamese.dyndns.org>
 <7vbq4j748l.fsf@gitster.siamese.dyndns.org>
 <7vr6d8apjx.fsf@gitster.siamese.dyndns.org>
 <7vhcdyfe9u.fsf@gitster.siamese.dyndns.org>
 <7vabjm1a0q.fsf@gitster.siamese.dyndns.org>
 <7vr6crj0jk.fsf@gitster.siamese.dyndns.org>
 <7vmyn4hr8f.fsf@gitster.siamese.dyndns.org>
 <7vmymsjz6x.fsf@gitster.siamese.dyndns.org>
 <7vabijxhk4.fsf@gitster.siamese.dyndns.org>
 <7vwslhg8qe.fsf@gitster.siamese.dyndns.org>
 <7vhccfiksy.fsf@gitster.siamese.dyndns.org>
 <7vod6k6zg4.fsf@gitster.siamese.dyndns.org>
 <7v4p7xwsfp.fsf@gitster.siamese.dyndns.org>
 <7v3anb19n7.fsf@gitster.siamese.dyndns.org>
 <7vwskjazql.fsf@gitster.siamese.dyndns.org>
 <7vk5ggipuw.fsf@gitster.siamese.dyndns.org>
 <7vej6l3lp7.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 29 10:51:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCsdO-00027i-Ew
	for gcvg-git-2@gmane.org; Sun, 29 Jun 2008 10:51:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752072AbYF2Iup (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jun 2008 04:50:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751881AbYF2Iup
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jun 2008 04:50:45 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:52869 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751212AbYF2Iuo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jun 2008 04:50:44 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id B7A0B288B;
	Sun, 29 Jun 2008 04:50:41 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id D7254288A; Sun, 29 Jun 2008 04:50:39 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 74374334-45B8-11DD-953F-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86787>

This makes the default expiration period for the reflog that implements
stash infinite.

The original behaviour to autoexpire old stashes can be restored by using
the gc.refs/stash.{reflogexpire,reflogexpireunreachable} configration
variables introduced by the previous commit.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 > [Stalled/Needs more work]
 >
 > * jc/reflog-expire (Sun Jun 15 23:48:46 2008 -0700) 1 commit
 >  - Per-ref reflog expiry configuration
 >
 > Perhaps a good foundation for optionally unexpirable stash.  As 1.6.0 will
 > be a good time to make backward incompatible changes, we might make expiry
 > period of stash 'never' in new repositories.  Needs a concensus.

 builtin-reflog.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/builtin-reflog.c b/builtin-reflog.c
index 0711728..125d455 100644
--- a/builtin-reflog.c
+++ b/builtin-reflog.c
@@ -441,6 +441,17 @@ static void set_reflog_expiry_param(struct cmd_reflog_expire_cb *cb, int slot, c
 		}
 	}
 
+	/*
+	 * If unconfigured, make stash never expire
+	 */
+	if (!strcmp(ref, "refs/stash")) {
+		if (!(slot & EXPIRE_TOTAL))
+			cb->expire_total = 0;
+		if (!(slot & EXPIRE_UNREACH))
+			cb->expire_unreachable = 0;
+		return;
+	}
+
 	/* Nothing matched -- use the default value */
 	if (!(slot & EXPIRE_TOTAL))
 		cb->expire_total = default_reflog_expire;
-- 
1.5.6.1.102.g8e69d
