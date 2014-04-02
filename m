From: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH 12/22] delete_ref_loose(): don't muck around in the lock_file's
 filename
Date: Wed, 02 Apr 2014 08:52:17 +0200
Message-ID: <533BB3A1.1080203@web.de>
References: <1396367910-7299-1-git-send-email-mhagger@alum.mit.edu> <1396367910-7299-13-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Apr 03 13:28:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WVeJ2-0006sp-5y
	for gcvg-git-2@plane.gmane.org; Thu, 03 Apr 2014 11:51:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757940AbaDBGwe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Apr 2014 02:52:34 -0400
Received: from mout.web.de ([212.227.17.12]:58420 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756938AbaDBGwd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Apr 2014 02:52:33 -0400
Received: from [192.168.88.199] ([194.47.243.242]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0Lo0ZA-1Wxh260RPU-00fw36; Wed, 02 Apr 2014 08:52:30
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:17.0) Gecko/20131104 Icedove/17.0.10
In-Reply-To: <1396367910-7299-13-git-send-email-mhagger@alum.mit.edu>
X-Provags-ID: V03:K0:B2j4wnHdAGsWDM2nnTuj/6butqppHjEjdK6AG3vv9ygL2BgFF59
 tevUsuit/WbRK/+7pVZnC3uxcDykZA6C9NvBnrlYtF6zuodPHyrKXOIbKSPCdlv2MgPh/Hr
 6+0fr9CPtST/aKEiZjDzwX1DN6LRAYCahbBcO9LGNr9Rf91ErX1sJzipqUfENw7xtNp8pnd
 egJWNTTcc83aSNAmq6VhQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245715>


[]
diff --git a/refs.c b/refs.c
index 28d5eca..11ad23e 100644
--- a/refs.c
+++ b/refs.c
@@ -2485,12 +2485,14 @@ static int repack_without_ref(const char *refname)
  static int delete_ref_loose(struct ref_lock *lock, int flag)
  {
  	if (!(flag & REF_ISPACKED) || flag & REF_ISSYMREF) {
-		/* loose */
-		int err, i = strlen(lock->lk->filename) - 5; /* .lock */
-
-		lock->lk->filename[i] = 0;
-		err = unlink_or_warn(lock->lk->filename);
-		lock->lk->filename[i] = '.';
+		/*
+		 * loose.  The loose file name is the same as the
+		 * lockfile name, minus ".lock":
+		 */
+		char *loose_filename = xmemdupz(lock->lk->filename,
+						strlen(lock->lk->filename) - 5);

At other places (lockfile.c) we use this

+#define LOCK_SUFFIX_LEN 5

I think it makes sense to move this definition to an include file (lockfile.h ??)
and use it here.
