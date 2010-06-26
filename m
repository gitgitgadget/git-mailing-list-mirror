From: Bo Yang <struggleyb.nku@gmail.com>
Subject: [PATCH 00/12] The first version of line level log browser
Date: Sat, 26 Jun 2010 06:27:25 -0700
Message-ID: <1277558857-23103-1-git-send-email-struggleyb.nku@gmail.com>
Cc: gitster@pobox.com, Jens.Lehmann@web.de, trast@student.ethz.ch,
	jrnieder@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 26 15:27:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OSVQH-0007cV-OT
	for gcvg-git-2@lo.gmane.org; Sat, 26 Jun 2010 15:27:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753356Ab0FZN1q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jun 2010 09:27:46 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:45678 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752779Ab0FZN1p (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jun 2010 09:27:45 -0400
Received: by pwj8 with SMTP id 8so2772894pwj.19
        for <git@vger.kernel.org>; Sat, 26 Jun 2010 06:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=mQpRwbYVWRDLHXPUaWxT0B75aJHXKZwOZPN10zcEBRw=;
        b=Rc37ahT1YmqyKGX8eeZjq1tDMmqQdrgxFpldqFcw9mixLf9SRPpLE6I7Eu3IzW2+bW
         jxokD7Pi8ZvNjdchNrzGld7r5GiCNRyHmVPkRUbHC/ki/UZvhWZm+VRjj/HCiLRQB6z9
         pu7DJejNMAVM5nOynjrJyz4I8shAiLqkLI6Kc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=RdGvU+rqOYnyM8YK/LZa2yaFOkHoj2pRInht8+6J9C4XcNDXvOd69Yw7aUimUGSjKn
         nbO4+jrD2SaHE/7tgVKcJ9cXVMEzwAybbGbX9QH2OUnccVsCIcdTdNdB8+2cq0KsJbtW
         OFSgEAa64vYt5MQig0QVnFPtWvSjBGWR+XpuE=
Received: by 10.142.7.19 with SMTP id 19mr2465975wfg.268.1277558865052;
        Sat, 26 Jun 2010 06:27:45 -0700 (PDT)
Received: from localhost.localdomain ([222.30.37.37])
        by mx.google.com with ESMTPS id b23sm1553667wfj.0.2010.06.26.06.27.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 26 Jun 2010 06:27:44 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.577.g36cf0.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149743>

In this version, we support multiple ranges from multiple files. Anybody interested at it can try it with something like:
git log -L /assign_range_to_parent/,/^}/ line.c or
git log -L diff-range /assign_range_to_parent/,/^}/ line.c to get a more detail history of how the lines evolved into such a state after fixing several bugs, or
git log diff-range -L /assign_range_to_parent/,/^}/ -L /cleanup/,/^}/ line.c to see when cleanup() function come into sceen.

We use a line number calculating method to find out the pre-image line range from the post-image line range. The algorithm is all in the map_lines function and I think the function is self-documenting. :)

For merge commit, we pass the line range to all of its parents and let these ranges change along each branch and combine again later when we encounter the splitting commit. This is because, if we keep the range non-split, we can give more context to users and make the output more meaningful.  So I chagne the original idea that to split the ranges at a merge commit. :)

I have also test some run on the Linux kernel source code. The tool is a little slow in the kernel repository, but it always give the correct history. :)

Feel free to post any criticism/advice to me!

Bo Yang (12):
  parse-options: stop when encounter a non-option
  parse-options: add two helper functions
  add the basic data structure for line level history
  parse the -L options
  export three functions from diff.c
  add range clone functions
  map/take range to parent
  print the line log
  map/print ranges along traversing the history topologically
  add --always-print option
  add two test cases
  some document update

 Documentation/git-log.txt          |   30 +
 Makefile                           |    2 +
 builtin/log.c                      |  130 ++++-
 diff.c                             |    6 +-
 diff.h                             |   18 +
 diffcore.h                         |    3 +
 line.c                             | 1244 ++++++++++++++++++++++++++++++++++++
 line.h                             |  128 ++++
 parse-options.c                    |   24 +-
 parse-options.h                    |    7 +-
 revision.c                         |   13 +-
 revision.h                         |   13 +-
 t/t4301-log-line-single-history.sh |  342 ++++++++++
 t/t4302-log-line-merge-history.sh  |  118 ++++
 14 files changed, 2066 insertions(+), 12 deletions(-)
 create mode 100644 line.c
 create mode 100644 line.h
 create mode 100755 t/t4301-log-line-single-history.sh
 create mode 100755 t/t4302-log-line-merge-history.sh

-- 
1.7.1.577.g36cf0.dirty
