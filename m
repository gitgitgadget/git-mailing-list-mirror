From: Conrad Irwin <conrad.irwin@gmail.com>
Subject: Re: [PATCH] Use a temporary index for interactive git-commit
Date: Thu, 30 Dec 2010 12:41:18 +0000
Message-ID: <AANLkTina562i6KzYR4AQbTNExJbCBA3bKHwA_7W45qAG@mail.gmail.com>
References: <1293670038-8606-1-git-send-email-conrad.irwin@gmail.com>
	<20101230043355.GA24555@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Dec 30 13:41:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PYHoq-0002BC-F7
	for gcvg-git-2@lo.gmane.org; Thu, 30 Dec 2010 13:41:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751557Ab0L3MlU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Dec 2010 07:41:20 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:50816 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751056Ab0L3MlT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Dec 2010 07:41:19 -0500
Received: by ywl5 with SMTP id 5so4434613ywl.19
        for <git@vger.kernel.org>; Thu, 30 Dec 2010 04:41:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=Ut27cevWLz1P38gtyOVJBwc/lpdUlPhA6pXtdm9UxDM=;
        b=XDt8gzT6n/3TZDNxTC33vrcXNhNgpbuMpQthQg7RozeJgO7F1sf8p1UpzsHeJT8kxN
         8EW2bhBZK0EArue1/frM/mnzKUJGD0jrTSZB17zdBn7G166Kcb/I+thKhHc95IA7ZlVi
         TCTAZVoTLP89bFsoK4+PYVivJX8JtZyLV/sDw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=aGuFm5xzVrRzgsP2+5N/SI0Mq4OxPb7r1YLibaLy3CQELzr3/ykln8THeuc9Rzf+mu
         be2f4hd0DRJamocGhT22wguiAAuh2lX4w3qK8KCDrc666Jigju7ISc4Hm3gfQ262aXh5
         HC5u8LRNii90e0vywdp/WbOl2U0SZRukqqM/E=
Received: by 10.236.111.38 with SMTP id v26mr2065408yhg.39.1293712878653; Thu,
 30 Dec 2010 04:41:18 -0800 (PST)
Received: by 10.236.105.206 with HTTP; Thu, 30 Dec 2010 04:41:18 -0800 (PST)
In-Reply-To: <20101230043355.GA24555@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164357>

On 30 December 2010 04:33, Jeff King <peff@peff.net> wrote:
>
> this behavior will not apply to "git add -p". So doesn't that introduce
> a new confusing inconsistency, that ^C from "git commit -p" abandons
> changes entirely, but from "git add -p" will silently stage changes?
>

That is an interesting observation. The intention of the commit was
not to make the
interactive add atomic, just isolated from the real index (much like
git commit /path/to/file.c
or git commit -a). This means that if you leave the commit message
empty (even after a
successful git-add--interactive) you have not staged any new files.

I'd agree that it would also make sense for git-add--interactive to be
atomic, so that when you
abort it forgets everything you've told it to do (and that this patch
highlights that very nicely).
At the moment git-add--interactive is atomic at a file level, i.e. it
remembers each decision for
git add --interactive, and for git add --patch, it saves your
decisions only once you've got to
the end of a file (not that you'd notice).

While I could fix git add -p in the same manner as git commit -p, by
using a temporary isolated
index, it would be better to change git-add--interactive directly, and
thus git checkout -p and
git reset -p too.

Conrad
