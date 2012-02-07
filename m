From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 3/6] Stop producing index version 2
Date: Tue, 7 Feb 2012 15:51:54 +0700
Message-ID: <CACsJy8DBenQGrF4-X-rsUmJQUhx6MMQg+8Yrspjuxx6W6L48AQ@mail.gmail.com>
References: <1328507319-24687-1-git-send-email-pclouds@gmail.com>
 <1328507319-24687-3-git-send-email-pclouds@gmail.com> <7v4nv4a131.fsf@alter.siamese.dyndns.org>
 <CAJo=hJvtRnmvALcn3vKpYTr3j6ada8iboPjWN3cQnwwKzRvrDA@mail.gmail.com> <CACsJy8Ayqea75xeFKJNm6iT7GSUGDEfvZD17uEv7ihr4SS2LMg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Thomas Rast <trast@inf.ethz.ch>,
	Joshua Redstone <joshua.redstone@fb.com>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Feb 07 09:52:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rugmt-0000NY-Jl
	for gcvg-git-2@plane.gmane.org; Tue, 07 Feb 2012 09:52:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756700Ab2BGIw1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Feb 2012 03:52:27 -0500
Received: from mail-we0-f174.google.com ([74.125.82.174]:42561 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756659Ab2BGIw0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Feb 2012 03:52:26 -0500
Received: by werb13 with SMTP id b13so4847040wer.19
        for <git@vger.kernel.org>; Tue, 07 Feb 2012 00:52:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=OPZj3s866fomNsjnwMd8HQ7qpJqzXSOKlWtFqJz35ME=;
        b=WnKsDxburHBZuRGqfy4Nr0zduxqlQwnoeWSCDUA7s3cIUxbI/0ZvbE+02POxPpg7ae
         kTHX8o5Y4kOvrINeCV42F/WDyT8RKECK7m+fXpNYK5VC8UU1szpw6kQsuOf4jGRO13ID
         yTHlytkFT3o5hv74U66XAjknqQhOaZ5H9bgR4=
Received: by 10.216.52.198 with SMTP id e48mr4702591wec.18.1328604745227; Tue,
 07 Feb 2012 00:52:25 -0800 (PST)
Received: by 10.223.2.139 with HTTP; Tue, 7 Feb 2012 00:51:54 -0800 (PST)
In-Reply-To: <CACsJy8Ayqea75xeFKJNm6iT7GSUGDEfvZD17uEv7ihr4SS2LMg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190155>

On Tue, Feb 7, 2012 at 11:50 AM, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
>> Version 3 was a mistake because of the variable length record sizes.
>> Saving 2 bytes on some records that don't use the extended flags makes
>> the index file *MUCH* harder to parse. So much so that we should take
>> version 3 and kill it, not encourage it as the default!
>
> Probably too late for that, but it's good to know there are strong
> user base for v2.

OK probably not too late. We cannot kill it, but we could deprecate
it. We can introduce a mandatory extension to store extra flags. The
extension is basically an array of

struct ce_extended_flags {
    int ce_index; /* points to istate->cache[ce_index] */
    unsigned long flags;
};

On reading the extension, extra flags is applied back in mem, the
extension is created again when new index is written. There are only
two users of index v3: skip-worktree and intent-to-add bits, which are
not used often, I think. Still want to kill it?

Switching from sha-1 to crc32 could be done the same way (i.e. new
mandatory extension _at the end_ that contains crc32 checksum and skip
sha-1 check on reading if it's all zero) if we agree to move to crc32.
-- 
Duy
