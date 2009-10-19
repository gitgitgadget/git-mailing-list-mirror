From: "Per Strandh" <per.strandh@q-matic.se>
Subject: Re: Unapplied patches reminder
Date: Mon, 19 Oct 2009 15:08:28 +0200
Message-ID: <hbhoeq$ehf$1@ger.gmane.org>
References: <20091019052030.6117@nanako3.lavabit.com> <7vzl7ogtxs.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 19 15:15:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mzs5B-00066F-Bg
	for gcvg-git-2@lo.gmane.org; Mon, 19 Oct 2009 15:15:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756147AbZJSNPG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Oct 2009 09:15:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756146AbZJSNPF
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Oct 2009 09:15:05 -0400
Received: from lo.gmane.org ([80.91.229.12]:38965 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756129AbZJSNPE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Oct 2009 09:15:04 -0400
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1Mzs4m-0005q0-2H
	for git@vger.kernel.org; Mon, 19 Oct 2009 15:15:04 +0200
Received: from fw1.q-matic.se ([194.236.6.194])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 19 Oct 2009 15:15:04 +0200
Received: from per.strandh by fw1.q-matic.se with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 19 Oct 2009 15:15:04 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: fw1.q-matic.se
In-Reply-To: <7vzl7ogtxs.fsf@alter.siamese.dyndns.org>
X-MSMail-Priority: Normal
X-Newsreader: Microsoft Windows Mail 6.0.6002.18005
X-MimeOLE: Produced By Microsoft MimeOLE V6.0.6002.18005
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130699>


"Junio C Hamano" <gitster@pobox.com> skrev i meddelandet 
news:7vzl7ogtxs.fsf@alter.siamese.dyndns.org...
>> From: Per Strandh <Per.Strandh@q-matic.se>
>> Subject: [PATCH] git-p4: Fixed bug that didn't allow spaces in the depot
>> Date: Tue, 13 Oct 2009 22:09:12 +0200
>> Message-ID: 
>> <65D9329CA2AF94438F542D48F2A42E830F95F51514@GOT-SRV-005.QMATIC.local>
>>
>>     git-p4 clone (and sync) did not work if the specified depot path 
>> contained spaces.
>>     Fixed by quoting the argument to the "p4 changes" and "p4 files" 
>> commands.
>
> I do recall ignoring this one because (1) I never use git-p4 myself and
> always rely on Acks from people who have been involved in it, and (2) the
> message was mangled (perhaps it had two or three copies of patches as
> attachments).


Sorry for posting a mangled patch.
Please let someone involved in the git-p4 code review/approve/apply the 
patch.

Regards
/Per/



>From c70682a9c4051f2dc92e2dd92f1710c755df6cfe Mon Sep 17 00:00:00 2001
From: Per Strandh <per.strandh@q-matic.se>
Date: Fri, 9 Oct 2009 12:11:14 +0200
Subject: [PATCH] git-p4: Fixed bug that didn't allow spaces in the depot 
path

git-p4 clone (and sync) did not work if the specified depot path contained 
spaces.
Fixed by quoting the argument to the "p4 changes" and "p4 files" commands.

Signed-off-by: Per Strandh <per.strandh@q-matic.se>
---
 contrib/fast-import/git-p4 |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index e710219..01b6bbb 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -440,8 +440,8 @@ def originP4BranchesExist():

 def p4ChangesForPaths(depotPaths, changeRange):
     assert depotPaths
-    output = p4_read_pipe_lines("changes " + ' '.join (["%s...%s" % (p, 
changeRange)
-                                                        for p in 
depotPaths]))
+    output = p4_read_pipe_lines("changes \"" + ' '.join (["%s...%s" % (p, 
changeRange)
+                                                        for p in 
depotPaths]) + "\"" )

     changes = {}
     for line in output:
@@ -1437,10 +1437,10 @@ class P4Sync(Command):
         newestRevision = 0

         fileCnt = 0
-        for info in p4CmdList("files "
+        for info in p4CmdList("files \""
                               +  ' '.join(["%s...%s"
                                            % (p, revision)
-                                           for p in self.depotPaths])):
+                                           for p in self.depotPaths]) + 
"\""):

             if info['code'] == 'error':
                 sys.stderr.write("p4 returned an error: %s\n"
-- 
1.6.3.msysgit.0

 
