From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] sha1_name: fix segfault caused by invalid index access
Date: Sun, 28 Feb 2010 11:25:50 -0500
Message-ID: <20100228162550.GA7315@coredump.intra.peff.net>
References: <1267372155-7578-1-git-send-email-markus.heidelberg@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: Markus Heidelberg <markus.heidelberg@web.de>
X-From: git-owner@vger.kernel.org Sun Feb 28 17:26:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nllxw-0007gR-7B
	for gcvg-git-2@lo.gmane.org; Sun, 28 Feb 2010 17:26:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030288Ab0B1QZz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Feb 2010 11:25:55 -0500
Received: from peff.net ([208.65.91.99]:59390 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030247Ab0B1QZy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Feb 2010 11:25:54 -0500
Received: (qmail 30018 invoked by uid 107); 28 Feb 2010 16:26:12 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 28 Feb 2010 11:26:12 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 28 Feb 2010 11:25:50 -0500
Content-Disposition: inline
In-Reply-To: <1267372155-7578-1-git-send-email-markus.heidelberg@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141255>

On Sun, Feb 28, 2010 at 04:49:15PM +0100, Markus Heidelberg wrote:

> It can be reproduced in a bare repository with
>     $ git show :anyfile
> 
> I didn't find a recipe for reliably reproducing it in a repository with
> working tree, it happened depending on the filename and the repository.
>     $ git show :nonexistentfile

I can confirm the bug here. It is not about bareness, but having no
index makes it easy to trigger, since it is easy to walk past the end of
a zero-length index. But it is not restricted to that case:

> It seemed to happen more likely with high letters (x, y, z) as the first
> character of the filename. This always worked for me:
>     $ git show :z
> But I found this to be too strange to be added to the commit message.

That's because cache_name_pos returns the position where the entry
_would_ be if it existed (well, the negation minus one, but the intent
is you can reconstruct that position if you did want to insert it). The
diagnose_invalid function then looks at that entry to see if it is a
missing filename or a missing stage. But of course, if it would be
inserted past the end of what exists in the index, there is nothing to
look at. So your ":z" is simply about being at the end of the index,
which is sorted alphabetically.

Which means your fix (to make sure we are not at the end) is correct.

-Peff
