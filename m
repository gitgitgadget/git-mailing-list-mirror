From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2] macos: lazily initialize iconv
Date: Tue, 31 Jul 2012 12:51:30 -0700
Message-ID: <CA+55aFwE93YeVjZp9VLhRvbxFJNonafmUE6rHzPer5hv-hON5Q@mail.gmail.com>
References: <7vk3xjked0.fsf@alter.siamese.dyndns.org> <7v1ujrkc9p.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org, Ralf Thielow <ralf.thielow@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 31 21:52:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SwIU1-0005hN-9J
	for gcvg-git-2@plane.gmane.org; Tue, 31 Jul 2012 21:51:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754230Ab2GaTvw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Jul 2012 15:51:52 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:60080 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751735Ab2GaTvv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jul 2012 15:51:51 -0400
Received: by weyx8 with SMTP id x8so4608726wey.19
        for <git@vger.kernel.org>; Tue, 31 Jul 2012 12:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        bh=6zXhtqln2OVZ1AmFghYx+Md61HvZZVH8gLy7uIs7fXI=;
        b=fT8cfFSFWcGepupRhWZvWavrEG9XrU6XPYhgNmKJ0hVx4MYQDoBTRa7kvtv4L/VXmJ
         Uh5WtVgv0qDDzDzM8lzkN5kIxngwr+w5nIJs8uWYniEO3bKN9xPhWy/KvWPInhxIN1nJ
         JZCOnog/gGUEaxPdqW++uwF/FrtZ3hRVqJRExQz/EPO1VgtJRg2I3YVaj/29Gf0emWco
         xgCtNdmCKcQ3+Mj4PlzvnvsmnW9dLfbuaVxwW6qYHkuLNDbDkt+5qMUjlcilsXN/BivR
         CDmxSVwn1fdRfp7AU56hPyXuCPCzoAArJip+wnMUQAcs7aDvzPvTr51tCwobKu1DbwQ4
         VMcQ==
Received: by 10.180.84.169 with SMTP id a9mr9992979wiz.8.1343764310396; Tue,
 31 Jul 2012 12:51:50 -0700 (PDT)
Received: by 10.216.203.207 with HTTP; Tue, 31 Jul 2012 12:51:30 -0700 (PDT)
In-Reply-To: <7v1ujrkc9p.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: Lbvve71AYFAeW_TuIbttXXrhXsQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202677>

On Tue, Jul 31, 2012 at 11:37 AM, Junio C Hamano <gitster@pobox.com> wrote:
>
>  * This is not even compile tested, so it needs testing and
>    benchmarking, as I do not even know how costly the calls to
>    open/close are when we do not have to call iconv() itself.

Ok, so it's easily compile-tested: just add

+       COMPAT_OBJS += compat/precompose_utf8.o
+       BASIC_CFLAGS += -DPRECOMPOSE_UNICODE

to the makefile for Linux too.

Actually testing how well it *works* is hard, since I don't really
have a mac (well, I do, but it no longer has OS X on it ;), and the
whole "utf-8-mac" thing does not make sense.

HOWEVER. I actually tested it with the conversion being from Latin1 to
UTF-8 instead, and it does interesting things, and kind of works. I
say "kind of", because for the case of the filesystem being in Latin1,
we actually have to convert things back to the filesystem character
set when doing "open()" and "lstat()", and this patch obviously
doesn't do that, because OS X does the conversion back to NFD on its
own.

But ACK on the patch.

If I had more time, I'd actually be interested to do the generic case
of namespace conversion, and we could make this a generic git feature
- it's something I wanted to do long ago. However, right now I'm in
the merge window and will go on a vacation to Finland after that, so I
probably won't get around to it.

I do have one suggestion: please rename the "has_utf8()" function to
"has_nonascii()" too. Why? Because that's what the function actually
does. It has nothing to do with testing for UTF-8 (the utf-8 rules are
more complex than just "high bit set"), and *if* I ever get around to
doing a more generic character set conversion for the filenames, the
decision really would be about non-ASCII, not about non-UTF8.

              Linus
