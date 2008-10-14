From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH] remote.c: correct the check for a leading '/' in a remote
 name
Date: Tue, 14 Oct 2008 15:30:21 -0500
Message-ID: <J-KL1Cgc2b78Lced5uBNDhP0MHdg91do73K_0waicFQYbDZHjYkocw@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Daniel Barkalow <barkalow@iabervon.org>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Oct 14 22:32:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KpqYf-0001zv-C5
	for gcvg-git-2@gmane.org; Tue, 14 Oct 2008 22:31:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751241AbYJNUa1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Oct 2008 16:30:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751054AbYJNUa0
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Oct 2008 16:30:26 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:60490 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751084AbYJNUaZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Oct 2008 16:30:25 -0400
Received: by mail.nrlssc.navy.mil id m9EKULmW006067; Tue, 14 Oct 2008 15:30:21 -0500
X-OriginalArrivalTime: 14 Oct 2008 20:30:21.0775 (UTC) FILETIME=[AE39EDF0:01C92E3B]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98208>

This test is supposed to disallow remote entries in the config file of the
form:

   [remote "/foobar"]
      ...

The leading slash in '/foobar' is not acceptable.

Instead it was incorrectly testing that the subkey had no leading '/', which
had no effect since the subkey pointer was made to point at a '.' in the
preceding lines.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---


I stumbled across this code which looks like a mistake.
This patch seems like the correct fix.

-brandon


 remote.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/remote.c b/remote.c
index d5efadd..8a04066 100644
--- a/remote.c
+++ b/remote.c
@@ -341,13 +341,14 @@ static int handle_config(const char *key, const char *value, void *cb)
 	if (prefixcmp(key,  "remote."))
 		return 0;
 	name = key + 7;
+	if (*name == '/') {
+		warning("Config remote shorthand cannot begin with '/': %s",
+			name);
+		return 0;
+	}
 	subkey = strrchr(name, '.');
 	if (!subkey)
 		return error("Config with no key for remote %s", name);
-	if (*subkey == '/') {
-		warning("Config remote shorthand cannot begin with '/': %s", name);
-		return 0;
-	}
 	remote = make_remote(name, subkey - name);
 	if (!strcmp(subkey, ".mirror"))
 		remote->mirror = git_config_bool(key, value);
-- 
1.6.0.2.468.gd5b83
