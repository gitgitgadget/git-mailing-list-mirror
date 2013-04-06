From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [RFC/PATCH 0/7] Rework git core for native submodules
Date: Sun, 7 Apr 2013 01:40:32 +0530
Message-ID: <CALkWK0mM9HBUvHGHPEw4Vdosp_qfu_1L49TaZrzdC5n3soWkYg@mail.gmail.com>
References: <1365100243-13676-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Apr 06 22:11:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOZSU-0003Gf-ID
	for gcvg-git-2@plane.gmane.org; Sat, 06 Apr 2013 22:11:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161118Ab3DFULP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Apr 2013 16:11:15 -0400
Received: from mail-ie0-f182.google.com ([209.85.223.182]:37829 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161108Ab3DFULO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Apr 2013 16:11:14 -0400
Received: by mail-ie0-f182.google.com with SMTP id at1so5538300iec.13
        for <git@vger.kernel.org>; Sat, 06 Apr 2013 13:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=WyEla+gOpNE8v3Vt8+6+5v/m5m16U+NvJfLEQZzBR4A=;
        b=rBotjXJ7Xgw6KCEXtzng1ylLm3XO0Rn4RUveGz0WaL2TEcm7BLoTPxz/mSYRfAaDQk
         6rgVKi1bPZHR3nm53lAOy/0qHk5s4E6N5aNFgRN76xYam3cs/w53VChWPPvun2BwKZK8
         uqQzfp+53+Ptsof3ZBxWZ+ujKyeHX794jXu6TX74VRSc3OEBMuJRJCaz7saANVIOU+Mf
         /5F3heh7hC3USGpoZPNqQZRPrkuYiVqJwfkX3qFZXLEp5DmB0bhE7GZUwnrmWp3B+srD
         92YEu/tcnjZbptXRlUsoyt0FEVAG172hxOHTGdC1FFRVPG/ELb7fI2OKC2rgkXOdfiuj
         iVWw==
X-Received: by 10.42.50.202 with SMTP id b10mr8437090icg.7.1365279073700; Sat,
 06 Apr 2013 13:11:13 -0700 (PDT)
Received: by 10.64.34.80 with HTTP; Sat, 6 Apr 2013 13:10:32 -0700 (PDT)
In-Reply-To: <1365100243-13676-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220271>

Hi again,

So we've thought about it for some time, and I really need you to
start reviewing the code now.
I'll just summarize what we've discussed so far:

1. The malleability argument doesn't hold, because we're proposing a
link object with optional fields.

2. The local-fork argument doesn't hold, because users will be
rebasing changes to the link object in exactly the same way as they
currently do with the blob object .gitmodules.

3. The worktree argument doesn't hold, because we're proposing to
treat the link object as nothing more than a blob object that can be
parsed by git-core.  It will stage and unstage just like a blob.
Sure, it's not accessible directly by the filesystem: so what?  What
is the difference does `emacsclient .gitmodules` versus `git edit-link
clayoven` make to the end-user?

4. The diff-confusion argument is just another by-the-way, but it
doesn't really hold either.  Currently, we see:

    - Subproject commit b83492
    + Subproject commit 39ab2f

(with diff.submodule set to log, we can actually see the log of the
submodule between these two commits.  With links, we will see:

    - checkout_rev = b83492
    + checkout_rev = 39ab2f

There's nothing that prevents us from respecting diff.submodule (some
minor glue code will have to be written; that's all).

*. There is actually one thing that .gitmodules does better than
links.  foreach.  It's trivial to implement with .gitmodules and hard
to implement with links: with .gitmodules, the paths of all the
submodules are in one place.  But with links, we'll have to
unpack_trees() every tree in the entire repository, and dig through it
to find all the link objects to initialize.  Basically, inefficient
and inelegant.  However, I don't think this is a big problem in
practice, since this is not exactly a common operation: I'd probably
want to recurse-submodules once at clone time.
