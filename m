From: Chris Harris <ryguasu@gmail.com>
Subject: Is the "text" attribute meant *only* to specify end-of-line
 normalization behavior, or does it have broader implications?
Date: Thu, 29 Mar 2012 19:19:26 -0700
Message-ID: <CANSc5vG0o_eAn7X39XhCzUoN4ab52pGCP+PvzOQCyTV31R8LGg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 30 04:19:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDRRS-0003Ld-V4
	for gcvg-git-2@plane.gmane.org; Fri, 30 Mar 2012 04:19:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759932Ab2C3CTu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Mar 2012 22:19:50 -0400
Received: from mail-wi0-f170.google.com ([209.85.212.170]:38558 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759114Ab2C3CTs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Mar 2012 22:19:48 -0400
Received: by wibhr17 with SMTP id hr17so305108wib.1
        for <git@vger.kernel.org>; Thu, 29 Mar 2012 19:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=OkHmQpK8QqMucX9ZEVhcfGSuepjL5ADEn0XhVQpAkvg=;
        b=tqZVVXdwNTKwPxRGXYHVd3KT09pGj6AZAakjoatMAdDhpp/x6U9/YB0qPEKbjA0mW0
         vZM5ZAZwtTvkQFl+txO+jTRIWmgQ44FVkJuZbBrsJEt425RLqz8+78c63yTS2b3hQDcx
         BS/17KHMwT02WRSTavLdOxMUBP3hkpSInXtaeNrZb0NvmyY1as6D/0HDktdJvi1/DHFk
         wYqHTKbOzi8osoE49x+O35/06q6+Yf0J0Ae0g4jDeIw7+guVGg0GFwjsT5fnQUt+hmBY
         pKceD7tvmk0JaD6uL1TfjLQ8NXyqIakFLyZ5bAjCpjHo3w2e3E/qvg+Y5h84TZbEHcSb
         cWgw==
Received: by 10.180.95.197 with SMTP id dm5mr1236271wib.20.1333073987421; Thu,
 29 Mar 2012 19:19:47 -0700 (PDT)
Received: by 10.223.144.207 with HTTP; Thu, 29 Mar 2012 19:19:26 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194315>

The gitattributes documentation (e.g. from "git help attributes")
gives the impression that the "text" attribute's sole effect is to
control whether or not end-of-line normalization takes place. I wanted
to check whether I'm indeed supposed to take such a narrow
interpretation as a git user, or whether setting "text" or "-text"
might have a broader meaning (or whether it will have a broader
meaning in the future).

In the rest of this message, let me outline a case of current interest
where the distinction seems to matter:

I'm starting a new repository for a Windows-only project where I don't
think I want git to do any end-of-line normalization on my text files.
(I'm totally happy to have CRLFs both in the repo and in all the
working copies.) Unless you think that end-of-line normalization is
always vital, let's try to presume I've made the right choice about
this.

Now as far I can tell from the gitattributes documentation, one
perfectly legitimate way to accomplish this (and to override any
core.autocrlf settings on other teammates' machines in the process) is
to add a .gitignore file to my repo containing the single line

    * -text

If all "-text" does is disable end-of-line normalization, then this
setting should be a small deal. For example, it shouldn't
fundamentally alter how any of the source control operations (diffs,
merges, etc.) work on my text files, or generate more merge conflicts
than otherwise. (Recall that I'm starting a fresh repo, so I don't
have to worry that the repo might already have some normalized
linefeeds.)

But I'm not completely sure if it's reasonable to expect there to be
no side-effects. I haven't yet discovered any side-effects from git
itself, but I have at least discovered one in the Git Extensions
project, which takes a broader interpretation of "-text". Some of you
might not care directly about Git Extensions, but perhaps you can
still help me figure out whether I'm making a misguided use of
"-text", or whether this is perhaps an area where Git Extensions is
doing the wrong thing:

* Here's the normal behavior (without "* -text"): Git Extensions has a
widget that lets you explore a given commit. In that widget, if you
click on the name of a text file, then the contents of that file shows
up in an adjacent pane. In contrast, if you click on the name of a
binary file, then the adjacent pane simply says, e.g., "Binary file:
foo.jpg".
* Here's the behavior with "* -text" in my .gitattributes: Now, no
matter what file I click on in the above widget, the pane says, e.g.,
"Binary file: foo.txt". I can no longer see the contents of any text
files, which is annoying.
* I peeked at the Git Extensions code, and it is making the following
inference: The path to foo.txt is tagged as "-text", therefore the
file is "binary", therefore it doesn't make sense to display its
contents to the user, and therefore I'll just display "Binary file:
foo.txt" instead. But this is an unfortunate consequence. When I
originally set "-text" I didn't mean to convey "this is a binary
file", merely "don't mess with newlines."
