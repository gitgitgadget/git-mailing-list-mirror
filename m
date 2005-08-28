From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 2/9] Fix detection of files with only one line in git-apply.
Date: Sun, 28 Aug 2005 09:55:43 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0508280946180.3317@g5.osdl.org>
References: <1125242667404-git-send-email-robfitz@273k.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 28 18:56:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E9QRn-0003cu-0A
	for gcvg-git@gmane.org; Sun, 28 Aug 2005 18:55:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750705AbVH1Qzt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 28 Aug 2005 12:55:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750735AbVH1Qzt
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Aug 2005 12:55:49 -0400
Received: from smtp.osdl.org ([65.172.181.4]:44503 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750705AbVH1Qzs (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 28 Aug 2005 12:55:48 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j7SGtijA011630
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 28 Aug 2005 09:55:44 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j7SGthCU021619;
	Sun, 28 Aug 2005 09:55:43 -0700
To: Robert Fitzsimons <robfitz@273k.net>
In-Reply-To: <1125242667404-git-send-email-robfitz@273k.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.114 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7878>



On Sun, 28 Aug 2005, Robert Fitzsimons wrote:
>
> A patch which added one line to an empty file or removed the only line
> from a one line file would be incorrectly detected as an invalid new
> or delete patch.  Added a new test case.

This patch looks wrong or at least needs some more thought. The test was
done the way it was done for a reason. For example:

	if (patch->is_new != !oldlines)
		return error("new file depends on old contents");

actually has two error cases (admittedly it re-uses the same error message 
for both, which is a bit confusing):

 - is_new, and oldlines != 0

	This is the obvious error, and the one the message talk about.

 - !is_new, and oldlines == 0

	In kernel usage, empty files are not legal, and empty files get 
	deleted. So this actually was intentional, even if the error 
	message ends up being less than perfect.

The "is_delete" thing is the same. At least for the kernel, I want a patch 
that removes all content to also always _delete_ the file, because 
otherwise old-style patches are ambiguous. Is it a delete, or is it a 
"leave an empty file"?

Now, git patches aren't ambigious, so while git patches can clearly say 
"this is a patch to an existing empty file" vs "this patch creates this 
file", I wanted to have the behaviour where we maintain the principle that 
empty files are wrong.

Now, that's a kernel-specific thing, so it may be that enabling this
behaviour this should be a command line flag, but the point is that I 
don't want to entirely lose the test.

		Linus
