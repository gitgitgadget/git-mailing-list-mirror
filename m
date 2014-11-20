From: Stefan Beller <sbeller@google.com>
Subject: [PATCH v4] refs.c: add a function to append a reflog entry to a fd
Date: Thu, 20 Nov 2014 13:59:41 -0800
Message-ID: <20141120215941.GB22370@google.com>
References: <20141120023655.GG6527@google.com>
 <1416508657-9057-1-git-send-email-sbeller@google.com>
 <xmqq4mtt35x1.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, jrnieder@gmail.com,
	Ronnie Sahlberg <sahlberg@google.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 20 22:59:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XrZlU-0004zX-Hh
	for gcvg-git-2@plane.gmane.org; Thu, 20 Nov 2014 22:59:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757318AbaKTV7o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Nov 2014 16:59:44 -0500
Received: from mail-ie0-f201.google.com ([209.85.223.201]:43655 "EHLO
	mail-ie0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756141AbaKTV7n (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Nov 2014 16:59:43 -0500
Received: by mail-ie0-f201.google.com with SMTP id rp18so501690iec.2
        for <git@vger.kernel.org>; Thu, 20 Nov 2014 13:59:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=mJD6VQ8aJ39RvCUbAOrkh7TfsluhcgHrN31EOa0HYAQ=;
        b=EQQuoUturaNrFqaEx2mdziHsD+yR1afq8w1qs3wUZg43DQO9T0fF4/XTBNzBkV8axE
         Iy95mQZX4Vjlu1IQLIm2WqIGdr/SXWHw+EPTNfj3MMoDpgAxl5OIaAJNz11Oc+Ch86Le
         fqPornK7HJ4+f48Ndgl5us/6Py6ob7wIaG0U9rPtmRxQjuRoTFHufxu4icU3pF8E7tln
         f5508v4IKUom1sBJjHsBJwhMyuhUC76fChg5+NDKEuvOtNO12PMluWo8QeIgFXu+jg06
         NoHEJTOM1EHJLEWSR4/hgc+Lqor078KtXGGUm6+xQz+4uvIytBf22XFnw2Hv9/ROJURP
         q/WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=mJD6VQ8aJ39RvCUbAOrkh7TfsluhcgHrN31EOa0HYAQ=;
        b=V01CwmuUVNCMmRbZycU29Brm9mrVPG1L0o5j4rGvqfOQjFO9nbwircrVIatyUwsq/e
         MUTh9C7evUJrOw4uMoVHbSygDV7BjESeqiMA/OLVQ/hKoZNkemcD9AgrMv6BoBABRc16
         YcygcUSxBV2rRxgGCxVLd3DjG28NE1RnNPyHRXs9861If7k3L/+4rbASACSXjn6D+vNz
         V9nffaYTGPejC9Qz5h2g2DXK6p7GDRCfZJuyMiACBKjTBW8r07XI5npE8BmD6iGEKwGW
         D8W9K9nMxcgTAHSBsMGGvjmv6aJVlQpL3qAXL4X6jBhtOrrUKfOssXrG5J1HhQ/XDtrU
         AbTA==
X-Gm-Message-State: ALoCoQkLIBi6p/Xt6snhrzj/PuwHlRD975lnMme/1BWFDLD/GgwbMwm0kZIjbCNFPw0q0Go9MVDM
X-Received: by 10.182.214.72 with SMTP id ny8mr843896obc.18.1416520782871;
        Thu, 20 Nov 2014 13:59:42 -0800 (PST)
Received: from corpmail-nozzle1-1.hot.corp.google.com ([100.108.1.104])
        by gmr-mx.google.com with ESMTPS id lu9si867711qcb.0.2014.11.20.13.59.42
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Nov 2014 13:59:42 -0800 (PST)
Received: from sbeller.mtv.corp.google.com ([172.27.69.125])
	by corpmail-nozzle1-1.hot.corp.google.com with ESMTP id tT0nsEsi.1; Thu, 20 Nov 2014 13:59:42 -0800
Received: by sbeller.mtv.corp.google.com (Postfix, from userid 279346)
	id 714671411F5; Thu, 20 Nov 2014 13:59:41 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <xmqq4mtt35x1.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ronnie Sahlberg <sahlberg@google.com>

Move code to create the string for a ref and write it to a file descriptor
from log_ref_write and add it into a new dedicated function
log_ref_write_fd.

For now the new function is only used from log_ref_write, but later
on we will call this function from reflog transactions too. That means
that we will end up with only a single place, where we write a reflog
entry to a file instead of the current two places (log_ref_write and
builtin/reflog.c).

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 
Changes in version 3:
 * reword the commit message to make it more understandable.
 * no changes in code
 * wait for the follow up to address any changes in the code.

Changes in version 4:
 * fix arguments of sprintf
 * break lines of commit message again to appease the taste of Jonathan ;)
 * take the simplification for
   
   result = log_ref_write_fd(...);
   
   if (result) {
       ...
       
   and omit the result variable in there to just become
    
   if (log_ref_write_fd(...)) {
       ...
   
 refs.c | 48 ++++++++++++++++++++++++++++++------------------
 1 file changed, 30 insertions(+), 18 deletions(-)

diff --git a/refs.c b/refs.c
index 5ff457e..a6088e3 100644
--- a/refs.c
+++ b/refs.c
@@ -2990,15 +2990,37 @@ int log_ref_setup(const char *refname, char *logfile, int bufsize)
 	return 0;
 }
 
+static int log_ref_write_fd(int fd, const unsigned char *old_sha1,
+			    const unsigned char *new_sha1,
+			    const char *committer, const char *msg)
+{
+	int msglen, written;
+	unsigned maxlen, len;
+	char *logrec;
+
+	msglen = msg ? strlen(msg) : 0;
+	maxlen = strlen(committer) + msglen + 100;
+	logrec = xmalloc(maxlen);
+	len = sprintf(logrec, "%s %s %s\n",
+		      sha1_to_hex(old_sha1),
+		      sha1_to_hex(new_sha1),
+		      committer);
+	if (msglen)
+		len += copy_msg(logrec + len - 1, msg) - 1;
+
+	written = len <= maxlen ? write_in_full(fd, logrec, len) : -1;
+	free(logrec);
+	if (written != len)
+		return -1;
+
+	return 0;
+}
+
 static int log_ref_write(const char *refname, const unsigned char *old_sha1,
 			 const unsigned char *new_sha1, const char *msg)
 {
-	int logfd, result, written, oflags = O_APPEND | O_WRONLY;
-	unsigned maxlen, len;
-	int msglen;
+	int logfd, result, oflags = O_APPEND | O_WRONLY;
 	char log_file[PATH_MAX];
-	char *logrec;
-	const char *committer;
 
 	if (log_all_ref_updates < 0)
 		log_all_ref_updates = !is_bare_repository();
@@ -3010,19 +3032,9 @@ static int log_ref_write(const char *refname, const unsigned char *old_sha1,
 	logfd = open(log_file, oflags);
 	if (logfd < 0)
 		return 0;
-	msglen = msg ? strlen(msg) : 0;
-	committer = git_committer_info(0);
-	maxlen = strlen(committer) + msglen + 100;
-	logrec = xmalloc(maxlen);
-	len = sprintf(logrec, "%s %s %s\n",
-		      sha1_to_hex(old_sha1),
-		      sha1_to_hex(new_sha1),
-		      committer);
-	if (msglen)
-		len += copy_msg(logrec + len - 1, msg) - 1;
-	written = len <= maxlen ? write_in_full(logfd, logrec, len) : -1;
-	free(logrec);
-	if (written != len) {
+
+	if (log_ref_write_fd(logfd, old_sha1, new_sha1,
+			     git_committer_info(0), msg)) {
 		int save_errno = errno;
 		close(logfd);
 		error("Unable to append to %s", log_file);
-- 
2.2.0.rc2.23.gca0107e
