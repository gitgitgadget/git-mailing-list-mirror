From: Craig Silverstein <csilvers@khanacademy.org>
Subject: Are simultaneous fetches safe?
Date: Fri, 19 Dec 2014 11:17:53 -0800
Message-ID: <CAGXKyzFfzxwhQJJWXqivU2U940Pq3my_gTKS6RJzfO_OVsOygg@mail.gmail.com>
Reply-To: csilvers@khanacademy.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 19 20:18:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y233n-0003rd-Lx
	for gcvg-git-2@plane.gmane.org; Fri, 19 Dec 2014 20:18:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751384AbaLSTRz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Dec 2014 14:17:55 -0500
Received: from mail-ig0-f175.google.com ([209.85.213.175]:50815 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751156AbaLSTRy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Dec 2014 14:17:54 -0500
Received: by mail-ig0-f175.google.com with SMTP id h15so1169864igd.14
        for <git@vger.kernel.org>; Fri, 19 Dec 2014 11:17:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=khanacademy.org; s=google;
        h=mime-version:reply-to:date:message-id:subject:from:to:content-type;
        bh=nmtC7lgywfiO3tt8/sqIIDMcGQNDaw3qXMzgVsffVDk=;
        b=O9gva5phfG0nOE7HmhIVdmQNDx0TMRNZd2N6BXzRHO8YpRZCLnk1yVcFvQ6z9HyOOQ
         GZS812buA4L7V+u0Wrdj+5M3FvIl4QDKrh6Bupf13wu3IMuqZebcfLDqcMfx0wLr8MV/
         XmkWmiQEtGsQNFKvMbD0FHBXyzTjCoIDMFzG8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:reply-to:date:message-id:subject
         :from:to:content-type;
        bh=nmtC7lgywfiO3tt8/sqIIDMcGQNDaw3qXMzgVsffVDk=;
        b=gryK7DN0zvrKbRQ89kePA3+XjVsEWx/sAPHsm3AWSV8wI0VWsQ9kEJBN83Z8Q3U9b7
         iAzzMj/L9Exqem1FHrHwCR8d5Ljm/8DPfzQDnf+QoezOQHhGbJBTVhNtedvHBdvuCJej
         idPsyf+Hjw37fgd+Hdk99n7QVFruLR2b5I2e0KJk0N4MO2nYPgXA/u0bhN2A6kLS8Irm
         MJa/waeLH/+JFOqCiymLrkWFvFUZGXJI52/Wyp+o52UAUxI3USImmJa5dd5Z0ZLFSSYo
         n2qlK/lxh+NG/6dnrwMttNTvXlONso8srgWcNKb5+4cliMJ+HIBjlGk+t0eIUsSb92VR
         jG7g==
X-Gm-Message-State: ALoCoQmhOBCRXOgLmPWELHNKOLI5tcNq1HVw7q9hvkh0cNwZWg+tklfl3dSyau0AXPnON574moeb
X-Received: by 10.50.127.241 with SMTP id nj17mr4820680igb.22.1419016673894;
 Fri, 19 Dec 2014 11:17:53 -0800 (PST)
Received: by 10.107.7.159 with HTTP; Fri, 19 Dec 2014 11:17:53 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261585>

(Separated out from another thread since this issue seems more general.)

I am planning to use 'git new-workdir', which basically lets several
workspaces share a single .git/refs directory. (Among other dirs in
.git) It's possible that I'll end up running 'git fetch' in these
workspaces simultaneously, meaning they'll be trying to update
.git/ref at the same time.  Is this safe?  I know there's a push-lock,
but there doesn't seem to be a fetch-lock.

When I tried it, I got some errors:

Running 'git fetch' in window 1:
---
khan% git fetch origin
remote: Counting objects: 37, done.
remote: Compressing objects: 100% (37/37), done.
remote: Total 37 (delta 11), reused 0 (delta 0)
Unpacking objects: 100% (37/37), done.
From github.com:Khan/webapp
   1f893f3..a9d6739  master     -> origin/master
   2641d9f..b630758  athena     -> origin/athena
 + 2a83b90...b7ca8be chris      -> origin/chris  (forced update)
   0e74194..a9d6739  sat        -> origin/sat
 * [new tag]         gae-1219-0726-b7ca8bef9b50 -> gae-1219-0726-b7ca8bef9b50
 * [new tag]         gae-1219-0908-a9d67391b44c -> gae-1219-0908-a9d67391b44c
---

Running 'git fetch' in window2 at the same time, in the same directory:
---
khan% git fetch origin
error: Ref refs/remotes/origin/master is at
a9d67391b44cc8df8336afbc0b0a53691eae1bd4 but expected
1f893f3a4d78012964fc7fb93d1f61eacb1b4858
From github.com:Khan/webapp
 ! 1f893f3..a9d6739  master     -> origin/master  (unable to update local ref)
error: Ref refs/remotes/origin/athena is at
b63075834f77e494c56aade8ef8d7154f174865c but expected
2641d9ff052769aca8919c5528f02d65210a12cf
 ! 2641d9f..b630758  athena     -> origin/athena  (unable to update local ref)
error: Ref refs/remotes/origin/chris is at
b7ca8bef9b5011aa763104f1193b60dd91e0ba0c but expected
2a83b9042cfd1d73970cf0333910f4db978fbc71
 ! 2a83b90...b7ca8be chris      -> origin/chris  (unable to update local ref)
error: Ref refs/remotes/origin/sat is at
a9d67391b44cc8df8336afbc0b0a53691eae1bd4 but expected
0e74194f8a07a13dbae023f88d9cdf2ddcc3566f
 ! 0e74194..a9d6739  sat        -> origin/sat  (unable to update local ref)
 * [new tag]         gae-1219-0726-b7ca8bef9b50 -> gae-1219-0726-b7ca8bef9b50
 * [new tag]         gae-1219-0908-a9d67391b44c -> gae-1219-0908-a9d67391b44c
---

Are these errors benign, or is there the risk of corruption of some
kind?  Is there the possibility of corruption in other dirs as well,
such as .git/objects?

Is it possible that both fetch's could prompt a gc run, and if so, is
there a risk that two gc's running simultaneously could cause
problems?

(Here's the full list of .git dirs shared across workspaces, according
to https://github.com/git/git/blob/master/contrib/workdir/git-new-workdir):
   config refs logs/refs objects info hooks packed-refs remotes rr-cache svn

Thanks,
craig
