From: Anastas Dancha <anapsix@random.io>
Subject: [PATCH] remote: allow adding remote w same name as alias
Date: Tue, 16 Dec 2014 02:30:30 +0000
Message-ID: <20141216021900.50095.24877@random.io>
Mime-Version: 1.0
Content-Type: text/plain; charset="ascii"
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 16 03:34:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y0hxi-0003Uy-Db
	for gcvg-git-2@plane.gmane.org; Tue, 16 Dec 2014 03:34:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750892AbaLPCac (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Dec 2014 21:30:32 -0500
Received: from mail-s74.mailgun.info ([184.173.153.202]:46791 "EHLO
	mail-s74.mailgun.info" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750859AbaLPCab (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Dec 2014 21:30:31 -0500
X-Greylist: delayed 663 seconds by postgrey-1.27 at vger.kernel.org; Mon, 15 Dec 2014 21:30:31 EST
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=random.io; q=dns/txt; s=mailo;
 t=1418697031; h=Sender: Date: Content-Transfer-Encoding: Message-Id:
 To: From: Subject: Cc: Content-Type: Mime-Version;
 bh=ISiOM6XFfGjLyy5g+sHuZ/Nl44HvjQ2cu7voVygYAT0=; b=eb7ZWJN73BZ7KvgVExn/ZGZYa2u3wv31bDLU+Jsw4nwtHq9rUiUa6/befn58PkQ+uBT/0mQ5
 Lt7DRd6fRORSshy0hKoULvnxBBUIk7ClHRiJCxVdFBmnItguTW3kVbsymjRCydhc6Qc/q9r6
 QvPdATdZ1GX/WAVDMHSyrbLt5v4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=random.io; s=mailo; q=dns;
 h=Mime-Version: Content-Type: Cc: Subject: From: To: Message-Id:
 Content-Transfer-Encoding: Date: Sender;
 b=uYm9oefJBY5haAPQB17YANf0vRbQpuayNt6A+kHiOFMSMZ1oQaw2UE0+P77FzE0dC0WCqN
 EHK4zGt+1EAJTMzxHHxhm5liLZbWE1X86hYgvS+sM3N09+5WuHByatGy7LnIA3dKOi+ArAT+
 rkg+F5a7TyH4EUdAlAHjg66u9T/RI=
Received: by luna.mailgun.net with HTTP; Tue, 16 Dec 2014 02:19:00 +0000
X-Mailgun-Sid: WyJlNGQ0NiIsICJnaXRAdmdlci5rZXJuZWwub3JnIiwgImRjZGNkMCJd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261437>

>From f80bdf3272e7bdf790ee67fb94196a8aa139331f Mon Sep 17 00:00:00 2001
From: Anastas Dancha <anapsix@random.io>
Date: Mon, 15 Dec 2014 16:30:50 -0500
Subject: [PATCH] remote: allow adding remote w same name as alias

When ~/.gitconfig contains an alias (i.e. myremote)
and you are adding a new remote using the same name
for remote, Git will refuse to add the remote with
the same name as one of the aliases, even though the
remote with such name is not setup for current repo.

$ git remote add myremote git@host.com:team/repo.git
fatal: remote myremote already exists.

The fatal error comes from strcmp(name, remote->url[0])
condition, which compares a name of the new remote with
existing urls of all the remotes, including the ones
from ~/.gitconfig (or global variant).
I'm not sure why that is necessary, unless Git is meant
to prevent users from naming their remotes as their
remote aliases..
Imho, if someone want's to git remote add myremote
myremote, they should, since git-remote always takes
2 arguments, first being the new remote's name and
second being new remote's url (or alias, if set).
Thanks to @mymuss for sanity check and debugging.

Signed-off-by: Anastas Dancha <anapsix@random.io>
---
 builtin/remote.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index 7f28f92..7471d0a 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -180,9 +180,8 @@ static int add(int argc, const char **argv)
 	url = argv[1];
 
 	remote = remote_get(name);
-	if (remote && (remote->url_nr > 1 || strcmp(name, remote->url[0]) ||
-			remote->fetch_refspec_nr))
-		die(_("remote %s already exists."), name);
+	if (remote && (remote->url_nr > 1 || remote->fetch_refspec_nr))
+		die(_("remote %s %s already exists."), name, url);
 
 	strbuf_addf(&buf2, "refs/heads/test:refs/remotes/%s/test", name);
 	if (!valid_fetch_refspec(buf2.buf))
-- 
2.2.0
