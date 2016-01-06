From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Git 2.7.0 gitignore behaviour regression
Date: Wed, 6 Jan 2016 16:42:32 +0700
Message-ID: <CACsJy8AQ9s4VkFn+TNJLD55xJc40+-54BTYbC4Os71uSkL1QSA@mail.gmail.com>
References: <4B0F686D-3DF9-4E5D-971D-DB106C6573FD@mikemcquaid.com> <20160105150602.GA4130@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>, Mike McQuaid <mike@mikemcquaid.com>
X-From: git-owner@vger.kernel.org Wed Jan 06 10:43:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aGkcZ-0007eg-Kc
	for gcvg-git-2@plane.gmane.org; Wed, 06 Jan 2016 10:43:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752227AbcAFJnI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Jan 2016 04:43:08 -0500
Received: from mail-lf0-f52.google.com ([209.85.215.52]:35414 "EHLO
	mail-lf0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752088AbcAFJnE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Jan 2016 04:43:04 -0500
Received: by mail-lf0-f52.google.com with SMTP id c192so133440921lfe.2
        for <git@vger.kernel.org>; Wed, 06 Jan 2016 01:43:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=GuC7XdsQNN3nS4/rgsuW9LUsfnX0tC5C3Rd4ljr71Iw=;
        b=qeJ5N13iEikhFFSRDgXwTQFECPfe4IbKmlaJloDKg6Cizxe0sviO95plekmf3Ddfgs
         ty1EE/PKsoi5V5y5yBCXkuUve8YklSy8Wdm+3xndoQSGyQnauNckFs27LnUR+W1PzRRN
         VqKgxj8ehGTEhwzbgIzLtUiBx0VF3iW5N0ujC/G6q2y5wH4f+ygjt7nMqA76B1JIiGTr
         XkadtBu0d8ixNlyLFK10eADU5JrgaSYGslwmWDYGKobJ3G/mAPtOUbKr4uznD3rebw7R
         y/2gfq23SAsPu2EIHDu4JvoOuaCMvCPifyxZTMU18TxeTnskYyoIYx4E5sKCDR60B/j7
         4Onw==
X-Received: by 10.25.137.84 with SMTP id l81mr35250079lfd.45.1452073382351;
 Wed, 06 Jan 2016 01:43:02 -0800 (PST)
Received: by 10.112.97.72 with HTTP; Wed, 6 Jan 2016 01:42:32 -0800 (PST)
In-Reply-To: <20160105150602.GA4130@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283428>

On Tue, Jan 5, 2016 at 10:06 PM, Jeff King <peff@peff.net> wrote:
> On Tue, Jan 05, 2016 at 02:40:16PM +0000, Mike McQuaid wrote:
>
>> Homebrew has a series of convoluted .gitignore rules due to our
>> special/weird use-case of wanting to ignore everything in a working
>> directory except a select few files/directories. We experienced a bu=
g
>> with our .gitignore file for users using Git 2.7.0. This may well be=
 a
>> valid WONTFIX or intentional behaviour change but I wanted to flag i=
t
>> in case it wasn=E2=80=99t.
>>
>> Here=E2=80=99s a minimal test case:
>>
>> - Create an empty git repository in a directory with `git init`
>> - Create a directory named =E2=80=98a' containing a file named =E2=80=
=98b' with `mkdir a && touch a/b`
>> - Create a =E2=80=98gitignore=E2=80=99 file with the following conte=
nts:
>> ```
>> */
>> /a
>> !/a/*
>> ```
>> - Run `git status --short`.
>>
>> The output with Git 2.6.4 is:
>> ```
>> ?? .gitignore
>> ```
>>
>> The output with Git 2.7.0 is:
>> ```
>> ?? .gitignore
>> ?? a/
>> ```
>
> Thanks for giving a clear example. This bisects to Duy's 57534ee (dir=
=2Ec:
> don't exclude whole dir prematurely if neg pattern may match,
> 2015-09-21). AFAICT (and I don't recall looking over this patch
> previously), what you are seeing is the intended effect of the patch.

Yeah.. I think it's the only relevant commit in 2.7.0 cycle anyway.
These patterns "/a" followed by "!/a/*" were wrecking my head. But I
finally decided 2.7 output makes more sense. You asked to un-ignore
everything inside 'a' so we can't treat 'a' as (entirely) ignored and
hide it away.

> I'm sympathetic that in making that use-case work, we might have
> regressed another one, but it's hard to tell from the small example. =
Can
> you elaborate on your use case? Why are you both ignoring and unignor=
ing
> everything in the directory?

Also how bad this affects you (widely-used 'wrong' behavior can become
'right', and my change a regression as a result)
--=20
Duy
