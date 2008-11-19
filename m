From: Johannes Sixt <j.sixt@viscovery.net>
Subject: [PATCH] compat/mingw.c: Teach mingw_rename() to replace read-only
 files
Date: Wed, 19 Nov 2008 17:25:27 +0100
Message-ID: <49243DF7.7000604@viscovery.net>
References: <81b0412b0811190313p643c0cb4vad620ea942aeea93@mail.gmail.com> <4923FE58.3090503@viscovery.net> <alpine.LFD.2.00.0811190753420.27509@xanadu.home> <81b0412b0811190534r4f71f981s53de415f79e56e25@mail.gmail.com> <49241AEF.1080808@viscovery.net> <alpine.LFD.2.00.0811190940480.27509@xanadu.home> <49242821.50604@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Alex Riesen <raa.lkml@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Wed Nov 19 17:26:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L2ptF-0005oF-5m
	for gcvg-git-2@gmane.org; Wed, 19 Nov 2008 17:26:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752157AbYKSQZh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Nov 2008 11:25:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752159AbYKSQZh
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Nov 2008 11:25:37 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:30539 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752157AbYKSQZg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Nov 2008 11:25:36 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1L2prr-0002nI-FL; Wed, 19 Nov 2008 17:25:28 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 3532C69F; Wed, 19 Nov 2008 17:25:27 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <49242821.50604@viscovery.net>
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101360>

From: Johannes Sixt <j6t@kdbg.org>

On POSIX, rename() can replace files that are not writable. On Windows,
however, read-only files cannot be replaced without additional efforts:
We have to make the destination writable first.

Since the situations where the destination is read-only are rare, we do not
make the destination writable on every invocation, but only if the first
try to rename a file failed with an "access denied" error.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
Johannes Sixt schrieb:
> Nicolas Pitre schrieb:
>> On Wed, 19 Nov 2008, Johannes Sixt wrote:
>>> The unusual case is where you do this:
>>>
>>>  $ git rev-list -10 HEAD | git pack-objects foobar
>>>
>>> twice in a row: In this case the second invocation fails on Windows
>>> because the destination pack file already exists *and* is open. But not
>>> even git-repack does this even if it is called twice. OTOH, the test case
>>> *does* exactly this.
>> OK.... Well, despite my earlier assertion, I think the above should be a 
>> valid operation.

Would you please clarify which operation you exactly mean? As is written
above, or with .git/objects/pack/foobar instead like in the test case?

>> I'm looking at it now.  I'm therefore revoking my earlier ACK as well 
>> (better keep that test case alive).
> 
> Hold on a moment: When I tested the above sequence, I was fooled by a flaw
> in mingw_rename() (it doesn't replace read-only files). With that fixed...

Here is this fix.

-- Hannes

 compat/mingw.c |   15 ++++++++++++---
 1 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index b534a8a..3dbe6a7 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -819,6 +819,8 @@ int mingw_connect(int sockfd, struct sockaddr *sa, size_t sz)
 #undef rename
 int mingw_rename(const char *pold, const char *pnew)
 {
+	DWORD attrs;
+
 	/*
 	 * Try native rename() first to get errno right.
 	 * It is based on MoveFile(), which cannot overwrite existing files.
@@ -830,12 +832,19 @@ int mingw_rename(const char *pold, const char *pnew)
 	if (MoveFileEx(pold, pnew, MOVEFILE_REPLACE_EXISTING))
 		return 0;
 	/* TODO: translate more errors */
-	if (GetLastError() == ERROR_ACCESS_DENIED) {
-		DWORD attrs = GetFileAttributes(pnew);
-		if (attrs != INVALID_FILE_ATTRIBUTES && (attrs & FILE_ATTRIBUTE_DIRECTORY)) {
+	if (GetLastError() == ERROR_ACCESS_DENIED &&
+	    (attrs = GetFileAttributes(pnew)) != INVALID_FILE_ATTRIBUTES) {
+		if (attrs & FILE_ATTRIBUTE_DIRECTORY) {
 			errno = EISDIR;
 			return -1;
 		}
+		if ((attrs & FILE_ATTRIBUTE_READONLY) &&
+		    SetFileAttributes(pnew, attrs & ~FILE_ATTRIBUTE_READONLY)) {
+			if (MoveFileEx(pold, pnew, MOVEFILE_REPLACE_EXISTING))
+				return 0;
+			/* revert file attributes on failure */
+			SetFileAttributes(pnew, attrs);
+		}
 	}
 	errno = EACCES;
 	return -1;
-- 
1.6.0.4.1694.g07ac
