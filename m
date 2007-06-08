From: "Benjamin Sergeant" <bsergean@gmail.com>
Subject: Re: git-p4 fails when cloning a p4 depo.
Date: Fri, 8 Jun 2007 11:13:55 -0700
Message-ID: <1621f9fa0706081113w7bb765ebx74f03a7407b753cb@mail.gmail.com>
References: <1621f9fa0706080941k67d2878dud8cf06436c67aea0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 08 20:14:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HwiyI-0006lS-Bl
	for gcvg-git@gmane.org; Fri, 08 Jun 2007 20:14:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S970235AbXFHSN6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Jun 2007 14:13:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S970197AbXFHSN6
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jun 2007 14:13:58 -0400
Received: from wr-out-0506.google.com ([64.233.184.232]:45655 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S970190AbXFHSN5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jun 2007 14:13:57 -0400
Received: by wr-out-0506.google.com with SMTP id i21so788036wra
        for <git@vger.kernel.org>; Fri, 08 Jun 2007 11:13:56 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Y7WzSQx0z0FJ516EcT2Co3V+Ky3BNJqSYE5YZ9fG3M9XuYrJNFfVQ3exHi0+oVTzz5t/iAAAbwpwkhTxjk41SXEa7UvjnStUNUKk/eGQRla6marjVENIm0CH5lNHnINmtRF1ZyVQV78AaoUmuF/pgMZBSTxElSmAHeAEHdBbgnA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ghjRrgbkmU62LA/b4mXgU5sdITEpTbhRq/uLL0ozCCm3IbBA+Kz6idNGPTURRNbMzWzr91fPgIuveOUZ5KP2agrSZepOeNPEXejmjbfzUnVx3/abVXs3dHPnIeGpDrUw4YslAtoDaDlIH29s7TXTIaluvHlVq7nmAQ8qsdaewA4=
Received: by 10.143.159.11 with SMTP id l11mr166199wfo.1181326435840;
        Fri, 08 Jun 2007 11:13:55 -0700 (PDT)
Received: by 10.143.43.1 with HTTP; Fri, 8 Jun 2007 11:13:55 -0700 (PDT)
In-Reply-To: <1621f9fa0706080941k67d2878dud8cf06436c67aea0@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49489>

A perforce command with all the files in the repo is generated to get
all the file content.
Here is a patch to break it into multiple successive perforce command
who uses 4K of parameter max, and collect the output for later.

It works, but not for big depos, because the whole perforce depo
content is stored in memory in P4Sync.run(), and it looks like mine is
bigger than 2 Gigs, so I had to kill the process.


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











On 6/8/07, Benjamin Sergeant <bsergean@gmail.com> wrote:
> I attached a lame patch to die without showing the Python Traceback,
> but I'd rather succeed :)
> Maybe there is a different mailing list for git-p4. If there is tell
> me and I'll post there.
>
> Benjamin.
>
> [bsergean@flanders sandbox]$ rm -rf dev ; git-p4 clone
> //Work/Users/Capture3D/A3D810/pdfl/Common/a3d/dev
> Importing from //Work/Users/Capture3D/A3D810/pdfl/Common/a3d/dev into dev
> Initialized empty Git repository in .git/
> Doing initial import of
> //Work/Users/Capture3D/A3D810/pdfl/Common/a3d/dev/ from revision #head
> [{'p4ExitCode': 32512}]
> Traceback (most recent call last):
>   File "/home/bsergean/src/fast-export/git-p4", line 1489, in <module>
>     main()
>   File "/home/bsergean/src/fast-export/git-p4", line 1484, in main
>     if not cmd.run(args):
>   File "/home/bsergean/src/fast-export/git-p4", line 1395, in run
>     if not P4Sync.run(self, depotPaths):
>   File "/home/bsergean/src/fast-export/git-p4", line 1203, in run
>     self.commit(details, self.extractFilesFromCommit(details),
> self.branch, self.depotPaths)
>   File "/home/bsergean/src/fast-export/git-p4", line 744, in commit
>     self.readP4Files(files)
>   File "/home/bsergean/src/fast-export/git-p4", line 722, in readP4Files
>     contents[stat['depotFile']] = text
> KeyError: 'depotFile'
>
>
