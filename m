From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: [PATCH] [RFD] Add repoid identifier to commit
Date: Fri, 13 May 2005 01:48:03 +1000
Message-ID: <2cfc403205051208483132921@mail.gmail.com>
References: <428297DB.8030905@zytor.com> <1115884637.22180.277.camel@tglx>
	 <1895.10.10.10.24.1115890333.squirrel@linux1>
	 <1115890792.22180.306.camel@tglx>
	 <3656.10.10.10.24.1115891188.squirrel@linux1>
	 <1115896713.22180.314.camel@tglx>
	 <3745.10.10.10.24.1115897090.squirrel@linux1>
	 <1115898230.11872.8.camel@tglx>
	 <20050512132922.GB20785@delft.aura.cs.cmu.edu>
	 <2cfc4032050512084426ea3d4d@mail.gmail.com>
Reply-To: jon@blackcubes.dyndns.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Thu May 12 17:41:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWFnc-0000me-KN
	for gcvg-git@gmane.org; Thu, 12 May 2005 17:40:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262052AbVELPsL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 May 2005 11:48:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262055AbVELPsL
	(ORCPT <rfc822;git-outgoing>); Thu, 12 May 2005 11:48:11 -0400
Received: from rproxy.gmail.com ([64.233.170.203]:52725 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262052AbVELPsD convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2005 11:48:03 -0400
Received: by rproxy.gmail.com with SMTP id i8so74925rne
        for <git@vger.kernel.org>; Thu, 12 May 2005 08:48:03 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YvMQ9OwLAXLKqdxTt6cxCr3hs5AJoARM78WCa5JONnYvB3yk6pv1R8rYYz2GeSF5gsYFNGM0D6eFCjvZxhhv6NPD55qw2UxM2f553oUaRIzISBw4xRokI+IyS0tcsRdev8/iel8ZS0A8TQc52ihEdckKIOVuJi2uAVF+Ur0hX40=
Received: by 10.38.88.73 with SMTP id l73mr186106rnb;
        Thu, 12 May 2005 08:48:03 -0700 (PDT)
Received: by 10.38.104.37 with HTTP; Thu, 12 May 2005 08:48:03 -0700 (PDT)
To: Git Mailing List <git@vger.kernel.org>
In-Reply-To: <2cfc4032050512084426ea3d4d@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

| small clarification to algorithm, removed editing work area 

On 5/12/05, Jan Harkes <jaharkes@cs.cmu.edu> wrote:
> On Thu, May 12, 2005 at 01:43:50PM +0200, Thomas Gleixner wrote:
> ....
> Your examples break if you consider additional merges where M syncs up a
> couple of times (f.i. at Rn-2) before M is merged back into R.
>
> What you seem to want won't be fixed by adding a repoid, you need to
> keep a list of all the commits you have already seen and append any new
> ones whenever you look at the history. If you look whenever you pull or
> merge the list will be in the total ordering that you seem to expect for
> your repository. But that is a porcelain thing.
>
> Jan

If committers always follow the convention that their previous local
commit is nominated as the first (local) parent in the commit and
commits from foreign repositories are listed after the first parent,
can the chain of "local" parents be an effective proxy for repoid?

Consider first a graph where there are no more than 2 parents in a merge

Ln
|     \
Ln-1  Fn
|         |
Ln-2  Fn-1
|       /
Ln-3

Thomas would like to sort this as:

Ln
Fn
Fn-1
Ln-1
Ln-2
Ln-3

So, use this algorithm:

1. Merge result comes first.
2. For each foreign parent:
    - sort the graph between the foreign parent and the merge base
(not including merge base) according to his algorithm using the
foreign parent as the starting
point of the algorithm. Append the result into the list.
3. Append the merge base to the list.

Admittedly the order for foreign parent for N-way merges is somewhat
arbitrary but a committer could probably make a choice that "works" in
most cases by specifying the foreign parents in a "sensible" order.

Of course, this relies on a committer always nominating the local
parent first, but that wouldn't be hard to enforce in the porcelain
layer.

jon.
-- 
homepage: http://www.zeta.org.au/~jon/
blog: http://orwelliantremors.blogspot.com/
