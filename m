From: Paul Tan <pyokagan@gmail.com>
Subject: Re: [GSoC microproject] Add XDG support to the credential-store helper
Date: Fri, 6 Mar 2015 16:04:39 +0800
Message-ID: <CACRoPnR3i3pTyqcxm0iELP0uR9cL2kvm9fd7BQPVpbLB0UBNVw@mail.gmail.com>
References: <20150305215146.394caa71@gentp.lnet>
	<CAP8UFD3kHKsUWqmfr3mEtTYwVFwGGqMF_wJgVQyoaH=2i9Ge=A@mail.gmail.com>
	<20150306001534.06882282@gentp.lnet>
	<20150306004139.2dac2502@gentp.lnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
To: Luis Ressel <aranea@aixah.de>
X-From: git-owner@vger.kernel.org Fri Mar 06 09:04:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTnFY-00028U-DK
	for gcvg-git-2@plane.gmane.org; Fri, 06 Mar 2015 09:04:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754340AbbCFIEn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Mar 2015 03:04:43 -0500
Received: from mail-la0-f49.google.com ([209.85.215.49]:38638 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754304AbbCFIEk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Mar 2015 03:04:40 -0500
Received: by labgf13 with SMTP id gf13so31474680lab.5
        for <git@vger.kernel.org>; Fri, 06 Mar 2015 00:04:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=09hajDhBA2A5SbZp2/4v4c+xl+PDvRgIXV9PIPO6wU4=;
        b=fmiraKsL96VjC0KGslscp1DFFHwQ2IBq1cG3nKQcpaIXpOGNHUb9jQoN/SLEhvuPT2
         CjJjj2xWOOhXXgZnMtTLksTyYcYStLsC2FQQ9rC6O3Dqv73SS+LlVm6/itefHWsk4dXn
         fcwf26+DO3UBPwgMuV1Fiwa3XyjEjV+FaKDegAVz/20vt2KahgA49cknVj6nKixXEKhg
         x+svEdE5LmpZJTHZe+CCi1dq+SLGVwTXrWyrPfF3gaOwalnW7+uq+dWO2TLYZL7DtvPg
         GEB5yKZ9FjvN+10kBkXOV16GDOsVrkQ27ni0UTVMF04QB82AhZbA7yCWfBVIIl9TeXWz
         8vCA==
X-Received: by 10.152.87.115 with SMTP id w19mr6227082laz.66.1425629079125;
 Fri, 06 Mar 2015 00:04:39 -0800 (PST)
Received: by 10.112.130.228 with HTTP; Fri, 6 Mar 2015 00:04:39 -0800 (PST)
In-Reply-To: <20150306004139.2dac2502@gentp.lnet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264895>

Hi Luis,

On Fri, Mar 6, 2015 at 7:41 AM, Luis Ressel <aranea@aixah.de> wrote:
> Okay, I've had a look at Paul's patch for this. Sorry again for the
> dupe, I must've missed it before. I guess I'll attempt another
> microproject.
>
> However, I feel like my patch is really all that's neccessary; I don't
> think we should try to use both files if they exist -- I consider
> Paul's approach to be a bit overcomplicated.
>
> My patch still uses ~/.git-credentials as a default location, which
> should be sufficient for compability.

Indeed, that was my initial plan for implementation as well[1]. Matthieu,
however, wanted the behavior to follow that of git-config[2].

[1] http://article.gmane.org/gmane.comp.version-control.git/264666
[2] http://article.gmane.org/gmane.comp.version-control.git/264669

> A user that wants to use
> ~/.config/git/credentials instead has to manually create that file
> first, which he just shouldn't do if he has to stay compatible to
> previous git versions.

Yes, I totally agree. I wonder if the current behavior to read the home
config file in addition to the xdg config file is actually
useful to the end-user. (However, that behavior has been in git since 2012, so
for consistency purposes it may not be desirable to make credential-store act
differently from git-config.)

What I do believe, however, is that there *should* be a way for
credential-store to lookup, erase and (maybe) store credentials to multiple
files. This opens the door for git to be fully xdg base dir spec compliant
by supporing both $XDG_CONFIG_HOME and $XDG_CONFIG_DIRS.
I quote from the spec[3]:

    The order of base directories denotes their importance; the first directory
    listed is the most important. When the same information is defined in
    multiple places the information defined relative to the more important base
    directory takes precedent. The base directory defined by $XDG_DATA_HOME is
    considered more important than any of the base directories defined by
    $XDG_DATA_DIRS. The base directory defined by $XDG_CONFIG_HOME is
    considered more important than any of the base directories defined by
    $XDG_CONFIG_DIRS.

[3] http://standards.freedesktop.org/basedir-spec/basedir-spec-latest.html

Reading from multiple credential stores could be useful, for example, if the
system administrator wanted to setup credentials for all users on the system.

Thus, if we are implementing the machinery for the XDG dir spec, it would make
sense to just add the home git-credentials file to the search path as well.

Regards,
Paul
