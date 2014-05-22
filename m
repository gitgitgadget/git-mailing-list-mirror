From: David Turner <dturner@twopensource.com>
Subject: Re: git reset for index restoration?
Date: Thu, 22 May 2014 14:17:22 -0400
Organization: Twitter
Message-ID: <1400782642.18134.8.camel@stross>
References: <1400775763.1933.5.camel@stross>
	 <CABPp-BHtYnput7SiAbnqUjpDibTi5o_2MAXfSj17fCdKSC7Hjg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git mailing list <git@vger.kernel.org>
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 22 20:17:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WnXYZ-0006md-Mk
	for gcvg-git-2@plane.gmane.org; Thu, 22 May 2014 20:17:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750922AbaEVSR1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 May 2014 14:17:27 -0400
Received: from mail-qg0-f41.google.com ([209.85.192.41]:37018 "EHLO
	mail-qg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751037AbaEVSRZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 May 2014 14:17:25 -0400
Received: by mail-qg0-f41.google.com with SMTP id j5so6384760qga.28
        for <git@vger.kernel.org>; Thu, 22 May 2014 11:17:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:content-transfer-encoding
         :mime-version;
        bh=aRqt3R95sFK2cKpWieXTvgslQffLpUPNIHrJ6+BTSC8=;
        b=HqUXAyIgtMpDGB6DsL6C+r42ytLVpyN6Ts7ycvqZ0j/jj8eF5m6/6muWgjsKHF2itQ
         Dsj2+TGInUD4VQrx9SLJInJt+ibfdjYtw28gEiYFdNH/C4U87egY8El51cu3haxnjsbV
         MGZc7LzI0ncPkmG/qGyTsVDa3/QsadogqDIdTQ4+NuRMoYRTtnts5CBjIDOCOF+jM41Z
         gaVpQDocSl48M6k2CEtcH44YKoEBjZLF0QCBWYlh+x/874d6F60awao8PomzWxZkZSa7
         NvdmugC5Td39MGBzUmvqa2P+o5jycVu7aDUG1xIJCtVf0X4UtDmUYOZa3mLYu4y7y0Eh
         JF/A==
X-Gm-Message-State: ALoCoQm4sEWYUqoSkQp1E1barAOfW801Q1IRuji9nEFAzUCm3DU5JJ0FRqmGEZhFe1DDTSukpKTI
X-Received: by 10.224.66.193 with SMTP id o1mr82394338qai.43.1400782644762;
        Thu, 22 May 2014 11:17:24 -0700 (PDT)
Received: from [172.17.3.46] ([38.104.173.198])
        by mx.google.com with ESMTPSA id d89sm346121qga.2.2014.05.22.11.17.23
        for <multiple recipients>
        (version=SSLv3 cipher=RC4-SHA bits=128/128);
        Thu, 22 May 2014 11:17:23 -0700 (PDT)
In-Reply-To: <CABPp-BHtYnput7SiAbnqUjpDibTi5o_2MAXfSj17fCdKSC7Hjg@mail.gmail.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249928>

On Thu, 2014-05-22 at 09:46 -0700, Elijah Newren wrote:
> On Thu, May 22, 2014 at 9:22 AM, David Turner <dturner@twopensource.com> wrote:
> > If I have a git repository with a clean working tree, and I delete the
> > index, then I can use git reset (with no arguments) to recreate it.
> > However, when I do recreate it, it doesn't come back the same.  I have
> > not analyzed this in detail, but the effect is that commands like git
> > status take much longer because they must read objects out of a pack
> > file.  In other words, the index seems to not realize that the index (or
> > at least most of it) represents the same state as HEAD.  If I do git
> > reset --hard, the index is restored to the original state (it's
> > byte-for-byte identical), and the pack file is no longer read.
> >
> > Before I try to dig in to why this should be so, does anyone happen to
> > know off the top of their head?  Does this constitute a bug in git, or a
> > bug in my understanding of git?
> 
> It's not a bug.  The index has additional stat-info it tracks about
> files -- inode number, mtime, etc. -- so that it can quickly check
> whether files are up to date without comparing full file contents in
> the working copy to the relevant version from .git/objects.
> 
> 'git reset' means make the index match the commit in HEAD. 

Sure, so why does git status the need to read the pack file, given that
we already know that the index matches HEAD?

>  It implies
> nothing about the working copy files, which could be different.
> Although you say that you have a clean working tree, git doesn't check
> to verify that, so it has to treat these files as stat-dirty until the
> next operation (e.g. git status) fills these in -- an operation that
> involves full comparison of the files in the working copy with the
> relevant version of the file from under .git/objects. (You may find
> 'git update-index --refresh' helpful here.)

In fact, git status does not write the index (at least in this context).
And what is slow is not (only) checking over the working tree, but
reading the packs.  There should be no need to read files from the ODB
at all, since the index knows those objects' SHA1s, and it can check
those against the working tree's SHA1s.  Interestingly, if strace is to
be believed, git status doesn't even do check the working trees SHA1s
after a git reset; maybe reset already sets the stat bits?

So that's why I'm confused.
