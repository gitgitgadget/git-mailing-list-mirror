From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 2/4] pack v4: add v4_size to struct delta_base_cache_entry
Date: Sun, 15 Sep 2013 14:35:57 +0700
Message-ID: <CACsJy8CrEwt+WiE9_0CU-TqMCJtNgzouc3e=ifQR=5r+GRXUPQ@mail.gmail.com>
References: <1378982284-7848-1-git-send-email-pclouds@gmail.com>
 <1378982284-7848-2-git-send-email-pclouds@gmail.com> <alpine.LFD.2.03.1309130913510.20709@syhkavp.arg>
 <CACsJy8DrxQqvKyAH0trd1nDbFTL2Gq7k5O-shK4j8W6PMirNYw@mail.gmail.com>
 <alpine.LFD.2.03.1309132155540.20709@syhkavp.arg> <alpine.LFD.2.03.1309132351310.20709@syhkavp.arg>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Sun Sep 15 09:36:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VL6sv-0004wF-91
	for gcvg-git-2@plane.gmane.org; Sun, 15 Sep 2013 09:36:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752877Ab3IOHg3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Sep 2013 03:36:29 -0400
Received: from mail-oa0-f48.google.com ([209.85.219.48]:43178 "EHLO
	mail-oa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752712Ab3IOHg2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Sep 2013 03:36:28 -0400
Received: by mail-oa0-f48.google.com with SMTP id o17so2650133oag.35
        for <git@vger.kernel.org>; Sun, 15 Sep 2013 00:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=J1nhiZG/9oyomVScY3HIm5/3HF/iBRY6HluvAevEAoc=;
        b=uq5ZD6ucALzgX5/JAh/abARffkOWtWMp15Tz+LU3bkiFiFbySMv1c/Xw0pynTBTpyA
         X2GgTPB12XN4oYWF3BBdYZeC0GU28Fc7Hkfj6FZ9PcMULB4QXzVGqqPzFiQkbYFd6loS
         PuMttZHFKYS7N5ugQ7k6/HikC2nSoT/QfGkMjWTyoxV7cdbxXwkBcxGb1+bCWd5kS/L0
         AuUQ1UFqUOR20HWg7no93ZKaSJEqAsc8NY9vjppO2/grETbobdfkeQqe8RbStiiZ2F7M
         IYhzcSQDpk/owTpxK2GfYzSG+x261LmKm0OX59HyfNxzsKnAmm3amkNjwOkwmX9nSQXI
         uYYg==
X-Received: by 10.60.42.203 with SMTP id q11mr102085oel.54.1379230587695; Sun,
 15 Sep 2013 00:36:27 -0700 (PDT)
Received: by 10.182.49.233 with HTTP; Sun, 15 Sep 2013 00:35:57 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.03.1309132351310.20709@syhkavp.arg>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234809>

On Sat, Sep 14, 2013 at 11:22 AM, Nicolas Pitre <nico@fluxnic.net> wrote:
> The cache is currently updated by the caller.  The caller may ask for a
> copy of 2 entries from a base object, but that base object may itself
> copy those objects from somewhere else in a larger chunk.
>
> Let's consider this example:
>
> tree A
> ------
> 0 (0) copy 2 entries from tree B starting at entry 0
> 1 (2) copy 1 entry from tree B starting at entry 3
>
> tree B
> ------
> 0 (0) copy 6 entries from tree C starting at entry 0
> 1 (6) entry "foo.txt"
> 2 (7) entry "bar.txt"
>
> Right now, the code calls decode_entries() to decode 2 entries from tree
> B but those entries are part of a copy from tree C.  When that call
> returns, the cache is updated as if tree B entry #2 would start at
> offset 1 but this is wrong because offset 0 in tree B covers 6 entries
> and therefore offset 1 is for entry #6.
>
> So this needs a rethink.

I've given it some thought and see no simple/efficient way do it when
2+ depth is involved. Ideally tree A should refer to tree C directly
for the first two entries, but in general we can't enforce that a copy
sequence must refer to non-copy sequences only. Caching flattened tree
B up until the 6th entry may help, but then there's no need to cache
offsets anymore because we could just cache tree A..
--
Duy
