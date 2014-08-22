From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Shallow clones with explicit history cutoff?
Date: Fri, 22 Aug 2014 20:27:03 +0700
Message-ID: <CACsJy8CSCcaFNxqqBLAnb5NXkwT+wVXCVmB8uF3RYwqRmz4tuw@mail.gmail.com>
References: <loom.20140821T171416-31@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Matthias Urlichs <matthias@urlichs.de>
X-From: git-owner@vger.kernel.org Fri Aug 22 15:27:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XKosU-0004M7-KB
	for gcvg-git-2@plane.gmane.org; Fri, 22 Aug 2014 15:27:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756296AbaHVN1f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2014 09:27:35 -0400
Received: from mail-ie0-f180.google.com ([209.85.223.180]:36861 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756228AbaHVN1e (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2014 09:27:34 -0400
Received: by mail-ie0-f180.google.com with SMTP id at20so6470350iec.39
        for <git@vger.kernel.org>; Fri, 22 Aug 2014 06:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=oviER27LRcnRxXWAlgcXlvBJFXfBZavGFPciRyfXzJE=;
        b=FlfX8PphR0ApgKiypz7I1qpxlXBTBgpMirEfxV4AnHaMKzDLNuZxF9KYfjaDrXl61a
         Ay1d5XjQi1VWExQxe4Ye3sO/ti/GoF/7sJr2MfkRCgoFFITHY1TyrgMZL2GysvyrmGp+
         +NTdKZdgmGOGVsp70nICqmvu0YMvf0107C/8/GRCeZBg7JLADPlwOz0D7HfCY8Xfa7yL
         4nJ3O/hT65Ai8cQOjl8U4IrvXaIFM/8i4DQPEkdzDFa9xjNYvb8Rz+KAfA7RhOUR9IaD
         ednhZgnD7TJd5p93Xp/N+vW2541tsiqbi+YM/+4W1zOyAoEidv6QCwrydcMci4ATJuXG
         MR6w==
X-Received: by 10.50.61.145 with SMTP id p17mr11210038igr.41.1408714053794;
 Fri, 22 Aug 2014 06:27:33 -0700 (PDT)
Received: by 10.107.13.80 with HTTP; Fri, 22 Aug 2014 06:27:03 -0700 (PDT)
In-Reply-To: <loom.20140821T171416-31@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255669>

On Thu, Aug 21, 2014 at 10:39 PM, Matthias Urlichs <matthias@urlichs.de> wrote:
> What I would like to have, instead, is a version of shallow cloning which
> cuts off not at a pre-determined depth, but at a given branch (or set of
> branches). In other words, given
>
>             +-J--K  (packaged)
>            /    /
>   +-F--G--H----I    (clean)
>  /       /
> A---B---C---D---E   (upstream)
>
> a command "git clone --shallow-until upstream $REPO" (or however that would
> be named) would create a shallow git archive which contains branches
> packaged+clean, with commits FGHIJK. In contrast, with --single-branch and
> --depth 4 I would get CGHIJK, which isn't what I'd want.

I would imagine a more generic mechanism "git clone
--shallow-rev=<rev> $REPO" where you could pass anything that "git
rev-list" can accept (maybe more restricted, and some verification
required). --shallow-rev could be repeated. So in your case it could
be "git clone --shallow-rev="^A" $REPO". We could even maybe turn
--depth into a generic thing that is accepted by rev-list so that it
could be easily combined with other rev-list options (--shallow-rev
and --depth are mutually exclusive).

> As I have not spent too much time with the git sources lately (as in "None
> at all"), some pointers where to start implementing this would be
> appreciated, assuming (a) this has a reasonable chance of landing in git and
> (b) nobody beats me to it. ;-)

I'd like to see this implemented. You are not the first one
complaining about the (lack of) flexibility of --depth. If you have
time, I may be able to support (I should not take on another topic
given my many ongoing/unfinished topics). The starting point is
upload-pack.c. And GIT_TRACE env variable will be your friend. Search
for get_shallow_commits(). There the function is supposed to traverse
down from want_obj and set/unset SHALLOW/NOT_SHALLOW flags  properly.

SHALLOW flag should be set right before the cut-out commit (e.g. B and
F if you want to cut A out). NOT_SHALLOW flags could be used to remove
shallow lines in the receiver repo. If you traverse past an existing
shallow point in the client (this is the fetch/pull case, not clone),
then you should set NOT_SHALLOW so the client knows to remove that
point from their $GIT_DIR/shallow. Once you set these properly, the
rest should work.
-- 
Duy
