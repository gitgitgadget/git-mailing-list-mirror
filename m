From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] mailinfo: resolve -Wstring-plus-int warning
Date: Tue, 23 Sep 2014 03:52:21 -0400
Message-ID: <CAPig+cQmbOs7Xw8wv63mLHfpG13Vo+tR7oLq-5srCcP1QQddnQ@mail.gmail.com>
References: <1411290838-45622-1-git-send-email-sunshine@sunshineco.com>
	<xmqqk34vlfhz.fsf@gitster.dls.corp.google.com>
	<CAPig+cTAFaG5H8rmf1jrvFwr_OOH7u19JMKDUE12UddokUmfaQ@mail.gmail.com>
	<20140923060407.GA23861@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Sep 23 09:52:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XWKtd-0006Dh-TT
	for gcvg-git-2@plane.gmane.org; Tue, 23 Sep 2014 09:52:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753693AbaIWHwW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Sep 2014 03:52:22 -0400
Received: from mail-yk0-f180.google.com ([209.85.160.180]:53512 "EHLO
	mail-yk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753378AbaIWHwV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Sep 2014 03:52:21 -0400
Received: by mail-yk0-f180.google.com with SMTP id 9so1839176ykp.39
        for <git@vger.kernel.org>; Tue, 23 Sep 2014 00:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=5NL49k4J0BkVwrLhSjw2qspOYbdFgKg8qwKgARMK6ks=;
        b=sQO2eIYLUjGDy9sPy9/ccOQrqXK159wtOR2UTz/WuIXvcWfzXIK8sgg9Js1IaGFOwo
         QLjlU7pFfXHmQNuV7Fynl0mxfy3hXJ33lYpfTuoaBumDvC+gDMqThz1ryu/4R2O243t2
         lprrk69eqOLgNESk1ufVEDC3y5NJWiaE6rvRiDOuQwAroQhXvaN7KE3mDfJmtPXb/F/1
         Yg0k/bX8MNqtAWeK4RLlyToGJv8rKQ37foukFyqKIxPUWFdNPn4EjxSR6EKkbzD4c9Iv
         WmWmixqwNy5viZyrtx4z6BVY5xisfUi6dBSAvJXaqQQXVHu080zRaybKntdYMJbTpEGm
         OJ3Q==
X-Received: by 10.236.121.44 with SMTP id q32mr33607997yhh.55.1411458741253;
 Tue, 23 Sep 2014 00:52:21 -0700 (PDT)
Received: by 10.170.68.68 with HTTP; Tue, 23 Sep 2014 00:52:21 -0700 (PDT)
In-Reply-To: <20140923060407.GA23861@peff.net>
X-Google-Sender-Auth: ENAG4ENTr51nXXndmCv9BqHBL7Y
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257399>

On Tue, Sep 23, 2014 at 2:04 AM, Jeff King <peff@peff.net> wrote:
> On Mon, Sep 22, 2014 at 05:10:08PM -0400, Eric Sunshine wrote:
>
>> On Mon, Sep 22, 2014 at 1:41 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> > Eric Sunshine <sunshine@sunshineco.com> writes:
>> >
>> >> The just-released Apple Xcode 6.0.1 has -Wstring-plus-int enabled by
>> >> default which complains about pointer arithmetic applied to a string
>> >> literal:
>> >>
>> >>     builtin/mailinfo.c:303:24: warning:
>> >>         adding 'long' to a string does not append to the string
>> >>             return !memcmp(SAMPLE + (cp - line), cp, strlen(SAMPLE) ...
>> >>                            ~~~~~~~^~~~~~~~~~~~~
>> >
>> > And why is that a warning-worthy violation?
>>
>> Not being privy to Apple's decision making process, I can only guess
>> that it is in response to their new Swift programming language which
>> they are pushing heavily on iOS (and soon Mac OS X), in which '+' is
>> the string concatenation operator. For projects written in Swift and
>> incorporating legacy or portable components in C, C++, or Objective-C,
>> the warning may help programmer's avoid the pitfall of thinking that
>> '+' is also concatenation in the C-based languages.
>
> That is my reading from the warning text, too, but I have to wonder:
> wouldn't that mean they should be warning about pointer + pointer, not
> pointer + int?

'pointer + pointer' is not legal C, is it? What would the result
represent? The compiler correctly diagnoses that case as an error
(without special command-line switches):

    error: invalid operands to binary expression
      ('char *' and 'char *')
      return "a" + "b";
             ~~~ ^ ~~~

> Also, wouldn't the same advice apply to adding to _any_ char pointer,
> not just a string literal?

Not really. Indexing into a char array via pointer arithmetic is a
perfectly reasonable and common idiom in C (indeed, git is peppered
with it), so such a warning would be pure noise. The more restricted
case of 'stringliteral + something' is probably sufficiently rare that
diagnosing it may catch genuine errors by programmers coming from
languages in which '+' does string concatenation (which may be the
original motivation for the warning; see below).

> I know you don't have answers to those questions, but the whole thing
> seems rather silly to me.

I did some more research and discovered that -Wstring-plus-int was
added in response to 'string + int' cases being found in Chromium's C
code (perhaps by programmers living in both JavaScript and C worlds).
The proposed option was discussed [1] and committed [2]. Later a
-Wstring-plus-char option was also discussed [3] and committed [4].

Regarding Apple: The Swift language supports 'string + string' and
'string + char', but not 'string + int'. However, in C, the char would
be promoted to int, so there is some sense in warning about 'string +
int' if they want to help safeguard programmers coming to C from Swift
(but, again, I'm just speculating).

[1]: http://thread.gmane.org/gmane.comp.compilers.clang.scm/47203/
[2]: http://llvm.org/klaus/clang/commit/1cb2d742eb6635aeab6132ee5f0b5781d39487d7/
[3]: http://thread.gmane.org/gmane.comp.compilers.clang.scm/82462/
[4]: http://llvm.org/klaus/clang/commit/02debf605cd904edac8dceb196e5f142ce3d14eb/

>> > Can we have them fix their compiler instead?
>>
>> If the above supposition is correct, then it's likely that Apple
>> considers this a feature, not a bug which needs to be fixed.
>
> Like Junio, I prefer keeping strlen() rather than switching to sizeof,
> as it is less error-prone (no need for extra "-1" dance, and it won't
> silently do the wrong thing if the array is ever converted to a
> pointer).

Sounds reasonable.
