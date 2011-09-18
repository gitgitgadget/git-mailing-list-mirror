From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/3] fast-import: die if we produce too many
 (MAX_PACK_ID) packs
Date: Sun, 18 Sep 2011 14:17:41 -0500
Message-ID: <20110918191741.GD2308@elie>
References: <1316372508-7173-1-git-send-email-divanorama@gmail.com>
 <1316372508-7173-2-git-send-email-divanorama@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	David Barr <davidbarr@google.com>
To: Dmitry Ivankov <divanorama@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 18 21:18:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R5Msc-00063D-Bc
	for gcvg-git-2@lo.gmane.org; Sun, 18 Sep 2011 21:18:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756584Ab1IRTRq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Sep 2011 15:17:46 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:63143 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755856Ab1IRTRp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Sep 2011 15:17:45 -0400
Received: by iaqq3 with SMTP id q3so4483835iaq.19
        for <git@vger.kernel.org>; Sun, 18 Sep 2011 12:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Kdgz1/mrHBP0JEylBIIaJjdd0mGcPotOWsCXQF4Xus0=;
        b=IwjqFoRmbHHUhGoD7pOJdGz8p1frjVF+0mm01DDtGTVZCAyCTGFauru0BaYsfRpHd+
         8c+NctrO86tBLVxCgvtmcTlXnyr33liKYIEj5qLPpVBNGbGnQRhkDYxnBbXRsq2r28Nh
         deCBp3Cs7F6x/Iz0f1ns58O9Eu5VjC1hLWUjQ=
Received: by 10.42.145.137 with SMTP id f9mr3153274icv.128.1316373465054;
        Sun, 18 Sep 2011 12:17:45 -0700 (PDT)
Received: from elie (99-120-124-35.lightspeed.cicril.sbcglobal.net. [99.120.124.35])
        by mx.google.com with ESMTPS id el2sm21835040ibb.10.2011.09.18.12.17.43
        (version=SSLv3 cipher=OTHER);
        Sun, 18 Sep 2011 12:17:43 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1316372508-7173-2-git-send-email-divanorama@gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181626>

Dmitry Ivankov wrote:

> In fast-import pack_id is 16-bit with MAX_PACK_ID reserved to identify
> pre-existing objects. It is unlikely to wrap under reasonable settings
> but still things in fast-import will break once it happens.
>
> Add a check and immediate die() as the simplest reaction to being unable
> to continue the import.

Makes a lot of sense.  A few possible minor clarity improvements:

 - missing commas after "In fast-import" and before "with MAX_PACK_ID
   reserved"
 - "pre-existing objects": it would be clearer to say something like
   "objects this fast-import process instance did not write out to a
   packfile", like the comment before gfi_unpack_entry() does
 - I suppose "under reasonable settings" means "with a reasonable
   max-pack-size setting"?
 - "things will break" is a bit vague.
 - "immediate" -> "immediately"

Maybe:

	In fast-import, pack_id is a 16-bit unsigned integer, with MAX_PACK_ID
	(2^16 - 1) reserved for use by objects that are not in a packfile that
	this fast-import process instance wrote.  It is unusual for pack_id to
	hit MAX_PACK_ID with a reasonable --max-pack-size setting, but when it
	does, the pack_id stored in each "struct object_entry" wraps and
	fast-import gets utterly confused.

	Add a check and immediately die() so the operator can at least see what
	went wrong instead of experiencing an unexplained broken import.

With or without that clarification,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks!  A test would still be nice, if someone has time to write one.
