From: Jean-Jacques Lafay <jeanjacques.lafay@gmail.com>
Subject: Re: [PATCH] git tag --contains : avoid stack overflow
Date: Mon, 12 Nov 2012 23:27:14 +0100
Message-ID: <CA+TMuX2p4ck0qXijH+OOcBoveBC42U8PqnXdisau57RXwt1isg@mail.gmail.com>
References: <1352568970-4669-1-git-send-email-jeanjacques.lafay@gmail.com>
	<03ED9D50D1F64467863C051959CFC433@PhilipOakley>
	<d9843c09-3ca9-406e-9df8-78603235d985@googlegroups.com>
	<509FD668.20609@lsrfire.ath.cx>
	<20121111165431.GA25884@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	msysgit@googlegroups.com, Git List <git@vger.kernel.org>,
	Philip Oakley <philipoakley@iee.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Nov 12 23:27:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TY2TZ-0007qC-Rf
	for gcvg-git-2@plane.gmane.org; Mon, 12 Nov 2012 23:27:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752666Ab2KLW1Q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 12 Nov 2012 17:27:16 -0500
Received: from mail-vb0-f46.google.com ([209.85.212.46]:56152 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752157Ab2KLW1P convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Nov 2012 17:27:15 -0500
Received: by mail-vb0-f46.google.com with SMTP id ff1so6812725vbb.19
        for <git@vger.kernel.org>; Mon, 12 Nov 2012 14:27:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=XOafkWT+ued9N5a/yUIV3Xh5ByzguHARvgAC+z9O+as=;
        b=jQ4p+nZDaBrJbnK40Xd3JPf/8h3EUNIdO5AzemkGCJSJE4B3VyfEhQp4gelnkODcKy
         HucXTgVI/rR89Q+B74paSUXcmvDigS4N+jYRJZgs4ExE1Mvp1qPWQzM3P0PZMesd+DNo
         /WoK63ETj8/qwULSuVHdmI6C1/aMKF+BGisqOL8rzoohClou06yxAWIKD7qf0HYRpRw4
         4dsW+CouGKwrvSBbGAs3MZm4QFvyPuhSZiJB/OJ0wkBXXDpRiO0GBkZKrthsGsO9WWSI
         5Aoix8YwW71qqLF56UKHkr9gK2eI4fQ9Vi0VcvxPAz3qC9HmW0nPP6BDd5EYegV5y0OE
         SgxA==
Received: by 10.52.180.5 with SMTP id dk5mr24275584vdc.45.1352759235005; Mon,
 12 Nov 2012 14:27:15 -0800 (PST)
Received: by 10.220.252.6 with HTTP; Mon, 12 Nov 2012 14:27:14 -0800 (PST)
In-Reply-To: <20121111165431.GA25884@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209536>

2012/11/11 Jeff King <peff@peff.net>:
> On Sun, Nov 11, 2012 at 05:46:32PM +0100, Ren=E9 Scharfe wrote:
>
> Ultimately, I have some ideas for doing this in a breadth-first way,
> which would make it more naturally iterative. It would involve having=
 N
> bits of storage per commit to check N tags, but it would mean that we
> could get accurate answers in the face of clock skew (like the
> merge-base calculation, it would merely get slower in the face of ske=
w).

I guess the optimal algorithm may also depend on the commit graph
general shape, but intuitively, I'd say that the critical factor is
the number and distribution of tags. As soon as you have a significant
number of tags (let's say 1% of the commits are tagged, evenly
distributed), you'll quickly end up with every commit marked as
containing or not the target commit, so that each additional tag check
is cheap.

This suggests a complexity of O(number of commits) more often then
not, however you choose to traverse the graph.

At least on my almost-real-life repo*, with ~140,000 commits and
~2,000 tags, tag --contains takes a few seconds, of course more than
the worst-case test on a 40,000 commit / 1 tag repo, but still in the
same order of magnitude.

* : meaning we're in the process of migrating from clearcase (deep
sighs allowed !), and for now I kept almost everything in a single git
repo, which may not be the eventual choice

Jean-Jacques.
