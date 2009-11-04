From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH v2 08/13] Write local refs written by the "import" helper command only once
Date: Wed,  4 Nov 2009 20:48:13 +0100
Message-ID: <1257364098-1685-9-git-send-email-srabbelier@gmail.com>
References: <1257364098-1685-1-git-send-email-srabbelier@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>
To: Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Nov 04 20:50:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5lrl-0000NL-0S
	for gcvg-git-2@lo.gmane.org; Wed, 04 Nov 2009 20:50:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758114AbZKDTtf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Nov 2009 14:49:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758097AbZKDTtQ
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Nov 2009 14:49:16 -0500
Received: from mail-ew0-f207.google.com ([209.85.219.207]:61042 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758088AbZKDTtM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Nov 2009 14:49:12 -0500
Received: by mail-ew0-f207.google.com with SMTP id 3so3490470ewy.37
        for <git@vger.kernel.org>; Wed, 04 Nov 2009 11:49:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=xk+TjPv1SJ9VTD5LVbxShpJwZGJu6035rmjc2T2Qwq8=;
        b=csONEFRRZOiX8b9DqlkLdVlnVfs7HWhCDZ4FOcG0L3xGhsvysCniygvSvzh09gNIXP
         7Q8OeqsXKbLPufRBiF1SK8J5W1IsOsS6hx6d/FLHiP1kxKWrZ8runO+ZtUXTw+kzBYcY
         ubYH6a3TtZhHt/kQS8vkYQ0H4m2rA/fXFum4U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=E7/7LNUZQWfHBcQ6ApEy6T1Z7aveMAy38/woJ4qFM2VcWwDAnOmKaAGQauC5rFZECN
         r+FFoipDoSdySYRgsMaxECAgW7Vmablx8V/Vu+aC+aBgZm3XKEYkg0ILox0bml0eJ83j
         Hz9TSlaNUhU1uA2j4U3z97UGfm7yE4sZhxSiU=
Received: by 10.213.23.75 with SMTP id q11mr2292117ebb.43.1257364157497;
        Wed, 04 Nov 2009 11:49:17 -0800 (PST)
Received: from localhost.localdomain (ip138-114-211-87.adsl2.static.versatel.nl [87.211.114.138])
        by mx.google.com with ESMTPS id 5sm4314489eyh.2.2009.11.04.11.49.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 04 Nov 2009 11:49:16 -0800 (PST)
X-Mailer: git-send-email 1.6.5.2.295.g0d105
In-Reply-To: <1257364098-1685-1-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132133>

At clone time the "import" helper command has already written a
packfile with all refs, so write_remote_refs will create a duplicate
entry for each ref returned by wanted_peer_refs. Prevent this
duplication by setting fetched_refs_written in the transport when
executing the "import" helper command and only adding the extra refs
if it is not set.

Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
---

	I am not 100% sure this is the proper fix, but I do know that
	without this I get a .git/packed-refs file that has duplicate
	entries in it.

 builtin-clone.c    |    5 ++++-
 transport-helper.c |    3 +++
 transport.h        |    2 ++
 3 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/builtin-clone.c b/builtin-clone.c
index 5df8b0f..e44347e 100644
--- a/builtin-clone.c
+++ b/builtin-clone.c
@@ -542,7 +542,10 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	if (refs) {
 		clear_extra_refs();
 
-		write_remote_refs(mapped_refs);
+		if(transport->fetched_refs_written)
+			pack_refs(PACK_REFS_ALL);
+		else
+			write_remote_refs(mapped_refs);
 
 		remote_head = find_ref_by_name(refs, "HEAD");
 		remote_head_points_at =
diff --git a/transport-helper.c b/transport-helper.c
index 82caaae..148496c 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -165,7 +165,10 @@ static int fetch(struct transport *transport,
 		return fetch_with_fetch(transport, nr_heads, to_fetch);
 
 	if (data->import)
+	{
+		transport->fetched_refs_written = 1;
 		return fetch_with_import(transport, nr_heads, to_fetch);
+	}
 
 	return -1;
 }
diff --git a/transport.h b/transport.h
index 503db11..7458b9e 100644
--- a/transport.h
+++ b/transport.h
@@ -65,6 +65,8 @@ struct transport {
 	signed verbose : 2;
 	/* Force progress even if the output is not a tty */
 	unsigned progress : 1;
+	/* Refs fetched by transport_get_remote_refs are already written */
+	unsigned fetched_refs_written : 1;
 };
 
 #define TRANSPORT_PUSH_ALL 1
-- 
1.6.5.2.295.g0d105
