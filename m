From: "David Tweed" <david.tweed@gmail.com>
Subject: [RFC,PATCH] Make git prune remove temporary packs that look like write failures
Date: Mon, 4 Feb 2008 14:10:32 +0000
Message-ID: <e1dab3980802040610s27a54a9due3b42db5f59c0cd5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "gi mailing list" <git@vger.kernel.org>,
	"Nicolas Pitre" <nico@cam.org>
X-From: git-owner@vger.kernel.org Mon Feb 04 15:11:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JM22Q-0007xm-F6
	for gcvg-git-2@gmane.org; Mon, 04 Feb 2008 15:11:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753319AbYBDOKh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2008 09:10:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753070AbYBDOKg
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Feb 2008 09:10:36 -0500
Received: from rn-out-0910.google.com ([64.233.170.191]:34323 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751593AbYBDOKg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2008 09:10:36 -0500
Received: by rn-out-0910.google.com with SMTP id i24so1753050rng.19
        for <git@vger.kernel.org>; Mon, 04 Feb 2008 06:10:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=cVw6mKKvbHNu+iSvHSOqhaTKSX/stOZSAqvHtfLWjx4=;
        b=JVEmqOaL6Pd4EWhfLmS61IMn2w6ziCF937sJFEjHQOiEMnOJFFpNvKsg5JKGt8cktdNAuBGkRny6ErhBOCMV+AnI8NPV88Krp78VCXDTnSRGloD39xXWKOEZvzrAjWavmlsxGIzAQYn+Lx/TtrlCVbZ08Jr4YKW4DrJyIIKdx8Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=ROZxjU0yxzderaDhx10kTdH/G9C8bBqTx1ANpCR2q75f2rEgc2iZQGB6vE7415IZ8oGsRtaq/iTHNWMrtWruEEM+tehF2HSxGzbe1Z9fHOCGx3vqQNMROS/aINY13SdUV7TJGXM+rgOCUhkEcpkyc1WtF0gEQoKsX4NZ5MX+hbo=
Received: by 10.150.200.8 with SMTP id x8mr2970815ybf.80.1202134232896;
        Mon, 04 Feb 2008 06:10:32 -0800 (PST)
Received: by 10.150.149.2 with HTTP; Mon, 4 Feb 2008 06:10:32 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72505>

Make git prune remove temporary packs that look like write failures

Write errors when repacking (eg, due to out-of-space conditions)
can leave temporary packs lying around which no existing
codepath removes and  which aren't obvious to the casual user.
Unfortunately the only way to tell in builtin-prune that a tmp_pack file is
of this sort is that it hasn't been modified recently. We assume a pack
which hasn't been modified within 10 minutes is of this sort and
delete it, printing a notification to help debugging. (Nicolas Pitre
suggested this functionality should be activated only by --prune.)

Signed-off-by: David Tweed (david.tweed@gmail.com)
---

I KNOW this initial RFC is mailer whitespace damaged. Finally version won't be.

In principle this is a really trivial patch, but I'm being cautious because I
don't like the fact that I don't know (and AFAICS can't reliably check) that
the files being deleting are definitely dead. An alternative would
be to make prune just print out that the suspicious packs are
there and let the user delete them manually. (My itch is that once
a write-failure pack gets created, nothing in git operations tells the
user that a generally multimegabyte file hidden in .git occupying space.)

 builtin-prune.c |   34 ++++++++++++++++++++++++++++++++++
 1 files changed, 34 insertions(+), 0 deletions(-)

diff --git a/builtin-prune.c b/builtin-prune.c
index b5e7684..90111ab 100644
--- a/builtin-prune.c
+++ b/builtin-prune.c
@@ -83,6 +83,39 @@ static void prune_object_dir(const char *path)
        }
 }

+/*
+ * Write errors (particularly out of space) can result in
+ * failed temporary packs accumulating in the object directory.
+ * This removes anything in the object directory beginning
+ * with tmp_ using the heuristic that anything
+ * that was last modified more than 10 minutes
+ * ago is the abandoned result of a write failure.
+ */
+static void remove_temporary_files(void)
+{
+       DIR *dir;
+       struct stat status;
+       time_t now;
+       struct dirent *de;
+       char* dirname=get_object_directory();
+
+       now = time(NULL);
+       dir = opendir(dirname);
+       while ((de = readdir(dir)) != NULL) {
+               if(strncmp(de->d_name, "tmp_", 4) == 0){
+                       char name[4096];
+                       int c=snprintf(name, 4095, "%s/%s", dirname,
de->d_name);
+                       if(c>0 && c<4096 && stat(name, &status) == 0
+                          && status.st_mtime < now - 600){
+                               printf("Removing apparently abandoned
%s\n",name);
+                               unlink(name);
+                       }
+               }
+       }
+       closedir(dir);
+}
+
+
 int cmd_prune(int argc, const char **argv, const char *prefix)
 {
        int i;
@@ -115,5 +148,6 @@ int cmd_prune(int argc, const char **argv, const
char *prefix)

        sync();
        prune_packed_objects(show_only);
+       remove_temporary_files();
        return 0;
 }
