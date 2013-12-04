From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/3] builtin/push.c: use strbuf instead of manual allocation
Date: Tue,  3 Dec 2013 16:39:52 -0800
Message-ID: <1386117594-22062-2-git-send-email-gitster@pobox.com>
References: <1386117594-22062-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 04 01:40:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vo0Vf-00059Z-0I
	for gcvg-git-2@plane.gmane.org; Wed, 04 Dec 2013 01:40:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754968Ab3LDAkF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Dec 2013 19:40:05 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40076 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754468Ab3LDAkD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Dec 2013 19:40:03 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 97E3C58EEF
	for <git@vger.kernel.org>; Tue,  3 Dec 2013 19:40:00 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=QhF9
	CopXk8IqeGfeqPadBlBwyeI=; b=gXIHTl82UDiMzyWViO2g7B3t42ayK/WBw+Sm
	OlFIEenFRg9jCd5qwNOCe17KH2qC2/VBw+yz4E3tGxOMIP2Kv8uA59QZilyJktN7
	LLLRwfUAUlE7ajCRpG5ga60s/QpSFTYhrWUzsOOTUwLgz1DtAWeAuu7Ua/bZ/VCl
	991FBik=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=EH97Fw
	oM0NuG1OZ4lYapNh5LksxbkSZF/RcaN9gTrA8rZDhQrVnmw/PFsPJcWfByW1m0cZ
	t/B2tlo57P53gCprzEu5nbKD6MVi4570dtSKWvTaX42kPkbnnRryuAzzsPYwneFi
	weKUYvzd3X6x1S0vddqWVUdrADPHl+2NaGBPo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7DAE958EED
	for <git@vger.kernel.org>; Tue,  3 Dec 2013 19:40:00 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A5FA958EEC
	for <git@vger.kernel.org>; Tue,  3 Dec 2013 19:39:59 -0500 (EST)
X-Mailer: git-send-email 1.8.5.1-400-gbc1da41
In-Reply-To: <1386117594-22062-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 9AF82610-5C7C-11E3-81CE-D331802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238745>

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
1.8.5.1-400-gbc1da41
