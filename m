X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Alexandre Julliard <julliard@winehq.org>
Subject: Re: Shallow clone
Date: Sat, 11 Nov 2006 14:57:23 +0100
Message-ID: <87zmaynl18.fsf@wine.dyndns.org>
References: <7v8ximwrm3.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0611072009220.2601@qynat.qvtvafvgr.pbz>
	<45520872.3090506@gmail.com> <45521AE9.7050902@gmail.com>
	<7vac31p8om.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sat, 11 Nov 2006 13:57:44 +0000 (UTC)
Cc: "Aneesh Kumar K.V" <aneesh.kumar@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <7vac31p8om.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's message of "Wed\, 08 Nov 2006 20\:04\:25 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.90 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31222>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GitMa-0000EJ-G7 for gcvg-git@gmane.org; Sat, 11 Nov
 2006 14:57:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1754838AbWKKN5h (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 11 Nov 2006
 08:57:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754837AbWKKN5h
 (ORCPT <rfc822;git-outgoing>); Sat, 11 Nov 2006 08:57:37 -0500
Received: from mail.codeweavers.com ([216.251.189.131]:12440 "EHLO
 mail.codeweavers.com") by vger.kernel.org with ESMTP id S1754838AbWKKN5g
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 11 Nov 2006 08:57:36 -0500
Received: from adsl-84-227-4-69.adslplus.ch ([84.227.4.69]
 helo=wine.dyndns.org) by mail.codeweavers.com with esmtpsa
 (TLS-1.0:DHE_RSA_AES_256_CBC_SHA:32) (Exim 4.50) id 1GitMM-0005uv-Hu; Sat, 11
 Nov 2006 07:57:27 -0600
Received: by wine.dyndns.org (Postfix, from userid 1000) id 3FE0910A151; Sat,
 11 Nov 2006 14:57:23 +0100 (CET)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Junio C Hamano <junkio@cox.net> writes:

> But it seems to need some more work.  I just tried to clone
> git.git with --depth=1 and it cauterizes each branch with two
> commits (I think that is what depth=1 means -- the latest and
> one behind it), but it pulled almost the whole repository
> anyway, and it turns out that "git log v1.4.3-rc1" gives me the
> full history leading to it.

That's apparently because tags are not considered when truncating the
commit list. The patch below fixes it, and fetches the right number of
commits for each tag. However the correct fix is probably to not fetch
historical tags at all.

There's also a problem with the packing, a clone --depth 1 currently
results in a pack that's about 3 times as large as it should be.

---
diff --git a/shallow.c b/shallow.c
index 58a7b20..2db1dc4 100644
--- a/shallow.c
+++ b/shallow.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "commit.h"
+#include "tag.h"
 
 static int is_shallow = -1;
 
@@ -54,7 +55,7 @@ struct commit_list *get_shallow_commits(
 		if (!commit) {
 			if (i < heads->nr) {
 				commit = (struct commit *)
-					heads->objects[i++].item;
+					deref_tag(heads->objects[i++].item, NULL, 0);
 				if (commit->object.type != OBJ_COMMIT) {
 					commit = NULL;
 					continue;

-- 
Alexandre Julliard
