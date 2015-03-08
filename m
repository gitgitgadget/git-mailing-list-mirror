From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Git very slow ?
Date: Sun, 8 Mar 2015 12:46:07 -0700
Message-ID: <CA+55aFzDRg4kHHGGHd91kVxfj8eX0g1w5T7SyN_CouCf=_tW3A@mail.gmail.com>
References: <20150307013007.GA13250@milliways>
	<20150308155136.GA6273@vps892.directvps.nl>
	<87zj7nmpdp.fsf@fencepost.gnu.org>
	<20150308192045.GB32504@milliways>
	<87sidfmgag.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Ken Moffat <zarniwhoop@ntlworld.com>, Kevin D <me@ikke.info>,
	Git Mailing List <git@vger.kernel.org>
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Sun Mar 08 20:46:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YUh9S-0000C2-7h
	for gcvg-git-2@plane.gmane.org; Sun, 08 Mar 2015 20:46:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751767AbbCHTqJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Mar 2015 15:46:09 -0400
Received: from mail-ie0-f182.google.com ([209.85.223.182]:39998 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751343AbbCHTqI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Mar 2015 15:46:08 -0400
Received: by iecrp18 with SMTP id rp18so29906855iec.7
        for <git@vger.kernel.org>; Sun, 08 Mar 2015 12:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=BJJ/aoROw17FPtaQct+amwyuWJ368zAbUz4p/f+7MkA=;
        b=Po8GBKj0X8O3OsiDcOFSY79l/EplK821ZThY0qWYZtLv8RkC0YpkDDdyJwZUYzEMTf
         Du7bBgI+/iBlBTP0alhvrAq0UOMkLAjozgojU9iy2k3yIRRlSFClcm5Go5E2oN8//bXV
         R5SUH54/978iJgvLG0oMw/rwqs+Ad9sN9uTeMy5NrGr2LpaA7tnhSSIUW9HKdb74RtLh
         x/BQrzMYqmGcgZIx8M04Jlnq3yb8vZtLoiT04shvHaaZ0RQoG3nKzrGVdnKLS0afDK56
         MGGBRDGrf7ofJ8YNAkvdzUsRMraCnOLh/g9LGy9TDRrsu/ZlueSX7pmdZLolEsNv6tbV
         WFZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=BJJ/aoROw17FPtaQct+amwyuWJ368zAbUz4p/f+7MkA=;
        b=B3k4Nl0roqyHqrH+OQTz0vWU/nuXuMCl1DEiQjRCB+G/gyf79a73YoHQnV0VHH3Cqt
         JgnSHbDC1aFW0E1wJ99pYh9l1KzwptAV+omqEPqxCL4uHPTJMF8DMGE06HUnG7j27RDg
         QCVEGsDt/aMff0KBLeZqLEHtlXoZKE439ni/w=
X-Received: by 10.50.49.43 with SMTP id r11mr69657343ign.18.1425843967383;
 Sun, 08 Mar 2015 12:46:07 -0700 (PDT)
Received: by 10.36.60.9 with HTTP; Sun, 8 Mar 2015 12:46:07 -0700 (PDT)
In-Reply-To: <87sidfmgag.fsf@fencepost.gnu.org>
X-Google-Sender-Auth: 802iz01C6JxPYQggge3PxppVY6Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265108>

On Sun, Mar 8, 2015 at 12:37 PM, David Kastrup <dak@gnu.org> wrote:
>
> Since git blame outputs everything once it is finished ("the first
> screen" is purely the pager's business), it needs to unpack the entire
> history of the file (unless no blameable lines remain at all) and look
> at it.  6 seconds tends not to be all that excessive for extracting more
> than 5 years of a file's history.

Yeah, "git blame" can easily be several seconds without anything being wrong.

But "git commit" should be fairly instantaneous. Even over NFS.

That said, on NFS in particular, make sure you don't have

    [core]
        PreloadIndex = false

in your .gitconfig to disable the threaded index preloading.

But "core.preloadindex" _should_ be enabled by default in anything but
the most ancient git versions, and it can make a huge difference on
NFS because it allows the 'lstat()' calls to check that the index is
up-to-date to be done in parallel. Without that, git on NFS can be a
bit sluggish.

On local filesystems it normally doesn't make as much of a difference,
since things tend to be either cached or seek-limited.

                             Linus
