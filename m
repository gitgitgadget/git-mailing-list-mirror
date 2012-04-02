From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH 3/3] revision: insert unsorted, then sort in prepare_revision_walk()
Date: Mon, 2 Apr 2012 09:39:59 -0700
Message-ID: <CAJo=hJshOBg4pT8nuWZ=eZvj=E9x+4b9M_EANa=02x=NFW2OfQ@mail.gmail.com>
References: <201203291818.49933.mfick@codeaurora.org> <20120330094052.GB12298@sigill.intra.peff.net>
 <4F7780F5.3060306@lsrfire.ath.cx> <201204021024.49706.mfick@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	Shawn Pearce <sop@google.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Martin Fick <mfick@codeaurora.org>
X-From: git-owner@vger.kernel.org Mon Apr 02 18:40:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SEkIu-00022b-61
	for gcvg-git-2@plane.gmane.org; Mon, 02 Apr 2012 18:40:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752420Ab2DBQkX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 Apr 2012 12:40:23 -0400
Received: from mail-pz0-f52.google.com ([209.85.210.52]:58731 "EHLO
	mail-pz0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751548Ab2DBQkW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Apr 2012 12:40:22 -0400
Received: by dake40 with SMTP id e40so2669112dak.11
        for <git@vger.kernel.org>; Mon, 02 Apr 2012 09:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=tRLXhh2WvGyl/TXv+NKtRuoMdVEdw78UjbG5PttMYc8=;
        b=Y1v6/tujf+NjCr7nUjZ5MdiSto7OkHd7wve1iqaQGiDYgJ5XjbZbxftmtrJRrUJpi8
         bH5cYAIZb/jcpaCWmbLvgoKICFxDo39rShH2/J+GD+vWYw/LRv/RkBwqueMeS0EZVMW2
         9xDbcHTT2NlO9mqPZnlnLO5jI1ILhcfZuCVJE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding:x-gm-message-state;
        bh=tRLXhh2WvGyl/TXv+NKtRuoMdVEdw78UjbG5PttMYc8=;
        b=pErBJh+E7hAX+8jhWjz6w8C012/RBmAzQ8JpF2iZvTrxoUSag7RazZL00lll3cJq9c
         IcRNQ20j0YJWvouyOGQcFAyGKnVChJx2vx30keEZkWFTyFQtJCGoqEo+P6dmsiunQ7Ll
         zWAcLi4t10v11WWMMS+jRJDjJhcC2DpTWIIuJYnakjgaM5XJxS+CNHUyYCNcet6sUGHK
         cqSSOfTGO8xBdsNOnagsJT036ctBs0N9/KmkYwRTPytPgy9ZffZnc+K18rHw08ECV0VG
         cuiuiCveDuXfwm7M6oLg6asbLSLN8NQF6Ezg0lR/DZrwUOr6ePA7FUpxvhvUB41MvU5F
         08og==
Received: by 10.68.234.106 with SMTP id ud10mr21475374pbc.128.1333384822256;
 Mon, 02 Apr 2012 09:40:22 -0700 (PDT)
Received: by 10.68.237.201 with HTTP; Mon, 2 Apr 2012 09:39:59 -0700 (PDT)
In-Reply-To: <201204021024.49706.mfick@codeaurora.org>
X-Gm-Message-State: ALoCoQky4uxnS0EE5iTdtT0+PvakT/DcCHzgceRki3zJr3OLNP4s6URhHS8rI5aJd4rYHO0UadN+
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194532>

On Mon, Apr 2, 2012 at 09:24, Martin Fick <mfick@codeaurora.org> wrote:
> On Saturday, March 31, 2012 04:11:01 pm Ren=E9 Scharfe wrote:
>> Speed up prepare_revision_walk() by adding commits
>> without sorting to the commit_list and at the end sort
>> the list in one go. =A0Thanks to mergesort() working
>> behind the scenes, this is a lot faster for large
>> numbers of commits than the current insert sort.
>
> This speeds up my git push test on my repo with ~100K refs
> case from out ~43s to about ~10s. =A0Not bad, thanks!
>
> The rest of the 10s do not seem to be spent with high CPU on
> either the pushing or the receiving side (only a very small
> 100% burst on both sides near the end of the operation). =A0I
> also ran iotop on the receiving side and could not find any
> activity (of course, the repo is likely cached). =A0iftop does
> show a decent amount of traffic during this time, so perhaps
> we are finally approaching the protocol limit?

The protocol is basically two round trips, receive side tells push
side what it has, push side sends data, receive side sends
success/error response. It would be more traffic with SSH due to the
encryption and custom ACK messages that SSH runs to wrap the stream.

> But, I have my doubts on that to be honest. =A0The reason is
> because I am able to hack Gerrit to receive this push much
> faster (around 3.5s) by reusing a cached RevWalk. =A0Without
> the cached RevWalk, Gerrit (using jgit) is about the same as
> your new patch ~10s. =A0I am not saying that git is spending
> its time in the same place (but it may be) as jgit, but with
> jgit, the time I was able to save with the cached RevWalk
> was the time spent loading and parsing the RevCommits. =A0This
> could be the same thing that git is doing? =A0And while it may
> not be I/O (disk) bound so to speak since the packs are
> likely cached, it may still be memory bound on that I/O? =A0If
> it is memory bound, and not I/O(disk) or CPU bound, I guess
> it makes sense that git and jgit would perform about the
> same (10s)?

Git can't really do the same thing as "cache the RevWalk". Its
spawning a new process that needs to decompress and parse each commit
object to determine its timestamp so the commits can be sorted into
the priority queue. This is still an O(N) operation given N
references.
