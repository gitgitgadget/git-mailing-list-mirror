From: Richard Hansen <rhansen@bbn.com>
Subject: Re: [PATCH] remote-bzr: reuse bzrlib transports when possible
Date: Sun, 08 Sep 2013 01:30:14 -0400
Message-ID: <522C0B66.1080707@bbn.com>
References: <1378598300-22737-1-git-send-email-rhansen@bbn.com> <522BBE87.10206@bbn.com> <CAMP44s0uHs8=r1eh2D-jdj563co5y7Rr1_6u=xoZDC52A6CPTQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 08 07:30:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIXZq-0004KI-IQ
	for gcvg-git-2@plane.gmane.org; Sun, 08 Sep 2013 07:30:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751490Ab3IHFaX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Sep 2013 01:30:23 -0400
Received: from smtp.bbn.com ([128.33.0.80]:50121 "EHLO smtp.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751365Ab3IHFaW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Sep 2013 01:30:22 -0400
Received: from socket.bbn.com ([192.1.120.102]:55358)
	by smtp.bbn.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.77 (FreeBSD))
	(envelope-from <rhansen@bbn.com>)
	id 1VIXZg-0000SJ-J4; Sun, 08 Sep 2013 01:30:16 -0400
X-Submitted: to socket.bbn.com (Postfix) with ESMTPSA id E347A3FF85
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130803 Thunderbird/17.0.8
In-Reply-To: <CAMP44s0uHs8=r1eh2D-jdj563co5y7Rr1_6u=xoZDC52A6CPTQ@mail.gmail.com>
X-Enigmail-Version: 1.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234186>

On 2013-09-07 20:30, Felipe Contreras wrote:
> On Sat, Sep 7, 2013 at 7:02 PM, Richard Hansen <rhansen@bbn.com> wrote:
>> On 2013-09-07 19:58, Richard Hansen wrote:
>>> Pass a list of open bzrlib.transport.Transport objects to each bzrlib
>>> function that might create a transport.  This enables bzrlib to reuse
>>> existing transports when possible, avoiding multiple concurrent
>>> connections to the same remote server.
>>>
>>> If the remote server is accessed via ssh, this fixes a couple of
>>> problems:
>>>   * If the user does not have keys loaded into an ssh agent, the user
>>>     may be prompted for a password multiple times.
>>>   * If the user is using OpenSSH and the ControlMaster setting is set
>>>     to auto, git-remote-bzr might hang.  This is because bzrlib closes
>>>     the multiple ssh sessions in an undefined order and might try to
>>>     close the master ssh session before the other sessions.  The
>>>     master ssh process will not exit until the other sessions have
>>>     exited, causing a deadlock.  (The ssh sessions are closed in an
>>>     undefined order because bzrlib relies on the Python garbage
>>>     collector to trigger ssh session termination.)
>>
>> I forgot to mention:  I didn't add a Signed-off-by line because there is
>> no mention of a copyright license at the top of git-remote-bzr.
> 
> And why is that relevant? A signed-off-by line means you wrote the
> code and you are fine with the patch being applied, or you are
> responsible somehow.

The "Developer's Certificate of Origin 1.1" in
Documentation/SubmittingPatches refers to "the open source license
indicated in the file", but there is no such indication.

However, it looks like most of the files in the repository don't
indicate which license applies.  So I guess the license in the COPYING
file (GPLv2) applies by default?  I'll re-send with the Signed-off-by
line.

Perhaps SubmittingPatches should be updated to clarify what happens if
the file doesn't indicate which license applies to the file (see
example below).

-Richard


diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index 7055576..c5ff744 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -227,13 +227,15 @@ the patch, which certifies that you wrote it or otherwise have
 the right to pass it on as a open-source patch.  The rules are
 pretty simple: if you can certify the below:

-        Developer's Certificate of Origin 1.1
+        Developer's Certificate of Origin 1.2

         By making a contribution to this project, I certify that:

         (a) The contribution was created in whole or in part by me and I
             have the right to submit it under the open source license
-            indicated in the file; or
+            indicated in the file (or, if no license is indicated in
+            the file, the license in COPYING that accompanies the
+            file); or

         (b) The contribution is based upon previous work that, to the best
             of my knowledge, is covered under an appropriate open source
@@ -241,7 +243,8 @@ pretty simple: if you can certify the below:
             work with modifications, whether created in whole or in part
             by me, under the same open source license (unless I am
             permitted to submit under a different license), as indicated
-            in the file; or
+            in the file (or, if no license is indicated in the file,
+            the license in COPYING that accompanies the file); or

         (c) The contribution was provided directly to me by some other
             person who certified (a), (b) or (c) and I have not modified
