From: Luke San Antonio <lukesanantonio@gmail.com>
Subject: [Bug] git stash generates a different diff then other commands (diff,
 add, etc) resulting in merge conflicts!
Date: Thu, 8 Aug 2013 03:07:23 -0400
Message-ID: <CAP+CFTZWzoAg=ni6t1aif-85y6W4-2JUT4wooapTvD0oGH+HRw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 08 09:07:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7KJl-0002fx-2y
	for gcvg-git-2@plane.gmane.org; Thu, 08 Aug 2013 09:07:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933831Ab3HHHHZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Aug 2013 03:07:25 -0400
Received: from mail-ob0-f196.google.com ([209.85.214.196]:38715 "EHLO
	mail-ob0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933594Ab3HHHHY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Aug 2013 03:07:24 -0400
Received: by mail-ob0-f196.google.com with SMTP id wc20so1054782obb.7
        for <git@vger.kernel.org>; Thu, 08 Aug 2013 00:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=cxJ0l6IDBBkRtbG9jU6PK5IjLTus2VAl4qLowH3pPgI=;
        b=IBVx/lTOBLSpJuCuZdndpuBUbVx+fempj2DvPntTWN9T65ePWW/aN0BTJ3l2JNb6Xn
         N/bopx0wtosr/vCHQgK4M1objw4lac/BRgt/9lZYAonSehs2hhis9+OXftIASMpCtbW3
         7rPgxquziYrbJWywgNnwR1JDyYW/n2bVOXqVKvwqoGY7reXHvrqTN6F+J4esAJckmIag
         h1IDX7+y8j14UV3CxbyC9a6fB2JrdlR+QPP3k/4IwtRuhReOwGBODytlYeXaKLis0tiL
         YedacqdR1hxN86YrZMkLLoxPeG4aqjA2xKmV9FbraT0GtaZqvvZsTPH9T2cJ8Zwd6TVA
         3pUw==
X-Received: by 10.182.246.39 with SMTP id xt7mr5390612obc.16.1375945643337;
 Thu, 08 Aug 2013 00:07:23 -0700 (PDT)
Received: by 10.182.79.162 with HTTP; Thu, 8 Aug 2013 00:07:23 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231867>

Hi, my name's Luke!

Today, I had a problem merging a stash after immediately creating it.
This is exactly what I did!

git stash save --keep-index
git stash pop

And BAM! Merge conflict! This was especially weird because my file had
this in it (taken directly from my code!)

<<<<<<< Updated upstream
     *
     * It should be used and passed along to member objects by GameStates!
     *
=======
     *
     * It should be used and passed along to member objects by GameStates!
     *
>>>>>>> Stashed changes

They are exactly the same!

Oh, by the way, I should mention that I did not edit any hunks to get
the index the way I wanted it, I have read that doing that causes
merge conflicts similar to this!

Then I got a hunch! I realized that git will refrain from applying a
hunk if it finds it already was applied exactly (that's correct
right?)... So I thought, maybe the patches are similar (represent the
same changes) but aren't *exactly* the same.

I was right!

After saving the stash I take a look at the diff: (git stash show -p)

     /*!
-     * \brief The default font renderer, global to all who have a pointer to
-     * the Game class.
+     * \brief The font renderer implementation, obtained from the config file.
+     *
+     * It should be used and passed along to member objects by GameStates!
      *
-     * It need not be used at all!
+     * \note It can be cached, but not between GameStates, meaning it should be
+     * cached again every time a new GameState is constructed!
      */

After that, I take a look at the diff in my index: (git diff --staged)

     /*!
-     * \brief The default font renderer, global to all who have a pointer to
-     * the Game class.
+     * \brief The font renderer implementation, obtained from the config file.
      *
-     * It need not be used at all!
+     * It should be used and passed along to member objects by GameStates!
+     *
+     * \note It can be cached, but not between GameStates, meaning it should be
+     * cached again every time a new GameState is constructed!
      */

Aha! A difference, a difference so tiny it went unnoticed by me, but not by git!

Now the housekeeping:

What I wanted to do:

Apply a stash on top of a 'kept' index.

What I did:

git stash save --keep-index
git stash pop

What I saw happen:

A merge conflict between the same changes (see above).

What I expected to see:

No merge conflict.

How are these different:

The conflict, which shouldn't happen since the changes introduced were the same!

-------------------------------------------------

It seems to me like the stash command is using a slightly different
diff algorithm...
Can anyone explain to me what's going on under the hood so I can
understand this subtle difference? Does anyone know?

Thanks in advance, I'm sure you all will be very helpful!
- Luke
