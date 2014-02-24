From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 00/19] Multiparent diff tree-walker + combine-diff speedup
Date: Tue, 25 Feb 2014 06:43:24 +0700
Message-ID: <CACsJy8BXMVNVAyqPEbHTkGxSSEJ6DpYUVwZqthiMQfO7Tj9T8A@mail.gmail.com>
References: <cover.1393257006.git.kirr@mns.spb.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Kirill Smelkov <kirr@mns.spb.ru>
X-From: git-owner@vger.kernel.org Tue Feb 25 00:44:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WI5Bp-0007KH-9c
	for gcvg-git-2@plane.gmane.org; Tue, 25 Feb 2014 00:44:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753237AbaBXXn4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Feb 2014 18:43:56 -0500
Received: from mail-qc0-f170.google.com ([209.85.216.170]:59325 "EHLO
	mail-qc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752903AbaBXXnz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Feb 2014 18:43:55 -0500
Received: by mail-qc0-f170.google.com with SMTP id c9so9749459qcz.15
        for <git@vger.kernel.org>; Mon, 24 Feb 2014 15:43:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=AJRsmVjxIaVm6dRGR0cHW8bwZCkZMoJIWtrW8lijZCE=;
        b=X0+PzSx9ervEInMJiKU1Ud0HzXB7bzfgMZCPx1jOvAOp0r3zbeJx4ubz0F4h1RTbxH
         gumMcCyHzBkJWh8RRRiKda4CEmgqgD5J6FoHhtF5KwzkXCN5OQo95TU41a07n+tWz7Og
         /v41uT8WJNQDYTkesJargCosZNRtIlFM7DNF+hGvLOaOqr5/cUiC3E8Y300xs2TI6URq
         +SjoOnWgWs0Dg30p/zu0fjApVfSxpIEBPGDGFUK3iMzUsTkcfuBFlnbQcNObs1dAAFaF
         D/ps/kQZ255zd9H0wzSl+dyPM3RO82j6xntzBovzzL9O/Wmi+9xJCzTJgictLu8qxjwc
         u+ow==
X-Received: by 10.224.36.129 with SMTP id t1mr33795825qad.8.1393285434755;
 Mon, 24 Feb 2014 15:43:54 -0800 (PST)
Received: by 10.96.215.102 with HTTP; Mon, 24 Feb 2014 15:43:24 -0800 (PST)
In-Reply-To: <cover.1393257006.git.kirr@mns.spb.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242655>

On Mon, Feb 24, 2014 at 11:21 PM, Kirill Smelkov <kirr@mns.spb.ru> wrote:
> Hello up there.
>
> Here go combine-diff speedup patches in form of first reworking diff
> tree-walker to work in general case - when a commit have several parents, not
> only one - we are traversing all 1+nparent trees in parallel.
>
> Then we are taking advantage of the new diff tree-walker for speeding up
> combine-diff, which for linux.git results in ~14 times speedup.

I think there is another use case for this n-tree walker (but I'm not
entirely sure yet as I haven't really read the series). In git-log
(either with pathspec or --patch) we basically do this

diff HEAD^ HEAD
diff HEAD^^ HEAD^
diff HEAD^^^ HEAD^^
diff HEAD^^^^ HEAD^^^
...

so except HEAD (and the last commit), all commits' tree will be
read/diff'd twice. With n-tree walker I think we may be able to diff
them in batch to reduce extra processing: commit lists are split into
16-commit blocks where 16 trees are fed to the new tree walker at the
same time. I hope it would make git-log a bit faster (especially for
-S). Maybe not much.
-- 
Duy
