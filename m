From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: Can a git push over ssh trigger a gc/repack? Diagnosing pack explosion
Date: Thu, 21 Nov 2013 10:35:39 -0500
Message-ID: <CACPiFC+xbnYjZUG49Em=aDUXnS_3_Cp=ZZBCrQCHM-sL78HCdA@mail.gmail.com>
References: <CACPiFC+TqD_DhMaG+posoK4fTOLCoi=3jhJUPjt_72HTm9xjeQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Sam Coffland <sam.coffland@remote-learner.net>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Nov 21 16:36:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VjWIg-0005G0-PA
	for gcvg-git-2@plane.gmane.org; Thu, 21 Nov 2013 16:36:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754530Ab3KUPgD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Nov 2013 10:36:03 -0500
Received: from mail-vb0-f54.google.com ([209.85.212.54]:43849 "EHLO
	mail-vb0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754517Ab3KUPgA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Nov 2013 10:36:00 -0500
Received: by mail-vb0-f54.google.com with SMTP id p6so4840769vbe.27
        for <git@vger.kernel.org>; Thu, 21 Nov 2013 07:35:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=uhrRMnuQb0NgbVL3lrv5q8z//AhIfyAsP79cOXTl4WE=;
        b=g9xErnKZVQ6r8xrh6w/a0o8tO1yMvz1bTnjl29esWC6uABUeMowSPPaexYbccR2eVV
         pDdU+6yWp4tFSFuz4fdgHa+/IybJ6K3czjx9Mm+03MNaAaAInUDJsiWvwJtED+K06HYk
         gKwmwKF3QCw1wfsDo37kXR05UAIzRk0jnTaCRuAkK6IXJxJgs5u/V7y//B9J+TOmevKK
         Jaf/ci72UyP4h62o8Q1f/P+lJLc7aEfZ+WdaEm5BcqmurkyJgLPc8MlJoyYzN8QzErH4
         2IF5W6Lp2+aMB6tb07GP5ivmHWtormujHwJ/iGfuBMJxg8UAYM5kNYnqF5Owyey93KXJ
         ZsKg==
X-Received: by 10.52.182.39 with SMTP id eb7mr5182624vdc.6.1385048159835; Thu,
 21 Nov 2013 07:35:59 -0800 (PST)
Received: by 10.221.61.210 with HTTP; Thu, 21 Nov 2013 07:35:39 -0800 (PST)
In-Reply-To: <CACPiFC+TqD_DhMaG+posoK4fTOLCoi=3jhJUPjt_72HTm9xjeQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238127>

On Thu, Nov 21, 2013 at 10:21 AM, Martin Langhoff
<martin.langhoff@gmail.com> wrote:
> Do client pushes over git+ssh ever trigger a repack on the server?

man git-config
[snip]

       receive.autogc
           By default, git-receive-pack will run "git-gc --auto" after
           receiving data from git-push and updating refs. You can stop it by
           setting this variable to false.

Oooooops!

Ok, couple problems here:

 - if it's receiving from many pushers, it races with itself; needs
some lock or back-off mechanism

 - alternatively, an splay mechanism. We have a "hard" threshold...
given many "pushers" acting in parallel, they'll all hit the threshold
at the same time. There is no need for this, we could randomize the
threshold by 20%; that would radically reduce the racy-ness

 - auto repack in this scenario has a reasonable likelihood if being
visited by the OOM killer -- therefore it needs to fail more
gracefully, for example with tmpfile cleanup. Perhaps by having the
tmpfiles places in a tmpdir named with the pid of the child would make
this easier...

Naturally, I'll move quickly to disable this evil-spawn-automagic
setting and setup a cronjob. But I think it is possible to have
defaults that work more reliably and with lower risk of explosion.

thoughts?



m
-- 
 martin.langhoff@gmail.com
 -  ask interesting questions
 - don't get distracted with shiny stuff  - working code first
 ~ http://docs.moodle.org/en/User:Martin_Langhoff
