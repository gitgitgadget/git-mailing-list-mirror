From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [RFC/PATCH] remote-curl: Obey passed URL
Date: Thu,  6 Oct 2011 15:15:59 +0200
Message-ID: <2f1eccfa3fa9e732e9bea344fd69dfd9b16697a9.1317906388.git.git@drmicha.warpmail.net>
References: <4E8D4BD5.2090202@drmicha.warpmail.net>
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Tay Ray Chuan <rctay89@gmail.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 06 15:16:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBno1-0006Am-8k
	for gcvg-git-2@lo.gmane.org; Thu, 06 Oct 2011 15:16:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964807Ab1JFNQE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Oct 2011 09:16:04 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:42805 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758250Ab1JFNQC (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Oct 2011 09:16:02 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 5B2DF266A8;
	Thu,  6 Oct 2011 09:16:01 -0400 (EDT)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute3.internal (MEProxy); Thu, 06 Oct 2011 09:16:01 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references; s=smtpout; bh=yzLuNfVKtN9dQv+VAf7u0Mpk5
	Nc=; b=rw+UAsIeZ0wOsAo5wUEGT0WCyDM1HwEuVLrE4ABxygedtyqf/0GwwLTPY
	vIgR8zIaboq/Q31DR9myO54WIQ4fMpCc2MBlLcOR4ASqqZIjti6Vc2Faii0+GJw5
	OabhBgfaxI/zSIz+tQow9VF864idgDgyPKh2satKK+Q0u1qEFc=
X-Sasl-enc: 9KjspiA4kcqQeesd0GmCrzaITFjZIM4VsTcsB3gd3TnE 1317906960
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id C9BC5400595;
	Thu,  6 Oct 2011 09:16:00 -0400 (EDT)
X-Mailer: git-send-email 1.7.7.rc2.451.g15e150
In-Reply-To: <4E8D4BD5.2090202@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182944>

When the curl remote helper is called, e.g., as

git-remote-https foo https://john@doe.com

it looks up remote.foo.url rather than taking the provided url, at least
as far as http_init() is concerned (authentication). (It does use the
provided url at later stages.)

The problem is that for pushing, "git push" looks up the pushurl, which
may be different, and passes that down to the remote helper, so that the
remote helper should take that when provided.

Note that at the init stage, the remote helper does not know what kind of
transcation is going to be requested, but the caller does.

Change it so that the remote helper obeys the passed url rather than
trying to look it up.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
While this passes all tests and fixes the described problem, I don't
know about any side effects. Also, I always feel a bit insecure about
simply dropping pointers to allocated memory (remote->url[0]). Should
I free() it? Neither remote-helpers nor memory management are exactly
homeground for me...
---
 remote-curl.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/remote-curl.c b/remote-curl.c
index b8cf45a..1fa396a 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -846,6 +846,7 @@ int main(int argc, const char **argv)
 
 	if (argc > 2) {
 		end_url_with_slash(&buf, argv[2]);
+		remote->url[0] = xstrdup(argv[2]);
 	} else {
 		end_url_with_slash(&buf, remote->url[0]);
 	}
-- 
1.7.7.rc2.451.g15e150
