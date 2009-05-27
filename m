From: "Matthias Andree" <matthias.andree@gmx.de>
Subject: git-svn dcommits messages not in UTF-8 charset to mod_dav_svn?
Date: Wed, 27 May 2009 18:16:24 +0200
Message-ID: <op.uuljhmmg1e62zd@balu.cs.uni-paderborn.de>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; delsp=yes; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, users@subversion.tigris.org
X-From: git-owner@vger.kernel.org Wed May 27 18:16:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9LoD-0004Zc-1e
	for gcvg-git-2@gmane.org; Wed, 27 May 2009 18:16:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756776AbZE0QQZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2009 12:16:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757172AbZE0QQZ
	(ORCPT <rfc822;git-outgoing>); Wed, 27 May 2009 12:16:25 -0400
Received: from mail.gmx.net ([213.165.64.20]:48565 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757121AbZE0QQY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2009 12:16:24 -0400
Received: (qmail invoked by alias); 27 May 2009 16:16:25 -0000
Received: from balu.cs.uni-paderborn.de (EHLO balu.cs.uni-paderborn.de) [131.234.21.37]
  by mail.gmx.net (mp069) with SMTP; 27 May 2009 18:16:25 +0200
X-Authenticated: #428038
X-Provags-ID: V01U2FsdGVkX18opIk9zJUonMvVD8ekXU9R8jIb/Tc6k9ULVSpVds
	cDl2YXKLS0VFtL
Received: from localhost ([127.0.0.1] helo=balu.cs.uni-paderborn.de)
	by balu.cs.uni-paderborn.de with esmtp (Exim 4.69)
	(envelope-from <matthias.andree@gmx.de>)
	id KKB97C-0004JW-NW; Wed, 27 May 2009 18:16:24 +0200
User-Agent: Opera Mail/9.64 (Win32)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.54
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120075>

Greetings,

I had tried to use git cvsimport and git svn to transfer a CVS repository  
(I have access to it) to an SVN repository (where I don't have access to  
the repo, so I cannot use cvs2svn or similar).

The problem is that the CVS repo had non-UTF-8 commit log messages, and I  
didn't bother to convert them to UTF-8. However, SVN insists on encoding  
filenames and log messages in UTF-8.

"git svn dcommit" (which uses the SVN Perl bindings under the hood)  
happily committed such a non-UTF-8 message and br0ke the repo. The actual  
reason is that the SVN server (https://...) is now wedged, as in:

$ svn log -r130
svn: REPORT of '/repos/!svn/bc/130': 200 OK (https://svn-serv...de)

$ svn --xml log -r130  2>/dev/null
[stdout:]
<?xml version="1.0"?>
<log>
[stderr:]
svn: REPORT of '/repos/!svn/bc/130': 200 OK (https://svn-serv...de)

$ svn propget --revprop svn:log -r130 https://svn-serv...de/path/
aktuelle version (disclaimer)
kopf und fu?\223zeilen
etc.


While mod_dav_svn arguably shouldn't accept b0rked messages, git-svn  
shouldn't attempt to commit them either. It seems that the svn command  
line utilities validate the message format by themselves, and apparently  
the svn server module (likely mod_dav_svn - or are there others?) does not.

So, could
a) git-svn be modified to refuse dcommiting non-UTF-8 messages?
b) mod_dav_svn be modified to refuse commits/propedits/propsets with  
non-UTF-8 messages?

I'm sorry to say I don't have information how the SVN server is configured  
and which version it's running.

Thanks.

-- 
Matthias Andree
