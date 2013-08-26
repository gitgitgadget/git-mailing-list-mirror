From: Corey Thompson <cmtptr@gmail.com>
Subject: Re: git-p4 out of memory for very large repository
Date: Mon, 26 Aug 2013 09:47:56 -0400
Message-ID: <20130826134756.GA1335@jerec>
References: <20130823011245.GA7693@jerec>
 <52170C6A.4080708@diamand.org>
 <20130823114856.GA8182@jerec>
 <20130825155001.GA875@padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Luke Diamand <luke@diamand.org>, git@vger.kernel.org
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Mon Aug 26 15:56:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VDxHE-0002BL-KB
	for gcvg-git-2@plane.gmane.org; Mon, 26 Aug 2013 15:56:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756923Ab3HZN4N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Aug 2013 09:56:13 -0400
Received: from mail-ye0-f179.google.com ([209.85.213.179]:52997 "EHLO
	mail-ye0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751968Ab3HZN4M (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Aug 2013 09:56:12 -0400
Received: by mail-ye0-f179.google.com with SMTP id l10so855123yen.10
        for <git@vger.kernel.org>; Mon, 26 Aug 2013 06:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=+KUyzbXnVvuerxxH59OheBfTNuSCWuCGv8xXGnvog4M=;
        b=ULDTBqmZ9I6I4cNcZ/38ZoYyXvZmqPDp/jZZDqb8RBZBZ9FU4884PqtoJnuUMOMojr
         Q8QHhntxAwo8v4H0+gXkoKsu5DwHM46V60pm0EMMcS4wJR9ziFdrndfO4Jkr26VUHQeH
         +xtva25XtwnwF9kAtBSp87uk5aqUsRxXb6LK8f2rW4h9kiAPGtsAks27YEnHRbWvHR/j
         ZWVc7hEMQuOA5UK5kMX3YphpQrwEqFzco6wzh2g8/QGMqiz5HqrUbse61aexdylx6UTD
         MnrP8KbKWTAbYJgpf3eOvs68E0hj1nvLBBOsVFj6rbY5DOqc5MhwRDKDoKZt6qN3dthD
         YTEQ==
X-Received: by 10.236.25.177 with SMTP id z37mr154236yhz.121.1377524883138;
        Mon, 26 Aug 2013 06:48:03 -0700 (PDT)
Received: from jerec (c-71-59-19-88.hsd1.ga.comcast.net. [71.59.19.88])
        by mx.google.com with ESMTPSA id o25sm17738355yhb.25.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 26 Aug 2013 06:48:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130825155001.GA875@padd.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232993>

On Sun, Aug 25, 2013 at 11:50:01AM -0400, Pete Wyckoff wrote:
> Modern git, including your version, do "streaming" reads from p4,
> so the git-p4 python process never even holds a whole file's
> worth of data.  You're seeing git-fast-import die, it seems.  It
> will hold onto the entire file contents.  But just one, not the
> entire repo.  How big is the single largest file?
> 
> You can import in pieces.  See the change numbers like this:
> 
>     p4 changes -m 1000 //depot/big/...
>     p4 changes -m 1000 //depot/big/...@<some-old-change>
> 
> Import something far enough back in history so that it seems
> to work:
> 
>     git p4 clone --destination=big //depot/big@60602
>     cd big
> 
> Sync up a bit at a time:
> 
>     git p4 sync @60700
>     git p4 sync @60800
>     ...
> 
> I don't expect this to get around the problem you describe,
> however.  Sounds like there is one gigantic file that is causing
> git-fast-import to fill all of memory.  You will at least isolate
> the change.
> 
> There are options to git-fast-import to limit max pack size
> and to cause it to skip importing files that are too big, if
> that would help.
> 
> You can also use a client spec to hide the offending files
> from git.
> 
> Can you watch with "top"?  Hit "M" to sort by memory usage, and
> see how big the processes get before falling over.
> 
> 		-- Pete

You are correct that git-fast-import is killed by the OOM killer, but I
was unclear about which process was malloc()ing so much memory that the
OOM killer got invoked (as other completely unrelated processes usually
also get killed when this happens).

Unless there's one gigantic file in one change that gets removed by
another change, I don't think that's the problem; as I mentioned in
another email, the machine has 32GB physical memory and the largest
single file in the current head is only 118MB.  Even if there is a very
large transient file somewhere in the history, I seriously doubt it's
tens of gigabytes in size.

I have tried watching it with top before, but it takes several hours
before it dies.  I haven't been able to see any explosion of memory
usage, even within the final hour, but I've never caught it just before
it dies, either.  I suspect that whatever the issue is here, it happens
very quickly.

If I'm unable to get through this today using the incremental p4 sync
method you described, I'll try running a full-blown clone overnight with
top in batch mode writing to a log file to see whether it catches
anything.

Thanks again,
Corey
