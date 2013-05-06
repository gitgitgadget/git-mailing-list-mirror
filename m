From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 2/3] fast-export: improve speed by skipping blobs
Date: Mon, 6 May 2013 14:12:57 -0500
Message-ID: <CAMP44s16pX-n9AAMu8zdSPPBhJxYQAisgDd2-gD2eiS=g-uuFg@mail.gmail.com>
References: <1367793534-8401-1-git-send-email-felipe.contreras@gmail.com>
	<1367793534-8401-3-git-send-email-felipe.contreras@gmail.com>
	<20130506123111.GB3809@sigill.intra.peff.net>
	<7v7gjctabm.fsf@alter.siamese.dyndns.org>
	<20130506162008.GB7992@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Antoine Pelisse <apelisse@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon May 06 21:13:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZQqN-0004HB-EC
	for gcvg-git-2@plane.gmane.org; Mon, 06 May 2013 21:13:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754344Ab3EFTM7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 May 2013 15:12:59 -0400
Received: from mail-la0-f46.google.com ([209.85.215.46]:36331 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752448Ab3EFTM6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 May 2013 15:12:58 -0400
Received: by mail-la0-f46.google.com with SMTP id fk20so3651309lab.33
        for <git@vger.kernel.org>; Mon, 06 May 2013 12:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=ZxaD+wLrsBn+aHmP0Po6+hy328rjdqr70kX9ZbH485w=;
        b=e5Vr1NsBc9jF7CrdlyDHS7AqGePYpN/Wsf/2acSU22E8EgjvYSjbLW0XoTX1Of6TZC
         hxRUXHrhMHlPc1o3TPpCHRKrnXngKgItjRiE4fXewCaSFndPf/N1XKjPzJ053moe1yfO
         mufXMjAdpFG06w5WipHiPucNGUo5NLungbF3YQpTYSs5pk4/CHqIVVUEI+k/zAV318yx
         Q1kx+z7pfFMZDAqhPC//WX0VYn2F69C0hr1TR+PeZ8B7WoSKePbhQ326dRMp6c8eFNDZ
         Em81cUuUTuDCJxwKn4+EecjjhXnsvNF9A/YxpsuqQC2ETEX2VDw2sFfepIBjOXSF/Be8
         n1LA==
X-Received: by 10.152.20.134 with SMTP id n6mr8604343lae.19.1367867577216;
 Mon, 06 May 2013 12:12:57 -0700 (PDT)
Received: by 10.114.184.3 with HTTP; Mon, 6 May 2013 12:12:57 -0700 (PDT)
In-Reply-To: <20130506162008.GB7992@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223486>

On Mon, May 6, 2013 at 11:20 AM, Jeff King <peff@peff.net> wrote:
> On Mon, May 06, 2013 at 08:08:45AM -0700, Junio C Hamano wrote:
>
>> > I'm also not sure why your claim "we don't care about blobs" is true,
>> > because naively we would want future runs of fast-export to avoid having
>> > to write out the whole blob content when mentioning the blob again.
>>
>> The existing documentation is fairly clear that marks for objects
>> other than commits are not exported, and the import-marks codepath
>> discards anything but commits, so there is no mechanism for the
>> existing fast-export users to leave blob marks in the marks file for
>> later runs of fast-export to take advantage of.  The second
>> invocation cannot refer to such a blob in the first place.
>
> OK. If the argument is "we do not write them, so do not bother reading
> them back in", I think that is reasonable.

We already do that:

5d3698f fast-export: avoid importing blob marks

> It could hurt anybody trying
> to run "fast-export" against a marks file created by somebody else, but
> that is also the same case that is being helped here (since otherwise,
> we would not be seeing blob entries at all).
>
> I do not offhand know enough about the internals of import/export-style
> remote-helpers to say whether the "hurt" case even exists, let alone how
> common it is.
>
>> By discarding marks on blobs, we may be robbing some optimization
>> possibilities, and by discarding marks on tags, we may be robbing
>> some features, from users of fast-export; we might want to add an
>> option "--use-object-marks={blob,commit,tag}" or something to both
>> fast-export and fast-import, so that the former can optionally write
>> marks for non-commits out, and the latter can omit non commit marks
>> if the user do not need them. But that is a separate issue.
>
> Yeah, that would allow the old behavior (and more) if anybody is hurt by
> this.

There is no behavior change in this patch. We do *exactly* the same as before.

-- 
Felipe Contreras
