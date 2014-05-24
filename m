From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [BUG] auto-repack exits prematurely, locking other processing out
Date: Sat, 24 May 2014 08:26:56 +0700
Message-ID: <CACsJy8BfziZ7ciyKL0+X3rT9EfH_0E8nKNu9mTb_WSeTYWix_Q@mail.gmail.com>
References: <20140523195121.GA923@angband.pl> <xmqqy4xsgome.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Adam Borowski <kilobyte@angband.pl>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 24 03:27:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wo0kZ-0006NC-EB
	for gcvg-git-2@plane.gmane.org; Sat, 24 May 2014 03:27:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751017AbaEXB11 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 May 2014 21:27:27 -0400
Received: from mail-qg0-f53.google.com ([209.85.192.53]:39893 "EHLO
	mail-qg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750872AbaEXB11 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 May 2014 21:27:27 -0400
Received: by mail-qg0-f53.google.com with SMTP id f51so9167125qge.40
        for <git@vger.kernel.org>; Fri, 23 May 2014 18:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=GWRcBSD6FOrygANCN8izOVWIwDF04FdfUhqweoA/Uuw=;
        b=Q9CFluY+tw0cRHciMSLNPeBfID0ZgrDPxquYcE4NatvWlDUc0nqO1yQJn2JShJ0QGT
         +A4ltFcGZg+2VQqrAtq+u5nAwz058E0Mp/fPsxnNzvx+jnSUw3hcRxkf61axZIcpu/4c
         1UAX+9ZOkKwAYlkRrbfZFF9NdoIO/A+iq9GMWv9MOEHplccqx7lvZPezwSngPuF1oHbe
         3nshdnG22wPiKuBZnQ1lLcxNf8LI+GiIgdmxaK0qCiz45pN3PaI3/uhMc3rEO1vn6CsB
         dgM/oLgoqI+1wGcB2rOquXl+uAMxaWgHl7Vaq5cqbzCoM4GbLuWWpE1HWH7HO17vR9BX
         +D3g==
X-Received: by 10.140.107.137 with SMTP id h9mr11448508qgf.30.1400894846177;
 Fri, 23 May 2014 18:27:26 -0700 (PDT)
Received: by 10.96.138.9 with HTTP; Fri, 23 May 2014 18:26:56 -0700 (PDT)
In-Reply-To: <xmqqy4xsgome.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250048>

On Sat, May 24, 2014 at 4:40 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Duy, 9f673f94 (gc: config option for running --auto in background,
> 2014-02-08) turns to be not such a hot idea.  Sure, if we kick it
> off background after doing something heavy, immediately before
> giving control back to the end-user, and expect that the user will
> stay thinking without making new changes (i.e. read-only stuff like
> "git show" would be OK), then daemonize might be a great thing, but
> we forgot, while doing that commit, that long-running operations
> trigger the auto gc in the middle *and* they want it finish before
> they continue, as the purpose of gc is to help the performance
> during their further operation.

If by "long-running operations" you mean in a single process, it's my
first thought too but it looks like autogc is always called when the
process is all done and about to exit. The "git pull" case is
different because there's rebase after fetch. I see no easy way to
detect this kind of "middle of operation".

So we have two options: scripts should disable autogc before doing
things, a env variable would be more convenient than temporarily
updating gc.auto. Or we move "pack-refs" and "reflog expire" up,
before turning gc into a background task. Any locking will be
serialized this way. We could even go further to keep all but "repack"
in the background because it's "repack" that takes the longest time
(maybe "prune" coming close to second).
-- 
Duy
