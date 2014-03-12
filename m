From: Brian Gesiak <modocache@gmail.com>
Subject: Re: [GSoC14][RFC] Proposal Draft: Refactor tempfile handling
Date: Wed, 12 Mar 2014 21:26:21 +0900
Message-ID: <CAN7MxmXzowHjPFKS_+Dw8n8GUX7ooqTXW6MAGpNLA-VxnFY9uQ@mail.gmail.com>
References: <CAN7MxmVQuk96dmXfxZ5kRZPTXNwpz2RY=y8HyqX4mZzrZUVbNg@mail.gmail.com>
	<531F3959.4060608@alum.mit.edu>
	<20140311180559.GB28154@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 12 13:26:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNiEt-0000Y4-Rp
	for gcvg-git-2@plane.gmane.org; Wed, 12 Mar 2014 13:26:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753467AbaCLM0X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2014 08:26:23 -0400
Received: from mail-ie0-f172.google.com ([209.85.223.172]:63199 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752558AbaCLM0W (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2014 08:26:22 -0400
Received: by mail-ie0-f172.google.com with SMTP id as1so10443354iec.17
        for <git@vger.kernel.org>; Wed, 12 Mar 2014 05:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=RTKvMZxOLI5Jvcy4XzQnzCBA+/FqNTFvKCozTrCTMPA=;
        b=HMAGmZ3MQ4xMXGJqc2Q/Oi0Vvvkk7hqmTyK3c4oLXIwNweYnKepW8jEW/1Fl5XXFMu
         J4MvFBh/tE48/X6v0DGhDvawMjzgygqTZJQs4UzAHwxcOZ1LdmlmP8twUjIDDQfqv13r
         VfPSbGhJerog72X/nfcMEzgO+SDufq6CFjeEwoLxlhGqsEjux414ajp9suPc7y3i1PaA
         9nTOPWkM1ayz6rEWYt5PNQ3Wfj39Rc627LSzv12d+3ju0ArbGkahIbmdm38UnUDfGURS
         nXln5dyN5EBEJ2cy9d8oXixHzp3DxB7nR4t2IM8hIHBAsrRzUQCo17JQShKhf+UBnsgg
         x8Gw==
X-Received: by 10.43.155.209 with SMTP id lj17mr93926icc.94.1394627181989;
 Wed, 12 Mar 2014 05:26:21 -0700 (PDT)
Received: by 10.64.55.161 with HTTP; Wed, 12 Mar 2014 05:26:21 -0700 (PDT)
In-Reply-To: <20140311180559.GB28154@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243934>

> Currently the linked list of lockfiles only grows, never shrinks.  Once
> an object has been linked into the list, there is no way to remove it
> again even after the lock has been released.  So if a lock needs to be
> created dynamically at a random place in the code, its memory is
> unavoidably leaked.

Ah yes, I see. I think a good example is
config.git_config_set_multivar_in_file, which even contains a comment
detailing the problem: "Since lockfile.c keeps a linked list of all
created lock_file structures, it isn't safe to free(lock).  It's
better to just leave it hanging around."

> But I have a feeling that if we want to use a similar mechanism to
> handle all temporary files (of which there can be more), then it would
> be a good idea to lift this limitation.  It will require some care,
> though, to make sure that record removal is done in a way that is
> threadsafe and safe in the event of all expected kinds of process death.

It sounds like a threadsafe linked-list with an interface to manually
remove elements from the list is the solution here; does that sound
reasonable? Ensuring thread safety without sacrificing readability is
probably more difficult than it sounds, but I don't think it's
impossible.

I'll add some more details on this to my proposal[1]. Thank you!

- Brian Gesiak

[1] https://www.google-melange.com/gsoc/proposal/review/student/google/gsoc2014/modocache/5629499534213120
