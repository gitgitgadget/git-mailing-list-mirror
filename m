From: Mike Hommey <mh@glandium.org>
Subject: [PATCH] clone: call transport_set_verbosity before anything else on the newly created transport
Date: Tue, 12 May 2015 12:12:31 +0900
Message-ID: <1431400351-1590-1-git-send-email-mh@glandium.org>
References: <xmqqfv721rh7.fsf@gitster.dls.corp.google.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 12 05:12:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ys0cf-0003zM-JM
	for gcvg-git-2@plane.gmane.org; Tue, 12 May 2015 05:12:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752220AbbELDMk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 May 2015 23:12:40 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:37188 "EHLO
	glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752032AbbELDMk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 May 2015 23:12:40 -0400
Received: from glandium by zenigata with local (Exim 4.85)
	(envelope-from <glandium@glandium.org>)
	id 1Ys0cR-0000QK-52; Tue, 12 May 2015 12:12:31 +0900
X-Mailer: git-send-email 2.4.0.1.gde5e018
In-Reply-To: <xmqqfv721rh7.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268841>

Commit 2879bc3 made the progress and verbosity options sent to remote helper
earlier than they previously were. But nothing else after that would send
updates if the value is changed later on with transport_set_verbosity.

While for fetch and push, transport_set_verbosity is the first thing that
is done after creating the transport, it was not the case for clone. So
commit 2879bc3 broke changing progress and verbosity for clone, for urls
requiring a remote helper only (so, not git:// urls, for instance).

Moving transport_set_verbosity to just after the transport is created
works around the issue.
---
 builtin/clone.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Note that another long term way to fix this would be to move setting
verbosity and progress to the transport_get call itself.

The patch is against v2.4.0, if that matters.

diff --git a/builtin/clone.c b/builtin/clone.c
index 53a2e5a..13030ee 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -906,6 +906,8 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 
 	remote = remote_get(option_origin);
 	transport = transport_get(remote, remote->url[0]);
+	transport_set_verbosity(transport, option_verbosity, option_progress);
+
 	path = get_repo_path(remote->url[0], &is_bundle);
 	is_local = option_local != 0 && path && !is_bundle;
 	if (is_local) {
@@ -932,8 +934,6 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	if (option_single_branch)
 		transport_set_option(transport, TRANS_OPT_FOLLOWTAGS, "1");
 
-	transport_set_verbosity(transport, option_verbosity, option_progress);
-
 	if (option_upload_pack)
 		transport_set_option(transport, TRANS_OPT_UPLOADPACK,
 				     option_upload_pack);
-- 
2.4.0.1.gde5e018
