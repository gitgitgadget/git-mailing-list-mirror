From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH] Prevent git-remote-cvs from segfaulting
Date: Mon, 26 Oct 2009 18:43:36 -0700
Message-ID: <1256607816-10509-1-git-send-email-srabbelier@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>
To: "Git List" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>, "Jeff King" <peff@peff.net>,
	"Daniel Barkalow" <barkalow@iabervon.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Oct 27 02:44:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N2b6w-0006bE-RP
	for gcvg-git-2@lo.gmane.org; Tue, 27 Oct 2009 02:44:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756035AbZJ0BoZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Oct 2009 21:44:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756018AbZJ0BoZ
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Oct 2009 21:44:25 -0400
Received: from mail-ew0-f208.google.com ([209.85.219.208]:65378 "EHLO
	mail-ew0-f208.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754596AbZJ0BoY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Oct 2009 21:44:24 -0400
Received: by ewy4 with SMTP id 4so4228158ewy.37
        for <git@vger.kernel.org>; Mon, 26 Oct 2009 18:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=dMoYpIGNZYAVX4L91bCLz7G9K5GpH/uM97JLwakA1Q8=;
        b=ZiwKI6m+Se3w8S0C7Up3ocNGvK0vcTvVTtRfrv5BO6CbO7LW16tOAFvwSGWIhYLqbm
         bgXqrOa/2ba6y5lA8R5DrFIgsJRZlWivP6Ti0hvxZrKtT38l6/VXDymra2fk4eHxme7K
         bNNDjEDny98tAzBFT1xBOlWM+2yLhA28FIDcY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=GBrKCgWdAs2C5PQHtUV+drpFiV7lOQIf6tHFLeym6aJSuqwOhBOOxMk47ZJIua+hFc
         CVoPtSa9nPy8CD3vcRmX/MG+V4XxPmHjl209QBunXZ0p5Nrkx79u5vBkOiVIYRA7lw0a
         E9QvktrryG2KBlwOtwxgrOHJFGS/MlX6mD4zU=
Received: by 10.216.89.14 with SMTP id b14mr2385430wef.76.1256607867897;
        Mon, 26 Oct 2009 18:44:27 -0700 (PDT)
Received: from localhost.localdomain ([216.239.45.19])
        by mx.google.com with ESMTPS id j8sm2057735gvb.4.2009.10.26.18.44.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 26 Oct 2009 18:44:27 -0700 (PDT)
X-Mailer: git-send-email 1.6.5.1.125.g76b2.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131303>

In [0] Shawn identified what caused git-remote-cvs from segfaulting,
which should be fixed as desribed in Daniel's reply to that [1].
In the meanwhile, the current patch fixes the issue until Daniel
submits a patch to fix it properly.

[0] http://thread.gmane.org/gmane.comp.version-control.git/130357/focus=130421
[1] http://thread.gmane.org/gmane.comp.version-control.git/130357/focus=131021

Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
Not-Signed-off-by: Jeff King <peff@peff.net>
---

	Jeff wrote this total hack but wants no credit, responsibility or
	anything else to do with it whatsoever.

	I think it might be nice to have this on top of pu until Daniel
	submits a proper patch, so that until that time the test suite
	does not segfault.

 transport-helper.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/transport-helper.c b/transport-helper.c
index 410aa49..d867abb 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -68,6 +68,8 @@ static struct child_process *get_helper(struct transport *transport)
 static int disconnect_helper(struct transport *transport)
 {
 	struct helper_data *data = transport->data;
+	if(!data)
+		return 0;
 	if (data->helper) {
 		write_str_in_full(data->helper->in, "\n");
 		close(data->helper->in);
@@ -78,6 +80,7 @@ static int disconnect_helper(struct transport *transport)
 		free(data->helper);
 		data->helper = NULL;
 	}
+	transport->data = NULL;
 	free(data);
 	return 0;
 }
-- 
1.6.5.1.125.g76b2.dirty
