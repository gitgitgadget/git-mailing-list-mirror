From: Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: Reset sometimes updates mtime
Date: Fri, 10 Jul 2015 09:30:57 +0200
Message-ID: <1436513457.9537.28.camel@kaarsemaker.net>
References: <1436450534.15519.49.camel@kaarsemaker.net>
	 <xmqqa8v5w6xi.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 10 09:31:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZDSm3-0007Pn-L7
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jul 2015 09:31:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753276AbbGJHbE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jul 2015 03:31:04 -0400
Received: from mail-wi0-f175.google.com ([209.85.212.175]:38772 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753172AbbGJHbB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jul 2015 03:31:01 -0400
Received: by wicmv11 with SMTP id mv11so6804778wic.1
        for <git@vger.kernel.org>; Fri, 10 Jul 2015 00:31:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-type:mime-version:content-transfer-encoding;
        bh=SW9e/dwpdQas6vfIpU/M5gsFdddFIf1Gfs5pHkIOrSA=;
        b=WEl0LRlxIVeJOsQMr0TucXuZB0ZuS3W8Svv/u6cxxWkVYy0ugKQ0DtcgWF0F2et+e6
         7CUM13t9+rvyclnX2C57QDAGydbQCEVSRruKfU1Hg3s+sDuhi16enYKR2hSOOpZOJysc
         0YVN9/hw89tEatnU9gKLXi6TIGD2ynpg4eN3jOK73vihpKG6ZHJPvsbb69N53FQD/VJt
         NqQ8BgK69BzLHwmWaw+r4CjKYkjCefZKeeXe7Z6cStOXcdgCc6n0Majc+29mpLNSME/8
         9JjetxjeJ3Z/AlzJPKnS+N4HP9rqlwpXsksfNcDjSCTDC/NyGWe/ro3R8zFB0kVl4IEA
         fsYA==
X-Gm-Message-State: ALoCoQmkv1rtBXzkjT2B7icysTG5QWZChO+LzyrtncxhZBXCNYyaCDWH7zlUEVi5xJ7BlcnO4pyt
X-Received: by 10.180.76.193 with SMTP id m1mr3515167wiw.11.1436513460170;
        Fri, 10 Jul 2015 00:31:00 -0700 (PDT)
Received: from spirit.home.kaarsemaker.net (82-171-80-33.ip.telfort.nl. [82.171.80.33])
        by smtp.gmail.com with ESMTPSA id dz4sm1581869wib.17.2015.07.10.00.30.58
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Jul 2015 00:30:59 -0700 (PDT)
In-Reply-To: <xmqqa8v5w6xi.fsf@gitster.dls.corp.google.com>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273806>

On do, 2015-07-09 at 10:56 -0700, Junio C Hamano wrote:
> Dennis Kaarsemaker <dennis@kaarsemaker.net> writes:
> 
> > I'm seeing some behaviour with git reset that I find odd. Basically if I
> > do
> >
> > git fetch && \
> > git reset --hard simple-tag-that-points-to-the-current-commit
> >
> > sometimes the reset will update the mtime of all files and directories
> > in the repo and sometimes it will leave them alone. Changing it to
> >
> > git fetch && \
> > git status && \
> > git reset --hard simple-tag-that-points-to-the-current-commit
> >
> > Cause the mtime update to reliably not happen.
> 
> If my theory on what is happening is correct, I do not think there
> is any bug in what "reset --hard" is doing.
> 
> My theory is that something is causing the stat info that is cached
> in your index and the lstat(2) return you get from your working tree
> files go out of sync.  Even though you are not actively touching any
> working tree files (otherwise, you wouldn't be complaining about
> mtime changing in the first place), perhaps your build of Git
> records timestamps in NS but your filesystem and the operating
> system does not preserve nanosecond resolution of timestamps when it
> evicts inode data from the core, or something like that?  If that is
> what is happening, I think that "fetch" is a red herring, but any
> operation that takes some time and/or hits filesystem reasonably
> hard would trigger it.
> 
> And the reason why I say there is no bug in what "reset --hard" is
> doing here, if the above theory is correct, is because:
> 
>  - The user asked "reset --hard" to "make sure that my working tree
>    files are identical to those of HEAD";
> 
>  - "reset --hard" looks at lstat(2) return and the cached stat info
>    in the index and find them not to match.  It can do one of two
>    things:
> 
>    (1) see if the user did something stupid, like "touch file", that
>        modifies only lstat(2) info without actually changing its
>        contents, by reading from the working tree, reading HEAD:file
>        from the object database, and comparing them, and overwrite
>        the working tree file only when they do not match.
> 
>        or
> 
>    (2) the contents might happen to be the same, but the end result
>        user desires to have is that the contents of the working tree
>        file is the same as that from the HEAD, so overwrite it
>        without wasting time reading two and compare before doing so.
> 
>    and it is perfectly reasonable to do the latter.  After all, the
>    whole point of having its cached lstat(2) data in the index is to
>    so that we do not have to always compare the contents before
>    deciding something has changed in the working tree.
> 
> Running "git update-index --refresh" immediately before "reset" may
> alleviate the issue.  "git status" has the same effect, only because
> it does "update-index --refresh" at the beginning of its processing,
> but it wastes a lot more time and resource doing other things.
> 
> But unless/until you know _why_ the cached stat info in your index
> goes stale relative to what lstat(2) tells you, it would not "solve"
> it, because that magical thing (and my theory is cached data in your
> operating system that keeps a file timestamp with more precision
> than your underlying filesystem can represent is being flushed, and
> reading the file timestamp back from the disk has to truncate the
> nanoseconds part) can happen at any time between the "--refresh" and
> your "reset".

Thanks Junio!

If I understand you correctly, reset should not touch files if it thinks
they are up-to-date, so at least that assumption is safe to make. I'll
test your theory about why reset thinks all the files are outdated.

I did notice 'fetch' updates the index (well, mtime of .git/index
changes, I didn't look at index content yet), so maybe fetch isn't quite
a red herring. I'll try to eliminate this variable as well.
 
-- 
Dennis Kaarsemaker
www.kaarsemaker.net
