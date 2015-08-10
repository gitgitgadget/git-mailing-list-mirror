From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: Error pushing new branch: value too great for base (error token is...
Date: Mon, 10 Aug 2015 18:47:50 -0400
Message-ID: <CAPig+cTB0VU6rmLT1H7sPMNBPE0zKvWmMp_obS5VpZBAi2nYLA@mail.gmail.com>
References: <CAGDgvc3Gxn=pKBfYC+yrUhCmL9X6bqjPVwVokF0qPsXmhx_EaQ@mail.gmail.com>
	<CAPig+cTXO3699MdqSFVDBcnKcHAT=Mkp=c=r3C8F5nT8tfr6gw@mail.gmail.com>
	<CAGDgvc2hc+f5CuPXc2pr5uYd9kniVpuffrb6z416CicxBgVxJQ@mail.gmail.com>
	<CAGDgvc1FJ0K+OLQBj8iXPCnqMFyBD3mp32k0aTztQkKKuxNxtQ@mail.gmail.com>
	<CA+P7+xpKHw8xkpMSjCftmAnMh=J_R9HxhYD48O2-P2WKUH1diw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Gaurav Chhabra <varuag.chhabra@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Jacob Keller <jacob.keller@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 11 00:47:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZOvrH-0008Ho-60
	for gcvg-git-2@plane.gmane.org; Tue, 11 Aug 2015 00:47:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754803AbbHJWrv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2015 18:47:51 -0400
Received: from mail-yk0-f171.google.com ([209.85.160.171]:35636 "EHLO
	mail-yk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752974AbbHJWru (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Aug 2015 18:47:50 -0400
Received: by ykdz80 with SMTP id z80so41125958ykd.2
        for <git@vger.kernel.org>; Mon, 10 Aug 2015 15:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=Bw/lWwopxJBsy7MWgbR83lftyLD5hs9U56Tmx92DQc4=;
        b=JD1OUijM9FPfoRF80WUCJdS4Nr9V499W+xZzhH8T81zfRzFzbLikVKdWbQ7aHFXadn
         prVhHdUyhRSdPJJA+pEymtydzYblq2quWMD5GKrgK6LudtN5c/448HMNxKxGIWI0rclv
         uUr50bYsc5akan77c99bbYfnUw+zxdJw7ix56WsBBwsDqGziqxkZHBr6DHAZNALuK2kE
         Hf09KXqMkQ973EpCDZMShQrxZmI9LTvs6o7KKElyMcUX/UAuTirCII8JGSuxJ70nrGqn
         9w9/nDqvMm2IX1mZT4E8KfOiWWhzWD2KzylxQRqHPnrb5Pe2SXQldnQSeO0h3HDnEaN/
         UvMg==
X-Received: by 10.170.81.133 with SMTP id x127mr24029726ykx.13.1439246870171;
 Mon, 10 Aug 2015 15:47:50 -0700 (PDT)
Received: by 10.37.12.129 with HTTP; Mon, 10 Aug 2015 15:47:50 -0700 (PDT)
In-Reply-To: <CA+P7+xpKHw8xkpMSjCftmAnMh=J_R9HxhYD48O2-P2WKUH1diw@mail.gmail.com>
X-Google-Sender-Auth: be8TnLNte8Rk9FKgvpdGWYQdD5U
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275660>

On Mon, Aug 10, 2015 at 6:29 PM, Jacob Keller <jacob.keller@gmail.com> wrote:
> On Mon, Aug 10, 2015 at 2:54 AM, Gaurav Chhabra
> <varuag.chhabra@gmail.com> wrote:
>> Apologies for the delay in reply! I tried your suggestion and it
>> works. Thanks! :)
>>
>> I'm curious why integer comparison is throwing error. Shouldn't i be
>> comparing numbers with numeric operator?
>
> Yes, but shell doesn't treat hex numbers as numbers. So it will work
> only if the string is a decimal number.

This particular case deserves a bit more explanation. The expression
in question was this:

    if [[ "$new_sha" -eq "$NULL" ]]; then

where 'new_sha' was 9226289d2416af4cb7365d7aaa5e382bdb3d9a89.

In Bash, inside the [[ .. ]], it did attempt evaluating the SHA1 as a
*decimal* number, however, when it encountered the "d", it complained
that it was outside the allowed range of decimal digits ("0"..."9").
Had the SHA1 been prefixed by a "0x", the [[...]] context would have
dealt with it just fine.

Outside the [[...]] context, arguments to -eq do need to be base-10 integers.

Nevertheless, a SHA1 is effective an opaque value. There's little, if
anything, to be gained by treating it as a numeric quantity, hence
string '=' makes more sense than numeric '-eq'.
