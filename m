From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: [PATCH] [RFD] Add repoid identifier to commit [its a workspace id, isn't it?]
Date: Fri, 13 May 2005 11:37:47 +1000
Message-ID: <2cfc4032050512183788e01fc@mail.gmail.com>
References: <1115847510.22180.108.camel@tglx> <428291CD.7010701@zytor.com>
Reply-To: jon@blackcubes.dyndns.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: tglx@linutronix.de, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 13 03:31:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWP0a-0006ao-Cd
	for gcvg-git@gmane.org; Fri, 13 May 2005 03:30:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262183AbVEMBiI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 May 2005 21:38:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262192AbVEMBiI
	(ORCPT <rfc822;git-outgoing>); Thu, 12 May 2005 21:38:08 -0400
Received: from rproxy.gmail.com ([64.233.170.206]:5087 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262183AbVEMBhr convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2005 21:37:47 -0400
Received: by rproxy.gmail.com with SMTP id i8so138416rne
        for <git@vger.kernel.org>; Thu, 12 May 2005 18:37:47 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AEf/JU2LWcdE4Jn/OwxIDcjGqxc5T7CQcxl0BaW584MxupYDGQA30LkvQLmmWDK8CR5Jx4v7/+5Wc45lP7uTY8+fUv2BzZxpF7TTgfFK2scBSbM41orLtAj25yWZgIcQw0fLWTJOOV3DpTQZpitlj+c8EtLJH+/xoBga9qVBdw0=
Received: by 10.39.3.47 with SMTP id f47mr501654rni;
        Thu, 12 May 2005 18:37:47 -0700 (PDT)
Received: by 10.38.104.37 with HTTP; Thu, 12 May 2005 18:37:47 -0700 (PDT)
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <428291CD.7010701@zytor.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

> 
> I would like to suggest a few limiters are set on the repoid.  In
> particular, I'd like to suggest that a repoid is a UUID, that a file is
> used to track it (.git/repoid), and that if it doesn't exist, a new one
> is created from /dev/urandom.
> 

I think I understand what Thomas is trying to achieve, but I think
there is a naming problem here. The marker really isn't a repoid - it
is a workspace id.

Two workspaces can share the same physical repository, yet have
different "repoid"s. So the thing being identified isn't the
repository - it's the workspace in the commit was performed.

Thomas' objective, I think, is the following: 

    from the point of view of a given workspace, determine the merge
order of the
    global repository (and there really is only _one_ repository for
this purpose) from
    the point of view of that workspace. The interesting workspaces
are workspaces that
    contributed commits to the global history.

Thomas is correct to point out that committer id is not a substitute
for a workspace identifier since a given committer may work in
multiple workspaces concurrently.

I can also see why an identifier in the commit is necessary to
reconstruct the history.

Consider the following history:

Rn
|      \
Rn-1 Mn
|     /
Rn-2
|       \ 
Rn-3 Mn-1
|    /
Rn-4

Assume that changes Mn and Mn-1 are made the same workspace, M. Then, from the 
point of view of workspace M, the history is:

Rn
Rn-1
Mn
Rn-2
Rn-3
Mn-1
Rn-4

>From the point of view of a given change epoch, M always wants to see
"local changes occur first". To know what changes were local to M you
need to mark the changes that workspace M made with an identifier
saying that M did this in this workspace, hence the need for the
marker that Thomas is proposing.

Assuming that there is value in being able to reconstruct the merge
order from the perspective of workspaces that have contributed to the
global history it would seem that Thomas's suggestion of marking each
commit with an identifier is reasonable, however, I think the name of
the identifier should change - what's being tracked is a workspace,
not a repository.

jon.
