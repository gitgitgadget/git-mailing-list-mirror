From: Luke San Antonio <lukesanantonio@gmail.com>
Subject: Re: [Bug] git stash generates a different diff then other commands
 (diff, add, etc) resulting in merge conflicts!
Date: Mon, 12 Aug 2013 01:29:48 -0400
Message-ID: <520872CC.3040507@gmail.com>
References: <CAP+CFTZWzoAg=ni6t1aif-85y6W4-2JUT4wooapTvD0oGH+HRw@mail.gmail.com> <CABURp0oATJ58POmgYLjSmy-y84LTjkP0PTh4=3M-vc04_AoMdg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 12 07:29:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V8khW-0006Mt-To
	for gcvg-git-2@plane.gmane.org; Mon, 12 Aug 2013 07:29:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755421Ab3HLF3v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Aug 2013 01:29:51 -0400
Received: from mail-vc0-f177.google.com ([209.85.220.177]:50530 "EHLO
	mail-vc0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755254Ab3HLF3u (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Aug 2013 01:29:50 -0400
Received: by mail-vc0-f177.google.com with SMTP id gf12so2428781vcb.8
        for <git@vger.kernel.org>; Sun, 11 Aug 2013 22:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=KaODW3PBQBnWxtQdyoFGCSH9IGAbJO1v4t+M8W07YoI=;
        b=ci4AgnMaff0owsiHD4GtuMq/Hh5dplCuXp9I9DxUBvrjRqJ3ynXkyMQetvxTjA79D8
         U1k7cmRbhN5IxAtTIdR7I9CmnP5op++dVAtdgYIDsMG2QyowSeDTCc1KkAU2JNuljl+X
         oIK7kiRfSH/Eb0pnqSNm6GoZ6+G9jrOw5j+pBFIncIzXaKEQ8FfCf9bHOT/dleBPcd1J
         dLYv+YgYETD4qAoSy7R9z2hx3FOLxw6lPPrZswf7EE6PI81vHeDiox5F6yDEopdp4uUW
         qrI22R3OvLPtiElf4Wafsj7Eh1CpunH3KugzCojtyLzN7LR6ySiN374JbCcPpBITnlFQ
         FQhw==
X-Received: by 10.52.240.205 with SMTP id wc13mr9167492vdc.105.1376285389514;
        Sun, 11 Aug 2013 22:29:49 -0700 (PDT)
Received: from [192.168.1.6] (ool-457405c6.dyn.optonline.net. [69.116.5.198])
        by mx.google.com with ESMTPSA id ef3sm20393597vdc.13.2013.08.11.22.29.48
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 11 Aug 2013 22:29:48 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130803 Thunderbird/17.0.8
In-Reply-To: <CABURp0oATJ58POmgYLjSmy-y84LTjkP0PTh4=3M-vc04_AoMdg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232150>

On 08/08/20130 04:54 PM, Phil Hord wrote:
> Luke,
>
> I think the issue is that your working directory receives your cached
> file when you say 'git stash --keep-index'.  When you restore the
> stash, your previous working directory now conflicts with your new
> working directory, but neither is the same as HEAD.
>
> Here's a test script to demonstrate the issue, I think.  Did I get
> this right, Luke?
>
>   # cd /tmp && rm -rf foo
>   git init foo && cd foo
>   echo "foo" > bar &&  git add bar && git commit -mfoo
>   echo "bar" > bar &&  git add bar
>   echo "baz" > bar
>   echo "Before stash  bar: $(cat bar)"
>   git stash --keep-index
>   echo "After stash  bar: $(cat bar)"
>   git stash apply
Actually no, in your script, the bar file has a modification in the working
tree which is in the same hunk as a change applied to the index. In my
project the changes that were added to the index are not modified further
in theworking tree.

--------

Not only that, but I found out why git was generated different patches!
I realized that when I removed a hunk appearing before the merge conflict
from the working tree and index, the merge conflict disappeared! Turns
out, we can forget about stashing for a minute!
First the hunk in my working tree:

@@ -56,12 +56,14 @@
      bool running_ = true;

      /*!
-     * \brief The default font renderer, global to all who have a 
pointer to
-     * the Game class.
+     * \brief The font renderer implementation, obtained from the 
config file.
       *
-     * It need not be used at all!
+     * It should be used and passed along to member objects by GameStates!
+     *
+     * \note It can be cached, but not between GameStates, meaning it 
should be
+     * cached again every time a new GameState is constructed!
       */
-    std::unique_ptr<FontRenderer> font_renderer_ = nullptr;
+    FontRenderer* font_renderer_ = nullptr;

      int run(int argc, char* argv[]);

Most of this is unimportant, but notice the line number spec:@@ -56,12 
+56,14 @@
The line number of this hunk doesn't change! Then I addeda few lines *above*
this hunk, (around line 30 I think). Here is the diff again:

@@ -56,12 +58,14 @@
      bool running_ = true;

      /*!
-     * \brief The default font renderer, global to all who have a 
pointer to
-     * the Game class.
+     * \brief The font renderer implementation, obtained from the 
config file.
+     *
+     * It should be used and passed along to member objects by GameStates!
       *
-     * It need not be used at all!
+     * \note It can be cached, but not between GameStates, meaning it 
should be
+     * cached again every time a new GameState is constructed!
       */
-    std::unique_ptr<FontRenderer> font_renderer_ = nullptr;
+    FontRenderer* font_renderer_ = nullptr;

      int run(int argc, char* argv[]);

Notice the new line number spec:@@ -56,12 +58,14 @@

It moves two lines down, because I added those two lines before it, 
makes sense!
But also notice that the patches are different, just because of the two 
lines
above it!

I thought I might be able to fix this problem by changing the new 
diff.algorithm
config option to 'patience', but it seems to only affect how patches 
look, not
how they are stored internally... Same problem!

Also, I'm wondering why that line was picked up by git if the patches 
don't match,
shouldn't git give me a conflict with the whole hunk, or is the system 
smarter
than that?

What if merging suppressed the conflict if both possibilities are the 
same? Isn't
that reasonable, or is there some 1% where this could cause (silent but 
deadly)
data loss.

Sorry, I'm just rambling...

Anyway, thanks for your help Phil!
- Luke
