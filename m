From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: Cherry-pick with symlinks fails horribly
Date: Fri, 12 Mar 2010 04:48:22 +0100
Message-ID: <201003120448.22821.chriscool@tuxfamily.org>
References: <c6c947f61003081728u48292de4x6f2c26e1ea9c1756@mail.gmail.com> <201003110557.11268.chriscool@tuxfamily.org> <c6c947f61003110416l40a85b6fg7ede2403a8f6961b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Alexander Gladysh <agladysh@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 12 04:51:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NpvuE-0007T9-Of
	for gcvg-git-2@lo.gmane.org; Fri, 12 Mar 2010 04:51:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752014Ab0CLDvG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Mar 2010 22:51:06 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:59472 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751639Ab0CLDvB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Mar 2010 22:51:01 -0500
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 32E9E818039;
	Fri, 12 Mar 2010 04:50:55 +0100 (CET)
Received: from style.localnet (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 1A703818028;
	Fri, 12 Mar 2010 04:50:53 +0100 (CET)
User-Agent: KMail/1.12.2 (Linux/2.6.31-19-generic; KDE/4.3.2; x86_64; ; )
In-Reply-To: <c6c947f61003110416l40a85b6fg7ede2403a8f6961b@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142012>

On Thursday 11 March 2010 13:16:09 Alexander Gladysh wrote:
> On Thu, Mar 11, 2010 at 07:57, Christian Couder <chriscool@tuxfamily.org> 
wrote:
> > On Tuesday 09 March 2010 02:28:30 Alexander Gladysh wrote:
> >> I'm complaining about Git symlink handling again. This time it is
> >>  cherry-pick.
> >
> > I can reproduce the bug here on Linux. And Git v1.6.0 has the same bug.
> > So I suspect an old bug in unpack_trees.c. I will try to have another
> > look at it this evening, but I am not familiar with that code.
> 
> I have found my old bug-report. There is even some patch in that thread.
> 
> http://thread.gmane.org/gmane.comp.version-control.git/120741/
> 
> Not sure if it is the same issue or if the patch was even merged in
>  though...

The patch was merged:

commit 77716755cbdf970fa0814a5f77c884b1f17693de
Author: Kjetil Barvik <barvik@broadpark.no>
Date:   Sun Jun 14 15:08:28 2009 +0200

    lstat_cache: guard against full match of length of 'name' parameter

so I think it is a different issue, but feel free to test.

Anyway when looking at t/t6035-merge-dir-to-symlink.sh, we can see that there 
are still 2 broken tests:

$ ./t6035-merge-dir-to-symlink.sh
*   ok 1: create a commit where dir a/b changed to symlink
*   ok 2: keep a/b-2/c/d across checkout
*   ok 3: checkout should not have deleted a/b-2/c/d
*   ok 4: setup for merge test
*   ok 5: do not lose a/b-2/c/d in merge (resolve)
*   still broken 6: do not lose a/b-2/c/d in merge (recursive)
*   ok 7: setup a merge where dir a/b-2 changed to symlink
*   ok 8: merge should not have conflicts (resolve)
*   still broken 9: merge should not have conflicts (recursive)
* still have 2 known breakage(s)
* passed all remaining 7 test(s)

So it looks like breakages in this area are known, though perhaps not your 
particular breakage.

Best regards,
Christian.
