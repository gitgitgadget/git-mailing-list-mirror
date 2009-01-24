From: Chad Dombrova <chadrik@gmail.com>
Subject: read-only working copies using links
Date: Sat, 24 Jan 2009 01:17:19 -0800
Message-ID: <3EE64C92-CB4C-47BD-9C48-E369AED4B82F@gmail.com>
Mime-Version: 1.0 (Apple Message framework v929.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 24 10:18:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQefB-0007FJ-Q0
	for gcvg-git-2@gmane.org; Sat, 24 Jan 2009 10:18:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751164AbZAXJR1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Jan 2009 04:17:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751017AbZAXJRZ
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Jan 2009 04:17:25 -0500
Received: from yx-out-2324.google.com ([74.125.44.29]:24952 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750806AbZAXJRY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jan 2009 04:17:24 -0500
Received: by yx-out-2324.google.com with SMTP id 8so2309770yxm.1
        for <git@vger.kernel.org>; Sat, 24 Jan 2009 01:17:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:from:to
         :content-type:content-transfer-encoding:mime-version:subject:date
         :x-mailer;
        bh=dJr2ve3DIcsG5gkGWif/LizJwdpzXxTQ1df3qGPHPIA=;
        b=ohjAPFaP91okNQKzbDLLl91VhO/SAQRX4I9/XfX5W4j1aZC/enKRzCR+7ValqnZRcV
         YPLgpZlWZCJj2HkLjVMbLP/isBy/sp9l76PY35YMeO8BvxNZ7wOd5soDqZXQAEoalJKh
         3EYpUmVsvkemUKDpAqn+X5QHpd1qFZILZtSqE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:from:to:content-type:content-transfer-encoding
         :mime-version:subject:date:x-mailer;
        b=YTvuOo7dXzBiA2eM7kUifKHzLorGFsqNute8B4BkKJBcuO9eQ1Ki/vH+R40D9PQGgR
         nXrDoPC0pqeN8LjpbPfrpzG1FeAFPvfADnbHLM51k3zWL7NB3+t2pVYd84Svb1wvOpQK
         EUiljFyTho2f7D6AtfjETypKN1eNHrD+DvHvg=
Received: by 10.150.212.14 with SMTP id k14mr1395125ybg.7.1232788642543;
        Sat, 24 Jan 2009 01:17:22 -0800 (PST)
Received: from ?10.0.1.100? (pool-71-106-182-59.lsanca.dsl-w.verizon.net [71.106.182.59])
        by mx.google.com with ESMTPS id 34sm10609097yxm.34.2009.01.24.01.17.20
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 24 Jan 2009 01:17:21 -0800 (PST)
X-Mailer: Apple Mail (2.929.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106960>

hi all,

there's a major feature for working with large binaries that has not  
yet been addressed by git:  the ability to check out a file as a  
symbolic/hard link to a blob in the repository, instead of duplicating  
the file into the working copy.

imagine a scenario where one user is putting large binary files into a  
git repo on a networked server.  100 other users on the server need  
read-only access to this repo.  they clone the repo using --shared or  
--local, which saves disk space for the object files, but each of  
these 100 working copies also creates copies of all the binary files  
at the HEAD revision. it would be 100x as efficient in both disk space  
and checkout speeds if, in place of these files, symbolic or hard  
links were made to the blob files in .git/objects.

the crux of the issue is that the blob objects would have to be stored  
as exact copies of the original files.  it would seem there are two  
things that currently prevent this from happening.  1) blobs are  
stored with compression and 2) they include a small header.   
compression can be disabled by setting core.loosecompression to 0, so  
that seems like less of an issue.  as for the header, wouldn't it be  
possible to store it separately?  in other words, store two files per  
blob directory, a small stub file with the header info and the  
unaltered file data.

what are the caveats to a system like this?  has anyone looked into  
this before?

-chad

p.s.
i tried submitting a post through nabble a few days and it said that  
it was still pending, so i thought i'd try submitting directly to the  
mailing list.  sorry, if i end up double-posting
