From: Ben Walton <bdwalton@gmail.com>
Subject: Re: [PATCH] Avoid broken Solaris tr
Date: Mon, 28 Oct 2013 09:02:08 +0000
Message-ID: <CAP30j17OCrYjsVK+W_TR-g99YmzY3d9TnYfwHXK7+6vPrVjDaQ@mail.gmail.com>
References: <1371590247-13436-1-git-send-email-bdwalton@gmail.com>
	<7vli672gql.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 28 10:02:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VaiiF-0005zZ-4Q
	for gcvg-git-2@plane.gmane.org; Mon, 28 Oct 2013 10:02:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755498Ab3J1JCK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Oct 2013 05:02:10 -0400
Received: from mail-qa0-f51.google.com ([209.85.216.51]:52952 "EHLO
	mail-qa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752397Ab3J1JCJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Oct 2013 05:02:09 -0400
Received: by mail-qa0-f51.google.com with SMTP id ii20so1949000qab.10
        for <git@vger.kernel.org>; Mon, 28 Oct 2013 02:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=kSmbVTSDuPs4Fihypqoj4xxX2hmQaJ3c9RkLpPCkHT0=;
        b=Xl3bf8Dy9E+3bdEkQBUcMjS/WM8iiLElNWPLvqIGO7J/Mal4z+RnjE/YzEl4gpLiKN
         goS7qddRUMJpS8a1cKvgU7Kz3EeVNtyqma8+rVjs6BoqpwWR4o4Ljg+fGlFnVuiN4kbX
         N/qFrcZux+IuIauyvsrcp2adps9ltfcpw337auGeGmQTaFEHZxUqmqtk3WPZQhfTEwzN
         s+T3QNpsHAZ8Mq26fMsWX/G4g2UBnRubaFZYQWaO93VVo2nX5bCkI5U48E/pFVe34Mu3
         9wmJh7jL9NZKNCNWeqPWiacgSDNLKX0hGzOb3qIjfSdAss38EEVJCuIR/KAHlgPs1xEo
         244Q==
X-Received: by 10.49.17.98 with SMTP id n2mr27664097qed.61.1382950928473; Mon,
 28 Oct 2013 02:02:08 -0700 (PDT)
Received: by 10.224.189.12 with HTTP; Mon, 28 Oct 2013 02:02:08 -0700 (PDT)
In-Reply-To: <7vli672gql.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236822>

On Tue, Jun 18, 2013 at 11:31 PM, Junio C Hamano <gitster@pobox.com> wrote:

Sorry for the very slow reply. This got lost in my inbox and I forgot about it.

> Ben Walton <bdwalton@gmail.com> writes:
>
>> Solaris' tr (both /usr/bin/ and /usr/xpg4/bin) fail to handle the case
>> where the first argument is a multi-character set and the second is a
>> single null character.
>
> Almost all the tr invocations look like converting LF to NUL, except
> for two that squash a colon ':', HT and LF all to NUL.  Is Solaris's
> tr fine with the former but not the latter?

In retrospect, this isn't brokenness, just a difference in System V vs
BSD semantics for tr, both of which are allowed by POSIX since the
behaviour in question is specifically unspecified by the standard. The
System V behaviour is to require a 1:1 map between string1 and string2
transformations whereas BSD behaviour (when len(string2) <
len(string1)) is to pad string2 with the last character in string2
until the lengths are equal.

>
>> We make this change globally in t0008-ignores instead of just for the
>> cases where it matters in order to maintain consistency.
>
> I am not suggesting to keep 'tr "\n" "\0"', but just wanted to make
> sure I am reading the first paragraph correctly.  If we are
> rewriting, we should do so consistently.
>
>> +perl -pne 's/^"//; s/\\//; s/"$//; s/\n/\0/g' stdin >stdin0
>
> What is -pne?  Is it the same as -pe?
>
> tr/\n/\0/ (or y/\n/\0/) may be more faithful to the original.
>
>
>> +perl -pne 's/^"//; s/\\//; s/"$//; s/\n/\0/g' expected-default > \
>> +    expected-default0
>
> Ditto.  We may want to give the same script used in the above two
> (and twice again in the later hunk) more descriptive name, e.g.
>
>         broken_c_unquote () {
>                 perl -pe '... that script ...' "$@"
>         }
>
>         broken_c_quote stdin >stdin0
>
> Side note: the script is broken as a generic C-unquote function in
> multiple ways.  It does not work if it has more than one backslash
> quoted characters, it does not understand \t, \b, \015, \\, etc. to
> name two.
>
> But the breakage does not matter for the strings used in the test
> vector.

I've updated the patch and will forward it shortly.

Thanks
-Ben
--
---------------------------------------------------------------------------------------------------------------------------
Take the risk of thinking for yourself.  Much more happiness,
truth, beauty and wisdom will come to you that way.

-Christopher Hitchens
---------------------------------------------------------------------------------------------------------------------------
