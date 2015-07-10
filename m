From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] ident: support per-path configs by matching the path against a pattern
Date: Fri, 10 Jul 2015 08:10:54 -0700
Message-ID: <xmqqr3ogkpz5.fsf@gitster.dls.corp.google.com>
References: <0000014e7752e758-a0bf7acb-2d0f-4492-8004-8eeeb9b2f042-000000@eu-west-1.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 10 17:11:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZDZx8-0002YK-AU
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jul 2015 17:11:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932151AbbGJPK6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jul 2015 11:10:58 -0400
Received: from mail-ig0-f174.google.com ([209.85.213.174]:34510 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932408AbbGJPK5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jul 2015 11:10:57 -0400
Received: by igoe12 with SMTP id e12so37257701igo.1
        for <git@vger.kernel.org>; Fri, 10 Jul 2015 08:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=8SahXkldja8NgzIoxFCBo8mwAA2HCTm6V2WsteRV3KQ=;
        b=LmSOjajMpn+yGaqQSBtPuf2H0oygo5TAktH/oTY1O8G/HhkEE8DwOLbclQvpxmdSzN
         oHOOSr85gOMRfD5fA8HZRdQvKvECC+8eEtFq2QKPtDw0Kyrdymq6QxIjS14qXP6E4ZxF
         QezMxCxsvb+mC56SlavWwRpRadNiXjTniGcQ2dxYFTFGtyYe/9/2U0AhFHxnAJDvgv88
         Tpnhi4FcVL231XvMxshPROGMwAMNjdhhqUxZXzMvbqtUtObrwpoZ5ON97gFc8gg0vLel
         u50g6BkpvGZdnp7cq7qKvkSL6nclwjjM0QPYC7rhRgZtRG4SlMIyzj4zcXe/UzTBaOSU
         J6SA==
X-Received: by 10.107.134.141 with SMTP id q13mr33905568ioi.91.1436541056573;
        Fri, 10 Jul 2015 08:10:56 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:6de3:8019:a2a4:79ec])
        by smtp.gmail.com with ESMTPSA id i66sm6647294ioe.0.2015.07.10.08.10.54
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 10 Jul 2015 08:10:55 -0700 (PDT)
In-Reply-To: <0000014e7752e758-a0bf7acb-2d0f-4492-8004-8eeeb9b2f042-000000@eu-west-1.amazonses.com>
	(Sebastian Schuberth's message of "Fri, 10 Jul 2015 09:36:38 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273819>

Sebastian Schuberth <sschuberth@gmail.com> writes:

> Support per-path identities by configuring Git like
>
>     $ git config user.<pattern>.email <email address>
>
> e.g.
>
>     $ git config user.github.email sschuberth+github@gmail.com
>
> In this example, the middle "github" pattern is searched for
> case-insensitively in the absolute path name to the current git work tree.

I do agree it is a good feature to have to allow you to keep a
centralized registry of possible configuration in a single place,
e.g. $HOME/.gitconfig, and selectively apply pieces for multiple
places.

Having said that, a few comments.

 - It feels very hacky to only do this for the ident.  You would
   want to have, (conceptually, not necessarily at the syntax level)
   something more along the lines of:

   	if path matches this pattern
        	[user]
                	email = address
                        name = name
	end

   to allow any configuration to be covered by this new "selectively
   use from the centralized registry" feature.

 - It is iffy to match the pattern with "working tree".  There are
   pros and cons but a viable alternative would be to match with the
   location of the $GIT_DIR.  Given that we now are slowly moving to
   a world where a single $GIT_DIR can have multiple working trees,
   and that user.name ultimately matters per-project you are
   contributing to, it is more likely that you would want to tie it
   to a local repository, i.e. $GIT_DIR, no matter where working
   trees you have a checkout out of that repository live.  They
   would want to share the same setting.

   On the other hand, some things may be truly per working tree even
   if it is tied to the same local repository.

   I am not saying it is better to tie this to $GIT_DIR not
   $GIT_WORK_TREE.  I am not necessarily saying we should support
   both.  I am only saying that we need to consider if tying only to
   $GIT_WORK_TREE makes sense (and if so, clearly communicate that
   to the end users).  I couldn't read from your patch [*1*] what
   your stance on this point.

 - The pattern defined to be case-insensitive substring would not be
   a sane general design.  I would have expected it to be fnmatch
   pattern that may match case insensitively only on case insensitive
   filesystems.


[Footnote]

*1* this is one of the reasons why I usually ignore "I'll do the doc
and test if people agree it is a good idea."  Often, we cannot judge
if it is a good idea without these things.
