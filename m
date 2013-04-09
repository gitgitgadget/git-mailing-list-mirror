From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [ITCH] Specify refspec without remote
Date: Tue, 9 Apr 2013 17:14:27 +0530
Message-ID: <CALkWK0k2a6DSUodhKjRFKGvE1Rb_QmFgpy=Pvbu2Q=nGNYuByA@mail.gmail.com>
References: <CALkWK0nYECHZaxit9jR-tS=7fXyOP5dy6mqUz0DKmbTRU-xRNw@mail.gmail.com>
 <20130318170804.GA15924@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	=?UTF-8?B?RHV5IE5ndXnhu4Vu?= <pclouds@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Apr 09 13:45:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPWzE-0001Vo-9I
	for gcvg-git-2@plane.gmane.org; Tue, 09 Apr 2013 13:45:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936023Ab3DILpK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Apr 2013 07:45:10 -0400
Received: from mail-bk0-f43.google.com ([209.85.214.43]:41648 "EHLO
	mail-bk0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762364Ab3DILpI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Apr 2013 07:45:08 -0400
Received: by mail-bk0-f43.google.com with SMTP id jm2so3629322bkc.30
        for <git@vger.kernel.org>; Tue, 09 Apr 2013 04:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=PSAictbSuC0XUnJ0xBwBIXL669ShgRUl06NQ4ng8xS8=;
        b=InCpd1VuQn4t0QXv1T5gr1Y09WWWx4PIGwt7s0b/GtLtkvZyV4TkIuvj8m+irDi5kn
         S2j5nPbkFWl8+Icn4NgI8B5L4dE7sfPy+Mb7L9Pg0h7TuKv+/P4UZ+iOKRAyX9tOmdH5
         9UTK9YXgwFER/bSe+lBqwgL6xzGF/KzGSuTmiTcP9EVbmtsbSdLuxl8jEwdqojvqnZKY
         FQMGz9uHrT+ODxUTmnRfWJuxo11XAgcqqt6cFB3z+MJg+hfdXITr5plQOlZ4jq8mhw0F
         AYLKO7TZaufinGGwhzU6QAG6UByaUxTcQ0lHI5jilOVoCeytT50ZkDDwL0iPOr8FVo0+
         RJIQ==
X-Received: by 10.205.141.70 with SMTP id jd6mr12650780bkc.28.1365507907579;
 Tue, 09 Apr 2013 04:45:07 -0700 (PDT)
Received: by 10.204.37.69 with HTTP; Tue, 9 Apr 2013 04:44:27 -0700 (PDT)
In-Reply-To: <20130318170804.GA15924@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220563>

Jeff King wrote:
> So you would need some heuristics based on whether something was a valid
> refspec, or could be a valid remote name or URL.

All refspecs conform to a very simple format:

    quux
    +quux
    quux:baz
    +quux:baz

All of them fail at git_connect().  The third and fourth are
equivalent and take a little longer to fail than the first two,
because ssh tries to resolve the hostname "quux" or "+quux".

Okay, so I was hoping that we could first attempt to push as usual,
and fallback to pushing with the refspec set to argv[0] (if argc is
1); this approach is foolproof and doesn't involve any guessing.
Unfortunately, it's going to be very hard, as the callstack to the
final git_connect() failure looks like:

    git_connect()
    connect_setup()
    get_refs_via_connect()
    transport_push()
    push_with_options()
    do_push()

Now, it's nearly impossible to propagate the error back from
git_connect() to do_push() and switch the refspec.  It's not a simple
callstack either: there are callbacks being setup and called.

There's one small consolation in all this: all refspecs are match
match the !is_url() condition in transport.c:939 get_transport(), and
no preceding conditions.  This means that there is one place to check
if it could possibly be a ref, that's not very deep in the callstack,
and return something to the caller appropriately.  Currently,
get_transport() always returns a valid struct transport with no extra
information; maybe we can change this?

Duy's approach of using a special "-" is trivial to implement, but
doesn't make me happy.  There's no reason I can't have 'git push
master +pu foo:bar'.

Thoughts?
