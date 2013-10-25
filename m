From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH 10/19] pack-bitmap: add support for bitmap indexes
Date: Fri, 25 Oct 2013 13:55:13 +0000
Message-ID: <CAJo=hJvw-UNWVDADcGzA1P3GGOKJGh8h4LrETPYnjBNYmfkxjQ@mail.gmail.com>
References: <20131024175915.GA23398@sigill.intra.peff.net> <20131024180357.GJ24180@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git <git@vger.kernel.org>, Vicent Marti <vicent@github.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Oct 25 15:55:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZhrY-0001Z1-Su
	for gcvg-git-2@plane.gmane.org; Fri, 25 Oct 2013 15:55:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753605Ab3JYNzh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Oct 2013 09:55:37 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:32880 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752573Ab3JYNzg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Oct 2013 09:55:36 -0400
Received: by mail-wg0-f44.google.com with SMTP id n12so3875825wgh.35
        for <git@vger.kernel.org>; Fri, 25 Oct 2013 06:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=BWZ12wWvenkw68PoymtUPInOiRvLuvgpTSPqkxz3Pf0=;
        b=T3nSkTlqnki2gS6xKbwhqX8wlL/Snld8+tBWuP/CcOhZBw5taODtb92cxJoWGkGqyy
         JybTwoBXCjm1oFmov1PhyRgxOjUT2NwrFxHlYTPydqDzmWsKMz2qG4D+8cotlYs4g5+8
         eRHXdiEldq73UarK9sW48vsLQEfEgfrRovGzs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=BWZ12wWvenkw68PoymtUPInOiRvLuvgpTSPqkxz3Pf0=;
        b=OVP/voEkhiih6AdIlWpj4zjCuhfCMNqoTBYHlO+Rc7ulHqsVFLB6ophnuTNa8tExBV
         njNbWMp4KuWNx+xnnqBL8uPrY7Wwd+k50kL9hnPvaUaGzGpWL1AEZ0BMEnLEfckkiV58
         IK5oYk9NiZGfVNyqxxKTGqqLzkQSST3dqCPayV2BTvPm1oa9AnEpPsAfhmA9RZ8i1zCg
         abF5NLxPoHU9ve2C9nQYfJFpBzlL6zqwJb5vWTJDWCzI0QwjiZ2bSYzGZ662T4ZQ1Qp8
         Azf/q5MPGfy7RfmhQjQVG+ZjulN/mnd4PK2GG9KKaFNKTbx9pMwAa/Qq/p/8GNJX3J0X
         VOYg==
X-Gm-Message-State: ALoCoQmuUGW3LxbFkMEFtHj10fT8CncRBeg0hNRY77ItHz0sCZGwQS/jSGFIA+/mjQSOMT4JsWCt
X-Received: by 10.194.21.104 with SMTP id u8mr2151757wje.63.1382709334574;
 Fri, 25 Oct 2013 06:55:34 -0700 (PDT)
Received: by 10.227.62.140 with HTTP; Fri, 25 Oct 2013 06:55:13 -0700 (PDT)
In-Reply-To: <20131024180357.GJ24180@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236703>

On Thu, Oct 24, 2013 at 6:03 PM, Jeff King <peff@peff.net> wrote:
> If `prepare_bitmap_walk` runs successfully, the resulting bitmap is
> stored and the equivalent of a `traverse_commit_list` call can be
> performed by using `traverse_bitmap_commit_list`; the bitmap version
> of this call yields the objects straight from the packfile index
> (without having to look them up or parse them) and hence is several
> orders of magnitude faster.

This is interesting, we didn't attempt it in JGit, but I can see how
it could be very useful.

> As an extra optimization, when `prepare_bitmap_walk` succeeds, the
> `reuse_partial_packfile_from_bitmap` call can be attempted: it will find
> the amount of objects at the beginning of the on-disk packfile that can
> be reused as-is, and return an offset into the packfile. The source
> packfile can then be loaded and the bytes up to `offset` can be written
> directly to the result without having to consider the entires inside the
> packfile individually.

Yay! This is similar to the optimization we use in JGit to send the
entire pack, but the part about sending a leading prefix is new. Do
you have any data showing how well this works in practice for cases
where offset is before than length-20?
