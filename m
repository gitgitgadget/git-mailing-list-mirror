From: Joshua Jensen <jjensen@workspacewhiz.com>
Subject: Re: Repository data loss in fast-export with a merge of a deleted
 submodule
Date: Thu, 03 Nov 2011 10:05:09 -0600
Message-ID: <4EB2BBB5.3030908@workspacewhiz.com>
References: <4EA9B0B5.6060005@workspacewhiz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Nov 03 17:04:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RLzm3-0003FU-A9
	for gcvg-git-2@lo.gmane.org; Thu, 03 Nov 2011 17:04:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933739Ab1KCQEJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Nov 2011 12:04:09 -0400
Received: from hsmail.qwknetllc.com ([208.71.137.138]:50338 "EHLO
	hsmail.qwknetllc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932244Ab1KCQEI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Nov 2011 12:04:08 -0400
Received: (qmail 6205 invoked by uid 399); 3 Nov 2011 10:04:06 -0600
Received: from unknown (HELO ?192.168.1.11?) (jjensen@workspacewhiz.com@50.8.110.77)
  by hsmail.qwknetllc.com with ESMTPAM; 3 Nov 2011 10:04:06 -0600
X-Originating-IP: 50.8.110.77
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:7.0.1) Gecko/20110929 Thunderbird/7.0.1
In-Reply-To: <4EA9B0B5.6060005@workspacewhiz.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184725>

----- Original Message -----
From: Joshua Jensen
Date: 10/27/2011 1:27 PM
> We had a submodule that we deleted and then added back into the 
> repository at the same location as the former submodule.  When running 
> fast-export, the newly 'added' files for the merge commit are listed 
> and then are followed with a:
>
> M ... path/to/submodule/file
> D path/to/submodule
>
> On fast-import, the resultant repository becomes corrupt due to the 
> Delete instruction above occurring AFTER the file adds/modifications.  
> The new repository does not match the old repository where the 
> fast-export was performed.
>
> I am not familiar with the fast-export code.  Can anyone help out?
Okay, I looked into this further, and I came up with a patch that works 
for me.  Nevertheless, I do not understand exactly what is going on 
here, so I would like to defer to someone else's patch to fix the issue.

-Josh


---
builtin/fast-export.c |    8 ++++++++
1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 9836e6b..1abc470 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -161,6 +161,14 @@ static int depth_first(const void *a_, const void *b_)
                name_a = a->one ? a->one->path : a->two->path;
                name_b = b->one ? b->one->path : b->two->path;
+             /*
+             * Move 'D'elete entries first.
+             */
+             if (a->status == 'D')
+                             return -1;
+             else if (b->status == 'D')
+                             return 1;
+
                len_a = strlen(name_a);
                len_b = strlen(name_b);
                len = (len_a < len_b) ? len_a : len_b;
-- 
