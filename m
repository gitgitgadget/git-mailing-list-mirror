From: Brandon Casey <drafnel@gmail.com>
Subject: Re: [PATCH] http.c: don't rewrite the user:passwd string multiple times
Date: Tue, 18 Jun 2013 12:29:03 -0700
Message-ID: <CA+sFfMdEvwzmnEBeO+_pwdmN3m5rkJvUCVFFJU8mtmyN+WxH6w@mail.gmail.com>
References: <1371520840-24906-1-git-send-email-bcasey@nvidia.com>
	<20130618051902.GA5916@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Brandon Casey <bcasey@nvidia.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>, daniel@haxx.se
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 18 21:29:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Up1ab-0004z8-B7
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 21:29:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933264Ab3FRT3G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jun 2013 15:29:06 -0400
Received: from mail-wg0-f51.google.com ([74.125.82.51]:39243 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933047Ab3FRT3E (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jun 2013 15:29:04 -0400
Received: by mail-wg0-f51.google.com with SMTP id e11so3846513wgh.30
        for <git@vger.kernel.org>; Tue, 18 Jun 2013 12:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=fOf5/10QgLNQ27cetiYM0BPdQQn38V4wc4k/AHsFvEM=;
        b=bVpW1fkCN/hcKbkKNwyJ8e24mQL1knGbuLjMhDaHH3Z/sY0vvQOh6Q7rQjgqlhegzu
         fwUBDdVQL/peAMlSYI2J2prK7kibXoXAaYwWeRbla/paqb+sGQhesxt/h0Y7BBQFWlpm
         pRcVW72+BWlPAi/yltilf9g4THruaBUGE/OZ5LQXEAVrl/MlmA4GIaKa7Ac1/SSrxCpE
         GbD8Dn9T153z9NRoEK4IV4p1y9OPfHfRg8HQmAb2CVERQGKQBumumEWQ+WgMdaWY2meW
         HzgDCwbTHQyU2RbVXpNi/TqDaWThY7Dtn+JEVEqUtunIWUK4AL9O0LV4i5fYYaGtY5TR
         DEcg==
X-Received: by 10.180.74.146 with SMTP id t18mr8674733wiv.3.1371583743642;
 Tue, 18 Jun 2013 12:29:03 -0700 (PDT)
Received: by 10.194.71.170 with HTTP; Tue, 18 Jun 2013 12:29:03 -0700 (PDT)
In-Reply-To: <20130618051902.GA5916@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228306>

On Mon, Jun 17, 2013 at 10:19 PM, Jeff King <peff@peff.net> wrote:
> On Mon, Jun 17, 2013 at 07:00:40PM -0700, Brandon Casey wrote:
>
>> Curl requires that we manage any strings that we pass to it as pointers.
>> So, we should not be overwriting this strbuf after we've passed it to
>> curl.
>
> My understanding of curl's pointer requirements are:
>
>   1. Older versions of curl (and I do not recall which version off-hand,
>      but it is not important) stored just the pointer. Calling code was
>      required to manage the string lifetime itself.

Daniel mentions that the change happened in libcurl 7.17.  RHEL 4.X
(yes, ancient, dead, I realize) provides 7.12 and RHEL 5.X (yes,
ancient, but still widely in use) provides 7.15.  Just pointing it
out.

>   2. Newer versions of curl will strdup the string in curl_easy_setopt.
>
> So we do not have to worry about newer versions, as they do not care
> about our pointer after curl_easy_setopt returns.

I was probably reading the docs on one of these older platforms when I
wrote this.  I've actually had this patch sitting around for a while.

> For older versions, if we were to grow the strbuf, we might free() the
> pointer provided to an earlier call to curl_easy_setopt. But since we
> are about to call curl_easy_setopt with the new value, I would assume
> that curl will never actually look at the old one (i.e., when replacing
> an old pointer, it would not dereference it, but simply overwrite it
> with the new value).
>
> So for a single curl handle, I don't think it is a problem.
>
> It could be a problem when we have multiple handles in play
> simultaneously (we invalidate the pointer that another simultaneous
> handle is using, but do not immediately reset its pointer).

Don't we have multiple handles in play at the same time?  What's going
on in get_active_slot() when USE_CURL_MULTI is defined?  It appears to
be maintaining a list of "slot" 's, each with its own curl handle
initialized either by curl_easy_duphandle() or get_curl_handle().

So, yeah, this is what I was referring to when I mentioned
"potentially dangerous".  Since the current code does not change the
size of the string, the pointer will never change, so we won't ever
invalidate a pointer that another handle is using.

The other thing I thought was potentially dangerous, was just
truncating the string.  Again, if there are multiple curl handles in
use (which I thought was a possibility), then merely truncating the
string that contains the username/password could potentially cause a
problem for another handle that could be in the middle of
authenticating using the string.  But, I don't know if there is any
multi-processing happening within the curl library.

<snip>

Snip the remaining comments about allowing the user to specify
multiple passwords since I'm not sure they're relevant if we are
indeed using multiple curl handles.

If we _don't_ ever use multiple curl handles, and/or if there is no
threading going on in the background within libcurl, then I don't
think there is really any danger in what the current code does.  It
would just be an issue of needlessly rewriting the same string over
and over again, which is probably not a big deal depending on how
often that happens.

-Brandon
