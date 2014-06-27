From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Tackling Git Limitations with Singular Large Line-seperated
 Plaintext files
Date: Fri, 27 Jun 2014 12:38:49 -0700
Message-ID: <CA+55aFx6vFyZvpyQot_3Ym7wsCZ06abjNx_hEKkza-N856jMnw@mail.gmail.com>
References: <CAJoVafc1LMxmvCiWci3N+AuAZBsABR3Wb3c6c3stw93OJZ7Scw@mail.gmail.com>
	<CAJo=hJtJCy96SRYmOxEpEMoEVcaegv0SCG0_AH2u0=bSrHZi_A@mail.gmail.com>
	<xmqqegya2qgu.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Shawn Pearce <spearce@spearce.org>,
	Jarrad Hope <me@jarradhope.com>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 27 21:39:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X0bz5-0002oq-Ml
	for gcvg-git-2@plane.gmane.org; Fri, 27 Jun 2014 21:38:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751001AbaF0Tiv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2014 15:38:51 -0400
Received: from mail-ve0-f177.google.com ([209.85.128.177]:36587 "EHLO
	mail-ve0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750714AbaF0Tiu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2014 15:38:50 -0400
Received: by mail-ve0-f177.google.com with SMTP id i13so5660242veh.8
        for <git@vger.kernel.org>; Fri, 27 Jun 2014 12:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=bPXekCms0U3e8HaE3Uiu1jJr9cAIsAWrpA21BpZcsms=;
        b=rsP2O97nZq3fC0giCzFazhDWCCNA4zlmRVrIUeITrPMB9yS6qEWwItk/yNrCQqX2FS
         IP1citjPvo3Oi58nAdzDjuVmhUKP+FIzf7GrNWdjyFPeY16tX5GmozQ40sCbD8TY4lJ8
         tyuo80zCx+KVE/ncmETRDaxCtzpidUVKh8ad7466agCTyWzw//flo4ULg2NN5U/Intz6
         icpx4H5gX3sLkSRjy0hQGAjo0CxhdihEwzfc3gML/JnEvhfJAtwrkUIXPAy1S3b6Znc+
         9HV8YlVbXsik4agHOXW0blL7JteSMKzH1+C1As8kTOPgNaZXXyg96cVYucKRbSm+Hd8b
         flYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=bPXekCms0U3e8HaE3Uiu1jJr9cAIsAWrpA21BpZcsms=;
        b=gID9a3JVkPbrLlTNcz0blBI8z4C8iEGbmKZi5B1s39gfUFUcwNatyxTtF5DTqEKIeg
         i7UDFeu2sSwuvIfVKLeWhC7rt9jAFSei22NZg+AF7a44AzTTqbMWVIycGXfONiNtOBVo
         teJnFM5yr66Ggt3pu4Rt8IMXuECjoFG21DtNQ=
X-Received: by 10.58.40.75 with SMTP id v11mr192376vek.77.1403897929819; Fri,
 27 Jun 2014 12:38:49 -0700 (PDT)
Received: by 10.221.58.77 with HTTP; Fri, 27 Jun 2014 12:38:49 -0700 (PDT)
In-Reply-To: <xmqqegya2qgu.fsf@gitster.dls.corp.google.com>
X-Google-Sender-Auth: u3e3XOOg46IE1DUl7jzprc5SiTw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252575>

On Fri, Jun 27, 2014 at 10:48 AM, Junio C Hamano <gitster@pobox.com> wrote:
>
> Even though the original question mentioned "delta discovery", I
> think what was being asked is not "delta" in the Git sense (which
> your answer is about) but is "can we diff two long sequences of text
> (that happens to consist of only 4-letter alphabet but that is a
> irrelevant detail) without holding both in-core in their entirety?",
> which is a more relevant question/desire from the application point
> of view.

.. even there, there's another issue. With enough memory, the diff
itself should be fairly reasonable to do, but we do not have any sane
*format* for diffing those kinds of things.

The regular textual diff is line-based, and is not amenable to
comparing two long lines. You'll just get a diff that says "the two
really long lines are different".

The binary diff option should work, but it is a horrible output
format, and not very helpful. It contains all the relevant data ("copy
this chunk from here to here"), but it's then shown in a binary
encoding that isn't really all that useful if you want to say "what
are the differences between these two chromosomes".

I think it might be possible to just specify a special diff algorithm
(git already supports that, obviously), and just introduce a new "use
binary diffs with a textual representation" model.

But it also sounds like there might be some actual performance problem
with these 1GB file delta-calculations. Which I wouldn't be surprised
about at all.

Jarrad - is there any public data you could give as an example and for
people to play with?

                Linus
