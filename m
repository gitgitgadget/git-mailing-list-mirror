From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [BUG?] gc and impatience
Date: Tue, 6 Aug 2013 07:44:00 +0530
Message-ID: <CALkWK0nj+NS-OzT6faaNpgA6iQgLaCSX1=fohAnzEWt9BGzFYw@mail.gmail.com>
References: <CALkWK0k2B5OW9zMrw0jBDDWpufojYDJybXa7jCBdzftNUc7mxA@mail.gmail.com>
 <CACsJy8DRo9Akoydwn9-EPOSyJiPhqAf1=HncYjHvXZwS4S_d7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 06 04:14:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V6WnO-0001aW-AL
	for gcvg-git-2@plane.gmane.org; Tue, 06 Aug 2013 04:14:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752728Ab3HFCOm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Aug 2013 22:14:42 -0400
Received: from mail-oa0-f44.google.com ([209.85.219.44]:33538 "EHLO
	mail-oa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752382Ab3HFCOl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Aug 2013 22:14:41 -0400
Received: by mail-oa0-f44.google.com with SMTP id l20so8102814oag.3
        for <git@vger.kernel.org>; Mon, 05 Aug 2013 19:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=INJpXopfQlYgVz/GwEgp9HtT2TMH/8v6BB0z33RaWmc=;
        b=E8elHf+UgrdhoZk5Ny5X2HCIcF8+NYDws+l14EhkjFdd1bd6q9zjoWbieuIjLf3NvK
         4M5C6d/xlW0g3bV9jOpV36nNttYTTrZCX2RE+cbP/TnH3WCmkfVBDe0YNuvzP2kJmjjj
         rxTURS+8LAyoKszAa2RCNBLYY7WCPm/IqYwVKkr6b04oXrMVukvOHur3Hy32aeV185Zz
         iHB7n090a5vc/cLxPFxD5c09FK7K4Su3b27UPmApx8nu0FJVCzQG4N1D8HCGobiH8PHV
         aJ6psWw5fZftbvjEBC8vv0hwC40S4lS+M1sNiZ6J65dMN9z/Wudz7luXrc1yydrJ2soq
         6Jig==
X-Received: by 10.50.134.162 with SMTP id pl2mr47260igb.55.1375755280867; Mon,
 05 Aug 2013 19:14:40 -0700 (PDT)
Received: by 10.64.37.130 with HTTP; Mon, 5 Aug 2013 19:14:00 -0700 (PDT)
In-Reply-To: <CACsJy8DRo9Akoydwn9-EPOSyJiPhqAf1=HncYjHvXZwS4S_d7A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231710>

Duy Nguyen wrote:
> Good point. I think that is because gc does not check if gc is already
> running. Adding such a check should not be too hard. I think gc could
> save its pid in $GIT_DIR/auto-gc.pid. The next auto-gc checks this, if
> the pid is valid, skip auto-gc.

Check.  I also talked about gc not catching SIGINT properly: I'm
looking the issue.

> Or you could just make a cron job to gc all repos every week and the
> problem goes away ;-)

Fundamentally, we need to fix these problems:

1. Don't make the repo unusable when a gc is running: I don't expect
anything more than minor annoyances after your patch is checked in.

2. Improve the IO profile, so gc doesn't aggressively hammer out tiny
fragmentations. For this, git-exproll.sh is definitely a step in the
right direction.

3. Improve how gc fundamentally works, so we can minimize rebuilds and
CPU time. jc's git merge-pack is interesting, but I'm not very hopeful
about a naive incremental-packing. We need to keep the major
undeltified objects near the top of the file, and build an idx sorted
by SHA-1; mangling the offsets in the header after a packfile has been
written is both complicated and dangerous (we might introduce subtle
bugs corrupting the packfile), I think. I haven't thought about it
hard enough though.

We'll tackle these problems bit by bit in future patches.

Thanks.
