From: Ashwin Jha <ajha.dev@gmail.com>
Subject: Re: [PATCH] GSoC Miniproject 15. Rewrite fsck.c:fsck_commit()
Date: Fri, 21 Mar 2014 21:12:34 +0530
Message-ID: <532C5DEA.1030006@gmail.com>
References: <1395366886-16839-1-git-send-email-ajha.dev@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 21 16:43:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WR1bS-0000X2-Q2
	for gcvg-git-2@plane.gmane.org; Fri, 21 Mar 2014 16:43:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753501AbaCUPnW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2014 11:43:22 -0400
Received: from mail-pd0-f182.google.com ([209.85.192.182]:64925 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751848AbaCUPnV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2014 11:43:21 -0400
Received: by mail-pd0-f182.google.com with SMTP id y10so2481189pdj.41
        for <git@vger.kernel.org>; Fri, 21 Mar 2014 08:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=eFPxEoBhIenptCZyvjl7yTRMDb+MrRBBtVj3SZpPVjU=;
        b=d5A1zgR3Iz0hLOz82jtxEDzV2ymelYkMH6AiyOUjzAMZm4l+DzvAqpkNSvStMP1y8P
         fwgj/Mcqk28jjgNOmDwGN8I6QWdc/iFwqZfV+BB67Un59zPfdqUXDTT9sPsdrS0tPwiN
         0DagXRdeEnG0zevDbG7nlELGyGvil9noC2WMawSczEP6skCZka66oQlyCc56V5HWJjfZ
         dAkaqfbd1Ks5JuAZk7vRcXVSEQ9eH8U056bpRYglP5mh7EKLc6vARAfD+nqSMkotMQpm
         wkCz0QaEgfjebNiau5hEP0CXx0/nszw/Kk+MbULmBJz9uV2yqXk7lXHUI6FY6j2gvZHY
         /ziA==
X-Received: by 10.68.184.66 with SMTP id es2mr54865475pbc.19.1395416600789;
        Fri, 21 Mar 2014 08:43:20 -0700 (PDT)
Received: from [192.168.23.7] (nkn-admin-map.isical.ac.in. [14.139.222.67])
        by mx.google.com with ESMTPSA id zb2sm10559178pbc.30.2014.03.21.08.43.18
        for <git@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 21 Mar 2014 08:43:19 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.3.0
In-Reply-To: <1395366886-16839-1-git-send-email-ajha.dev@gmail.com>
X-Forwarded-Message-Id: <1395366886-16839-1-git-send-email-ajha.dev@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244691>


-------- Original Message --------
Subject: 	[PATCH] GSoC Miniproject 15. Rewrite fsck.c:fsck_commit()
Date: 	Fri, 21 Mar 2014 07:24:46 +0530
From: 	Ashwin Jha <ajha.dev@gmail.com>
To: 	git@vger.kernel.org
CC: 	Ashwin Jha <ajha.dev@gmail.com>



modified fsck.c:fsck_commit(). Replaced memcmp() with starts_with() function.
starts_with() seems much more relevant than memcmp(). It uses one less argument
and its return value makes more sense.
skip_prefix() is not used as it uses strcmp() internally which seems unnecessarily
for current task. The current task can be easily done by providing offsets to the
buffer pointer (the way it is implemented currently).

Signed-off-by: Ashwin Jha <ajha.dev@gmail.com>
---
  fsck.c |   11 ++++++-----
  1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/fsck.c b/fsck.c
index 64bf279..82e1640 100644
--- a/fsck.c
+++ b/fsck.c
@@ -6,6 +6,7 @@
  #include "commit.h"
  #include "tag.h"
  #include "fsck.h"
+#include "strbuf.h"
  
  static int fsck_walk_tree(struct tree *tree, fsck_walk_func walk, void *data)
  {
@@ -290,12 +291,12 @@ static int fsck_commit(struct commit *commit, fsck_error error_func)
  	int parents = 0;
  	int err;
  
-	if (memcmp(buffer, "tree ", 5))
+	if (!starts_with(buffer, "tree "))
  		return error_func(&commit->object, FSCK_ERROR, "invalid format - expected 'tree' line");
  	if (get_sha1_hex(buffer+5, tree_sha1) || buffer[45] != '\n')
  		return error_func(&commit->object, FSCK_ERROR, "invalid 'tree' line format - bad sha1");
  	buffer += 46;
-	while (!memcmp(buffer, "parent ", 7)) {
+	while (starts_with(buffer, "parent ")) {
  		if (get_sha1_hex(buffer+7, sha1) || buffer[47] != '\n')
  			return error_func(&commit->object, FSCK_ERROR, "invalid 'parent' line format - bad sha1");
  		buffer += 48;
@@ -322,15 +323,15 @@ static int fsck_commit(struct commit *commit, fsck_error error_func)
  		if (p || parents)
  			return error_func(&commit->object, FSCK_ERROR, "parent objects missing");
  	}
-	if (memcmp(buffer, "author ", 7))
+	if (!starts_with(buffer, "author "))
  		return error_func(&commit->object, FSCK_ERROR, "invalid format - expected 'author' line");
  	buffer += 7;
  	err = fsck_ident(&buffer, &commit->object, error_func);
  	if (err)
  		return err;
-	if (memcmp(buffer, "committer ", strlen("committer ")))
+	if (!starts_with(buffer, "committer "))
  		return error_func(&commit->object, FSCK_ERROR, "invalid format - expected 'committer' line");
-	buffer += strlen("committer ");
+	buffer += 10;
  	err = fsck_ident(&buffer, &commit->object, error_func);
  	if (err)
  		return err;
-- 
1.7.9.5
