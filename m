From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Moving (renaming) submodules, recipe/script
Date: Sun, 6 Jan 2013 17:39:52 -0800
Message-ID: <20130107013952.GE3823@elie.Belkin>
References: <20130107003603.GA25698@odin.tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git <git@vger.kernel.org>, Jens Lehmann <Jens.Lehmann@web.de>,
	Peter Collingbourne <peter@pcc.me.uk>
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Mon Jan 07 02:40:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ts1hQ-0007Wu-5I
	for gcvg-git-2@plane.gmane.org; Mon, 07 Jan 2013 02:40:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753372Ab3AGBj7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jan 2013 20:39:59 -0500
Received: from mail-da0-f47.google.com ([209.85.210.47]:56812 "EHLO
	mail-da0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753362Ab3AGBj6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jan 2013 20:39:58 -0500
Received: by mail-da0-f47.google.com with SMTP id s35so8387521dak.34
        for <git@vger.kernel.org>; Sun, 06 Jan 2013 17:39:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=Eb6GlM56IuhTB6nk5SgRnsftMDlu5ZOHh7LovybHYB0=;
        b=SdN7Zc3ymieZd3pWNhJvBuv0Jy+ToOuwwVht/wVuIGVmGDaSbkn4TbyMYQTxOJ6c7K
         4KlegXApQ/IAfNXY0VJSfoPS/2mCqhliNmwenXXTOBVtF4xEmsSTUjmPe9FFXRvGFnX3
         5iIkZSuI/gMbs2Ok334wUtVMgmc9Z7Dw6PRrYPRTFihKHv7+De9fQb35Kl78IfNC2h+Q
         GgPuBQSfJ8VAd9N819hs8ddjDdXwdVV4Z20RTMOatECi2EKebT5A0uz4vtDXOmY5Yhk6
         txQ91dHRtceFvHh3YfcpbFKwG3MYIdcoMBPtjVrIkQbCXVRdMemViv9xDfUXLqyXTohd
         SI1g==
X-Received: by 10.66.73.132 with SMTP id l4mr173827055pav.48.1357522797267;
        Sun, 06 Jan 2013 17:39:57 -0800 (PST)
Received: from elie.Belkin (c-67-180-61-129.hsd1.ca.comcast.net. [67.180.61.129])
        by mx.google.com with ESMTPS id m3sm37694103pav.4.2013.01.06.17.39.55
        (version=SSLv3 cipher=OTHER);
        Sun, 06 Jan 2013 17:39:56 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20130107003603.GA25698@odin.tremily.us>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212864>

(just cc-ing Jens and Peter, who might be interested)

W. Trevor King wrote:

> Today I had to move my first submodule, and I discovered that Git's
> support for this is pretty limited.  There have been a few patch
> series attempting to address this [1,2], but none of them seems to
> have pushed through into master (although I can't put my finger on a
> reason for why).  There are also some SO postings discussing this
> [3,4].  It would be nice if `git mv` worked out of the box on
> submodules.  Failing that, there could be a `git submodule mv` command
> that casts the appropriate spell.  Failing that, there could be a
> recipe in Documentation/git-submodule.txt.  Here's the best I could
> come up with for a `git-submodule-mv.sh`:
>
>   #!/bin/sh
>   # usage: git-submodule-mv.sh OLD NEW
>   OLD=$(realpath --relative-to . "$1")
>   NEW=$(realpath --relative-to . "$2")
>   SHA=$(git ls-files -s "$OLD" | sed 's|^[0-9]* \([0-9a-f]*\) .*|\1|')
>   NAME=$(git config -f .gitmodules --get-regexp 'submodule\..*\.path' "$OLD" |
>     sed -e 's|^submodule.||' -e "s|.path $OLD\$||")
>   GITDIR=$(realpath --relative-to "$NEW" .git/modules/"$NAME")
>   git config -f .gitmodules submodule."$NAME".path "$NEW"
>   git config -f .git/modules/"$NAME"/config core.worktree "../../../$NEW"
>   git rm --cached "$OLD"
>   mv "$OLD" "$NEW"
>   echo "gitdir: $GITDIR" > "$NEW/.git"
>   git update-index --add --cacheinfo 160000 "$SHA" "$NEW"
>
> This only works from the repository root directory, and I'm sure makes
> a number of poor assumptions (e.g. old-style submodules that don't use
> `gitdir` links are not supported).  It does work for some simple test
> cases.  The tricky parts (e.g. path -> name conversion) are already
> worked out more robustly git-submodule.sh, so adding a new cmd_mv
> shouldn't be very difficult.
>
> Could something like this live somewhere in Git, or are we waiting for
> a more integrated solution?
>
> Cheers,
> Trevor
>
> [1]: http://thread.gmane.org/gmane.comp.version-control.git/88720
> [2]: http://thread.gmane.org/gmane.comp.version-control.git/143250
> [4]: http://stackoverflow.com/questions/4323558/moving-submodules-with-git
> [3]: http://stackoverflow.com/questions/4604486/how-do-i-move-an-existing-git-submodule-within-a-git-repository
