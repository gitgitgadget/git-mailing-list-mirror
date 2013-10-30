From: Vicent Marti <vicent@github.com>
Subject: Re: [PATCH 10/19] pack-bitmap: add support for bitmap indexes
Date: Wed, 30 Oct 2013 16:47:57 +0100
Message-ID: <CAFFjANQyMfV4M_wynPORfN2S1=eAdBxScgNYzD_dsRmKekp83Q@mail.gmail.com>
References: <20131024175915.GA23398@sigill.intra.peff.net> <20131024180357.GJ24180@sigill.intra.peff.net>
 <CAJo=hJvw-UNWVDADcGzA1P3GGOKJGh8h4LrETPYnjBNYmfkxjQ@mail.gmail.com> <20131030081023.GK11317@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Shawn Pearce <spearce@spearce.org>, git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Oct 30 16:48:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VbY0M-0007d4-Sc
	for gcvg-git-2@plane.gmane.org; Wed, 30 Oct 2013 16:48:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751596Ab3J3PsT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Oct 2013 11:48:19 -0400
Received: from mail-vc0-f180.google.com ([209.85.220.180]:38479 "EHLO
	mail-vc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751305Ab3J3PsS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Oct 2013 11:48:18 -0400
Received: by mail-vc0-f180.google.com with SMTP id lc6so1039279vcb.39
        for <git@vger.kernel.org>; Wed, 30 Oct 2013 08:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=a1qpFB3qEt8essZvX98u5FYlxMOPBGSpBr6hNCHRdHA=;
        b=b/a//6aU0hiT86H+/IItRTjKMI+/KxYZzZdGM85A2uZxFsNYVonyq943jfjnlxV2Do
         0J33fAZzUYyGs7OT4TE5E8xsUAUIGa4PYie7SsghdRsHie78SLicW2hdwL8qDFjt/nYu
         xcnQ2ocWa7hchPrkWLLdd8NySRbT291aumCMVXMZV2szY/8YZwQ3z22+Thze33w8Dj70
         +9i7tlugD+l/9A79HQFrI/cvgq8msiERD2JL0H+w4OzuOSuQ5pn2q7Sw598Idw1SZSY3
         aFqQIAQFX3Jg5GVhoCl172NtlWd/hZAwjfr0hDO76yHGdxmjXsbwAgSMiN1JXiKBo/mq
         uLjg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=a1qpFB3qEt8essZvX98u5FYlxMOPBGSpBr6hNCHRdHA=;
        b=hLwcVBaz3agZyMyfbfhgtZBMM0x4qKv75K4btbQL7DgJEBJU7KZA7p9/bc1QFM7p1T
         bu1vRKZ8mRwGEwBXXd4qbjOgNnFBBxSFot1TUAjWNaISaGl8FigBcm+NtuTNI02iBEcw
         pqFreckgJeF+Ouu0mtX9GRwusgdJR1XItKTXU=
X-Received: by 10.58.233.98 with SMTP id tv2mr3496166vec.11.1383148097922;
 Wed, 30 Oct 2013 08:48:17 -0700 (PDT)
Received: by 10.221.65.202 with HTTP; Wed, 30 Oct 2013 08:47:57 -0700 (PDT)
In-Reply-To: <20131030081023.GK11317@sigill.intra.peff.net>
X-Google-Sender-Auth: 09vbWdA0s7kPHYMp_moY0hIq_Ug
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237026>

On Wed, Oct 30, 2013 at 9:10 AM, Jeff King <peff@peff.net> wrote:
>
> In fact, I'm not quite sure that even a partial reuse up to an offset is
> 100% safe. In a newly packed git repo it is, because we always put bases
> before deltas (and OFS_DELTA objects need this). But if you had a bitmap
> generated from a fixed thin pack, we would have REF_DELTA objects early
> on that depend on bases appended to the end of the pack. So I really
> wonder if we should scrap this partial reuse and either just have full
> reuse, or go through the regular object_entry construction.
>
> Vicent, you've thought about the reuse code a lot more than I have. Any
> thoughts?

Yes, our pack writing and bitmap code takes enough precautions to
arrange the objects in the packfile in a way that can be partially
reused, so for any given bitmap file written from Git, I'd say we're
safe to always reuse the leader of the pack if this is possible.

For bitmaps generated from JGit, however, we cannot make this
assumption. I mean, we can right now (from my understanding of the
current implementation for pack-objects on JGit), but they are free to
change this in the future.

Obviously I intend to keep the pack reuse on production because the
CPU savings are noticeable, but we can drop it from the public
patchset. Ideally, we'd have full pack reuse like JGit, but we cannot
reasonably do that in GitHub because splitting a pack for the network
root would double our disk usage for all the forks.

luv,
vmg
