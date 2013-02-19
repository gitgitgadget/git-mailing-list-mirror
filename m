From: Adam Spiers <git@adamspiers.org>
Subject: Re: [BUG] git-check-ignore: Segmentation fault
Date: Tue, 19 Feb 2013 13:40:17 +0000
Message-ID: <CAOkDyE_96Ef5CjoxNk3mbsNi+ZAuv6XeHcO7r8RQ-Of5ELsuKw@mail.gmail.com>
References: <CAKJhZwR7AT6VfCZYwaTvWYyjtYWg+RxBSmB5NaJY0LrqMUnD6A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Zoltan Klinger <zoltan.klinger@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 19 14:40:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7nR8-00086l-AT
	for gcvg-git-2@plane.gmane.org; Tue, 19 Feb 2013 14:40:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932829Ab3BSNkT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2013 08:40:19 -0500
Received: from mail-oa0-f51.google.com ([209.85.219.51]:62390 "EHLO
	mail-oa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932753Ab3BSNkR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2013 08:40:17 -0500
Received: by mail-oa0-f51.google.com with SMTP id h2so6892903oag.38
        for <git@vger.kernel.org>; Tue, 19 Feb 2013 05:40:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=HNmHShKx+krlC9K5Sn0vliuydmazW/S/dvBsHVkISMI=;
        b=0FeNNnRhg6yCRB8VF/Q5PRMFAZaKEif/vQfk4+HATEGfFOvwgRK7cNnu3pSHvRnxF+
         P79BQse5KkA1RqUpmzlDRqqrlcCVHM7ExvXraFk0guB+WPu/Bv9wKrvD9iPXUEYPfA4Z
         uDCEYn4R5btZIeNzAIzfK+etXk+ZO3EUW9rJmPuAing+ItHUdOteBKobck28Lw9FpLQy
         GxWRFoaPt+wpO+C0iyjgMwv60A5vzjHAewnnV7MWF3fYdmnzFblanTjRazPiagPbuSI4
         TATmLOWVs9Kmy6/xUQLLbxJw3jwnSAS2uCZJp2Z65AKBWl3DcebaiGAyuJ6XOulxmPhG
         wguQ==
X-Received: by 10.60.29.129 with SMTP id k1mr1091932oeh.8.1361281217116; Tue,
 19 Feb 2013 05:40:17 -0800 (PST)
Received: by 10.182.122.106 with HTTP; Tue, 19 Feb 2013 05:40:17 -0800 (PST)
In-Reply-To: <CAKJhZwR7AT6VfCZYwaTvWYyjtYWg+RxBSmB5NaJY0LrqMUnD6A@mail.gmail.com>
X-Google-Sender-Auth: I7C-Xnl2POhcI2I2h-fL98uc6HE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216616>

On Tue, Feb 19, 2013 at 5:24 AM, Zoltan Klinger
<zoltan.klinger@gmail.com> wrote:
> Hi there,
>
> The new git-check-ignore command seg faults when
>     (1) it is called with single dot path name at $GIT_DIR level  _AND_
>     (2) and .gitignore has at least one directory pattern.
>
> Git version: 1.8.2.rc0.16.g20a599e
>
> Reproduce the bug:
>     $ git --version
>     git version 1.8.2.rc0.16.g20a599e
>     $ mkdir test
>     $ cd test
>     $ git init
>     $ git check-ignore .  # All good, no errors here
>     $ echo "dirpattern/" > .gitignore
>     $ git check-ignore .
>     Segmentation fault (core dumped)
>
> The segmentation fault is actually caused by hash_name(const char
> *name, int namelen) function in name-hash.c when the 'name' argument
> is an empty stringi and namelen is 0.
>
> The empty string comes from a call to the prefix_path(prefix, len,
> path) function in setup.c. In this instance arguments 'prefix' is
> NULL, 'len' is 0 and 'path' is "." .

Good catch!  Thanks for the very helpful bug report.  I can reproduce
this, and have a fix - see follow-up mail to follow shortly.
