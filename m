From: Phil Hord <phil.hord@gmail.com>
Subject: Re: [PATCH 2/4] Learn to handle gitfiles in enter_repo
Date: Tue, 4 Oct 2011 16:13:59 -0400
Message-ID: <CABURp0p1kcccrAfTpyjOyZit0b+-0VWVCLyhK5B9SXksmy1riQ@mail.gmail.com>
References: <CABURp0r7o8Mq4RyjEac18syU3HwCXWm7FOe+Mu0PshVXddJwuA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org, Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 04 22:14:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBBNj-0001KY-CO
	for gcvg-git-2@lo.gmane.org; Tue, 04 Oct 2011 22:14:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933627Ab1JDUOW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Oct 2011 16:14:22 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:56928 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933567Ab1JDUOV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Oct 2011 16:14:21 -0400
Received: by wwf22 with SMTP id 22so1389614wwf.1
        for <git@vger.kernel.org>; Tue, 04 Oct 2011 13:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type;
        bh=f6CSo7Bw1f9H4yWKlsJN8759h/lrn61gjTdsbJnIuLg=;
        b=FgELBWt5X3HzRNIiavfhHsqfV8c1pMmWbCXDGzWK3e2KlV1G0nSKqkaT2w+CvtOWTM
         MH5iEBzoo7+1tek6j9ovkEOKM8qMIHixt2YJmYRQwkZe5frFysyQtPBzI7I1dHaAx/PV
         1HLj5Xn7Dm/xAC+iApEb3XOFKNjn8jnBh8gCU=
Received: by 10.216.133.129 with SMTP id q1mr2041954wei.87.1317759259878; Tue,
 04 Oct 2011 13:14:19 -0700 (PDT)
Received: by 10.216.88.72 with HTTP; Tue, 4 Oct 2011 13:13:59 -0700 (PDT)
In-Reply-To: <CABURp0r7o8Mq4RyjEac18syU3HwCXWm7FOe+Mu0PshVXddJwuA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182798>

On Tue, Oct 4, 2011 at 4:05 PM, Phil Hord <phil.hord@gmail.com> wrote:
> The enter_repo() function is used to navigate into a .git
> directory.  It knows how to find standard alternatives (DWIM) but
> it doesn't handle gitfiles created by git init --separate-git-dir.
> This means that git-fetch and others do not work with repositories
> using the separate-git-dir mechanism.
>
> Teach enter_repo() to deal with the gitfile mechanism by resolving
> the path to the redirected path and continuing tests on that path
> instead of the found file.
>
> Signed-off-by: Phil Hord <hordp@cisco.com>
> ---
>


I meant to include this note on this patch.  Maybe I should have added
an RFC, too.

I'm not sure how to resolve this change for the 'strict' case.

The actual path followed may be different than the version spelled
out on the input path because of resolved symlinks and whatnot.
This function normally returns the unmolested "original" path
that was validated.  In case of a gitfile, I think that means
we should return the url resolved from the gitfile contents.

But should we?

The returned path is only used in git-daemon where it gets
further checks for path restrictions.

A. If we return the gitfile-resolved path, this may cause these
   path restrictions to fail since the path gets canonicalized
   when the gitfile is created by git.

B. If we do not return the gitfile-resolved path, this can create
   a security-hole by allowing remote users to access files they
   would otherwise have been restricted from.  In effect it creates
   an alternate symlink mechanism of which the administrator might
   not be aware.
