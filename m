From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH 2/2] clone: pass the remote name to remote_get
Date: Sun, 21 Mar 2010 21:19:49 +0100
Message-ID: <1269202789-8833-2-git-send-email-srabbelier@gmail.com>
References: <1269202789-8833-1-git-send-email-srabbelier@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>
To: Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Martin Waitz <tali@admingilde.org>,
	"Junio C Hamano" <gitst
X-From: git-owner@vger.kernel.org Sun Mar 21 21:20:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NtRd8-0003C3-J7
	for gcvg-git-2@lo.gmane.org; Sun, 21 Mar 2010 21:20:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753223Ab0CUUUK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Mar 2010 16:20:10 -0400
Received: from mail-ew0-f216.google.com ([209.85.219.216]:50403 "EHLO
	mail-ew0-f216.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753237Ab0CUUUG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Mar 2010 16:20:06 -0400
Received: by ewy8 with SMTP id 8so493635ewy.28
        for <git@vger.kernel.org>; Sun, 21 Mar 2010 13:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=CNGGkwNdfHYzjDL2P0ccGBvUnqBHbkr3mEvaCMgqRWs=;
        b=AmzytDG5TPlC8xNXmBAdmr53fCXOFcW103rmVj+aZNyue9S39UqrZ76sJwi1FUhPV9
         o47Ft0zXuOwjBmcq/MyEzT8i/iAniTlJTZzK1mxn7QYAfOUAlIUzRZ/mXl4ffmQ5BgYE
         5vg+RVBAWvMPpAzlWyIYcu24qddiaK4ly9FZE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=wHVMyMSCfgf1DgXTkaWyyjSQQkKrNRZRMdN8ZGT9ujHOuhOBhFY9sAnsVWl9vsIFk4
         8duJ6LVE/yyRspWBllAui2jr8CqxtZycL+VIyUOrQN5s4J0h1O8wWPrRy8R09zmvEQwe
         IFbWttRYq2PJ+o/nQ2vIIJ9RQrkhe+ftH9hME=
Received: by 10.213.41.10 with SMTP id m10mr2357106ebe.21.1269202804971;
        Sun, 21 Mar 2010 13:20:04 -0700 (PDT)
Received: from localhost.localdomain (ip138-114-211-87.adsl2.static.versatel.nl [87.211.114.138])
        by mx.google.com with ESMTPS id 16sm1300202ewy.3.2010.03.21.13.20.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 21 Mar 2010 13:20:04 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.2.325.g634e5
In-Reply-To: <1269202789-8833-1-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142856>

Currently when using a remote helper to clone a repository, the
remote helper will be passed the url of the target repository as
first argument (which represents the name of the remote). This name
is extracted from transport->remote->name, which is set by
builtin/clone.c when it calls remote_get with argv[0] as argument.

Fix this by passing the name remote will be set up as instead.
---

  I've spent quite a few hours trying to figure out why this broke
  t5700, so I would appreciate feedback from those with more
  knowledge about hardlinking and clone/fetch in general as to
  whether this couild cause any problems.

 builtin/clone.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index f878563..068d61f 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -513,7 +513,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		refs = clone_local(path, git_dir);
 		mapped_refs = wanted_peer_refs(refs, refspec);
 	} else {
-		struct remote *remote = remote_get(argv[0]);
+		struct remote *remote = remote_get(option_origin);
 		transport = transport_get(remote, remote->url[0]);
 
 		if (!transport->get_refs_list || !transport->fetch)
-- 
1.7.0.2.325.g634e5
