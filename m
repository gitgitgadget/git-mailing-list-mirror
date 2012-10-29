From: =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: gitweb
Date: Mon, 29 Oct 2012 08:12:46 +0100
Message-ID: <CANQwDwd6EP94PEFkEcx8gBX1B5+-95qtjGMD6iU3ao8G+rCbLw@mail.gmail.com>
References: <20121028165647.b79fe3fcb6784c4ae547439e@lavabit.com> <20121029052815.GA30186@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: rh <richard_hubbe11@lavabit.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Oct 29 08:13:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TSjXF-0000t3-5E
	for gcvg-git-2@plane.gmane.org; Mon, 29 Oct 2012 08:13:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752493Ab2J2HNJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Oct 2012 03:13:09 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:59985 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751661Ab2J2HNH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Oct 2012 03:13:07 -0400
Received: by mail-oa0-f46.google.com with SMTP id h16so4373983oag.19
        for <git@vger.kernel.org>; Mon, 29 Oct 2012 00:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=xgko8ZVPBnxwKQOEOnsG03l2nQOm0kD8UVdDhRbzhhw=;
        b=wkErk2I85ZA740LCEBTx6tT8h+pslmbmVsxIl62CJF2zVYzshWgdrAmyJDCWxfjA6W
         FcGFHIxLJzB/dZSt1FnMkQcL7dHbTjEtp4hQW9HmG/anCuxCMHLgm4ILX97BJlyqPrEW
         stAXWn2XmMHveqU59ZwY1u92LiPXJvNyrA8d0XGgjcNbdOWMlhmkIuWySyg0zs3/4EYP
         jGkfbYKw+MgxI5zzZu0Mu01Y8Jz6u9cn8Z9HDzDzCx73Oexxfj3jB1BA8+3f3VphVLlA
         0tczCAyaf2nv7M8xSWoTkGIlAz42EHnF5WQ+NUI0e4/RZh7eqzCoeh+yeNlQ0ks42JLW
         1nMw==
Received: by 10.60.8.103 with SMTP id q7mr8129684oea.70.1351494786513; Mon, 29
 Oct 2012 00:13:06 -0700 (PDT)
Received: by 10.76.91.134 with HTTP; Mon, 29 Oct 2012 00:12:46 -0700 (PDT)
In-Reply-To: <20121029052815.GA30186@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208597>

On Mon, Oct 29, 2012 at 6:28 AM, Jeff King <peff@peff.net> wrote:
> On Sun, Oct 28, 2012 at 04:56:47PM -0700, rh wrote:
>
>> I'm not using gitweb I was thinking about using it and was looking at the
>> cgi and saw this in this file:
>> https://github.com/git/git/blob/master/gitweb/gitweb.perl
>>
>> I think I understand the intention but the outcome is wrong.
>>
>> our %highlight_ext = (
>>       # main extensions, defining name of syntax;
>>       # see files in /usr/share/highlight/langDefs/ directory
>>       map { $_ => $_ }
>>       qw(py c cpp rb java css php sh pl js tex bib xml awk bat ini spec tcl sql make),
>>       # alternate extensions, see /etc/highlight/filetypes.conf
>>       'h' => 'c',
[...]
> Yeah, this is wrong. The first map will eat the rest of the list, and
> you will get "h => h", "cxx => cxx", and so forth. I do not know this
> chunk of code, but that does not seem like it is the likely intent.
>
> You could fix it with extra parentheses:
>
>   our %he = (
>     (map { $_ => $_ } qw(py c cpp ...)),
>     'h' => 'c',
>     (map { $_ => 'sh' } qw(bash zsh ksh)),
>     ... etc ...
>   );
>
>> I think the intent is better met with this, (the print is for show)
>>
>> our %he = ();
>> $he{'h'} = 'c';
>> $he{$_} = $_     for (qw(py c cpp rb java css php sh pl js tex bib xml awk bat ini spec tcl sql make));
>> $he{$_} = 'cpp'  for (qw(cxx c++ cc));
[...]

> That is more readable to me (though it does lose the obviousness that it
> is a variable initialization).
>
> Looks like this was broken since 592ea41 (gitweb: Refactor syntax
> highlighting support, 2010-04-27). I do not use gitweb (nor highlight)
> at all, but I'd guess the user-visible impact is that "*.h" files are
> not correctly highlighted
>
> Jakub, can you confirm the intent and a fix like the one above makes
> things better?

Yes, either of those makes things better.

>                                   (unless highlight does this extension mapping
> itself, but then why are we doing it here?).

Highlight does extension mapping itself... but for that it needs file name,
and not to be feed file contents from pipe.

-- 
Jakub Narebski
