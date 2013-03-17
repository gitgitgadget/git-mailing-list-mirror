From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [BUG?] google code http auth weirdness
Date: Sat, 16 Mar 2013 18:11:32 -0700
Message-ID: <CAJo=hJt5P4616VLGcjdGFQ0YA_+gT+o1Vw3zWSbafDT6Cu6M2w@mail.gmail.com>
References: <20130315115947.GA30675@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Mar 17 02:12:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UH29G-0002uj-8c
	for gcvg-git-2@plane.gmane.org; Sun, 17 Mar 2013 02:12:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752964Ab3CQBLx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Mar 2013 21:11:53 -0400
Received: from mail-ia0-f178.google.com ([209.85.210.178]:61372 "EHLO
	mail-ia0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752477Ab3CQBLx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Mar 2013 21:11:53 -0400
Received: by mail-ia0-f178.google.com with SMTP id y10so2096866iak.9
        for <git@vger.kernel.org>; Sat, 16 Mar 2013 18:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=nyb9+7pKzP7sGG7ps8KCYoE2dYzXBHVEupGKKQqtwjc=;
        b=fBaHfb7O/+n07mg7mSZTI/avxbrOCiaXeedYfaL7vk2N7Sjd3y7T1lUiRpRINJYbje
         r8vMu9F30+x+q0x44DiiMkgct5q31CZDhhh8/uyl/uETTZpO2KZDNOVCBn+nfUNml9Dt
         bBp6E2zQW3xqO6i+PDCak7XqRJNknaCfQd14M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:x-gm-message-state;
        bh=nyb9+7pKzP7sGG7ps8KCYoE2dYzXBHVEupGKKQqtwjc=;
        b=Hn60tWyMndCvFqhSeub4Y/z7GAqgW6jthWd8aNJTNqGMfPOBD5eP5mTebLFV7A8nkp
         sR2HazGQV/MTjGG45PxElXVVeBczu0XcGbHM9BGx0RksyBlztSJ8BIRVmUP37CIBFeY3
         Urr6NrOSBotTbemCljQQIDusQpJYIst11prfgOmRSxLx5YgaH5nabOaAy85BCKWN63DJ
         0k0n+nYstVd0TOShjqzMVScX22U/7hwzQEjpKWc4s0Z5UQGRR4y8bBKDw1NQWP4BunC4
         02a5SI5AyzI9XWu+CQFsyTZsA0Stpx5lZ6fo4+2YM/J5WkpaUP5rpKMZE7VEaJIBQirJ
         /xFw==
X-Received: by 10.50.2.101 with SMTP id 5mr4021702igt.29.1363482712428; Sat,
 16 Mar 2013 18:11:52 -0700 (PDT)
Received: by 10.64.92.130 with HTTP; Sat, 16 Mar 2013 18:11:32 -0700 (PDT)
In-Reply-To: <20130315115947.GA30675@sigill.intra.peff.net>
X-Gm-Message-State: ALoCoQmgxHJU9n0rY6M6vfcn6DZGWMB0gG/79fHskqlEXuHfMmqGfZE9JQTrsr3DNF/y0QanV7Zl
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218321>

On Fri, Mar 15, 2013 at 4:59 AM, Jeff King <peff@peff.net> wrote:
> I tried pushing to a repository at Google Code for the first time today,
> and I encountered some weird behavior with respect to asking for
> credentials.
>
> If I use the url "https://code.google.com/r/repo/", everything works; I
> get prompted for my username/password.
>
> But if I instead use the url "https://myuser@code.google.com/r/repo/",
> it doesn't work. I get:
>
>   $ git push
>   fatal: remote error: Invalid username/password.
>   You may need to use your generated googlecode.com password; see
>   https://code.google.com/hosting/settings
>
> without any prompt at all. I bisected it to 986bbc0 (http: don't always
> prompt for password, 2011-11-04), but I think that is a red herring. It
> worked before that commit because we always asked for the password,
> before we even talked to the server.
>
> After that commit, we should be reacting to an HTTP 401. But it seems that
> Google Code's 401 behavior is odd. When t5540 checks this, the
> conversation goes something like:
>
>   1. We do a GET with no "Authorization" header.
>
>   2. The server returns a 401, asking for credentials.
>
>   3. Curl repeats the GET request, putting the username into the
>      Authorization header.
>
>   4. The server returns a 401, again, as our credential is not
>      sufficient.
>
>   5. Curl returns the 401 to git; git prompts for the credential, feeds
>      it to curl, and then repeats the request. It works.
>
> But with Google Code, the first three steps are identical. But then for
> step 4, the server returns this:
>
>   < HTTP/1.1 200 OK
>   < Content-Type: application/x-git-receive-pack-advertisement
>   < X-Content-Type-Options: nosniff
>   < Date: Fri, 15 Mar 2013 11:43:14 GMT
>   < Server: git_frontend
>   < Content-Length: 175
>   < X-XSS-Protection: 1; mode=block
>   <
>   * Connection #0 to host code.google.com left intact
>   packet:          git< # service=git-receive-pack
>   packet:          git< 0000
>   packet:          git< ERR Invalid username/password [...]
>
> That seems kind of crazy to me. It's generating an HTTP 200 just to tell
> us the credentials are wrong. Which kind of makes sense; it's the only
> way to convince the git client to show a custom message when it aborts
> (rather than producing its own client-side "authorization failed"
> message).

Actually the reason here wasn't to use a custom message. It was to
avoid the client from entering into the old /info/refs fallback path
that existed between 703e6e76 (Git 1.6.6.2) and 6ac964a62 (Git
1.7.12.3). During these versions non-200 responses from the smart
request usually led to a useless error in the client. I suggested to
the Google Code team when they implemented Git support to use a 200
response with the ERR header to give the end-user something easier to
understand than what the Git client have otherwise printed.

But in hindsight maybe I should have told them to always return 401
and let the client handle the error.

FWIW this same "misfeature" probably exists in Gerrit Code Review and
does exist on {gerrit,android}.googlesource.com because it also came
from me.

> But it takes the retry decision out of the client's hands. And
> in this case, it is wrong; the failed credential is a result of curl
> trying the username only, and git never even gets a chance to provide
> the real credential.
>
> Technically this did work before 986bbc0, so it could be considered a
> regression in git, but I really think that Google Code is in the wrong
> here. It should either:
>
>   1. Always return a 401 for bad credentials. This means it would lose
>      the custom message. But I think that is a good indication that the
>      client should be putting more effort into showing the body of the
>      401. Probably not all the time, as we do not want to spew HTML at
>      the user, but we could perhaps relay error bodies if the
>      content-type is "application/x-git-error" or something.
>
>      The downside is that even if we make such a client change and the
>      the Google Code server change sit's behavior, people on older git
>      clients will lose the benefit of the message.

I don't think this is the way to handle errors in the protocol. I
prefer the existing approach of sending a 200 OK with the ERR header
to indicate the message to show to the client. It works since 1.6.6
when smart HTTP was introduced, and it has a very specific meaning.
The 200 is stating the transport worked, and the ERR is stating the
Git operation did not. :-)

Where we have an issue is on a recoverable authentication error.
Recoverable authentication errors should use 401 so the client can try
again. I don't know how older (e.g. 1.6.6) clients behave here with a
401 response. I guess I should crack out a 1.6.6 build and test.

>   2. Treat a credential with a non-empty username and an empty password
>      specially, and return a 401. This covers the specific case of
>      https://user@host/, but continues to show the custom message when
>      the user provides a wrong password. It does mean that the custom
>      message will not be shown if the user actually enters a blank
>      password at the prompt (but it will still be shown if they get
>      prompted for both username and password and leave both blank).
>
>      So it's a little hacky, but I think it would work OK in practice.

I don't work on Google Code, but I have asked the team to consider
making at least this change.

We haven't deployed it yet, but I made the change for
{android,gerrit}.googlesource.com, and should try to get the same
thing into Gerrit Code Review.
