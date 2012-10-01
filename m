From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Using bitmaps to accelerate fetch and clone
Date: Mon, 1 Oct 2012 19:48:41 +0700
Message-ID: <CACsJy8Aikmf5vwNhLbELLKfyLLPTppWFvoqGOdSBZ2JoL1C_JQ@mail.gmail.com>
References: <CAJo=hJstK1tGrWhtBt3s+R1a6C0ge3wMtJnoo43Fjfg5A57eVw@mail.gmail.com>
 <CACsJy8AUdRyjSrAgM+ABzWet2NKz7N7M4re2QVoRPrrA=zfvvg@mail.gmail.com>
 <CAJo=hJsWczUqhvj6Kqsomeh9WxAAJO-Yc-=61k94jos6vVtEjQ@mail.gmail.com>
 <CACsJy8D5AXSWAdK7tgtXnE4Ro_+okaYM=zf9JnQfObkcx=FCOw@mail.gmail.com> <CAJo=hJs8TcU=Vvq4Re2aqTUrgRqiSyHs1rA+fPDHUkvrhwc3OA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Colby Ranger <cranger@google.com>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Oct 01 14:49:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TIfR5-0008Uf-Pn
	for gcvg-git-2@plane.gmane.org; Mon, 01 Oct 2012 14:49:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752987Ab2JAMtN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Oct 2012 08:49:13 -0400
Received: from mail-ia0-f174.google.com ([209.85.210.174]:42783 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752971Ab2JAMtN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Oct 2012 08:49:13 -0400
Received: by iagy32 with SMTP id y32so373809iag.19
        for <git@vger.kernel.org>; Mon, 01 Oct 2012 05:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=x/jwJqT5zb0KVOozGe3eW6N5+P94NJMkuFsBjLxE3aE=;
        b=EQAhnLrt6Rs7rZgsb0AndrEdYT9dCe8kx+JDNe/3XJonaRqeKpOiQQeK5nNVJUOHt3
         uZX8oeBduLfTpdh+1gyT89cfIOY5InlSdMSjnLzPGlM/0SQll8Myte+sXx8BymFDMHMT
         LQI9lnPZqlC/0X0NfTUy3gaIpRv6kEXRZHhDckBNSCM0ajzo/cN9eHixmTmXLd32kDRB
         IRz1zwB44sNu7m+Xe6NjJN6+s97FaXzlk6WnyKB5CEYJ5JKsDkILN54G3EWadZlgm071
         FqhF9IrYgp/2Hn47/mqNPvqKXVyAXFFNXYi/Hml6rZrHyEFkSgdGCnfEstblkW5Wy7MZ
         meqA==
Received: by 10.42.62.143 with SMTP id y15mr11155638ich.38.1349095752394; Mon,
 01 Oct 2012 05:49:12 -0700 (PDT)
Received: by 10.64.29.199 with HTTP; Mon, 1 Oct 2012 05:48:41 -0700 (PDT)
In-Reply-To: <CAJo=hJs8TcU=Vvq4Re2aqTUrgRqiSyHs1rA+fPDHUkvrhwc3OA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206731>

On Mon, Oct 1, 2012 at 9:26 AM, Shawn Pearce <spearce@spearce.org> wrote:
> One of the more troublesome problems is building the bitmaps is
> difficult from a streaming processor like index-pack. You need the
> reachability graph for all objects, which is not currently produced
> when moving data over the wire. We do an fsck after-the-fact to verify
> we didn't get corrupt data, but this is optional and currently after
> the pack is stored. We need to refactor this code to run earlier to
> get the bitmap built. If we take Peff's idea and put the bitmap data
> into a new stream rather than the pack-*.idx file we can produce the
> bitmap at the same time as the fsck check, which is probably a simpler
> change.

If we need to go through the whole pack, not random sha-1 access, then
index-pack's traversal is more efficient. I have some patches that
remove pack-check.c and make fsck use index-pack to walk through
packs. It takes much less time. But rev walk for building bitmaps
probably does not fit this style of traversal because rev walk does
not align with delta walk.

> Defining the pack's "edge" as a list of SHA-1s not in this pack but
> known to be required allows us to compute that leaf root tree
> reachability once, and never consider parsing it again. Which saves
> servers that host frequently accessed Git repositories but aren't
> repacking all of the time. (FWIW we repack frequently, I hear GitHub
> does too, because a fully repacked repository serves clients better
> than a partially packed one.)

Probably off topic. Does saving a list of missing bases in the pack
index help storing thin packs directly? I may be missing some points
because I don't see why thin packs cannot be stored on disk in the
first place.
-- 
Duy
