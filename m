From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 9/9] clone: run check_everything_connected
Date: Thu, 28 Mar 2013 07:40:51 +0700
Message-ID: <CACsJy8BMfYnFv=PL8x5JOMkjYc39h630oNEdukkjmBKBTNCibg@mail.gmail.com>
References: <20130325201427.GA15798@sigill.intra.peff.net> <20130325202627.GI16019@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 28 01:41:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UL0ue-00023y-EW
	for gcvg-git-2@plane.gmane.org; Thu, 28 Mar 2013 01:41:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754696Ab3C1AlY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Mar 2013 20:41:24 -0400
Received: from mail-oa0-f45.google.com ([209.85.219.45]:40321 "EHLO
	mail-oa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754392Ab3C1AlX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Mar 2013 20:41:23 -0400
Received: by mail-oa0-f45.google.com with SMTP id o6so9563377oag.32
        for <git@vger.kernel.org>; Wed, 27 Mar 2013 17:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=2alYP0ffzcpFs4IA5dzdIkYyXKqC65kMotAU0wwSSSc=;
        b=dsgzdYsGyYHXiV8cflu+SLrMhnK6djioMM6PWEOignIuY3N36ijmwfe6Kow251Cszl
         e2kDtMt9QtjTwxAlUMAOr3mzyTVjefo6sifzLKUig/gNQrtPbRUKjpwcRtiwkWtrmXDn
         rCznhQe5/Pj47cYS6jDC7MA+YBPVUtCVJtD4Cc9IEJFPJtGYG268DoUECWjmLpxM44ce
         s4+IO+u+9qfQGNgjS7rmA6zg6HyvamS9OaoP7Jc2z2o7s0FyCPjbnZqyT7+Ci5Lg6CDS
         D0wXjWZFbfoYO+Kp9BsTDgfsqDOfOmd0QM1eLbakl9qiKDRmH0EA7bNBeanUIbnm7New
         6IfQ==
X-Received: by 10.60.8.197 with SMTP id t5mr16666947oea.4.1364431282738; Wed,
 27 Mar 2013 17:41:22 -0700 (PDT)
Received: by 10.76.27.137 with HTTP; Wed, 27 Mar 2013 17:40:51 -0700 (PDT)
In-Reply-To: <20130325202627.GI16019@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219361>

On Tue, Mar 26, 2013 at 3:26 AM, Jeff King <peff@peff.net> wrote:
> The slowdown is really quite terrible if you try "git clone --bare
> linux-2.6.git". Even with this, the local-clone case already misses blob
> corruption. So it probably makes sense to restrict it to just the
> non-local clone case, which already has to do more work.
>
> Even still, it adds a non-trivial amount of work (linux-2.6 takes
> something like a minute to check). I don't like the idea of declaring
> "git clone" non-safe unless you turn on transfer.fsckObjects, though. It
> should have the same safety as "git fetch".

Maybe we could do it in index-pack to save some (wall) time. I haven't
tried but I think it might work. The problem is to make sure the pack
contains objects for all sha1 references in the pack. By that
description, we don't need to do standard DAG traversal. We could
extract sha-1 references in index-pack as we uncompress objects and
put all "want" sha-1 in a hash table. At the end of index-pack, we
check if any sha-1 in the hash table still points to non-existing
object.

This way, at least we don't need to uncompress all objects again in
rev-list. We could parse+hash in both phases in index-pack. The first
phase (parse_pack_objects) is usually I/O bound, we could hide some
cost there. The second phase is multithreaded, all the better.
-- 
Duy
