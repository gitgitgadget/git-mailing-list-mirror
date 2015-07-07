From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] index-pack: fix allocation of sorted_by_pos array
Date: Tue, 7 Jul 2015 07:36:23 +0700
Message-ID: <CACsJy8CsUu1zEnah9Ah3tQxk8N-xPpOBuV5TpQ4EB6+nyiDW3g@mail.gmail.com>
References: <1429354025-24659-1-git-send-email-pclouds@gmail.com>
 <1429354025-24659-3-git-send-email-pclouds@gmail.com> <xmqqoajt5glu.fsf@gitster.dls.corp.google.com>
 <CACsJy8D872sj9WQec_FZrTxx=gqy++L1XLxJdEtEQNpGpFYr=Q@mail.gmail.com>
 <xmqqzj3c3efv.fsf_-_@gitster.dls.corp.google.com> <xmqqr3on369x.fsf_-_@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 07 02:37:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCGsd-0003iy-1Z
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jul 2015 02:36:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754365AbbGGAgz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jul 2015 20:36:55 -0400
Received: from mail-ie0-f177.google.com ([209.85.223.177]:36135 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753238AbbGGAgx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jul 2015 20:36:53 -0400
Received: by iecvh10 with SMTP id vh10so124629232iec.3
        for <git@vger.kernel.org>; Mon, 06 Jul 2015 17:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=o1hCClVytDzVUlOVrdMaBN3y8dHijfcRmuRfKTPYmuc=;
        b=G+GhjWvJXszGKr2YGoap+udoINuqNIYw3gZ5+0ePcxSM9faHVbLnBjioNUQ8UyFk+b
         fbNud8yd3KSYMv0Nef3E7cqKVuXAHXPEq2P5ERtiSs5UUHJyPMAKaJYD3dFDZnE9AtZg
         s93bdHQGLjTMdn10ebKOUeZi06QuWyDiGKeCoiOflrpSv4E0VK8Z8xUJGL/CEuFKXzWv
         anSwZxLwZvwif/Yx0gPsQX7MMuox6c4Beq72dF8fN3lR3GtI2SD6T4fr2J+uqhuAnxsK
         cM6Lcqj+h+BqvaKiQELHw17096gB0zwPV+yHGw8V1MuVYoFp3XQrrXp37aVyjomIl5Ju
         uvyA==
X-Received: by 10.42.244.4 with SMTP id lo4mr39332383icb.65.1436229413114;
 Mon, 06 Jul 2015 17:36:53 -0700 (PDT)
Received: by 10.107.16.15 with HTTP; Mon, 6 Jul 2015 17:36:23 -0700 (PDT)
In-Reply-To: <xmqqr3on369x.fsf_-_@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273471>

On Sun, Jul 5, 2015 at 5:30 AM, Junio C Hamano <gitster@pobox.com> wrote:
> When c6458e60 (index-pack: kill union delta_base to save memory,
> 2015-04-18) attempted to reduce the memory footprint of index-pack,
> one of the key thing it did was to keep track of ref-deltas and
> ofs-deltas separately.
>
> In fix_unresolved_deltas(), however it forgot that it now wants to
> look only at ref deltas in one place.  The code allocated an array
> for nr_unresolved, which is sum of number of ref- and ofs-deltas
> minus nr_resolved, which may be larger or smaller than the number
> ref-deltas.  Depending on nr_resolved, this was either under or over
> allocating.

It's either that or we could put back "if (real_type != OBJ_REF_DELTA)
continue;" in the sorted_by_pos population loop. Resolved deltas can't
have real_type == OBJ_REF_DELTA, so if we allocate nr_unresolved, it's
guaranteed over-allocation, never under-allocation. But I guess your
approach would make the code easier to read.

I keep tripping over this "real_type vs type" in this code. What do
you think about renaming "type" field to "in_pack_type" and
"real_type" to "canon_type" (or "final_type")? "Real" does not really
say anything in this context..
-- 
Duy
