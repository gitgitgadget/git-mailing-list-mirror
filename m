From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: [BUG] incorrect error message in "git fsck" for empty loose objects
Date: Mon, 23 Jan 2012 11:19:21 +0100
Message-ID: <vpqfwf6en6e.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "Junio C. Hamano" <gitster@pobox.com>
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jan 23 11:19:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RpGzs-0006IV-5i
	for gcvg-git-2@lo.gmane.org; Mon, 23 Jan 2012 11:19:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752826Ab2AWKT2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jan 2012 05:19:28 -0500
Received: from mx2.imag.fr ([129.88.30.17]:37910 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752586Ab2AWKT1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jan 2012 05:19:27 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q0NAHHU2007348
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 23 Jan 2012 11:17:17 +0100
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtp (Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1RpGzi-0007zh-6k; Mon, 23 Jan 2012 11:19:22 +0100
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 23 Jan 2012 11:17:17 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q0NAHHU2007348
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1327918637.80645@4j0pJ8QWtoC6AOScFTwR5Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188983>

Hi,

If a loose object is empty, "git fsck" reports it as corrupt (which is
good), but with the following error message:

$ git fsck
Checking object directories: 100% (256/256), done.
fatal: failed to read object c1738f6288c9e5d5e58da00ced34d284ae93976c: Invalid argument
$ cat .git/objects/c1/738f6288c9e5d5e58da00ced34d284ae93976c 
$ ls -l .git/objects/c1/738f6288c9e5d5e58da00ced34d284ae93976c
-r--r--r-- 1 moy synchron 0 Jan 20 16:20 .git/objects/c1/738f6288c9e5d5e58da00ced34d284ae93976c

"Invalid argument" is really not the error message one would expect.
Before that, git used to say:

   fatal: loose object c1738f6288c9e5d5e58da00ced34d284ae93976c (stored in
   .git/objects/c1/738f6288c9e5d5e58da00ced34d28
   4ae93976c) is corrupt

Which was far better.

This bisects back to 3ba7a065527a (A loose object is not corrupt if it
cannot be read due to EMFILE), which essentially boils down to:

--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2090,16 +2090,21 @@ void *read_sha1_file_repl(const unsigned char *sha1,
                          const unsigned char **replacement)
[...]
+       errno = 0;
+       data = read_object(repl, type, size);
        if (data) {
                if (replacement)
                        *replacement = repl;
                return data;
        }
 
+       if (errno != ENOENT)
+               die_errno("failed to read object %s", sha1_to_hex(sha1));
+

Thanks,

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
