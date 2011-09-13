From: Chris Li <git@chrisli.org>
Subject: [PATCH] git-p4: import utf16 file properly
Date: Tue, 13 Sep 2011 14:33:14 -0700
Message-ID: <CANeU7QndA0yv1OzU3vta5B8r8nCRdBSqTy0Rboc_bbpst+1pcw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Pete Wyckoff <pw@padd.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 13 23:33:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3abe-0000ff-NC
	for gcvg-git-2@lo.gmane.org; Tue, 13 Sep 2011 23:33:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932910Ab1IMVdR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Sep 2011 17:33:17 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:53057 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932835Ab1IMVdP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Sep 2011 17:33:15 -0400
Received: by ywb5 with SMTP id 5so871039ywb.19
        for <git@vger.kernel.org>; Tue, 13 Sep 2011 14:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:date:x-google-sender-auth:message-id:subject
         :from:to:cc:content-type;
        bh=NOIyZ1nWhmEqCGyEblD/3Q+RIIhGBxW9Ukp6Df+/7IM=;
        b=Py4FHIOpJrxZEbnesx+J0PZxySUzkNFSjndEmR94yniEcIL3NIeiv/xKiVhAKQRtHN
         OWW9HXCpUcORBGpGgQSArHo3AuDFzGBpM98ZtA4TCrzSepWXW1ydQtK2IsPkAJ1MAtlv
         HEjhg7P7R02K37a3xaW+iyoQqnioOVzv84EPk=
Received: by 10.68.11.42 with SMTP id n10mr2700720pbb.185.1315949594511; Tue,
 13 Sep 2011 14:33:14 -0700 (PDT)
Received: by 10.143.76.16 with HTTP; Tue, 13 Sep 2011 14:33:14 -0700 (PDT)
X-Google-Sender-Auth: qOU1n5NWHp0U8eLO-NN1wRnwHoU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181306>

The current git-p4 does not handle utf16 files properly.
The "p4 print" command, when output to stdout, converts the
utf16 file into utf8. That effectively imported the utf16 file
as utf8 for git. In other words, git-p4 import a different
file compare to file check out by perforce. This breakes my
windows build in the company project.

The fix is simple, just ask perforce to print the depot
file into a real file. This way perforce will not performe
the utf16 to utf8 conversion. Git can import the exact same
file as perforce checkout.
---
 contrib/fast-import/git-p4 |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index 6b9de9e..5fb1ac7 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -1239,6 +1239,11 @@ class P4Sync(Command, P4UserMap):
             contents = map(lambda text:
re.sub(r'(?i)\$(Id|Header):[^$]*\$',r'$\1$', text), contents)
         elif file['type'] in ('text+k', 'ktext', 'kxtext',
'unicode+k', 'binary+k'):
             contents = map(lambda text:
re.sub(r'\$(Id|Header|Author|Date|DateTime|Change|File|Revision):[^$\n]*\$',r'$\1$',
text), contents)
+        elif file['type'] == 'utf16':
+             tmpFile = tempfile.NamedTemporaryFile()
+             p4CmdList("print -o %s %s"%(tmpFile.name, file['depotFile']))
+             contents = [ open(tmpFile.name).read() ]
+             tmpFile.close()

         self.gitStream.write("M %s inline %s\n" % (mode, relPath))

-- 
1.7.6
