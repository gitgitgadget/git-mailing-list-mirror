From: Dmitry Smirnov <divis1969@gmail.com>
Subject: Re: P4 Sync problem
Date: Wed, 11 Nov 2009 09:43:52 +0000 (UTC)
Message-ID: <loom.20091111T100646-406@post.gmane.org>
References: <loom.20091110T145046-137@post.gmane.org> <1a6be5fa0911110043i63b5c032s7924f9f1cdfe32ee@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 11 10:44:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N89ko-00044x-Lc
	for gcvg-git-2@lo.gmane.org; Wed, 11 Nov 2009 10:44:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753369AbZKKJoT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Nov 2009 04:44:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752468AbZKKJoS
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Nov 2009 04:44:18 -0500
Received: from lo.gmane.org ([80.91.229.12]:40858 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751985AbZKKJoR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Nov 2009 04:44:17 -0500
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1N89kP-0003uQ-2R
	for git@vger.kernel.org; Wed, 11 Nov 2009 10:44:17 +0100
Received: from 212.92.145.7 ([212.92.145.7])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 11 Nov 2009 10:44:17 +0100
Received: from divis1969 by 212.92.145.7 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 11 Nov 2009 10:44:17 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 212.92.145.7 (Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US) AppleWebKit/532.0 (KHTML, like Gecko) Chrome/3.0.195.27 Safari/532.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132634>

Tor Arvid Lund <torarvid <at> gmail.com> writes:

> Hi. So - I think the problem is that git-p4 doesn't understand what it
> is you want to sync. 

I believe it will never understand that until self.depotPaths 
will be initialized.
It looks like it is intitilized from argument list only (or from already saved 
settings). See P4Sync.run(). 
But self.getClientSpec() which is called some time before, does not init neither 
self.depotPaths nor args.

I had fixed this with the following code (new lines marked with +):
        if self.useClientSpec or gitConfig("git-p4.useclientspec") == "true":
+            if self.verbose:
+                print "Get client spec"
            self.getClientSpec()
+            if self.verbose:
+                print "Client Spec Dirs: %s" % self.clientSpecDirs
+            if len(args) == 0:
+                for item in self.clientSpecDirs:
+                      k,v = item
+                      args.append(k)

Unfortunately, this fails on another stage:

>git p4 sync --verbose
Reading pipe: git config git-p4.useclientspec
Get client spec
Reading pipe: git config git-p4.user
Reading pipe: git config git-p4.password
Reading pipe: git config git-p4.port
Reading pipe: git config git-p4.host
Reading pipe: git config git-p4.client
p4 -c MYCLIENT-G client -o
Opening pipe: p4 -c MYCLIENT-G client -o

Client Spec Dirs:[ <my paths here> ]
Doing initial import of  <my paths here> from revision #head into 
refs/remotes/p4/master
p4 -c MYCLIENT-G files <my paths here appended with ...#head >
Opening pipe: p4 -c MYCLIENT-G files <my paths here appended with ...#head >
p4 returned an error: //MYCLIENT/path/file.c/...#head> - file(s) not in client 
view.

My client spec contains some line to the file:
-//depot/path/... //MYCLIENT/null/...
//depot/path/file.cs //MYCLIENT/path/file.cs

This means that I wish to sync only file.cs into my client and get rid of other 
files in this directory.
BTW, note that file extension is truncated in the log


Dmitry
