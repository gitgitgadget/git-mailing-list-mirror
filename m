From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 15/17] rename_tmp_log(): handle a possible mkdir/rmdir race
Date: Sat, 18 Jan 2014 23:48:59 +0100
Message-ID: <1390085341-2553-16-git-send-email-mhagger@alum.mit.edu>
References: <1390085341-2553-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 18 23:50:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W4eiI-0005CE-7e
	for gcvg-git-2@plane.gmane.org; Sat, 18 Jan 2014 23:50:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751821AbaARWtz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Jan 2014 17:49:55 -0500
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:64026 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751727AbaARWtr (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 18 Jan 2014 17:49:47 -0500
X-AuditID: 12074411-b7f426d000005455-05-52db050abb19
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id B0.EB.21589.A050BD25; Sat, 18 Jan 2014 17:49:46 -0500 (EST)
Received: from michael.fritz.box (p4FDD4E9C.dip0.t-ipconnect.de [79.221.78.156])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s0IMnN98030075
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Sat, 18 Jan 2014 17:49:45 -0500
X-Mailer: git-send-email 1.8.5.2
In-Reply-To: <1390085341-2553-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrEIsWRmVeSWpSXmKPExsUixO6iqMvFejvI4O0tPYuuK91MFg29V5gt
	bq+Yz+zA7PH3/Qcmj4uXlD0+b5ILYI7itklKLCkLzkzP07dL4M64dvYKS8EywYo5F88zNjAe
	4u1i5OSQEDCR2DF5NiOELSZx4d56ti5GLg4hgcuMEu+fz2CEcE4wSey/dhmsik1AV2JRTzMT
	iC0ioCYxse0QC4jNLOAgsflzI1iNsICfRNuKA2A2i4CqxKqNU8DqeQVcJJ5seABkcwBtU5BY
	fV0IJMwJFD4y/wJYiZCAs8TN10/YJzDyLmBkWMUol5hTmqubm5iZU5yarFucnJiXl1qka6qX
	m1mil5pSuokREiqCOxhnnJQ7xCjAwajEw3uA6XaQEGtiWXFl7iFGSQ4mJVFeZZAQX1J+SmVG
	YnFGfFFpTmrxIUYJDmYlEd7gDbeChHhTEiurUovyYVLSHCxK4rx8S9T9hATSE0tSs1NTC1KL
	YLIyHBxKErzeLEBDBYtS01Mr0jJzShDSTBycIIILZAMPyAaQQt7igsTc4sx0iKJTjIpS4rzh
	IAkBkERGaR7cAFhUv2IUB/pHmFcKpIoHmBDgul8BDWYCGiwSexNkcEkiQkqqgXFbr/2tE2sr
	Fu9qM2HW2nxkkbr1jfyEL89+PohLNQj7wpOTnSV8lFGzSKtbR67nkFbIQieGN2drWdNzfGc6
	5fTWXF91a9nUKWc4U8O+LqiPWj63oTRr2QG9Fjm+zU2m13SC2TkuzahnmJfuO8lm4lKd4vhs
	5vqcxdW7P67++Snkerz+vNCgp0osxRmJhlrMRcWJAN6BwkTFAgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240659>

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
index d0fab39..a90904b 100644
--- a/refs.c
+++ b/refs.c
@@ -2530,12 +2530,14 @@ int delete_ref(const char *refname, const unsigned char *sha1, int delopt)
 
 static int rename_tmp_log(const char *newrefname)
 {
+	int attempts_remaining = 3;
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
+		} else if (errno == ENOENT && --attempts_remaining > 0) {
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
