From: Levin Du <zslevin@gmail.com>
Subject: Re: Questions about git-push for huge repositories
Date: Mon, 7 Sep 2015 11:51:52 +0800
Message-ID: <CAN6cQGNGP+n3L=tuRCymOTWFCnFNsq-tFHkaNm+W=o726mjmmw@mail.gmail.com>
References: <CAN6cQGPcGpaXUGu_7aaeJtMbruMocte-5po97vG5r39f=YdTZQ@mail.gmail.com>
	<xmqq4mj7bfsf.fsf@gitster.mtv.corp.google.com>
	<CAN6cQGMf089ERn2kZbFpHJ6vyJ4BnjCm-m-E+hQsduH55XFvKw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 07 05:51:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZYnTK-0007gk-D1
	for gcvg-git-2@plane.gmane.org; Mon, 07 Sep 2015 05:51:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753549AbbIGDvy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Sep 2015 23:51:54 -0400
Received: from mail-vk0-f53.google.com ([209.85.213.53]:32840 "EHLO
	mail-vk0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751240AbbIGDvx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Sep 2015 23:51:53 -0400
Received: by vkbf67 with SMTP id f67so36910584vkb.0
        for <git@vger.kernel.org>; Sun, 06 Sep 2015 20:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=yVRRbkbtmSI3B1OGEmOfAtIIqctr6fpLJGCjnwpVdS8=;
        b=IyGPIVHF2kvf+XukQ6dAhzXSsRLSPqPNjVtKF0UIgACub+LsZY/dz4fc5Q7A10z7iM
         Ie+jhkFmLuKnCtxCFdRdk46kgy3iTNvOXjz5aQE1eNyVROnVrx71GVhor356WL9AIZJG
         KjHVLPS3svK8lFNbAKUSlDoihcIacMSmV/ZfeJ72Ch8ZTIw7U/Fq5qgR3vpLhbMXDNb/
         esRMpq4KZG3vA+4O8ZUVvMF2uE5rN2IvmduOZCqGrk7blEhHH1O6ZhNE8XRts19LzR9q
         EOT/U12+Mdxjklt3OqInIf83STWfdmRwiKxaWUwU82MD7QHTDjBvdLaL7kof+i9Vg1Ly
         uQOA==
X-Received: by 10.52.97.106 with SMTP id dz10mr22982607vdb.66.1441597912204;
 Sun, 06 Sep 2015 20:51:52 -0700 (PDT)
Received: by 10.103.85.138 with HTTP; Sun, 6 Sep 2015 20:51:52 -0700 (PDT)
In-Reply-To: <CAN6cQGMf089ERn2kZbFpHJ6vyJ4BnjCm-m-E+hQsduH55XFvKw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277443>

I try to use 'git replace --graft' to work aroud this. Here's the process:
  cd A
  fetch ../B master:master_b
  git replace --graft master_b master_a
  # now master_b's parent is master_a

  # do a filter-branch to make the stone solid
  git filter-branch --tag-name-filter cat -- master_a..master_b

  # prune all the old refs and do gc
  git replace -d <origin_commit_of_master_b>
  git update-ref -d refs/original/refs/heads/master_b
  git reflog expire --expire=now --all
  git gc --prune=now --aggressive

And I'd like to make master_b look orphan, so using 'git replace' again:
   git replace --graft master_b
   git log master_b
   # only show one commit, fine
   git push /path/to/public/A master_b
   # small amount of data pushed
   du -hs  /path/to/public/A
   # 6.2 GiB

All are fine, except when I want to push the replace ref:
   git push /path/to/public/A 'refs/replace/*'

It pushes 6 GiB data again.

So right now, 'git replace --graft master_b' needs to run by users
if they need a tidy history view.
