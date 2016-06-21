Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB1BD2018B
	for <e@80x24.org>; Tue, 21 Jun 2016 16:41:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752058AbcFUQlj (ORCPT <rfc822;e@80x24.org>);
	Tue, 21 Jun 2016 12:41:39 -0400
Received: from mail-io0-f176.google.com ([209.85.223.176]:36516 "EHLO
	mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751811AbcFUQli (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jun 2016 12:41:38 -0400
Received: by mail-io0-f176.google.com with SMTP id s63so17157597ioi.3
        for <git@vger.kernel.org>; Tue, 21 Jun 2016 09:41:38 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=IlnKTmu5ACmp//fIZO2DxVsAMmjJpVoI9krz6lEXmks=;
        b=SOoy2JZV8fr193JRTi1eKT14QtkPH+XvKSbVKspzApklWL8sCvRDnRYdmawona42SZ
         ysMP0XpnQQA+YOn+K/nLiWrMICEpSaPY62iXkGEB4oPiyz2cJ1ulM8hn4nF8WGQmizK2
         rAe1cGXn0XQ/D0Ryx1JBwvMLE4+fLVGYgOjj7yifkZ4CPiXLZwGrVwool1Bb9taDAwUA
         SzPJRkfhQis+jngNb3tfms5ipnRENKhBI9HOeOepecLdosoZWJil3eTP1M5ztJsFmOC2
         8Cfo3/l0pj5MwSIS26lXw03oNrLTUeeVauk/rep78aDdOeZPKAb2AQ0r1de5SDEFgjQu
         qMAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=IlnKTmu5ACmp//fIZO2DxVsAMmjJpVoI9krz6lEXmks=;
        b=Wot2sQPKfIvzJETIofN3lwlUrzT2Vt5xmPSuY8kBJUH1pPs5SoLVQx8HC9nbEJU5W2
         EJaSYDfSyYWOWvWdzwAAjM7+N2Iq/YIHyLnTWyf9LlCofFhK4ri3BTxLxUZ9wTbjFWc3
         m4Q0Gg3rbwZ2ubHlew/UpeEWST8Ne9ZQtxbKa3Qwu8X5I1uP9mtJC1w/Xb3pIahAPYD/
         wz7clvhG95KEWlEDhe/KPA7+kwo0AWoJzxszWDNUTNrEvtNnltUZgpdUQh4sc73FeDk7
         Hw+KBBp/8A3J0h+NKyeN8GrrSXgMTxHvcbeg+ljcWYlrF+rcUs5u+itMoeFVqta/nQMC
         jNNQ==
X-Gm-Message-State: ALyK8tJAhM5E9JR6pIs3EkLsxn6VEyWDptgqOCiViO2YXC0oIoFaiUE2voUTS+qRvK0r2U5ds6v6O37zkb884g==
X-Received: by 10.107.8.220 with SMTP id h89mr33423837ioi.95.1466527297702;
 Tue, 21 Jun 2016 09:41:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.225.235 with HTTP; Tue, 21 Jun 2016 09:41:08 -0700 (PDT)
In-Reply-To: <20160621121041.GA29156@sigill.intra.peff.net>
References: <20160621112303.GA21973@dcvr.yhbt.net> <20160621121041.GA29156@sigill.intra.peff.net>
From:	Duy Nguyen <pclouds@gmail.com>
Date:	Tue, 21 Jun 2016 18:41:08 +0200
Message-ID: <CACsJy8DQGE2fAgzDdJjL82-UrS00zVwy+u1Jd06xDdYmfC94-w@mail.gmail.com>
Subject: Re: http-backend fatal error message on shallow clone
To:	Jeff King <peff@peff.net>
Cc:	Eric Wong <e@80x24.org>, Git Mailing List <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Jun 21, 2016 at 2:10 PM, Jeff King <peff@peff.net> wrote:
> ...
> So this request actually takes _two_ upload-pack instances to serve
> (which is not uncommon when we need multiple rounds of
> get_common_commits(), though I am a little surprised that would be the
> case for a clone). And the first one seems to be missing a closing
> "0000" flush packet from the client to end it.
>
> If that analysis is correct, this isn't affecting operation in any way;
> it's just giving a useless message from upload-pack (and as you note,
> that could trigger http-backend to exit(1), which may make the webserver
> unhappy).
>
> If we further instrument upload-pack to set GIT_TRACE_PACKET on the
> server side, we can see the two requests:
>
> packet:  upload-pack< want 379518c0c94e3b1a0710129d03d5560814a0ba6f multi_ack_detailed no-done side-band-64k thin-pack include-tag ofs-delta agent=git/2.9.0.37.gb3ad8ab.dirty
> packet:  upload-pack< deepen 1
> packet:  upload-pack< 0000
> packet:  upload-pack> shallow 379518c0c94e3b1a0710129d03d5560814a0ba6f
> packet:  upload-pack> 0000
>
> packet:  upload-pack< want 379518c0c94e3b1a0710129d03d5560814a0ba6f multi_ack_detailed no-done side-band-64k thin-pack include-tag ofs-delta agent=git/2.9.0.37.gb3ad8ab.dirty
> packet:  upload-pack< deepen 1
> packet:  upload-pack< 0000
> packet:  upload-pack> shallow 379518c0c94e3b1a0710129d03d5560814a0ba6f
> packet:  upload-pack> 0000
> packet:  upload-pack< done
> packet:  upload-pack> NAK
> packet:  upload-pack> 0000
>
> I think in the first one we would get "deepen 1" from the client in
> receive_needs(), and similarly write out our "shallow" line. But then we
> go into get_common_commits() and the client has hung up, which causes
> the message. Whereas in the second line it gives us a "done", which
> completes the negotiation.
>
> So my not-very-educated thoughts are:
>
>   1. The client should probably be sending an extra flush in the first
>      request. Alternatively, in the stateless-rpc case we should just
>      accept the lack of flush as an acceptable end to the request.

Our pkt-line.c can't deal with eof if I remember correctly (I tried to
use pkt-line for the parallel checkout stuff, where workers can also
exit early...) so sending extra flush may be easier. Old upload-pack
will not have a problem with this extra flush right? I haven't checked
upload-pack.c yet...

>   2. Presumably the shallowness is what causes the double-request, as
>      fetch-pack wants to see the shallow list before proceeding. But
>      since it has no actual commits to negotiate, the negotiation is a
>      noop. So probably this case could actually happen in a single
>      request.

I seem to recall our discussion a few months(?) ago about quickfetch()
where shallow clone would force another fetch initiated from
backfill_tags(). I guess that's why you see two fetches.

>
>      I suspect that other fetches could not, though, so I'm not sure how
>      much effort is worth putting into optimizing.
>
> -Peff
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Duy
