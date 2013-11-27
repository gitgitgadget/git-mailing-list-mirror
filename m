From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Pack transfer negotiation to tree and blob level?
Date: Thu, 28 Nov 2013 06:50:05 +0700
Message-ID: <CACsJy8C5om91ObOHvSjDyDtHfCB9Y2gSbgF8Dsi2oXCbO55Czw@mail.gmail.com>
References: <1E0A3B7F917445C7A968C81C35892FD4@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Thu Nov 28 00:50:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VlosS-0005oT-J8
	for gcvg-git-2@plane.gmane.org; Thu, 28 Nov 2013 00:50:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758192Ab3K0Xuh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Nov 2013 18:50:37 -0500
Received: from mail-qe0-f45.google.com ([209.85.128.45]:38706 "EHLO
	mail-qe0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757988Ab3K0Xuf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Nov 2013 18:50:35 -0500
Received: by mail-qe0-f45.google.com with SMTP id 6so8144075qea.4
        for <git@vger.kernel.org>; Wed, 27 Nov 2013 15:50:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=GG8MkmFXZpTbqWVkex7/yfZ+bgKRkbTBkOC0jjcSOc8=;
        b=py5KD/4kAbrgmPgO0Xa7RfIs1+x07euAPGlmrv+ARfMz5cfbBINSX+OihrJWi/E/Xm
         dvP3MRD3M9/V7AXPYb/RaAoVdnUKntOxwE/p4Z/BRy1eoRfnppEPewB1nlG6KLuqUcSh
         bdvWsiFG4CRFv+SkWej+sif3OgPrebs6fMwrbIsWDuqYZ/KNKZngrpxaemRCsyobFkRl
         QjDElyqlEk/iS+Lz9ivxr8R50MRRVwzDscOXK4MAkCPN2BwZkw8emE6ZyeKn9hswG1FM
         NAT8Pk30x9GKEFmQLhJbGK7f+1sgHbi7jg1ks2MCyo+jLGxvtkwWRAew9ROvKDc+Dksf
         7NrQ==
X-Received: by 10.224.32.66 with SMTP id b2mr71967868qad.80.1385596235299;
 Wed, 27 Nov 2013 15:50:35 -0800 (PST)
Received: by 10.96.134.68 with HTTP; Wed, 27 Nov 2013 15:50:05 -0800 (PST)
In-Reply-To: <1E0A3B7F917445C7A968C81C35892FD4@PhilipOakley>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238470>

On Thu, Nov 28, 2013 at 5:52 AM, Philip Oakley <philipoakley@iee.org> wrote:
> In the pack transfer protocol (Documentation\technical\pack-protocol.txt)
> the negotiation for refs is discussed, but its unclear to me if the
> negotiation explicitly navigates down into the trees and blobs of each
> commit that need to go into the pack.
>
> From one perspective I can see that, in the main, it's only commit objects
> that are being negotiated, and the DAG is used to imply which commit objects
> are to be sent between the wants and haves end points, without need to
> descend into their trees and blobs. The tags and the objects they point to
> are explicitly given so are negotiated easily.
>
> The other view is that the negotiation should be listing every object of any
> type between the wants and haves as part of the negotiation. I just couldn't
> tell from the docs which assumption is appropriate. Is there any extra
> clarifications on this?

other object negotiation is inferred from commits because sending full
listing is too much. If you say you have commit A, you imply you have
everything from commit A down to the bottom. With this knowledge, when
you want commit B, the sender only needs to send trees and objects
that do not exist in commit A or any of its predecessors. Although to
cut cost at the sender, we do something less than optimized (check out
the edge concept in documents, or else in pack-objects.c). Pack
bitmaps are supposed to provide cheap object traversal and make the
transfered pack even smaller.

> I ask as I was cogitating on options for a 'narrow' clone  (to complement
> shallow clones ;-) that could, say, in some way limit the size of blobs
> downloaded, or the number of tree levels downloaded, or even path limiting.

size limiting is easy because you don't need to traverse object dag at
all. Inside pack-objects it calls rev-list to collect objects to be
sent. You just filter by size at that phase. Support for raising or
lowering size limit is also workable, just like how shallow
deepen/shorten is done: you let the sender know you have size limit A,
now you want to raise to B and the sender just collects extra objects
in A..B range for all "have" refs.

The problem is how to let the client know what objects are not sent
due to the size limit, so it could set up refs/replace to stop the
user from running into missing objects. If there are too many excluded
objects, sending all those SHA-1 with pkt-line is inefficient. (path
limit does not have problem, it can infer from the command line
arguments most of the time). Maybe you could send this listing in
binary format just before sending the pack.

BTW another way to deal with large blobs in clone is git-annex. I was
thinking the other day if we could sort of integrate it to git to
provide smooth UI (the user does not have to type "git annex
something", or at least not often). Of course git-annex is still
optional and the UI integration is only activated via config key,
after git-annex is installed.
--
Duy
