From: Stephen Morton <stephen.c.morton@gmail.com>
Subject: Sample pre-push hook can crash
Date: Thu, 10 Mar 2016 16:22:14 -0500
Message-ID: <CAH8BJxHeyfpKsvjGfg5ZJ5YDQk6pzZp4ufHVEV=cFriL8j_4uw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Mar 10 22:22:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ae82G-0005pN-98
	for gcvg-git-2@plane.gmane.org; Thu, 10 Mar 2016 22:22:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932359AbcCJVWR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Mar 2016 16:22:17 -0500
Received: from mail-wm0-f45.google.com ([74.125.82.45]:33814 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932216AbcCJVWQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Mar 2016 16:22:16 -0500
Received: by mail-wm0-f45.google.com with SMTP id p65so4657143wmp.1
        for <git@vger.kernel.org>; Thu, 10 Mar 2016 13:22:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to;
        bh=2ttCW7OCWEKekJEZ7uOZdqsfLQnINoI9H/MdLCWBFqg=;
        b=S9K/AVgUBRp9XuWYegG8OX9f6mNUnmsochPoOAUybVAzJty5dNS+Xanloi5SVHa6zt
         zOKdx0yDhKsyeqYD2YDNA2Kp8B8CI4pmu3u7VP0h+nXJkrhMN6YBqnPFBcUQvbdxF/up
         vAADz1XHxnqIfrCiaFHSKTj8bhV3/7MhiT8pIqhEaPPNLScVv2SweX1wGOIK87vu1wzF
         hk9m+DdP3kr3EDsR9aBQ/4Y9B26a/aPG+RbyWU1jOiy99ZGqubVdgVMWRHVCXf9Nlfpi
         u3IoLNgziSkecFHswVofKehaThwrRt0atw/tM6EkA574HfjoG7UMz3EUjHiCEYZKGvgn
         31Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=2ttCW7OCWEKekJEZ7uOZdqsfLQnINoI9H/MdLCWBFqg=;
        b=GVjeQ9Sf3ckE0Cq4yhRIIOgkHQ3avGARtDppGylZ6zFa/ezTjH7wucSNG2k3zMYvce
         M1DsPc2guBrySW0te8iOutwbr29yCUsmKIQKQNNlDGVvxc4KiLVrbn+xkgXLjgGix7Z/
         98kQRJfftyrn14IosUZTOCOPbNaj+Q7Nip+FwfyjlIYomv4HSSw7OGmV/GgEr1fvynGJ
         iGPVc6T7bupo/fTAwizeN8+Hh9oks+DZQAIf61S+O/bX8WB0UtgmDLsrzh7ALZsDXz4j
         PmWkBY56CMqJs7RTwFeohfCL0aFUffWuJz5o1HFX3O+XNpjjKRv29TmAD8Thmsc51EyJ
         KZsw==
X-Gm-Message-State: AD7BkJL7eqBfTJJ2JEu0bzCQEmjLbjVIRRx1xmvYv+gb+LxjxGkpOUmBeYfq0M1n5QqSUZBRFG6CIrA6eLshZw==
X-Received: by 10.194.8.38 with SMTP id o6mr6239193wja.31.1457644934740; Thu,
 10 Mar 2016 13:22:14 -0800 (PST)
Received: by 10.194.63.82 with HTTP; Thu, 10 Mar 2016 13:22:14 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288642>

The sample pre-push hook provided with git [1] will crash if the local
repo is not up to date with the remote as $remote_sha is not present
in the local repo. I'm not sure if this patch is exactly correct, it's
just provided as an example.

Given that people are likely crafting their own solutions based on the
examples, it's probably good to get right.

diff --git a/templates/hooks--pre-push.sample b/templates/hooks--pre-push.sample
index 6187dbf..99ed984 100755
--- a/templates/hooks--pre-push.sample
+++ b/templates/hooks--pre-push.sample
@@ -36,9 +36,9 @@ do
                        # New branch, examine all commits
                        range="$local_sha"
                else
                        # Update to existing branch, examine new commits
-                       range="$remote_sha..$local_sha"
+                       range="@{u}..$local_sha"
                fi

                # Check for WIP commit
                commit=`git rev-list -n 1 --grep '^WIP' "$range"`


(This is just something I noticed and thought you might be interested
in, but is not important to me. I actually do care about the smudge
filter issue.)

Stephen

[1] https://github.com/git/git/blob/master/templates/hooks--pre-push.sample
