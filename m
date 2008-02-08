From: "H.Merijn Brand" <h.m.brand@xs4all.nl>
Subject: [PATCH] opening files in remote.c should ensure it is opening a
 file
Date: Fri, 8 Feb 2008 17:46:54 +0100
Message-ID: <20080208174654.2e9e679c@pc09.procura.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 08 17:47:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNWO0-0006J9-HD
	for gcvg-git-2@gmane.org; Fri, 08 Feb 2008 17:47:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755437AbYBHQrB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2008 11:47:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755143AbYBHQrB
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Feb 2008 11:47:01 -0500
Received: from smtp-vbr1.xs4all.nl ([194.109.24.21]:4731 "EHLO
	smtp-vbr1.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755238AbYBHQrA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2008 11:47:00 -0500
Received: from pc09.procura.nl (procura.xs4all.nl [82.95.216.29])
	(authenticated bits=0)
	by smtp-vbr1.xs4all.nl (8.13.8/8.13.8) with ESMTP id m18GksWB066169
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Fri, 8 Feb 2008 17:46:59 +0100 (CET)
	(envelope-from h.m.brand@xs4all.nl)
X-Mailer: Claws Mail 3.2.0cvs74 (GTK+ 2.10.6; x86_64-unknown-linux-gnu)
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwEAIAAACI8LKTAAAACXBIWXMAAABIAAAASABGyWs+AAAC
 JElEQVRo3u2aMY4CMQxFczZ6RItEzRm4DBINDbRUSPRInIRbsNK6+dJfezN4kokn48IaCSjysL8d
 e9Knoj2fr9f9/gllqQ6U9/vxWK3EdwdIEGjRIVCu18NhuxUfK46SH81+fzrdbuKPx/P5ctHQdAdI
 TKAgpvV6s9ntBEfXEYSGgMQzIHnuFBBjkshCNJ2KtJZ04hHNAugP8bZr3NIHhbcF0AKoK0CoaHXU
 LUWBIs1n+jV+Fl8CVqOApEXAwyMO/DSR4XVntoAYDR7eBjQupuYAYTMph8Rj21D4m7MChN02tpqs
 NSnb/KqU2oHCXu5xDCgflj/RAgBiKBIXnICzAsSjWBsTz5K4/HeXYvb8yK5lY3VGEwPi2aONKT+5
 AlcxrTPOwcTiraGRChgMEKJh0bVVifGVTq6qgBiNVl8QE29EsK6VE+YJAOG2wz5AvsqUS6uqgHCA
 n4NGvBYpnJ64Jgg27sCtxtBk1CJIA4S/GhdWKh07QxUB48jWGhZ4jKamRRr/T8/M0AaEyctry6YB
 4dTGj9iWZNs3DahES5kPCJOu0RQbF/fQOBprsB9gaO9JtPDzII9U5ySXX7AnuIt91y54AAW7rPpT
 LCe5gt3F+CLqr2UarGB3MXvMylWGq4+9RCx3TW1oJq1t3HPQlFs6N1fFNEB4s8dn7Ne7ACSm7TPQ
 I5quAWmw6qBpulHM33B0Csge4Nd8JTTYG2b1XyRe3lH8x34ABJ6aePuQ2N4AAAAASUVORK5CYII=
X-Virus-Scanned: by XS4ALL Virus Scanner
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73111>

HP-UX allows directories to be opened with fopen (path, "r"), which
will cause some translations that expect to read files, read dirs
instead. This patch makes sure the two fopen () calls in remote.c
only open the file if it is a file.

Signed-off-by: H.Merijn Brand <h.m.brand@xs4all.nl>
---

diff -pur git-1.5.4a/remote.c git-1.5.4b/remote.c
--- git-1.5.4a/remote.c    2008-01-27 09:04:18 +0100
+++ git-1.5.4/remote.c     2008-02-08 17:38:43 +0100
@@ -121,9 +121,18 @@ static struct branch *make_branch(const
        return branches[empty];
 }

+/* Helper function to ensure that we are opening a file and not a directory */
+static FILE *open_file(char *full_path)
+{
+       struct stat st_buf;
+       if (stat(full_path, &st_buf) || !S_ISREG(st_buf.st_mode))
+               return NULL;
+       return (fopen(full_path, "r"));
+}
+
 static void read_remotes_file(struct remote *remote)
 {
-       FILE *f = fopen(git_path("remotes/%s", remote->name), "r");
+       FILE *f = open_file(git_path("remotes/%s", remote->name));

        if (!f)
                return;
@@ -173,7 +182,7 @@ static void read_branches_file(struct re
        char *frag;
        char *branch;
        int n = slash ? slash - remote->name : 1000;
-       FILE *f = fopen(git_path("branches/%.*s", n, remote->name), "r");
+       FILE *f = open_file(git_path("branches/%.*s", n, remote->name));
        char *s, *p;
        int len;

--
git-1.5.4

-- 
H.Merijn Brand         Amsterdam Perl Mongers (http://amsterdam.pm.org/)
using & porting perl 5.6.2, 5.8.x, 5.10.x  on HP-UX 10.20, 11.00, 11.11,
& 11.23, SuSE 10.1 & 10.2, AIX 5.2, and Cygwin.       http://qa.perl.org
http://mirrors.develooper.com/hpux/            http://www.test-smoke.org
                        http://www.goldmark.org/jeff/stupid-disclaimers/
