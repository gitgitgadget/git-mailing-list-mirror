From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Reset sometimes updates mtime
Date: Thu, 09 Jul 2015 10:56:57 -0700
Message-ID: <xmqqa8v5w6xi.fsf@gitster.dls.corp.google.com>
References: <1436450534.15519.49.camel@kaarsemaker.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git <git@vger.kernel.org>
To: Dennis Kaarsemaker <dennis@kaarsemaker.net>
X-From: git-owner@vger.kernel.org Thu Jul 09 19:59:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZDG6G-0006DK-BR
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jul 2015 19:59:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754239AbbGIR7D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jul 2015 13:59:03 -0400
Received: from mail-ig0-f169.google.com ([209.85.213.169]:35604 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753203AbbGIR5A (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jul 2015 13:57:00 -0400
Received: by igcqs7 with SMTP id qs7so85561156igc.0
        for <git@vger.kernel.org>; Thu, 09 Jul 2015 10:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=g8lzLMu9j/yCVGbbW5EwH+H4fVWG0LXFyB7nz4u+wRg=;
        b=kTqUogFiNzDc+VZsuJJzcOJLrKw4cWzc0s2IHWa44/BwB/hoWnbGW7w8BenOXm0GFm
         TiKBDwi+ZKPiOsNzMumWVHNFbEqE9BQKiPiYLr/a27liiMl1M0d6MTNHQcpXnQjFyTwx
         IS7Y8XFXMoKRH03LrLeTWR9TZLDbx679FgxFyMUvLelfJzAjesol9AjHzc+2aBkAjgfI
         aiiKRk1r7EY6OuSxHOZCSyVGagkczQB/TT8TYjWj4T2LZ4XlBJNptcoMIq/Iaj3AQB1G
         FCaJzihdIzGAyBCIOrs74AAM92WVcYTv6Hlz3CjWPWjlvKv4qu6XXLGmVNFbc0Fq8VEE
         SIog==
X-Received: by 10.107.30.195 with SMTP id e186mr29036704ioe.57.1436464620182;
        Thu, 09 Jul 2015 10:57:00 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:647a:d824:a8a3:7bb0])
        by smtp.gmail.com with ESMTPSA id y98sm4656452ioi.25.2015.07.09.10.56.59
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 09 Jul 2015 10:56:59 -0700 (PDT)
In-Reply-To: <1436450534.15519.49.camel@kaarsemaker.net> (Dennis Kaarsemaker's
	message of "Thu, 09 Jul 2015 16:02:14 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273765>

Dennis Kaarsemaker <dennis@kaarsemaker.net> writes:

> I'm seeing some behaviour with git reset that I find odd. Basically if I
> do
>
> git fetch && \
> git reset --hard simple-tag-that-points-to-the-current-commit
>
> sometimes the reset will update the mtime of all files and directories
> in the repo and sometimes it will leave them alone. Changing it to
>
> git fetch && \
> git status && \
> git reset --hard simple-tag-that-points-to-the-current-commit
>
> Cause the mtime update to reliably not happen.

If my theory on what is happening is correct, I do not think there
is any bug in what "reset --hard" is doing.

My theory is that something is causing the stat info that is cached
in your index and the lstat(2) return you get from your working tree
files go out of sync.  Even though you are not actively touching any
working tree files (otherwise, you wouldn't be complaining about
mtime changing in the first place), perhaps your build of Git
records timestamps in NS but your filesystem and the operating
system does not preserve nanosecond resolution of timestamps when it
evicts inode data from the core, or something like that?  If that is
what is happening, I think that "fetch" is a red herring, but any
operation that takes some time and/or hits filesystem reasonably
hard would trigger it.

And the reason why I say there is no bug in what "reset --hard" is
doing here, if the above theory is correct, is because:

 - The user asked "reset --hard" to "make sure that my working tree
   files are identical to those of HEAD";

 - "reset --hard" looks at lstat(2) return and the cached stat info
   in the index and find them not to match.  It can do one of two
   things:

   (1) see if the user did something stupid, like "touch file", that
       modifies only lstat(2) info without actually changing its
       contents, by reading from the working tree, reading HEAD:file
       from the object database, and comparing them, and overwrite
       the working tree file only when they do not match.

       or

   (2) the contents might happen to be the same, but the end result
       user desires to have is that the contents of the working tree
       file is the same as that from the HEAD, so overwrite it
       without wasting time reading two and compare before doing so.

   and it is perfectly reasonable to do the latter.  After all, the
   whole point of having its cached lstat(2) data in the index is to
   so that we do not have to always compare the contents before
   deciding something has changed in the working tree.

Running "git update-index --refresh" immediately before "reset" may
alleviate the issue.  "git status" has the same effect, only because
it does "update-index --refresh" at the beginning of its processing,
but it wastes a lot more time and resource doing other things.

But unless/until you know _why_ the cached stat info in your index
goes stale relative to what lstat(2) tells you, it would not "solve"
it, because that magical thing (and my theory is cached data in your
operating system that keeps a file timestamp with more precision
than your underlying filesystem can represent is being flushed, and
reading the file timestamp back from the disk has to truncate the
nanoseconds part) can happen at any time between the "--refresh" and
your "reset".
