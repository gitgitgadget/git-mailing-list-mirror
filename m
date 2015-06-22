From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add list-all-objects command
Date: Mon, 22 Jun 2015 14:50:10 -0700
Message-ID: <xmqqk2uvfm5p.fsf@gitster.dls.corp.google.com>
References: <1434705059-2793-1-git-send-email-charles@hashpling.org>
	<1434914431-7745-1-git-send-email-charles@hashpling.org>
	<1434914431-7745-2-git-send-email-charles@hashpling.org>
	<20150622083822.GB12259@peff.net> <20150622103321.GB12584@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Charles Bailey <charles@hashpling.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jun 22 23:50:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z79be-0004eF-W3
	for gcvg-git-2@plane.gmane.org; Mon, 22 Jun 2015 23:50:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752880AbbFVVuP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jun 2015 17:50:15 -0400
Received: from mail-ie0-f178.google.com ([209.85.223.178]:33454 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752189AbbFVVuN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jun 2015 17:50:13 -0400
Received: by ieqy10 with SMTP id y10so36205131ieq.0
        for <git@vger.kernel.org>; Mon, 22 Jun 2015 14:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=UEmBu2fMIe1r1QHioG4chDgwSPd4SEJbBSkbNoLwvIg=;
        b=n/eIg7S5HG9/zLdSv3h9V4whgjTYGlbmg7TEi5gYPfhXGqSPcihHIcnpl5/VF4pR96
         y6ZP7SMID+Lm5xCigjVnYL+l8WBJBn+s3ZU49U/dzmeFaxDIFAeY0U1eu+ftroXLUBig
         zyRTFxYIDe1xTGfklcQWRPErbbNUnkrU/GfIuea3cRbe/ESrgKHuyKW/H+1dYfn3asPJ
         GGmV5naHTmVOrBWoI/Vkyu+wVdhkaS3yq1GMpYzZ6R3y/3nAEgLmDe4UURAXIzOiGHtF
         waPe/zyHfukAfuw9aMl0wWygLKS5njpYCjhCZ2rWnVYjVl0LYvusUBZ9122vTVIW3K1Y
         5xRQ==
X-Received: by 10.107.148.144 with SMTP id w138mr42390369iod.12.1435009813022;
        Mon, 22 Jun 2015 14:50:13 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:b0be:ae3d:b206:8e25])
        by mx.google.com with ESMTPSA id a2sm8372216igx.3.2015.06.22.14.50.12
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 22 Jun 2015 14:50:12 -0700 (PDT)
In-Reply-To: <20150622103321.GB12584@peff.net> (Jeff King's message of "Mon,
	22 Jun 2015 06:33:21 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272424>

Jeff King <peff@peff.net> writes:

> On Mon, Jun 22, 2015 at 04:38:22AM -0400, Jeff King wrote:
>
>> > +	prepare_packed_git();
>> > +	for (p = packed_git; p; p = p->next) {
>> > +		open_pack_index(p);
>> > +	}
>> 
>> Yikes. The fact that you need to do this means that
>> for_each_packed_object is buggy, IMHO. I'll send a patch.
>
> Here's that patch. And since I did not want to pile work on Charles, I
> went ahead and just implemented the patches I suggested in the other
> email.
>
> We may want to take patch 1 separately for the maint-track, as it is
> really a bug-fix (albeit one that I do not think actually affects anyone
> in practice right now).

Hmph, add_unseen_recent_objects_to_traversal() is the only existing
user, and before d3038d22 (prune: keep objects reachable from recent
objects, 2014-10-15) added that function, for-each-packed-object
existed but had no callers.

And the objects not beeing seen by that function (due to lack of
"open") would matter only for pruning purposes, which would mean
you have to be calling into the codepath when running a full repack,
so you would have opened all the packs that matter anyway (if you
have a "old cruft archive" pack that contains only objects that
are unreachable, you may not have opened that pack, though, and you
may prune the thing away prematurely).

So, I think I can agree that this would unlikely affect anybody in
practice.

> Patches 2-5 are useful even if we go with Charles' command, as they make
> cat-file better (cleanups and he new buffer option).
>
> Patches 6-7 implement the cat-file option that would be redundant with
> list-all-objects.
>
> By the way, in addition to not showing objects in order,
> list-all-objects (and my cat-file option) may show duplicates. Do we
> want to "sort -u" for the user? It might be nice for them to always get
> a de-duped and sorted list. Aside from the CPU cost of sorting, it does
> mean we'll allocate ~80MB for the kernel to store the sha1s. I guess
> that's not too much when you are talking about the kernel repo. I took
> the coward's way out and just mentioned the limitation in the
> documentation, but I'm happy to be persuaded.
>
>   [1/7]: for_each_packed_object: automatically open pack index
>   [2/7]: cat-file: minor style fix in options list
>   [3/7]: cat-file: move batch_options definition to top of file
>   [4/7]: cat-file: add --buffer option
>   [5/7]: cat-file: stop returning value from batch_one_object
>   [6/7]: cat-file: split batch_one_object into two stages
>   [7/7]: cat-file: add --batch-all-objects option
>
> -Peff
