From: "Benjamin Sergeant" <bsergean@gmail.com>
Subject: Re: git-p4 fails when cloning a p4 depo.
Date: Fri, 8 Jun 2007 17:32:16 -0700
Message-ID: <1621f9fa0706081732k7a31782cv26f3295245057b6f@mail.gmail.com>
References: <1621f9fa0706080941k67d2878dud8cf06436c67aea0@mail.gmail.com>
	 <1621f9fa0706081113w7bb765ebx74f03a7407b753cb@mail.gmail.com>
	 <4669CAB4.5080507@slamb.org> <4669CB75.7060009@slamb.org>
	 <1621f9fa0706081504l6106c639oe57c9fd74ebd097a@mail.gmail.com>
	 <4669E73F.2040702@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Scott Lamb" <slamb@slamb.org>
To: hanwen@xs4all.nl
X-From: git-owner@vger.kernel.org Sat Jun 09 02:32:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HwosO-0006LX-97
	for gcvg-git@gmane.org; Sat, 09 Jun 2007 02:32:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031202AbXFIAcS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Jun 2007 20:32:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S969435AbXFIAcS
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jun 2007 20:32:18 -0400
Received: from nz-out-0506.google.com ([64.233.162.227]:46649 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S968792AbXFIAcR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jun 2007 20:32:17 -0400
Received: by nz-out-0506.google.com with SMTP id n1so889382nzf
        for <git@vger.kernel.org>; Fri, 08 Jun 2007 17:32:17 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LOFw1WWPib9kLvefnb6QyE+d0NwTkAjmxjFd1CHFzx3qAgjtOC83sueRod2xM0gJSreErOZuXuZ0r9qUH78JB8ojJftfO/KTT2BRseP0yuw56u+QAk7D3R4bFhRUvD71YYvH1TizzSYEvBtz4IIPaSKBWKM7kY3BNl7aGvMzH8E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gq58gz6Ppk+QLTig6c741+d6DNUpEtU1JIXdyIElh8aJjaTVi04bMmK01U/PjrfZ64xmdAt6N9EnvZDPyOWs647pHcq60UppDfgQZ3c4RKjCFJjmLef3qMfLnIKwkH0q6rfbT5KQmga5BC0EnByVMed9knqeE+zKNJZBH60UXIo=
Received: by 10.142.111.14 with SMTP id j14mr176552wfc.1181349136744;
        Fri, 08 Jun 2007 17:32:16 -0700 (PDT)
Received: by 10.143.43.1 with HTTP; Fri, 8 Jun 2007 17:32:16 -0700 (PDT)
In-Reply-To: <4669E73F.2040702@xs4all.nl>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49549>

On 6/8/07, Han-Wen Nienhuys <hanwen@xs4all.nl> wrote:
> Benjamin Sergeant escreveu:
>
> > So are you saying that in the old days, git-p4 was importing the p4
> > depo in small slices to not overkill the process memory (in case the
> > depo is big) ?
>
> no, in the "old days" git-p4 used a separate p4 invocation for each file.
>

Anyway, in case you hit command line lenght limit here it is. That
might be interesting for the "next days" :)

Benjamin.


[bsergean@flanders fast-export]$ git format-patch -k -m --stdout origin
From 45f2dbdb9a8c0b3beb007ae892613cdc4afab80a Mon Sep 17 00:00:00 2001
From: Benjamin Sergeant <bsergean@flanders.(none)>
Date: Fri, 8 Jun 2007 09:58:57 -0700
Subject: Split p4 print call into multiple call to not exceed the
command line lenght maximum

---
 git-p4 |   21 ++++++++++++++++++---
 1 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/git-p4 b/git-p4
index 36fe69a..906b193 100755
--- a/git-p4
+++ b/git-p4
@@ -703,9 +703,22 @@ class P4Sync(Command):
         if not files:
             return

-        filedata = p4CmdList('print %s' % ' '.join(['"%s#%s"' % (f['path'],
-                                                                 f['rev'])
-                                                    for f in files]))
+        # We cannot put all the files on the command line
+        # OS have limitations on the max lenght of arguments
+        # POSIX says it's 4096 bytes, default for Linux seems to be 130 K.
+        # and all OS from the table below seems to be higher than POSIX.
+        # See http://www.in-ulm.de/~mascheck/various/argmax/
+        chunk = ''
+        filedata = []
+        for i in xrange(len(files)):
+            f = files[i]
+            chunk += '"%s#%s" ' % (f['path'], f['rev'])
+            if len(chunk) > 4000 or i == len(files)-1:
+                data = p4CmdList('print %s' % chunk)
+                if "p4ExitCode" in data[0]:
+                    die("Problems executing p4. Error: [%d]." %
(data[0]['p4ExitCode']));
+                filedata.extend(data)
+                chunk = ''

         j = 0;
         contents = {}
@@ -1486,3 +1499,5 @@ def main():

 if __name__ == '__main__':
     main()
+
+# vim: set filetype=python sts=4 sw=4 et si :
--
1.5.0.4


>From dd9975708433efeec37b608755f54fbeaedf0f3f Mon Sep 17 00:00:00 2001
From: Benjamin Sergeant <bsergean@flanders.(none)>
Date: Fri, 8 Jun 2007 10:20:39 -0700
Subject: Use os.sysconf('SC_ARG_MAX') to retrieve the max value, and
build the string using join (faster)

---
 git-p4 |   17 ++++++++++-------
 1 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/git-p4 b/git-p4
index 906b193..8dc1963 100755
--- a/git-p4
+++ b/git-p4
@@ -705,20 +705,23 @@ class P4Sync(Command):

         # We cannot put all the files on the command line
         # OS have limitations on the max lenght of arguments
-        # POSIX says it's 4096 bytes, default for Linux seems to be 130 K.
-        # and all OS from the table below seems to be higher than POSIX.
         # See http://www.in-ulm.de/~mascheck/various/argmax/
-        chunk = ''
+        chunks = []
+        chunkLenght = 0
         filedata = []
+        maxlenght = max(int(os.sysconf('SC_ARG_MAX') * 0.90), 4000)
+        print maxlenght
         for i in xrange(len(files)):
             f = files[i]
-            chunk += '"%s#%s" ' % (f['path'], f['rev'])
-            if len(chunk) > 4000 or i == len(files)-1:
-                data = p4CmdList('print %s' % chunk)
+            chunkLenght += len(f['path']) + len(f['rev'])
+            chunks.append('"%s#%s" ' % (f['path'], f['rev']))
+            if chunkLenght > maxlenght or i == len(files)-1:
+                data = p4CmdList('print %s' % ' '.join(chunks))
                 if "p4ExitCode" in data[0]:
                     die("Problems executing p4. Error: [%d]." %
(data[0]['p4ExitCode']));
                 filedata.extend(data)
-                chunk = ''
+                chunks = []
+                chunkLenght = 0

         j = 0;
         contents = {}
--
1.5.0.4
