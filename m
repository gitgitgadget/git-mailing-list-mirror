From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] Implement fast hash-collision detection
Date: Tue, 29 Nov 2011 21:04:06 +0700
Message-ID: <CACsJy8DboVU4kSbJSV=8NP08OyLYVgOKsm8tt=koZ0=JcGSE=A@mail.gmail.com>
References: <1322546563.1719.22.camel@yos> <20111129090733.GA22046@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Bill Zaumen <bill.zaumen+git@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com, spearce@spearce.org,
	torvalds@linux-foundation.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Nov 29 15:04:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RVOIh-0001rH-1C
	for gcvg-git-2@lo.gmane.org; Tue, 29 Nov 2011 15:04:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755610Ab1K2OEj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Nov 2011 09:04:39 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:38868 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755604Ab1K2OEi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Nov 2011 09:04:38 -0500
Received: by bkas6 with SMTP id s6so553301bka.19
        for <git@vger.kernel.org>; Tue, 29 Nov 2011 06:04:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=fy+EzSZqPe9tkoaPakzK/IYK//UC2vNsJTsLTEVSJj8=;
        b=TP3dX1Enb9cu8aiCX0FTeIqiy/upp1Wrftnb97sfAfqUa/5Pzj7T+l9xqn+nwLXqbX
         nJNrs2rOPOb6ITGPUO5iXFKqJjuPS8wyJ/xZL6BmikVuNVXCkxVcSEe9OrsRpQiqMSQb
         J9Z76FXi7ACnBiiN1ZzLopj+8TT9yJZokPPeE=
Received: by 10.204.9.211 with SMTP id m19mr49465929bkm.92.1322575477179; Tue,
 29 Nov 2011 06:04:37 -0800 (PST)
Received: by 10.204.23.2 with HTTP; Tue, 29 Nov 2011 06:04:06 -0800 (PST)
In-Reply-To: <20111129090733.GA22046@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186059>

On Tue, Nov 29, 2011 at 4:07 PM, Jeff King <peff@peff.net> wrote:
> That brings me to my second concern: how does this alternative message
> digest have any authority?
>
> For example, your patch teaches the git protocol a new extension to pass
> these digests along with the object sha1s. But how do we know the server
> isn't feeding us a bad digest along with the bad object?
>
> The "usual" security model discussed in git is that of verifying a
> signed tag. Linus signs a tag and pushes it to a server. I fetch the
> tag, and can verify the signature on the tag. I want to know that I have
> the exact same objects that Linus had. But I can't assume the server is
> trustworthy; it may have fed me a bad object with a collided sha1.
>
> But what's in the signed part of the tag object? Only the sha1 of the
> commit the tag points to, but not the new digest. So an attacker can
> replace the commit with one that collides, and it can in turn point to
> arbitrary trees and blobs.
>
> You can fix this by including an extra header in the signed part of the
> tag that says "also, the digest of the commit I point to is X". Then you
> know you have the same commit that Linus had. But the commit points to a
> tree by its sha1. So you have to add a similar header in the commit
> object that says "also, the digest of the tree I point to is X". And
> ditto for all of the parent pointers, if you want to care about signing
> history. And then you have the same problem in the tree: each sub-tree
> and blob is referenced by its sha1.
>
> ..

(Security ignorant speaking)

Can we just hash all objects in a pack from bottom up, (replacing
sha-1 in trees/commits/tags with the new digest in memory before
hashing), then attach the new top digest to tag's content? The sender
is required by the receiver to send new digests for all objects in the
pack together with the pack. The receiver can then go through the same
process to produce the top digest and match it with one saved in tag.

I do agree that we should use stronger digests, not weaker, preferably
a combination of them.
-- 
Duy
