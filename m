From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [RFC/PATCH 0/7] Rework git core for native submodules
Date: Sun, 7 Apr 2013 21:21:44 +0530
Message-ID: <CALkWK0=jrO9MQotB+anAn-5YtG1RBTLWEnGL5=K4wy=yi7E-CQ@mail.gmail.com>
References: <1365100243-13676-1-git-send-email-artagnon@gmail.com>
 <CALkWK0mM9HBUvHGHPEw4Vdosp_qfu_1L49TaZrzdC5n3soWkYg@mail.gmail.com>
 <7v61zz9fu3.fsf@alter.siamese.dyndns.org> <CALkWK0n64BW8zQXweR38T6DjT+iYBbsZDPCLZ-4igqGJHoFwKw@mail.gmail.com>
 <7vr4im7m1y.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 07 17:52:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOrtN-0003sU-Qy
	for gcvg-git-2@plane.gmane.org; Sun, 07 Apr 2013 17:52:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933899Ab3DGPwZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Apr 2013 11:52:25 -0400
Received: from mail-ie0-f172.google.com ([209.85.223.172]:41294 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933865Ab3DGPwZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Apr 2013 11:52:25 -0400
Received: by mail-ie0-f172.google.com with SMTP id c10so6054981ieb.31
        for <git@vger.kernel.org>; Sun, 07 Apr 2013 08:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=qf441T8ohkJ4KoHenkfVYo5nefAPeErDalOKLJ2sX2A=;
        b=mAD8MmSUD0w/EUVJlrD+VhSqn9qjQkDtji2ZhAx12zYZZpUoGO8W1UXN9/rEwZ3r3A
         TGnnvLeZ1HVdLk7WrVD0fUxlk0v3mXfeLxmmXAcuB994kZJhMcHDJfmEe7SuO90KFImL
         AauDduKHTn9DV3dNS2KJLUNvMubvgwto3bBIZYfPyMYT8HuK1qUEJVQ91HHPqaBBIps5
         p18satpV9EQ4K1f9nNT9aGYWh9y8GNh5+i1xDJNkAFlW+ihcuw/qempnIbEjyhldR1sO
         VySA3ADFXFIRKQOO7OToTGefAYMY7wYA0Gao75hAc8dyVL4tHNvjxYZwq6ToP1jY9qjc
         gCew==
X-Received: by 10.50.117.3 with SMTP id ka3mr4142817igb.107.1365349944846;
 Sun, 07 Apr 2013 08:52:24 -0700 (PDT)
Received: by 10.64.34.80 with HTTP; Sun, 7 Apr 2013 08:51:44 -0700 (PDT)
In-Reply-To: <7vr4im7m1y.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220320>

I suspect you're overtly worried about the fallout of such a
disruptive change.  If so, you could've just said: "Ram, I like the
idea.  But what breakages do you estimate we'll have to deal with?"
instead of attacking the idea and repeatedly questioning its purpose.
So, I'll make a rough guess based on the first iteration I intend to
get merged:

- Not all the git submodule subcommands will work. add/ status/ init/
deinit are easy to rewrite, but stuff like --recursive and foreach
might be slightly problematic as I already pointed out earlier.  We'll
have to code depending on how far you think the first iteration should
go.  After a few iterations, we can make 'git submodule' just print
"This command is deprecated.  Please read `man gitsubmodules`."

- All existing repositories with submodules will not be supported.  My
plan to deal with this: Have git-core code detect commit objects
in-tree and disable things like diff.  As soon as the user executes
the first 'git submodule' command, remove all existing submodules,
along with .gitmodules and re-add them as link objects.  Then print a
message saying: "We've just migrated your submodules to the new
format.  Please commit this."

That's really it.  It's certainly not earth-shattering breakage; and I
think the inconvenience it causes is more than compensated by its
beautiful design and UI/UX.
