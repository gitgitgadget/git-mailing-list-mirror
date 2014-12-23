From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v2 0/2] Let `git remote add` play nicer with
 url.<url>.insteadOf
Date: Tue, 23 Dec 2014 14:24:50 +0100 (CET)
Message-ID: <cover.1419340898.git.johannes.schindelin@gmx.de>
References: <20141216021900.50095.24877@random.io>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: anapsix@random.io, git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Dec 23 14:25:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y3PSQ-00022x-FU
	for gcvg-git-2@plane.gmane.org; Tue, 23 Dec 2014 14:25:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755249AbaLWNY5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Dec 2014 08:24:57 -0500
Received: from mout.gmx.net ([212.227.15.19]:60254 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751205AbaLWNY4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Dec 2014 08:24:56 -0500
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx003) with ESMTPSA (Nemesis) id 0MXqaN-1YQh643crX-00WjCO;
 Tue, 23 Dec 2014 14:24:51 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <20141216021900.50095.24877@random.io>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:p/EmlJY1tswOMb58LvwyEjVwtKgSIuUV5RXjSymjhCnl/ubT89c
 j0GWe0EreP6LHmMilzTg5Jn+/5Gdg5ipSE70m0/Sc0nGysHHtbiDMT6z3VIQnSWCPBqaYWh
 wt2q83DQyDwXyO6ciw0zrHDuFa/gLdI5EQ0lfKNg30EXcN0oNkNlgHHlqxvCg/+FkU0cFK2
 N475BszCKkyfShJM6Cy5A==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261730>

Anastas Dancha reported that it is not possible to add a remote when
there is already a url.<url>.insteadOf = <nick> setting in
$HOME/.gitconfig.

While it makes sense to prevent surprises when a user adds a remote and
it fetches from somewhere completely different, it makes less sense to
prevent adding a remote when it is actually the same that was specified
in the config.

Therefore we add just another check that let's `git remote add` continue
when the "existing" remote's URL is identical to the specified one.

Interdiff below the diffstat (the commit message was also touched up to
stop pretending that we allow adding a remote twice when the URL did not
change).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>

Johannes Schindelin (2):
  git remote: allow adding remotes agreeing with url.<...>.insteadOf
  Add a regression test for 'git remote add <existing> <same-url>'

 builtin/remote.c  | 4 +++-
 t/t5505-remote.sh | 5 +++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index 9168c83..b4ff468 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -180,7 +180,8 @@ static int add(int argc, const char **argv)
 	url = argv[1];
 
 	remote = remote_get(name);
-	if (remote && (remote->url_nr > 1 || (strcmp(name, remote->url[0]) &&
+	if (remote && (remote->url_nr > 1 ||
+			(strcmp(name, remote->url[0]) &&
 				strcmp(url, remote->url[0])) ||
 			remote->fetch_refspec_nr))
 		die(_("remote %s already exists."), name);
-- 
2.0.0.rc3.9669.g840d1f9
