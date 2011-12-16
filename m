From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Revisiting metadata storage
Date: Fri, 16 Dec 2011 01:52:51 -0600
Message-ID: <20111216075251.GA4048@elie.hsd1.il.comcast.net>
References: <CAD77+gQB+0zJG62jrtPn_MwLLR7zgH=5gBtkvPxrKgiLPZsbsw@mail.gmail.com>
 <87sjkx8gll.fsf@an-dro.info.enstb.org>
 <CAD77+gR=SjU0Ne9jort91pdHDA=RjkTJUJmnqKBipqoGUmoL_A@mail.gmail.com>
 <CAE1pOi2TGWmFErcKhQu-a37JjLh22O1zFYoBaVRyfBDFjOTE9Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Richard Hartmann <richih.mailinglist@gmail.com>,
	Ronan Keryell <Ronan.Keryell@hpc-project.com>,
	Git List <git@vger.kernel.org>
To: Hilco Wijbenga <hilco.wijbenga@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 16 08:53:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RbSbJ-0008TF-Vx
	for gcvg-git-2@lo.gmane.org; Fri, 16 Dec 2011 08:53:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756160Ab1LPHxA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Dec 2011 02:53:00 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:34146 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751477Ab1LPHw7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Dec 2011 02:52:59 -0500
Received: by yenm11 with SMTP id m11so2021481yen.19
        for <git@vger.kernel.org>; Thu, 15 Dec 2011 23:52:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=BnWGv92416Dl9njMWTlZXzIAZq0oZ35WwwQgkXrX7bU=;
        b=EdyQnei4ZvYxefz3pfMa1xckqoDj2eWMEhVZZqecI1cnVDOCQkvRbfdLe6uuSm4mf1
         du98au1wC9V5EFQ4pdz91zm1daBxQHE5C2zIqvD47GprlvMQ90E/ZjbE0pcYBVAcIb0P
         U+D4zoBVo2nitkhhJznUq7zp0HP7VzH7c6WmA=
Received: by 10.236.22.136 with SMTP id t8mr10793503yht.30.1324021979199;
        Thu, 15 Dec 2011 23:52:59 -0800 (PST)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id q52sm13095008yhh.3.2011.12.15.23.52.56
        (version=SSLv3 cipher=OTHER);
        Thu, 15 Dec 2011 23:52:57 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAE1pOi2TGWmFErcKhQu-a37JjLh22O1zFYoBaVRyfBDFjOTE9Q@mail.gmail.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187264>

Hilco Wijbenga wrote:

>                        Right now every rebase means a full (and almost
> completely unnecessary) rebuild.

It sounds like what you are suffering from is that "git rebase" uses
the worktree as its workspace instead of doing all that work
in-memory, right?

If I were in your situation, I would do the following:

 1. Don't rebase so often.  When wanting to take advantage of features
    from a new upstream version, use "git merge" to pull it in.  Only
    rebase when it is time to make the history presentable for other
    people.

    This way, "git log --first-parent" will give easy access to
    the intermediate versions you have hacked on and tested recently.

 2. When history gets ugly and you want to rebase to make the series
    easier to make sense of, use a separate workdir:

	$ git branch tmp; # make a copy to rebase

	$ cd ..
	$ git new-workdir repo rebase-scratch tmp
	$ cd rebase-scratch
	$ git rebase -i origin/master
	...
	$ cd ..
	$ rm -fr rebase-scratch

	$ cd repo
	$ git diff HEAD tmp;	# Does the rebased version look better?
	$ git reset --keep tmp;	# Yes.  Use it.
	$ git branch -d tmp

 3. Once the rebased history looks reasonably good, be sure to rebase
    one final time and test each commit before submitting for other
    people's use.

Hope that helps,
Jonathan
