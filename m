From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 5/5] pretty: make %GK output the signing key for signed commits
Date: Thu, 14 Feb 2013 17:04:46 +0100
Message-ID: <6787e82ff88f641eeb17245e93e9240e61270842.1360857415.git.git@drmicha.warpmail.net>
References: <CAJ9Ak2pLqUesOWKNtjwG7P_BW7-EqJP4Kaj0FF_+72Wn=oGoew@mail.gmail.com>
Cc: Mariusz Gronczewski <xani666@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 14 17:05:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U61JS-0004vW-PP
	for gcvg-git-2@plane.gmane.org; Thu, 14 Feb 2013 17:05:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934633Ab3BNQE5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Feb 2013 11:04:57 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:37334 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1761393Ab3BNQEw (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Feb 2013 11:04:52 -0500
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 5B74D20A2E;
	Thu, 14 Feb 2013 11:04:52 -0500 (EST)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute2.internal (MEProxy); Thu, 14 Feb 2013 11:04:52 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:in-reply-to:references; s=smtpout; bh=OP
	Wfc/nqKjwc32yNdCMKG7SLk8g=; b=DO61nZadhp6P27Upex2cOEfpzTcvaY6D/J
	fLUW3TtIYM4CNXJ/8jxO7RfwtuSugqN9P8BI8eWJsj52KL+qWPPVnAcYcYxOrSac
	x6g0aGJ/HEHQvP5SnMJInRmM6cbTov2v3vtMZhqJm7ljp45GaKPssfYHefJKuqzw
	WYWFwtvgU=
X-Sasl-enc: w9lldhsb16pW4WwgXAVFrDC81+60DSIlc/nuRSpUJw2b 1360857891
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id EF42D4824C8;
	Thu, 14 Feb 2013 11:04:51 -0500 (EST)
X-Mailer: git-send-email 1.8.1.3.797.ge0260c7
In-Reply-To: <CAJ9Ak2pLqUesOWKNtjwG7P_BW7-EqJP4Kaj0FF_+72Wn=oGoew@mail.gmail.com>
In-Reply-To: <cover.1360857415.git.git@drmicha.warpmail.net>
References: <cover.1360857415.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216316>

Because we can.

No, really: In order to employ signed keys in an automated way it is
absolutely necessary to check which keys the signatures come from. Now
you can.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 Documentation/pretty-formats.txt | 1 +
 pretty.c                         | 9 ++++++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index 105f18a..2939655 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -133,6 +133,7 @@ The placeholders are:
 - '%GG': raw verification message from GPG for a signed commit
 - '%G?': show either "G" for Good or "B" for Bad for a signed commit
 - '%GS': show the name of the signer for a signed commit
+- '%GK': show the key used to sign a signed commit
 - '%gD': reflog selector, e.g., `refs/stash@{1}`
 - '%gd': shortened reflog selector, e.g., `stash@{1}`
 - '%gn': reflog identity name
diff --git a/pretty.c b/pretty.c
index 973b912..b57adef 100644
--- a/pretty.c
+++ b/pretty.c
@@ -762,6 +762,7 @@ struct format_commit_context {
 		char *gpg_status;
 		char good_bad;
 		char *signer;
+		char *key;
 	} signature;
 	char *message;
 	size_t width, indent1, indent2;
@@ -964,7 +965,9 @@ static void parse_signature_lines(struct format_commit_context *ctx)
 		if (!found)
 			continue;
 		ctx->signature.good_bad = signature_check[i].result;
-		found += strlen(signature_check[i].check)+17;
+		found += strlen(signature_check[i].check);
+		ctx->signature.key = xmemdupz(found, 16);
+		found += 17;
 		next = strchrnul(found, '\n');
 		ctx->signature.signer = xmemdupz(found, next - found);
 		break;
@@ -1204,6 +1207,10 @@ static size_t format_commit_one(struct strbuf *sb, const char *placeholder,
 			if (c->signature.signer)
 				strbuf_addstr(sb, c->signature.signer);
 			break;
+		case 'K':
+			if (c->signature.key)
+				strbuf_addstr(sb, c->signature.key);
+			break;
 		}
 		return 2;
 	}
-- 
1.8.1.3.797.ge0260c7
