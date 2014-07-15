From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v8 4/4] cache-tree: Write updated cache-tree after commit
Date: Mon, 14 Jul 2014 23:38:06 -0700
Message-ID: <CAPc5daVH=i72Y4dA8TefPLfFB79Cvw7STPnQf_f10cBeYbg2ug@mail.gmail.com>
References: <1405140276-32162-1-git-send-email-dturner@twitter.com>
 <1405140276-32162-4-git-send-email-dturner@twitter.com> <CACsJy8D0CdS5B5xNSSCk+LToXV9FnHFLkPzJ5f-7NTWiw9yn5w@mail.gmail.com>
 <xmqqr41oylyo.fsf@gitster.dls.corp.google.com> <53C41456.2000006@ramsay1.demon.co.uk>
 <xmqqvbqzygkm.fsf@gitster.dls.corp.google.com> <53C42453.1090109@ramsay1.demon.co.uk>
 <xmqq8unvy4bf.fsf@gitster.dls.corp.google.com> <CACsJy8BvQYyXWB7YfoonfEeqi9gStEZHqKC_JNAhxZbLJas54w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	David Turner <dturner@twopensource.com>,
	Git Mailing List <git@vger.kernel.org>,
	David Turner <dturner@twitter.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 15 08:38:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X6wNl-0008OE-Q9
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jul 2014 08:38:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757803AbaGOGia (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jul 2014 02:38:30 -0400
Received: from mail-la0-f50.google.com ([209.85.215.50]:36588 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757665AbaGOGi2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2014 02:38:28 -0400
Received: by mail-la0-f50.google.com with SMTP id pv20so3568970lab.37
        for <git@vger.kernel.org>; Mon, 14 Jul 2014 23:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=0umWlPJr9acqs3ii0WPHBoAZFKGr7vMRrPLERzqFL1g=;
        b=WX+4EDefMtopLni/LiyNa7HOowsVSvdhxS6DkZWPB7r6cDkHxJBNKN15EnlNM63mCU
         HKSnnnHa8vQRydengGbCPrLm+i6VG+15CH1ZDHiJhiloY5aATMLPd2Y7yyttm9Iz3Ebk
         i1GKqz6+pv0AxiicWCPFxCkcX1DVZu5A4vEPBBTmmCGxufLLoDo+OGVYQTIUgZcBrZYE
         fROSty38+ZbIBBEc8of5jt064d5MEUkSsaOU0iQCqI76z9YvIBDEo58kHA6YQLboyD7V
         Tym7cfOdRZVRiOub5tuFw4V8xCEJBZhm7KN0P+OGhbaKFwrXv8bwJwDwPBoQjbuk5SnB
         Bwsg==
X-Received: by 10.112.147.233 with SMTP id tn9mr16494171lbb.17.1405406306866;
 Mon, 14 Jul 2014 23:38:26 -0700 (PDT)
Received: by 10.112.26.212 with HTTP; Mon, 14 Jul 2014 23:38:06 -0700 (PDT)
In-Reply-To: <CACsJy8BvQYyXWB7YfoonfEeqi9gStEZHqKC_JNAhxZbLJas54w@mail.gmail.com>
X-Google-Sender-Auth: _31tAr0jFoez0eeAigCKCXGwdH4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253549>

On Mon, Jul 14, 2014 at 7:15 PM, Duy Nguyen <pclouds@gmail.com> wrote:
>
> It makes me wonder if a cleaner way of rebuilding cache-treei in this
> case is from git-add--interactive.perl, or by simply spawn "git
> update-index --rebuild-cache-tree" after running
> git-add--interactive.perl.

We could check if the cache-tree has fully been populated by
"add -i" and limit the rebuilding by "git commit -p" main process,
but if "add -i" did not do so, there is no reason why "git commit -p"
should not do so, without relying on the implementation of "add -i"
to do so.

At least to me, what you suggested sounds nothing more than
a cop-out; instead of lifting the limitation of the API by enhancing
it with reopen-lock-file, punting to shift the burden elsewhere. I
am not quite sure why that is cleaner, but perhaps I am missing
something.

In the longer run, it would be plausible that somebody would want
to rewrite "git-add -i" and will make it just a C API call away without
having to spawn a separate process. You cannot punt by saying
"make 'add -i' responsible for it" at that point; you will be doing
what 'add -i' would be doing yourself, no?
