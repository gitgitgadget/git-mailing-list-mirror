From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 1/3] builtin/push.c: use strbuf instead of manual allocation
Date: Wed,  4 Dec 2013 17:27:27 -0800
Message-ID: <1386206849-6503-2-git-send-email-gitster@pobox.com>
References: <1386117594-22062-1-git-send-email-gitster@pobox.com>
 <1386206849-6503-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 05 02:27:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VoNjB-00043c-QA
	for gcvg-git-2@plane.gmane.org; Thu, 05 Dec 2013 02:27:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756266Ab3LEB1g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Dec 2013 20:27:36 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53434 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753515Ab3LEB1f (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Dec 2013 20:27:35 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7F5B75873E
	for <git@vger.kernel.org>; Wed,  4 Dec 2013 20:27:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=qwYN
	4GqZsks0VdJefMLl9dGqEFo=; b=O1M//rTF7eTwfMpzjKotyEz/fLVQaCv8UFh3
	dPBhLcsIhn6pg/wEjiU7fkyJBOI9zXBIOOzESx2ddaKVnOsAogmnj/ASlhz/pxvC
	F6KQCbZ96AU3pxcsqMykxcbflmiaSJRg/Bw5WHJ4K8jz9yVJtLfV/1qSRtQyxEjB
	xnOFK38=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=rZHmfO
	BoGCMlhkg3mUBLf8XBZ8hs1+oMIlXTldzaUjK2nfeS1kM6xx1kKLcjDLUw1tobX5
	ruiD/b7WNSl3WdR2al4bTB9hh3VPQ+nhgXXi/BCrUNkjzuyfGxXknQEt/JsEh/rH
	Z+KPCgqKAZ7WrKqaXAz+qz+Gr2SFzMfUr6DCg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6E78D5873D
	for <git@vger.kernel.org>; Wed,  4 Dec 2013 20:27:34 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AEB3C5873C
	for <git@vger.kernel.org>; Wed,  4 Dec 2013 20:27:33 -0500 (EST)
X-Mailer: git-send-email 1.8.5.1-402-gdd8f092
In-Reply-To: <1386206849-6503-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 6A84B266-5D4C-11E3-A3FB-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238834>

The command line arguments given to "git push" are massaged into
a list of refspecs in set_refspecs() function. This was implemented
using xmalloc, strcpy and friends, but it is much easier to read if
done using strbuf.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/push.c | 35 ++++++++++++++---------------------
 1 file changed, 14 insertions(+), 21 deletions(-)

diff --git a/builtin/push.c b/builtin/push.c
index 7b1b66c..76e4400 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -41,29 +41,22 @@ static void set_refspecs(const char **refs, int nr)
 	for (i = 0; i < nr; i++) {
 		const char *ref = refs[i];
 		if (!strcmp("tag", ref)) {
-			char *tag;
-			int len;
+			struct strbuf tagref = STRBUF_INIT;
 			if (nr <= ++i)
 				die(_("tag shorthand without <tag>"));
-			len = strlen(refs[i]) + 11;
-			if (deleterefs) {
-				tag = xmalloc(len+1);
-				strcpy(tag, ":refs/tags/");
-			} else {
-				tag = xmalloc(len);
-				strcpy(tag, "refs/tags/");
-			}
-			strcat(tag, refs[i]);
-			ref = tag;
-		} else if (deleterefs && !strchr(ref, ':')) {
-			char *delref;
-			int len = strlen(ref)+1;
-			delref = xmalloc(len+1);
-			strcpy(delref, ":");
-			strcat(delref, ref);
-			ref = delref;
-		} else if (deleterefs)
-			die(_("--delete only accepts plain target ref names"));
+			ref = refs[i];
+			if (deleterefs)
+				strbuf_addf(&tagref, ":refs/tags/%s", ref);
+			else
+				strbuf_addf(&tagref, "refs/tags/%s", ref);
+			ref = strbuf_detach(&tagref, NULL);
+		} else if (deleterefs) {
+			struct strbuf delref = STRBUF_INIT;
+			if (strchr(ref, ':'))
+				die(_("--delete only accepts plain target ref names"));
+			strbuf_addf(&delref, ":%s", ref);
+			ref = strbuf_detach(&delref, NULL);
+		}
 		add_refspec(ref);
 	}
 }
-- 
1.8.5.1-402-gdd8f092
