From: Elijah Newren <newren@gmail.com>
Subject: fast-import, merges, and file changes -- lack of clarity in docs, 
	possible minor bug, or PEBKAC?
Date: Mon, 16 Feb 2009 17:28:44 -0700
Message-ID: <51419b2c0902161628x7a3475e6p2a70310e5b294444@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Feb 17 01:30:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZDqn-0001np-S1
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 01:30:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751186AbZBQA2q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2009 19:28:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751169AbZBQA2q
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Feb 2009 19:28:46 -0500
Received: from el-out-1112.google.com ([209.85.162.182]:6180 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750923AbZBQA2p (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2009 19:28:45 -0500
Received: by el-out-1112.google.com with SMTP id b25so1314824elf.1
        for <git@vger.kernel.org>; Mon, 16 Feb 2009 16:28:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=Lo8KdIS+0p+t5U4YW4GZhuYmINPumd3+Ia6r5BMSb7k=;
        b=Of4AcsdXw3Bk5lVr4GNNLYR+Hiym9Og5AM+xNgn2oV0eJMVlZd1EHosA3gDIbuvJZp
         E/Pmpk0WGfDadv3t6hG6xok8qG+eRcjkGnqNIiXdTzXkXunzJSHJllGf0nhxl0CEVTfe
         eC0pxEOBG46zHLOV4KmGCwA+EJpQQYnk54FVs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=O/xK109unwZkgq7VcfwiHzemA/mof2xRVg65Iv2iBAB3hUxcdJlkFXC2U5RxszXo0N
         MeSPyvuZ0OKMYSmDpFZUMvurHeXRNCXOOMdlXRr092shJM65mfWDYghPbPeRA/e/HhmP
         A3La9xgH9RYKDwWmTMLRqS8W0XwR1D7F0NEAw=
Received: by 10.150.149.19 with SMTP id w19mr438604ybd.18.1234830524399; Mon, 
	16 Feb 2009 16:28:44 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110270>

Hi,

It appears the documentation for fast-import does not specify the
basis on which a commit command's file changes (filemodify,
filedelete, filecopy, or filerename) are relative to.  For a non-merge
commit, it's obvious, and I thought that it would be obvious for a
merge commit too -- and then found out I had assumed the wrong answer.
 I assumed the file changes would be relative to the *combined* set of
files from the parents, whereas fast-import apparently treats them as
relative to the first (or 'from') parent.  (Since the combined set of
files may have conflicts, I'd expect it to be an error if the merge
commit didn't specify an appropriate filemodify command for at least
each of the filenames with conflicts.)

In case my description above isn't clear, I've got a simple example at
the end of this email that has a file 'world' on one branch, a file
'bar' on another branch, and a merge of the two branches.  In the
merge commit, I do not need to mention the 'world' file; it will be
included automatically.  However, unless I mention the 'bar' file (by
adding a 'M 100644 :1 bar' line to the end of the input), it will not
be included in the merge commit.

Is this intentional?  I believe we could change this behavior without
breaking backward compatibility with older fast-export output streams,
since such older streams would simply be providing redundant
information.  But is there a reason for this behavior that I'm
missing?


Thanks,
Elijah


Sample input file for git fast-import (which merges two commits but
silently drops one of the files):

blob
mark :1
data 4
foo

reset refs/heads/other
commit refs/heads/other
mark :2
author Elijah Newren <newren@gmail.com> 1234815015 -0700
committer Elijah Newren <newren@gmail.com> 1234815015 -0700
data 29
Initial commit, other branch
M 100644 :1 bar

blob
mark :3
data 3
hi

reset refs/heads/master
commit refs/heads/master
mark :4
author Elijah Newren <newren@gmail.com> 1234814943 -0700
committer Elijah Newren <newren@gmail.com> 1234814943 -0700
data 30
Initial commit, master branch
M 100644 :3 world

commit refs/heads/master
mark :5
author Elijah Newren <newren@gmail.com> 1234815029 -0700
committer Elijah Newren <newren@gmail.com> 1234815029 -0700
data 21
Merge branch 'other'
from :4
merge :2
