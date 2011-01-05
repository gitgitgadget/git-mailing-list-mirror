From: Shawn Pearce <spearce@spearce.org>
Subject: Re: concurrent fetches to update same mirror
Date: Wed, 5 Jan 2011 12:51:12 -0800
Message-ID: <AANLkTini61q+NtDr6oytTcfA6QNGN74L60exdLrNmakd@mail.gmail.com>
References: <ig2kjt$f2u$1@dough.gmane.org> <20110105204738.GA7629@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Neal Kreitzinger <neal@rsss.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jan 05 21:51:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PaaKZ-0000xx-JF
	for gcvg-git-2@lo.gmane.org; Wed, 05 Jan 2011 21:51:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752959Ab1AEUve (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Jan 2011 15:51:34 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:51366 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751989Ab1AEUvd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Jan 2011 15:51:33 -0500
Received: by iyi12 with SMTP id 12so14284750iyi.19
        for <git@vger.kernel.org>; Wed, 05 Jan 2011 12:51:33 -0800 (PST)
Received: by 10.231.15.202 with SMTP id l10mr7493737iba.19.1294260693040; Wed,
 05 Jan 2011 12:51:33 -0800 (PST)
Received: by 10.231.168.3 with HTTP; Wed, 5 Jan 2011 12:51:12 -0800 (PST)
In-Reply-To: <20110105204738.GA7629@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164594>

On Wed, Jan 5, 2011 at 12:47, Jeff King <peff@peff.net> wrote:
>
> However, in the default configuration, we fetch using a "+" refspec,
> which forces update of the ref even in the case of a non-fast-forward. I
> don't know whether that force also would override any lock-checking.

Nope, it doesn't.  We still use locking to update the refs, to ensure
the update is seen atomically by a reader.  The + just means don't
check that the old value is fully reachable from the new after the
lock as been taken.

If both fetch processes try to update the same ref at the same time,
one will get the lock and continue, and the other will crash with an
error (because the lock was busy).  If one is slightly slower than the
other, they will probably update the refs twice, with the slower fetch
updating what the faster one had just updated.  :-)

-- 
Shawn.
