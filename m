From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: pack corruption post-mortem
Date: Sat, 19 Oct 2013 17:32:43 +0700
Message-ID: <CACsJy8ABdE8mZMVFZkqYMC4ZeN_baWw=XcYOZYBCZytWP97rRw@mail.gmail.com>
References: <20131016083400.GA31266@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Sat Oct 19 12:33:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VXTqR-0008NZ-CW
	for gcvg-git-2@plane.gmane.org; Sat, 19 Oct 2013 12:33:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751128Ab3JSKdP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Oct 2013 06:33:15 -0400
Received: from mail-oa0-f52.google.com ([209.85.219.52]:51055 "EHLO
	mail-oa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750843Ab3JSKdO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Oct 2013 06:33:14 -0400
Received: by mail-oa0-f52.google.com with SMTP id n10so1369273oag.25
        for <git@vger.kernel.org>; Sat, 19 Oct 2013 03:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=GoKM45xdMKNNtGwgMw0I3Nph8dxYKiRt0+49DPMnjrA=;
        b=YTxwdaGiuVPRGPod7ZWPH418Prca5bdgRXBpGXwnaAnZg60mfyeo00Q7HkedPboPSx
         Bvru0YloCla4aVzboehrPXRlYW68adZCE9DSdnFee9wze+iXdR1byeEVTscTtjl1AR/e
         YRVOYn126enWaYdAmxW79zg6zp2B0ucEx34lin1IubCI5GaO4ZmYg5/TCbk+tyxYrSRI
         Rg6gfzw2nl3QmE9TkM5mVWFluTkktHfMTSF2dYdwGmqlaWFBbvHoGtSndDxq7b2/TVPG
         K58nfZ4Rf68/LZjMVmJtrRUcnm1JlU62rfd5qy8C1Vvew9JssTCwEIK6/vN1PbRpj58e
         7snw==
X-Received: by 10.182.129.201 with SMTP id ny9mr10848604obb.0.1382178793979;
 Sat, 19 Oct 2013 03:33:13 -0700 (PDT)
Received: by 10.76.0.41 with HTTP; Sat, 19 Oct 2013 03:32:43 -0700 (PDT)
In-Reply-To: <20131016083400.GA31266@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236393>

On Wed, Oct 16, 2013 at 3:34 PM, Jeff King <peff@peff.net> wrote:
> I was recently presented with a repository with a corrupted packfile,
> and was asked if the data was recoverable. This post-mortem describes
> the steps I took to investigate and fix the problem. I thought others
> might find the process interesting, and it might help somebody in the
> same situation.
>
> I started with an fsck, which found a problem with exactly one object
> (I've used $pack and $obj below to keep the output readable, and also
> because I'll refer to them later):
>
>     $ git fsck
>     error: $pack SHA1 checksum mismatch
>     error: index CRC mismatch for object $obj from $pack at offset 51653873
>     error: inflate: data stream error (incorrect data check)
>     error: cannot unpack $obj from $pack at offset 51653873

I wonder if we should protect the sha-1 and pathname tables in packv4
with CRC too. A bit flipped in there could cause stream of corrupt
objects and make it hard to pinpoint the corrupt location..
-- 
Duy
