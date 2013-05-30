From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Poor performance of git describe in big repos
Date: Thu, 30 May 2013 20:20:01 +0700
Message-ID: <CACsJy8A1oEezNeFjXTrQ=+gJ6nxDheFYTU0xtiSRt0aOOvE=Vw@mail.gmail.com>
References: <CAJ-05NPQLVFhtb9KMLNLc5MqguBYM1=gKEVrrtT3kSMiZKma_g@mail.gmail.com>
 <20130530114808.GD17475@serenity.lan> <CAJ-05NM9EhikDBP0izqWrnLbZW6RcHq_cH-20YTE08SZw5fjqA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: John Keeping <john@keeping.me.uk>,
	Git Mailing List <git@vger.kernel.org>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <kernel-hacker@bennee.com>
X-From: git-owner@vger.kernel.org Thu May 30 15:20:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ui2mT-0003N5-EB
	for gcvg-git-2@plane.gmane.org; Thu, 30 May 2013 15:20:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754669Ab3E3NUe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 30 May 2013 09:20:34 -0400
Received: from mail-ob0-f178.google.com ([209.85.214.178]:41152 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752279Ab3E3NUc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 May 2013 09:20:32 -0400
Received: by mail-ob0-f178.google.com with SMTP id fb19so504053obc.37
        for <git@vger.kernel.org>; Thu, 30 May 2013 06:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=WlAX4A8HEAPUpYPQNSfDZ9Woy8DKmrFJptuYNeaLE2g=;
        b=ZeH9qch520BYTdqat58IN4ZgS+dJVfa8LYB7RXdjDxx2uWJo8J9/4M9sXIDJpVQi2y
         eYTRQo5LGgKwK4SK4IXLxX9Bu+84EJ8hTr03IwgDwZA+vjpX8TpypBvEOWHRPo/37lQh
         ylZRQU3CFM2orznRvw7bTSJa8GJ78jMmUYu9NAv32e0PMWJyVm2qF4f9DNxhQkOBZW8M
         6oQd+QJGuB9c98QLdlnF6tungmFdLrC+hEF6IbXodqB0zx7JJ22yf0HnbcziJIuZwxle
         31ghIi1P7vFpTGxUEG31om7Q0WqIxfCbC//iJMvE7qPb8wVw31WHEmbdfCFhh4dSuoRl
         5ncA==
X-Received: by 10.182.19.168 with SMTP id g8mr4172536obe.21.1369920032385;
 Thu, 30 May 2013 06:20:32 -0700 (PDT)
Received: by 10.76.171.199 with HTTP; Thu, 30 May 2013 06:20:01 -0700 (PDT)
In-Reply-To: <CAJ-05NM9EhikDBP0izqWrnLbZW6RcHq_cH-20YTE08SZw5fjqA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225985>

On Thu, May 30, 2013 at 7:29 PM, Alex Benn=C3=A9e <kernel-hacker@bennee=
=2Ecom> wrote:
> I ran perf on it and the top items in the report where:
>
>  41.58%   git  libcrypto.so.1.0.0  [.] 0x6ae73
>  33.96%   git  libz.so.1.2.3.4     [.] 0xe0ec
>  10.39%   git  libz.so.1.2.3.4     [.] adler32
>   2.03%   git  [kernel.kallsyms]   [k] clear_page_c
>
> So I'm guessing it's spending a lot of non-cache efficient time
> un-packing and processing the deltas?

If I'm not mistaken, commits are never deltified. They are usually
small and packed close together for better I/O patterns. If you really
just read hundreds of commits, it can't take that long. Maybe some
code paths accidentally open a tree, a blob or something..

Can you try setting core.logpackaccess to a path on and rerun
describe? Jugding from the code (I never actually tried it), it'll
create a file at the given path with the accessed pack offsets. You
can check what offset corresponds to what object with verify-pack -v.
--
Duy
