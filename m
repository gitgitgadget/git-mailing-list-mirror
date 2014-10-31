From: Alexandre Garnier <zigarn+git@gmail.com>
Subject: Bug in log for path in case of identical commit
Date: Fri, 31 Oct 2014 09:40:38 +0100
Message-ID: <CAFFOgCUeqcEPdjUyri0bivCj-Ofzp_9GhH3mR7UTzD-8PY9tGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001a1135e17e8f47bc0506b3f3a3
To: Git ML <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Oct 31 09:41:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xk7le-0006vx-Le
	for gcvg-git-2@plane.gmane.org; Fri, 31 Oct 2014 09:41:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756741AbaJaIlG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Oct 2014 04:41:06 -0400
Received: from mail-vc0-f176.google.com ([209.85.220.176]:33245 "EHLO
	mail-vc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752825AbaJaIkj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Oct 2014 04:40:39 -0400
Received: by mail-vc0-f176.google.com with SMTP id hq11so3528800vcb.21
        for <git@vger.kernel.org>; Fri, 31 Oct 2014 01:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:date:message-id:subject:from:to:content-type;
        bh=/pIQITZh8ahYyiBmiCs2sWWwDhzx9P3QX5OkrQZHRFM=;
        b=X5bMOi24nct8nblLhc7Tf7dradX+9JkmtG+7OR2sMnhW7VXCPDcroP1m/U9/SM9Wtk
         gyugN2g4T9ZGsgReMX3LpJojjh0WLUAa1LPHmFYigwVktCFLnEBXaOZPNMnfoIGU91R7
         o3yfTuhZ5szEKthtr6FspppCKLHkXQ6Faz13bnQ4gV2eUyRxO3vEyKa7rN7tvOpcTqEd
         2AGWXvohf3r7dRMtsG7GS0m6TffZrdd39qwwu8M2eclk7dH7x2NvbkRcNJEkIAUplIUs
         BV4FMxTNHKw+1sQQHgJyuG3e6JYFkWpO2kXIIpZfZkxRW8aLkZbzRo2XDvjYPBhfQ+kf
         q/Jw==
X-Received: by 10.52.251.34 with SMTP id zh2mr79761vdc.70.1414744838707; Fri,
 31 Oct 2014 01:40:38 -0700 (PDT)
Received: by 10.220.122.132 with HTTP; Fri, 31 Oct 2014 01:40:38 -0700 (PDT)
X-Google-Sender-Auth: E3STGqm9FCeGXoEb3HzxMv48dOM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--001a1135e17e8f47bc0506b3f3a3
Content-Type: text/plain; charset=UTF-8

When merging 2 branches with the same modifications on the both sides,
depending the merge side, one branch disappear from the file history.

To be more clear, there is a script in attachment to reproduce, but
here is the result :
$ git log --graph --oneline --all --decorate --name-status
*   63c807f (HEAD, master) Merge branch 'branch' into 'master'
|\
| * 5dc8785 (branch) Change line 15 on branch
| | M   file
| * d9cd3ce Change line 25 on branch
| | M   file
* | 7220d52 Change line 15 on master
|/
|   M   file
* 7566672 Initial commit
  A     file

$ git log --graph --oneline --all --decorate --name-status -- file
* 5dc8785 (branch) Change line 15 on branch
| M     file
* d9cd3ce Change line 25 on branch
| M     file
* 7566672 Initial commit
  A     file

=> The commit 7220d52 modified the file but is not shown in file
history anymore.
The expected result would be:
* 5dc8785 (branch) Change line 15 on branch
| M     file
* d9cd3ce Change line 25 on branch
| M     file
| * 7220d52 Change line 15 on master
|/
|   M   file
* 7566672 Initial commit
  A     file

The order between the 2 commits on the branch is not important.
If you do a 'cherry-pick 7220d52' or a 'merge --squash master' instead
of applying the same modification for commit 5dc8785, you get the same
result (cherry-picking was my initial use-case).
If you do not create the commit d9cd3ce, then the file history show all commits.
If you merge 'master' into 'branch', then the file history show all commits.

Am I missing something or is it really a bug?
Thanks.

-- 
Alex

--001a1135e17e8f47bc0506b3f3a3
Content-Type: application/x-sh; name="git_log_path_bug.sh"
Content-Disposition: attachment; filename="git_log_path_bug.sh"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_i1xa6ur50

IyEvYmluL3NoCmdpdCBpbml0IC0tcSByZXBvCmNkIHJlcG8KcHl0aG9uIC1jICJpbXBvcnQgcmFu
ZG9tOyBwcmludCAnXG4nLmpvaW4oWycgJy5qb2luKFt3b3JkLnJlcGxhY2UoJ1xuJywgJycpIGZv
ciB3b3JkIGluIHJhbmRvbS5zYW1wbGUobGlzdChvcGVuKCcvdXNyL3NoYXJlL2RpY3Qvd29yZHMn
KSksIDEwKV0pIGZvciBfIGluIHJhbmdlKDUwKV0pIiA+PiBmaWxlCmdpdCBhZGQgZmlsZQpnaXQg
Y29tbWl0IC1xbSAiSW5pdGlhbCBjb21taXQiCgpzZWQgLWkgJzE1cy9bZWlvdXldL2EvJyBmaWxl
CmdpdCBjb21taXQgLWFxbSAiQ2hhbmdlIGxpbmUgMTUgb24gbWFzdGVyIgoKZ2l0IGNoZWNrb3V0
IC1xYiBicmFuY2ggSEVBRH4Kc2VkIC1pICcyNXMvW2Vpb3V5XS9hLycgZmlsZQpnaXQgY29tbWl0
IC1hcW0gIkNoYW5nZSBsaW5lIDI1IG9uIGJyYW5jaCIKc2VkIC1pICcxNXMvW2Vpb3V5XS9hLycg
ZmlsZQpnaXQgY29tbWl0IC1hcW0gIkNoYW5nZSBsaW5lIDE1IG9uIGJyYW5jaCIKCmdpdCBtZXJn
ZSAtcSBtYXN0ZXIgLW0gIk1lcmdlIGJyYW5jaCAnbWFzdGVyJyBpbnRvICdicmFuY2gnIgplY2hv
ICJGdWxsIGxvZzoiCmdpdCBsb2cgLS1ncmFwaCAtLW9uZWxpbmUgLS1hbGwgLS1kZWNvcmF0ZSAt
LW5hbWUtc3RhdHVzCmVjaG8gIi0tLSIKZWNobyAiTG9nIG9mICdmaWxlJzoiCmdpdCBsb2cgLS1n
cmFwaCAtLW9uZWxpbmUgLS1hbGwgLS1kZWNvcmF0ZSAtLW5hbWUtc3RhdHVzIC0tIGZpbGUKCmdp
dCByZXNldCAtcSAtLWhhcmQgSEVBRF4KZ2l0IGNoZWNrb3V0IC1xIG1hc3RlcgpnaXQgbWVyZ2Ug
LXEgYnJhbmNoIC1tICJNZXJnZSBicmFuY2ggJ2JyYW5jaCcgaW50byAnbWFzdGVyJyIgPiAvZGV2
L251bGwKZWNobyAiLS0tIgplY2hvICJGdWxsIGxvZzoiCmdpdCBsb2cgLS1ncmFwaCAtLW9uZWxp
bmUgLS1hbGwgLS1kZWNvcmF0ZSAtLW5hbWUtc3RhdHVzCmVjaG8gIi0tLSIKZWNobyAiTG9nIG9m
ICdmaWxlJzoiCmdpdCBsb2cgLS1ncmFwaCAtLW9uZWxpbmUgLS1hbGwgLS1kZWNvcmF0ZSAtLW5h
bWUtc3RhdHVzIC0tIGZpbGUKIyA9PT4gTm8gaGlzdG9yeSBmcm9tIG1hc3RlciAhCg==
--001a1135e17e8f47bc0506b3f3a3--
