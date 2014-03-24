From: Scott Sandler <scott.m.sandler@gmail.com>
Subject: Git push race condition?
Date: Mon, 24 Mar 2014 15:18:14 -0400
Message-ID: <CAAyEjTN53+5B9Od9wW698wODNL3hR6Upot8-ZLwEksn3ir_zjA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 24 20:18:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSAOC-0004bJ-3W
	for gcvg-git-2@plane.gmane.org; Mon, 24 Mar 2014 20:18:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753931AbaCXTSU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Mar 2014 15:18:20 -0400
Received: from mail-la0-f52.google.com ([209.85.215.52]:42129 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753928AbaCXTSQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Mar 2014 15:18:16 -0400
Received: by mail-la0-f52.google.com with SMTP id ec20so3975595lab.39
        for <git@vger.kernel.org>; Mon, 24 Mar 2014 12:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=/Cy0NY6uvZ8sG0MYolSprX98jOWfOcTdU6VmeDbcLiI=;
        b=ulTNOzI/cZeMe7eO3GpSUFLu+sY0P32HT9Ii73uGwCVCamf0wIlwxK0Ih4gAS9BCJU
         b7ELZaMEXSx4HcfjMFKSohiszZHzZbLEYN37K1Z4ix1kx36eJXftHY4/SfXL0G2a59gd
         stw03/jDz4ZmhlMIv8Rp/zbpGBG2FL9dM7kfAEJ8LkA9QxEgLeZkg2oPaaYBM2Zn35Jw
         rqi/DLWmTk1NuCnkTKmtijaXOmh5LfM985cK6Kr0u0ecvhdCHw8QaIHygRWV7nFgIQcb
         KONlR+ng7fOYEUHUT3xpN6cJY1qhCHgWa0HP52+TXJ4vnNaAVs9Q5TkW1MvyXOw1ykFv
         h6qQ==
X-Received: by 10.112.118.20 with SMTP id ki20mr2098659lbb.45.1395688694589;
 Mon, 24 Mar 2014 12:18:14 -0700 (PDT)
Received: by 10.114.64.103 with HTTP; Mon, 24 Mar 2014 12:18:14 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244861>

Hi folks,

I run a private Git repository (using Gitlab) with about 200 users
doing about 100 pushes per day.

I've noticed that a few times in the past several weeks, we've had
events where pushes have been lost when two people pushed at just
about the same time. The scenario is that two users both have commits
based on commit A, call them B and B'. The user with commit B pushes
at about the same time as the user who pushes B'. Both pushes are
determined to be fast-forwards and both succeed, but B' overwrites B
and B is no longer on origin/master. The server does have B in its
.git directory but the commit isn't on any branch.

I'm confident nobody is force pushing (we have a hook to disallow it
on master branches and I've seen screenshots of both user's clients
after they pushed). Both git clients say "successfully pushed A..B
master -> master" (or A..B') in the output of their push commands.
However, when the user that had B does a fetch, it shows master as
having been force updated.

We have a few pre-receive hooks and post-receive hooks that run on
pushes, and Gitlab has an update hook as well. My original theory was
that this was happening because Git checks if it's a fast-forward
before running hooks, and that the hooks taking a few seconds creates
more opportunity for a race condition to occur.

However, after reading
http://git.661346.n2.nabble.com/push-race-td7569254.html and doing
some of my own testing (creating a hook that runs for 60 seconds and
pushing from two locations to a test repo) this theory seems to be
wrong. With the 60 second sleep hook (tried as an update hook and a
pre-receive hook), I wasn't able to reproduce the problem. The second
pusher always got an error like this:

error: Ref refs/heads/master is at
4584c1f34e07cea2df6abc8e0d407fe016017130 but expected
61b79b6d35b066d054fb3deab550f1c51598cf5f
remote: error: failed to lock refs/heads/master

Which looks like exactly what I'd want Git to be doing in this
scenario, and supports what that archived thread says about how this
should work.

So the question is, how might this be happening and what can I do about it?

Thanks,
Scott
