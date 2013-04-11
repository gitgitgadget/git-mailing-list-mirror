From: Magnus Therning <magnus@therning.org>
Subject: Re: git-http-backend: anonymous read, authenticated write
Date: Thu, 11 Apr 2013 08:52:56 +0200
Message-ID: <CAAExw5t3rk_R1GB9OMVKjPYEMRQg1gNSUGQtEK71m1Ux01N27w@mail.gmail.com>
References: <20130409054553.GA1537@mteis.lan>
	<20130409171247.GD21972@sigill.intra.peff.net>
	<5165DA13.8010100@gmail.com>
	<20130410214722.GA6215@sigill.intra.peff.net>
	<20130410231919.GA1315@mteis.lan>
	<20130411015613.GA8455@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 11 08:53:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQBNW-0006Al-89
	for gcvg-git-2@plane.gmane.org; Thu, 11 Apr 2013 08:53:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752694Ab3DKGw5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Apr 2013 02:52:57 -0400
Received: from mail-ie0-f170.google.com ([209.85.223.170]:35429 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751765Ab3DKGw4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Apr 2013 02:52:56 -0400
Received: by mail-ie0-f170.google.com with SMTP id c11so1632794ieb.15
        for <git@vger.kernel.org>; Wed, 10 Apr 2013 23:52:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:x-gm-message-state;
        bh=BnaPxQjyT5KsX2FhZZd2c0so1mhS37azZoONcKZli7w=;
        b=WE1ROzo0UGGwKUZaJAjGdxMcmlorlvw/71QY5K6Z9uhhd/PV5BWuRSY72gB0GMAcQj
         O6/1uLfK/PaojV5dPhd/hBrHIr/Yjrze0hX4oCF3NRKhT7R/KNKcp/Fr+NdOOkVB4A2Q
         wa+DgjvEef9qnPoYhHZBo6OegRt2OaRSmBwnzcIr2w/KiO6seetDDzX15JnPgLNNMQtB
         eQHDehX+EDOvCevCA90UjiW16p0QOM4Ni2W+49fEH+xQEW7e5pYgu9xVX2M60Jic+pwK
         GOaD5JDFi45KJP9gDFcOijGQGzl79M+k7KshGR6O8nP5jhzpJl+0Kll/XikExLG2Mfvr
         wnLw==
X-Received: by 10.50.20.38 with SMTP id k6mr3608426ige.72.1365663176348; Wed,
 10 Apr 2013 23:52:56 -0700 (PDT)
Received: by 10.64.163.35 with HTTP; Wed, 10 Apr 2013 23:52:56 -0700 (PDT)
In-Reply-To: <20130411015613.GA8455@sigill.intra.peff.net>
X-Gm-Message-State: ALoCoQm/eG1cDyCMDQGlLxQQhf5+RyRNIhGx8xYUidZxiKG+DOrreG6Wd0t8iajvPiwQr4yIZI0S
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220827>

On Thu, Apr 11, 2013 at 3:56 AM, Jeff King <peff@peff.net> wrote:
> On Thu, Apr 11, 2013 at 01:19:19AM +0200, Magnus Therning wrote:
>
>> Nope.  I'm pretty sure this had *nothing* to do with my config.  This
>> is the original config, which doesn't work:
>>
>> $HTTP["url"] =~ "^/git" {
>>     cgi.assign = ( "" => "" )
>>     setenv.add-environment = (
>>         "GIT_PROJECT_ROOT" => "/srv/git",
>>         "GIT_HTTP_EXPORT_ALL" => ""
>>     )
>>     $HTTP["url"] =~ "^/git/.*/git-receive-pack$" {
>>         include "trac-git-auth.conf"
>>     }
>> }
>
> Ah, I think I see what it is.
>
> Did you turn on http.receivepack in the git config to enable pushing?

Nope, of course I didn't :)  Instead I did what the man-page tells me
will allow full export of a git repo *without* having to fiddle around
with the repo's config:

1. set GIT_HTTP_EXPORT_ALL in the environment
2. turn on authentication for *one* location that requires it for
pushing: ^/git/.*/git-receive-pack$

[...]
> If there is no authentication happening for the initial service-request,
> then the default http.receivepack kicks in, which is to turn pushing
> off (because there is no authenticated user).

Yes, but that only becomes clear when looking at the traffic.  In
fact, the whole design of services is not clearly mentioned in the
man-page.  I was *very* surprised to see the query strings when I
started looking at the access logs.

> The documentation should probably make the use of http.receivepack more
> clear in this situation.

I think that'd be good.  The fact that it wasn't until several mails
into the thread that anyone thought of the http.receivepack setting
also suggests that its use is a bit un-intuitive (even though it
probably makes perfect sense and is a good solution).

> So _if_ you fixed it by setting http.receivepack (which I think is the
> simplest thing under Apache, since matching the query string there is
> hard), then you would need a version of git with that fix on the
> client side to actually have git prompt for the password correctly.

Ah, so *that* is the fix that has been mentioned (I haven't bothered
reading it myself), or are there in fact two fixes that have been
referred to in the thread?

> But your fix under lighttpd is much better, as it asks for the
> credentials up front (which means the client does not go to any work
> creating a packfile just to find out that it does not have access).

Yes, I think it also helps with my particular scenario where new repos
will be added from time to time.  This way there is no second step,
after `git init`, that must be remembered.

Thank you very much for taking the time to help me out with this!
I'll also take a look at the patches you sent, as a dumb simpler user
I might have something to add, who knows?

/M

--
Magnus Therning                      OpenPGP: 0xAB4DFBA4
email: magnus@therning.org   jabber: magnus@therning.org
twitter: magthe               http://therning.org/magnus
