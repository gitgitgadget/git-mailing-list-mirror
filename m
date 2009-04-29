From: Augie Fackler <durin42@gmail.com>
Subject: [PATCH] Workaround for ai_canonname sometimes coming back as null
Date: Wed, 29 Apr 2009 16:48:57 -0500
Message-ID: <9C355DCC-0240-4B9E-83CA-083B51C2E34C@gmail.com>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 29 23:51:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LzHgT-0001m8-6Y
	for gcvg-git-2@gmane.org; Wed, 29 Apr 2009 23:51:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753651AbZD2Vue (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2009 17:50:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752219AbZD2Vue
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Apr 2009 17:50:34 -0400
Received: from hapkido.dreamhost.com ([66.33.216.122]:40211 "EHLO
	hapkido.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750834AbZD2Vud (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2009 17:50:33 -0400
Received: from spunkymail-a17.g.dreamhost.com (caiajhbdcbef.dreamhost.com [208.97.132.145])
	by hapkido.dreamhost.com (Postfix) with ESMTP id 38E5918580A
	for <git@vger.kernel.org>; Wed, 29 Apr 2009 14:50:33 -0700 (PDT)
Received: from [192.168.50.170] (unknown [12.116.117.150])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by spunkymail-a17.g.dreamhost.com (Postfix) with ESMTP id 7410E7361F
	for <git@vger.kernel.org>; Wed, 29 Apr 2009 14:49:27 -0700 (PDT)
X-Mailer: Apple Mail (2.930.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117957>

Fix a weird bug where git-daemon was segfaulting when started by sh(1)
because ai_canonname was null.

---
I'm not really sure why being started by sh has any measurable impact.
git-daemon works fine if I start it manually from an interactive prompt.

Easy reproduction script (the git clone command will fail reliably for  
me without this patch):

#!/bin/sh
mkdir temp
cd temp
mkdir narf
cd narf
git init
echo a > a
git add a
git commit -am 'hi'
cd ..
git daemon --base-path="$(pwd)"\
  --listen=127.0.0.1\
  --export-all\
  --pid-file=gitdaemon.pid \
  --detach --reuseaddr
git clone git://127.0.0.1/narf bla
kill `cat gitdaemon.pid`


  daemon.c |    5 ++++-
  1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/daemon.c b/daemon.c
index 13401f1..b1fede0 100644
--- a/daemon.c
+++ b/daemon.c
@@ -459,7 +459,10 @@ static void parse_extra_args(char *extra_args,  
int buflen)
  				inet_ntop(AF_INET, &sin_addr->sin_addr,
  					  addrbuf, sizeof(addrbuf));
  				free(canon_hostname);
-				canon_hostname = xstrdup(ai->ai_canonname);
+				if (ai->ai_canonname)
+					canon_hostname = xstrdup(ai->ai_canonname);
+				else
+					canon_hostname = "unknown";
  				free(ip_address);
  				ip_address = xstrdup(addrbuf);
  				break;
-- 
1.6.3.rc3.12.gb7937
