From: "Felipe Contreras" <felipe.contreras@gmail.com>
Subject: Re: Memory issue with fast-import, why track branches?
Date: Mon, 22 Dec 2008 04:36:11 +0200
Message-ID: <94a0d4530812211836w16933c7dv52ffa099ca18f731@mail.gmail.com>
References: <94a0d4530812202154l26dfe0dfm49397c63dbfdfdf9@mail.gmail.com>
	 <20081221221702.GC17355@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "git list" <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Dec 22 03:37:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LEafk-0002Oi-BP
	for gcvg-git-2@gmane.org; Mon, 22 Dec 2008 03:37:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752069AbYLVCgO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Dec 2008 21:36:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751995AbYLVCgO
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Dec 2008 21:36:14 -0500
Received: from fg-out-1718.google.com ([72.14.220.154]:11930 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751980AbYLVCgN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Dec 2008 21:36:13 -0500
Received: by fg-out-1718.google.com with SMTP id 19so711748fgg.17
        for <git@vger.kernel.org>; Sun, 21 Dec 2008 18:36:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=fhe+INPFd7BcxQqFSL+ayH9aPVreNVbdY9axr98R7y4=;
        b=JkifBLYQab83QLG7ymnzrfkoo8nASM6Z3U+zkB49AsE7S3Uc14IajJUfG7oBx4/geR
         3Eyo7oqMMC8v3k9+Lnlfocn3mIFqQsKjg+/Rgui/kKs0gOA6hWpe++UUWA3wkUvQHfhT
         fX9UsczGTXq5jmSHzlB61DXfBGduazax8JH/I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=AjSpf6GZfcJFSS1w4Vez+U0M13tLQBMgpEG1PZljdM40Lf6p6FOAecZmZsnxInDCgR
         6ahEBglkE1ZLHZbv9WDPh58m7DAK/63kQl+EOtJvSdrSrU6bru8070o/LbI0dOe0z7U6
         BaChfB1MtXEPHIYFycpZQGdyS2dsKZpSKF7g4=
Received: by 10.86.50.6 with SMTP id x6mr3300913fgx.71.1229913371584;
        Sun, 21 Dec 2008 18:36:11 -0800 (PST)
Received: by 10.86.77.17 with HTTP; Sun, 21 Dec 2008 18:36:11 -0800 (PST)
In-Reply-To: <20081221221702.GC17355@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103741>

On Mon, Dec 22, 2008 at 12:17 AM, Shawn O. Pearce <spearce@spearce.org> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> wrote:
>> I tracked down an issue I have when importing a big repository. For
>> some reason memory usage keeps increasing until there is no more
>> memory.
>>
>> After looking at the code my guess is that I have a humongous amount
>> of branches.
>>
>> Actually they are not really branches, but refs. For each git commit
>> there's an original mtn ref that I store in 'refs/mtn/sha1', but since
>> I'm using 'commit refs/mtn/sha1' to store it, a branch is created for
>> every commit.
>>
>> I guess there are many ways to fix the issue, but for starters I
>> wonder why is fast-import keeping track of all the branches? In my
>> case I would like fast-import to work exactly the same if I specify
>> branches or not (I'll update them later).
>
> Because fast-import has to buffer them until the pack file is done.
> The objects aren't available to the repository until after a
> checkpoint is sent or until the stream ends.  Either way until
> then fast-import has to buffer the refs so they don't get exposed
> to other git processes reading that same repository, because they
> would point to objects that the process cannot find.
>
> I guess it could release the brnach memory after it dumps the
> branches in a checkpoint, but its memory allocators work under an
> assumption that strings (like branch and file names) will be reused
> heavily by the frontend and thus they are poooled inside of a string
> pool.  The branch objects are also pooled inside of a common alloc
> pool, to ammortize the cost of malloc's block headers out over the
> data used.
>
> IOW, fast-import was designed for ~5k branches, not ~1 million
> unique branches.

My point is: why is it not designed for 0 branches? In many places in
the code there's the assumption that the tree = branch, but that's not
always the case. You can specify a 'from sha1' and then the branch
becomes irrelevant.

In fact in monotone some commits are not part of any branch, and many
are part of multiple branches. Those cases can't be handled by
fast-import right now. Not to mention random refs like 'ref/mtn/foo'
which would come in handy for my script.

Now my question is: would it be possible to get rid of the notion of
branches on fast-import and go for refs instead?

On the other hand if branch memory is freed after a checkpoint then
there's no limit to how many 'branches' can be handled.

-- 
Felipe Contreras
