From: Zoltan Klinger <zoltan.klinger@gmail.com>
Subject: Re: [PATCH v3] git-clean: Display more accurate delete messages
Date: Fri, 4 Jan 2013 10:21:45 +1100
Message-ID: <CAKJhZwS6VUwWoX1QmNL19asNt1B3dPsDeg5-JTzq8FMd1WYkSw@mail.gmail.com>
References: <1357091159-22080-1-git-send-email-zoltan.klinger@gmail.com>
	<7vfw2j2vlp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 04 00:29:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TquEJ-0001Z6-Jo
	for gcvg-git-2@plane.gmane.org; Fri, 04 Jan 2013 00:29:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753946Ab3ACX3Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jan 2013 18:29:25 -0500
Received: from mail-ie0-f175.google.com ([209.85.223.175]:60040 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753847Ab3ACX3X (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jan 2013 18:29:23 -0500
Received: by mail-ie0-f175.google.com with SMTP id qd14so19063352ieb.34
        for <git@vger.kernel.org>; Thu, 03 Jan 2013 15:29:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=jor06Z89V4MVrXAnh2PAdiPNaCEDyj61iJDylNZTbr8=;
        b=WAEmzSBUDuiAwXkl+WJ7ZnE4tRFChycNjpC+oPIsFG6JTUREg/rK6X+rGI1qDK7xAh
         m5M6RZvyJ2PeepOv2GictT43VxnU9CCVKIHTfACaijJ9ghEpGD8AHdvhEs3A6+jVb0sT
         X3fMC3Oe9bwT0juO/TV7xVJOstZNtXNmSlcKx2KgP46u5lLuNOLDP8MWV8E/5yT2E++x
         xIZr6kF88GRs9lnbeUUVD89as7+xfaY15/b21XtQSREDzOmyZva7KU3+BOxGOe3qBVXP
         F6lU5bDnJmkKqFfjF86xSVFQt4CjlrY5yaaon0iNfaUUIvc0HXzbf4uYOoDv0/EdjnFw
         VVSQ==
Received: by 10.50.7.135 with SMTP id j7mr40507142iga.82.1357255306155; Thu,
 03 Jan 2013 15:21:46 -0800 (PST)
Received: by 10.50.13.104 with HTTP; Thu, 3 Jan 2013 15:21:45 -0800 (PST)
In-Reply-To: <7vfw2j2vlp.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212619>

> The updated code structure is much nicer than the previous round,
> but I am somewhat puzzled how return value of remove_dirs() and
> &gone relate to each other.  Surely when gone is set to zero,
> remove_dirs() is reporting that the directory it was asked to remove
> recursively did not go away, so it must report failure, no?  Having
> the &gone flag looks redundant and checking for gone in some places
> while checking for the return value for others feels like an
> invitation for future bugs.

The return value of remove_dirs() has an overall effect on the exit
code of git-clean, and &gone indicates whether the directory we asked
remove_dirs() to delete was actually removed. If all goes well  in
remove_dirs() the return code is 0 and gone flag is 1. If file or
subdirectory delete fails return code is 1 and the gone flag is set to
0. The special case is when remove_dirs() is asked to remove an
untracked git repo that should be ignored. In this case remove_dirs()
is not going to remove the directory so the gone flag is set to zero
but it is not an error so the return value will be set to zero too.

> Also the remove_dirs() function seems to replace the use of
> remove_dir_recurse() from dir.c by copying large part of it, with
> error message sprinkled.  Does remove_dir_recurse() still get used
> by other codepaths?  If so, do the remaining callsites benefit from
> using this updated version?

In dir.c the remove_dir_recurse() is a private function that is called
by the public remove_dir_recursively() wrapper function. The
remove_dir_recursively() function is called from the following places:

    builtin/clone.c:387:
    builtin/clone.c:392:
    builtin/rm.c:349:
    notes-merge.c:771:
    refs.c:1527:
    sequencer.c:27:
    transport.c:247:
    transport.c:393:

The messages that remove_dirs() prints out are very specific to
git-clean and they are not really relevant in the above places where
remove_dir_recursively() is called from. Also, the remove logic for
files is slightly different in remove_dirs() when it comes to handling
a failed file delete. While remove_dirs() continues removing other
files in the same directory upon failure, remove_dir_recurse() will
stop at the first error. So perhaps having the remove_dirs() in
builtin/clean.c is OK.
