From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 13/18] sequencer: simplify memory allocation of get_message
Date: Tue, 16 Feb 2016 01:05:05 -0500
Message-ID: <CAPig+cTLemy=YGVQFZVyA7V+EJcU_Z5KTw2nJ9LiJKa36van+A@mail.gmail.com>
References: <20160215214516.GA4015@sigill.intra.peff.net>
	<20160215215619.GM10287@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 16 07:05:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVYl7-0002dn-Sx
	for gcvg-git-2@plane.gmane.org; Tue, 16 Feb 2016 07:05:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753458AbcBPGFH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2016 01:05:07 -0500
Received: from mail-vk0-f41.google.com ([209.85.213.41]:33433 "EHLO
	mail-vk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752232AbcBPGFG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2016 01:05:06 -0500
Received: by mail-vk0-f41.google.com with SMTP id k196so125137701vka.0
        for <git@vger.kernel.org>; Mon, 15 Feb 2016 22:05:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=RsQxOvxfShfe0hZG2J10SWwToUwIISnS7XfevCH1Fwg=;
        b=ZtfY5dGnAtr9KaI7I3A8QanbVqDDzzu6FCrrK17vLrttOxC+BvtI1uCdOTgAyR2Uy4
         sYQnK4bYjcgmS3kucgIC/gmul+x9DQTm/LbC4tftJxfystKeD8Ybh/u3PfdKLTyjdRu2
         FjmnhRfmYrrMyTDy3bJoYv6eH9csV0dIRo5oIx15UJZE97l1VFty0O0RGEQzZYnbtPaS
         HQ5bEet8anCr3VhEH84/vdObmG59qaMlVQcdTSYoLzkUESnZVw+Qb8DJqBRvItSpDKUT
         dPJZOzJp07dFG3UcoOcSjk8Hs3tzHTTtEmze6wGOIjsGt/ny9EjngRn5Kw8hPKS/lei8
         kCsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=RsQxOvxfShfe0hZG2J10SWwToUwIISnS7XfevCH1Fwg=;
        b=ZDFmmIbf2Nc8UCQDIZbBlKuqN6XLjSI4D9I0N7ejlDmT9477AXELNFGpEprLG5n5O6
         BPPVt3gAd6ZkFGi/kt1+7gHhmE+/x8k/fTK5jNx6tDyeyf1Csvza5D/w6ld/xjWwS0Sp
         r0+J+fq+jJ63zoonsLE3Z8djE6hAUI2vt8c7kzO/ZtnxpdpS8IxZY9pStpdyza2MGVHb
         aRaYS24O7KJGGu/CYpHzP3ngirOMkqq1zL4SVT4C14F4DfPdOEvxZevaAmBXoj9sRzbJ
         evF9BHPYOYVqlmaaH02Mhy1Yo3haVoQa0f1x+16qgf2pKDS0u/i/9LVfDGCB2vGkIYED
         ZeZQ==
X-Gm-Message-State: AG10YOSxa0AnX4dh9yvY++YrbPVbzu2ZTBwkJGWLWNL1a+HeOnn2nrWuirHgI5nEHYeeXuznkRc3WfLkQUw3sA==
X-Received: by 10.31.47.135 with SMTP id v129mr16226621vkv.115.1455602705298;
 Mon, 15 Feb 2016 22:05:05 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Mon, 15 Feb 2016 22:05:05 -0800 (PST)
In-Reply-To: <20160215215619.GM10287@sigill.intra.peff.net>
X-Google-Sender-Auth: PIM97l1G_L5dSQVADPMQ-hzTrio
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286324>

On Mon, Feb 15, 2016 at 4:56 PM, Jeff King <peff@peff.net> wrote:
> For a commit with has "1234abcd" and subject "foo", this

Did you mean s/with has/which has ID/ or something?

> function produces a struct with three strings:
>
>  1. "foo"
>
>  2. "1234abcd... foo"
>
>  3. "parent of 1234abcd... foo"
>
> It takes advantage of the fact that these strings are
> subsets of each other, and allocates only _one_ string, with
> pointers into the various parts. Unfortunately, this makes
> the string allocation complicated and hard to follow.
>
> Since we keep only one of these in memory at a time, we can
> afford to simply allocate three strings. This lets us build
> on tools like xstrfmt and avoid manual computation.
>
> While we're here, we can also drop the ad-hoc
> reimplementation of get_git_commit_encoding(), and simply
> call that function.
>
> Signed-off-by: Jeff King <peff@peff.net>
