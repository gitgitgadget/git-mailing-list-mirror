From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 2/4] remote-hg: fix compatibility with older versions of hg
Date: Tue, 13 Nov 2012 08:11:05 +0100
Message-ID: <CAMP44s3GQOVUGOMsz=U5zbecsHybejjH-KLgmbmJsbnzFzC+qg@mail.gmail.com>
References: <1352742068-15346-1-git-send-email-felipe.contreras@gmail.com>
	<1352742068-15346-3-git-send-email-felipe.contreras@gmail.com>
	<CALkWK0k9Ta-SOo43Knz9kMV0ePKf7wjK-3Zm6ocDQpe7VzFz+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 13 08:11:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYAeY-0003eZ-0W
	for gcvg-git-2@plane.gmane.org; Tue, 13 Nov 2012 08:11:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751537Ab2KMHLH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2012 02:11:07 -0500
Received: from mail-ob0-f174.google.com ([209.85.214.174]:62894 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751217Ab2KMHLF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2012 02:11:05 -0500
Received: by mail-ob0-f174.google.com with SMTP id uo13so7097157obb.19
        for <git@vger.kernel.org>; Mon, 12 Nov 2012 23:11:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=IXU2gJy7v9OcErBZLaR0mrPRel/x5f2JFZ2Qu3koKWs=;
        b=ptIcT/Dxs+nhw8wXP7D2T94jVZiyE04OVjy2lXbxgegbezcxrYxAf0KBQEfp/jo0oB
         CConBBaGxBQFzjPXun0IwFvPt3uqPTUjnj/YTBzkbVsba0pKkV5nz8Zv5PtSKQ4qHNQ5
         qpkepSdL7AD0yqk8KOk6VZAqKH0kvFQK1v6zzUbUV8r5Q3PKWHnrr5S+uhI0ayto5hxo
         4fk5aNHmDN+fMlMTeJxuxk9cginu/ypuEcI5ZMnMwy5Ua7Vf5wX8pjL1OhnKU4tVaBld
         y+eY0bINRxDjs8dFAuBs3RyBae9HQs1wJbS3TRSbLu1u8r//w4gaPkscH34SZire7QAK
         sAYg==
Received: by 10.182.116.6 with SMTP id js6mr17039732obb.82.1352790665193; Mon,
 12 Nov 2012 23:11:05 -0800 (PST)
Received: by 10.60.4.74 with HTTP; Mon, 12 Nov 2012 23:11:05 -0800 (PST)
In-Reply-To: <CALkWK0k9Ta-SOo43Knz9kMV0ePKf7wjK-3Zm6ocDQpe7VzFz+A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209581>

On Tue, Nov 13, 2012 at 6:25 AM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> This patch fixes my original problem. So,
> Reported-by: Ramkumar Ramachandra <artagnon@gmail.com>
> Tested-by: Ramkumar Ramachandra <artagnon@gmail.com>
>
> However, test 4 in test-hg.sh still fails for me:
>
> --- expected    2012-11-13 05:22:57.946637384 +0000
> +++ actual      2012-11-13 05:22:57.946637384 +0000
> @@ -1,2 +1,2 @@
> -zero
> -refs/heads/master
> +feature-a
> +refs/heads/feature-a
>
> What is going on?

Probably a bug in mercurial, but can be worked around:

--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -429,10 +429,18 @@ def get_branch_tip(repo, branch):

     return heads[0]

+def get_current_bookmark(repo):
+    head = bookmarks.readcurrent(repo)
+    if not head:
+        return None
+    if repo[head] != repo['.']:
+        return None
+    return head
+
 def list_head(repo, cur):
     global g_head, bmarks

-    head = bookmarks.readcurrent(repo)
+    head = get_current_bookmark(repo)
     if head:
         node = repo[head]
     else:

-- 
Felipe Contreras
