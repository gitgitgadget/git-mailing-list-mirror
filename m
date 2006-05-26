From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: [PATCH] cvsimport: introduce -L<imit> option to workaround memory leaks
Date: Fri, 26 May 2006 18:02:30 +1200
Message-ID: <46a038f90605252302v5ff1a3a8vb4053b7da8eb7a68@mail.gmail.com>
References: <11482978883713-git-send-email-martin@catalyst.net.nz>
	 <Pine.LNX.4.64.0605221926270.3697@g5.osdl.org>
	 <46a038f90605251742p2435ae23k8bfbb98409a30c1c@mail.gmail.com>
	 <Pine.LNX.4.64.0605252204590.5623@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Cc: "Martin Langhoff" <martin@catalyst.net.nz>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Junio C Hamano" <junkio@cox.net>, Johannes.Schindelin@gmx.de,
	spyderous@gentoo.org, smurf@smurf.noris.de
X-From: git-owner@vger.kernel.org Fri May 26 08:02:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FjVP8-0002p2-Dj
	for gcvg-git@gmane.org; Fri, 26 May 2006 08:02:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030458AbWEZGCb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 May 2006 02:02:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030485AbWEZGCb
	(ORCPT <rfc822;git-outgoing>); Fri, 26 May 2006 02:02:31 -0400
Received: from wr-out-0506.google.com ([64.233.184.228]:53907 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1030458AbWEZGCb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 May 2006 02:02:31 -0400
Received: by wr-out-0506.google.com with SMTP id i7so316956wra
        for <git@vger.kernel.org>; Thu, 25 May 2006 23:02:30 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tkikh4mLARzAxXW6bChQq60iDT8faAVdDUDeUbxJwNjmCo9v4pP+yjnTrQGzyXupuwvc/uV1yOxpXRPI0vm9IjJ2Ocs4Veq+al/vK6ManXU2U50ptESd/NropWsxYSko+pn4BMockDKmIVx9sDGrjjMOXmIuCKNZFUPxPVtZ2zU=
Received: by 10.54.120.6 with SMTP id s6mr164661wrc;
        Thu, 25 May 2006 23:02:30 -0700 (PDT)
Received: by 10.54.127.12 with HTTP; Thu, 25 May 2006 23:02:30 -0700 (PDT)
To: "Linus Torvalds" <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0605252204590.5623@g5.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20796>

On 5/26/06, Linus Torvalds <torvalds@osdl.org> wrote:
> I'm doing it too, just for fun.

Well, it's good to not be so alone in our definition of fun ;-)

> Of course, since I'm doing this on a machine that basically has a laptop
> disk, the "just for fun" part is a bit sad. It's waiting for disk about
> 25% of the time ;/

Ouch.

> And it's slow as hell. I really wish we could do better on the CVS import
> front.

Me too. However, I don't think the perl part is so costly anymore.
It's down to waiting on IO. git-write-tree is also prominently there.
It takes a lot of memory in some writes -- I had thought it'd be
cheaper as it takes one tree object at the time...

I also have a trivial patch that I haven't posted yet, that runs cvsps
to a tempfile, and then reads the file. Serialising the tasks means
that we don't carry around cvsps' memory footprint during the import
itself.

...
> It's "git-rev-list --objects" that is the memory sucker for me, the
> packing itself doesn't seem to be too bad.


No, you're right, it's git-rev-list that gets called during the
repack. But it was pushing everything it could to swap. Once it didn't
fit in memory, it hit a brick wall :(

> The biggest cost seems to be git-write-tree, which is about 0.225 seconds
> for me on that tree on that machine. Which _should_ mean that we could do
> 4 commits a second, but that sure as hell ain't how it works out. It seems
> to do about 1.71 commits a second for me on that tree, which is pretty
> damn pitiful. Some cvs overhead, and probably some other git overhead too.

Well, we _have_ to fetch the file. I guess you are thinking of
extracting if frrom the RCS ,v file directly? One tihng that I found
that seemed to speed things up a bit was to declare TMPDIR to be a
directory in the same partition.

> (That's a 2GHz Merom, so the fact that you get ~6k commits per hour on
> your 2GHz Opteron is about the same speed - I suspect you're also at least
> partly limited by disk, our numbers seem to match pretty well).

Yup. This is _very_ diskbound.

> 200k commits at 6k commits per hour is about a day and a half (plus the
> occasional packing load). Taking that long to import a CVS archive is
> horrible. But I guess it _is_ several years of work, and I guess you
> really have to do it only once, but still.

And it's a huge CVS archive too.



martin
