From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 15/17] rename_tmp_log(): handle a possible mkdir/rmdir race
Date: Mon,  6 Jan 2014 14:45:33 +0100
Message-ID: <1389015935-21936-16-git-send-email-mhagger@alum.mit.edu>
References: <1389015935-21936-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 06 14:54:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0Acv-0002IH-LO
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jan 2014 14:53:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754484AbaAFNxy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jan 2014 08:53:54 -0500
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:60384 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753572AbaAFNxx (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Jan 2014 08:53:53 -0500
X-Greylist: delayed 437 seconds by postgrey-1.27 at vger.kernel.org; Mon, 06 Jan 2014 08:53:52 EST
X-AuditID: 12074414-b7fb46d000002a4d-f5-52cab3baa189
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 89.84.10829.AB3BAC25; Mon,  6 Jan 2014 08:46:34 -0500 (EST)
Received: from michael.fritz.box (p57A25457.dip0.t-ipconnect.de [87.162.84.87])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s06DjfPG021935
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 6 Jan 2014 08:46:33 -0500
X-Mailer: git-send-email 1.8.5.2
In-Reply-To: <1389015935-21936-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGIsWRmVeSWpSXmKPExsUixO6iqLtr86kgg7bnkhZdV7qZLBp6rzBb
	vL25hNHi9or5zBa7py1gc2D1+Pv+A5PHzll32T0uXlL2eDzxBKvH501yAaxR3DZJiSVlwZnp
	efp2CdwZ27ctYCmYJFhx7IBpA+M63i5GTg4JAROJr7O3skDYYhIX7q1n62Lk4hASuMwocWL3
	RXYI5xiTxJ7tn5hBqtgEdCUW9TQzgdgiAmoSE9sOsYAUMQssZpTomvaNESQhLOAnMefyE7AG
	FgFVidN7VrCD2LwCrhITd50FsjmA1ilIrL4uBBLmBApPm3aYDcQWEnCRWHPoEcsERt4FjAyr
	GOUSc0pzdXMTM3OKU5N1i5MT8/JSi3Qt9HIzS/RSU0o3MUJCSmQH45GTcocYBTgYlXh4Pzw+
	GSTEmlhWXJl7iFGSg0lJlJdz9akgIb6k/JTKjMTijPii0pzU4kOMEhzMSiK8XAuAcrwpiZVV
	qUX5MClpDhYlcd5vi9X9hATSE0tSs1NTC1KLYLIyHBxKErwbNgE1ChalpqdWpGXmlCCkmTg4
	QQQXyAYeoA0zQAp5iwsSc4sz0yGKTjEqSonzTgFJCIAkMkrz4AbAov8VozjQP8K85SBVPMDE
	Adf9CmgwE9Dg0DiwwSWJCCmpBsYUMYfjExNqGDYnH+sqUHfSXHiy/P3+WVIcWRd8vdieLtJc
	/nzT0Ul7yrS3zxeaPSHuxSpbI+fZn5cstrvFwtp1JKFi/c5Jr/ZsDJjqkFrl0Fn6Vl9II2VO
	XPAeyb1szN887b/uq/3/fm+qs0mu8fGshsPNrNy/Gjx2TNrLevqA+KHPgn9m7OxT 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240010>

If a directory vanishes while renaming the temporary reflog file,
retry (up to 3 times).  This could happen if another process deletes
the directory created by safe_create_leading_directories() just before
we rename the file into the directory.

As far as I can tell, this race could not occur internal to git.  The
only time that a directory under $GIT_DIR/logs is deleted is if room
has to be made for a log file for a reference with the same name;
for example, in the following sequence:

    git branch foo/bar    # Creates file .git/logs/refs/heads/foo/bar
    git branch -d foo/bar # Deletes file but leaves .git/logs/refs/heads/foo/
    git branch foo        # Deletes .git/logs/refs/heads/foo/

But the only reason the last command deletes the directory is because
it wants to create a file with the same name.  So if another process
(e.g.,

    git branch foo/baz

) wants to create that directory, one of the two is doomed to failure
anyway because of a D/F conflict.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index 5bc01a7..8de636e 100644
--- a/refs.c
+++ b/refs.c
@@ -2530,12 +2530,14 @@ int delete_ref(const char *refname, const unsigned char *sha1, int delopt)
 
 static int rename_tmp_log(const char *newrefname)
 {
+	int attempts = 3;
+
+ retry:
 	if (safe_create_leading_directories(git_path("logs/%s", newrefname))) {
 		error("unable to create directory for %s", newrefname);
 		return -1;
 	}
 
- retry:
 	if (rename(git_path(TMP_RENAMED_LOG), git_path("logs/%s", newrefname))) {
 		if (errno==EISDIR || errno==ENOTDIR) {
 			/*
@@ -2548,6 +2550,13 @@ static int rename_tmp_log(const char *newrefname)
 				return -1;
 			}
 			goto retry;
+		} else if (errno == ENOENT && --attempts > 0) {
+			/*
+			 * Maybe another process just deleted one of
+			 * the directories in the path to newrefname.
+			 * Try again from the beginning.
+			 */
+			goto retry;
 		} else {
 			error("unable to move logfile "TMP_RENAMED_LOG" to logs/%s: %s",
 				newrefname, strerror(errno));
-- 
1.8.5.2
