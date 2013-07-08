From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: A local shared clone is now much slower
Date: Mon, 8 Jul 2013 15:57:04 +0700
Message-ID: <CACsJy8Chmm0=wDV4NQ+4Gh7KZYpbd9qkb=pNzkPeG-a-xiwVmw@mail.gmail.com>
References: <20130708130355.647fffb6e5b6a453bfa0fa6e@canb.auug.org.au> <20130708073041.GA25072@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Linus <torvalds@linux-foundation.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jul 08 10:57:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uw7GO-0000p5-JO
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jul 2013 10:57:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752524Ab3GHI5g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jul 2013 04:57:36 -0400
Received: from mail-ob0-f171.google.com ([209.85.214.171]:34843 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752467Ab3GHI5f (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jul 2013 04:57:35 -0400
Received: by mail-ob0-f171.google.com with SMTP id dn14so5295141obc.30
        for <git@vger.kernel.org>; Mon, 08 Jul 2013 01:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=5wKvaPyYAcGoxTeHO2l+mrl7kce/09udtoyN97frwqA=;
        b=NUVxCtGWx6p1nFkS3u7mWYdp2I+C7Ukbgw4hUtvSOrqv7cR2hQjAE83tHBdTV5dV3N
         WeId1YJyz97l9jMBLoBtaxuIJ47krn3IeXE5xdYR3rLF1gk7aiUtTTK2tZeCImGpHfSN
         i9kj/L9o2JGX+s8n7OJdVU7DVWHvZVoT724wkc2v20f6bmxYbQU9pyfH9VAsDjn36Uon
         +B4OzOW2Vr4sn6wnbEWjsqOTEtq2MHGm+5OBKf04fT51aClf+yGVa5fc32zehSS60bfe
         lhMuvcphIsYahmKG8xlcmObWznf4WV3XnYA6lI82Xh5/yeM+sXKB8erDPXeQUmkn1hOK
         XPwQ==
X-Received: by 10.60.102.202 with SMTP id fq10mr19613269oeb.42.1373273854440;
 Mon, 08 Jul 2013 01:57:34 -0700 (PDT)
Received: by 10.76.88.230 with HTTP; Mon, 8 Jul 2013 01:57:04 -0700 (PDT)
In-Reply-To: <20130708073041.GA25072@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229830>

On Mon, Jul 8, 2013 at 2:30 PM, Jeff King <peff@peff.net> wrote:
> Subject: [PATCH] clone: drop connectivity check for local clones
>
> Commit 0433ad1 (clone: run check_everything_connected,
> 2013-03-25) added the same connectivity check to clone that
> we use for fetching. The intent was to provide enough safety
> checks that "git clone git://..." could be counted on to
> detect bit errors and other repo corruption, and not
> silently propagate them to the clone.
>
> For local clones, this turns out to be a bad idea, for two
> reasons:
>
>   1. Local clones use hard linking (or even shared object
>      stores), and so complete far more quickly. The time
>      spent on the connectivity check is therefore
>      proportionally much more painful.

There's also byte-to-byte copy when system does not support hardlinks
(or the user does not want it) but I guess it's safe to trust the OS
to copy correctly in most cases.

>   2. Local clones do not actually meet our safety guarantee
>      anyway. The connectivity check makes sure we have all
>      of the objects we claim to, but it does not check for
>      bit errors. We will notice bit errors in commits and
>      trees, but we do not load blob objects at all. Whereas
>      over the pack transport, we actually recompute the sha1
>      of each object in the incoming packfile; bit errors
>      change the sha1 of the object, which is then caught by
>      the connectivity check.

We used to, before d21c463 (fetch/receive: remove over-pessimistic
connectivity check - 2012-03-15). But back then we did not even do
connectivity check in clone.

> This patch drops the connectivity check in the local case.
> Note that we have to revert the changes from 0433ad1 to
> t5710, as we no longer notice the corruption during clone.
>
> We could go a step further and provide a "verify even local
> clones" option, but it is probably not worthwhile. You can
> already spell that as "cd foo.git && git fsck && git clone ."
> or as "git clone --no-local foo.git".

Faster clones make everybody happy :-)
--
Duy
