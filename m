From: Tomas Carnecky <tom@dbservice.com>
Subject: Git confused when file is renamed/renamed+modified and result merged
Date: Fri, 5 Jun 2009 22:06:04 +0200
Message-ID: <B88C71A7-5EDB-4DAC-9288-E1C700C255DA@dbservice.com>
Mime-Version: 1.0 (Apple Message framework v935.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 05 22:06:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCfgL-0000mE-0l
	for gcvg-git-2@gmane.org; Fri, 05 Jun 2009 22:06:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751823AbZFEUGT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jun 2009 16:06:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751345AbZFEUGS
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jun 2009 16:06:18 -0400
Received: from office.neopsis.com ([78.46.209.98]:50221 "EHLO
	office.neopsis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751343AbZFEUGS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jun 2009 16:06:18 -0400
Received: from calvin.emmen.dbservice.com ([62.65.141.13])
	(authenticated user tom@dbservice.com)
	by office.neopsis.com
	(using TLSv1/SSLv3 with cipher AES128-SHA (128 bits))
	for git@vger.kernel.org;
	Fri, 5 Jun 2009 22:06:16 +0200
X-Mailer: Apple Mail (2.935.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120826>

I was helping someone on IRC with merge problems and it boiled down to  
this. Git is confused when one branch renames a file while another  
branch renames the file in the same way and then modifies the file.  
When merging the two branches git will indicate a conflict in the  
'source' file (rename/delete) but not the 'destination' file and will  
put the destination file from the first branch into the working tree,  
even though the second branch has a file with the same name but  
conflicting contents.

Git commands that lead up to this situation, with interleaved  
comments. A usability suggestion is also included in the following  
transcript:

bash-3.2$ git --version
git version 1.6.3.2.198.g6096d
bash-3.2$ git init
Initialized empty Git repository in /Users/tomc/gitest/.git/
bash-3.2$ echo arst > file1
bash-3.2$ git add file1
bash-3.2$ git commit -m 'initial commit'
[master (root-commit) fdad65c] initial commit
  1 files changed, 1 insertions(+), 0 deletions(-)
  create mode 100644 file1
bash-3.2$ git branch new

# branch master renames the file without modifying it
bash-3.2$ git mv file1 file2
bash-3.2$ git commit -m 'move file1 to file2'
[master 053cc6f] move file1 to file2
  1 files changed, 0 insertions(+), 0 deletions(-)
  rename file1 => file2 (100%)
bash-3.2$ git checkout new
Switched to branch 'new'

# branch new moves the file while modifying it so heavily that git  
doesn't
# recognize it as a rename anymore
bash-3.2$ git rm file1
rm 'file1'
bash-3.2$ echo qwfp > file2
bash-3.2$ git add file2
bash-3.2$ git commit -m 'move file1 to file2, while heavily modifying  
it'
[new 4118625] rename file1 to file2, while heavily modifying it
  2 files changed, 1 insertions(+), 1 deletions(-)
  delete mode 100644 file1
  create mode 100644 file2

# merge new into master
bash-3.2$ git checkout master
Switched to branch 'master'
bash-3.2$ git merge new

# Usability suggestion: Not clear to which file the 'deleted in new' is
# referring to. Maybe change the message to:
# CONFLICT in 'file1' (rename/delete): Renamed to file2 in HEAD,  
deleted in new.
CONFLICT (rename/delete): Rename file1->file2 in HEAD and deleted in new
Automatic merge failed; fix conflicts and then commit the result.

# as expected, there's a conflict in 'file1'. But 'file2' is silently  
accepted
# from the 'master' branch, even though the 'new' branch has a file  
with the
# same name but different contents
bash-3.2$ git show :2:file2
arst
bash-3.2$ git show :3:file2
fatal: ambiguous argument ':3:file2': unknown revision or path not in  
the working tree.
Use '--' to separate paths from revisions
bash-3.2$ git show new:file2
qwfp
bash-3.2$

tom
