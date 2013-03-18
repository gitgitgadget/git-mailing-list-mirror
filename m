From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [RFC/PATCH] Documentation/technical/api-fswatch.txt: start with outline
Date: Mon, 18 Mar 2013 13:54:03 +0530
Message-ID: <CALkWK0=0+HYn=bSrGC5sMQOE-53As0h9dG3N9wvUB2=NW3=98A@mail.gmail.com>
References: <1362946623-23649-1-git-send-email-artagnon@gmail.com>
 <513FB85C.5010106@gmail.com> <CACsJy8CBru+Z0+oYVKGdwjiF4DDH3w4vCjunaoCnoDQ6AizwWg@mail.gmail.com>
 <5140BC80.4000201@gmail.com> <7vtxof146d.fsf@alter.siamese.dyndns.org> <87ehffv30f.fsf@pctrast.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Karsten Blees <karsten.blees@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>, Git List <git@vger.kernel.org>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Robert Zeh <robert.allan.zeh@gmail.com>,
	Jeff King <peff@peff.net>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Drew Northup <n1xim.email@gmail.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Mar 18 09:24:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UHVNE-0007uQ-L1
	for gcvg-git-2@plane.gmane.org; Mon, 18 Mar 2013 09:24:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752382Ab3CRIYZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Mar 2013 04:24:25 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:41598 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752320Ab3CRIYX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Mar 2013 04:24:23 -0400
Received: by mail-ie0-f174.google.com with SMTP id k10so6527382iea.5
        for <git@vger.kernel.org>; Mon, 18 Mar 2013 01:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=+NN9anfIGQDrBGec8s1IM0DEuXGpf8/a0v3dG8e7YTw=;
        b=zQwPy76GSvFcwddJFg8H4WGBC2GceXJiaZVnFPnwDzpurlhVTIrt/1E6vdR04IE9Wl
         YZXPnilmE527PnutbEE16oaZbzE3+WYurXAEc5hfQAkc7yzpue5UwaFRKSbHKW6O5+gJ
         76qoGAiPbu9+AoC4fNqL2f3n6qVkyF38AwFp09B3K8WvJ3QX3dse6s4JvFPVnwP7tFEG
         XB/5QJoSfB5IgQ79BwIPtpJcONzZ4oL3H0QO650nJBhdfAyrG6VGrwp12LhmfltyeKIj
         VwgnlV1XH9GN7hzGbk5lGtxYK0Juv/4eT9QhZlTu5ALnZO2dR1PlrhqM53aKqQfgC9pM
         njFw==
X-Received: by 10.50.17.166 with SMTP id p6mr5594960igd.12.1363595063483; Mon,
 18 Mar 2013 01:24:23 -0700 (PDT)
Received: by 10.64.166.33 with HTTP; Mon, 18 Mar 2013 01:24:03 -0700 (PDT)
In-Reply-To: <87ehffv30f.fsf@pctrast.inf.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218397>

Junio C Hamano wrote:
> Yes, and you would need one inotify per directory but you do not
> have an infinite supply of outstanding inotify watch (wasn't the
> limit like 8k per a single uid or something?), so the daemon must be
> prepared to say "I'll watch this, that and that directories, but the
> consumers should check other directories themselves."
>
> FWIW, I share your suspicion that an effort in the direction this
> thread suggests may end up duplicating what the caching vfs layer
> already does, and doing so poorly.

Thomas Rast wrote:
>   $ cat /proc/sys/fs/inotify/max_user_watches
>   65536
>   $ cat /proc/sys/fs/inotify/max_user_instancest
>   128

>From Junio's and Thomas' observations, I'm inclined to think that
inotify is ill-suited for the problem we are trying to solve.  It is
designed as a per-directory watch, because VFS can quickly supply the
inodes for a directory entry.  As such, I think the ideal usecase for
inotify is to execute something immediately when a change takes place
in a directory: it's well-suited for solutions like Dropbox (which I
think is poorly designed to begin with, but that's offtopic).  It
doesn't substitute of augment VFS caching.  I suspect the VFS cache
works by caching the inodes in a frequently used directory entry, thus
optimizing calls like lstat() on them.

The correct solution for our problem is to get VFS to recognize our
repository as a unit: the repository is not a bunch of frequently-used
directory entries, but a frequently-used unit in itself.  We need an
optimization that will work on recursively on a directory entry.
However, since the repository is a special usecase, I suspect adding
an rwatch() system call (or similar) will be necessary to register the
repository with VFS.  The design of this feature should be transparent
to userland, and their filesystem calls will be optimized magically.
We certainly don't need something as fine-grained as inotify to
perform these optimizations: if the tree hash of a registered
repository changes frequently enough, we have to optimize operations
on that directory tree (recursively).

Inputs from btrfs/ vfs hackers would be appreciated.  I'll take out
some time to look at them myself this week.
