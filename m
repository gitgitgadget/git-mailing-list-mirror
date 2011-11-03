From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: long fsck time
Date: Thu, 3 Nov 2011 08:36:16 +0700
Message-ID: <CACsJy8DN74QWYA_NzBCGgp_VdQpV5PqGMgAFUKYbOecVqw6HYQ@mail.gmail.com>
References: <CACsJy8D04Hw0_OoV01g2xtNK2d6fmZD_+YNEOR3A8aMUTpG5Lw@mail.gmail.com>
 <CACsJy8B=5mEWoOBkrTfmJ+p7HxqJM97zdG-k71oW81-3XxuO_Q@mail.gmail.com> <20111102213332.GA14108@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Nov 03 03:08:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RLmik-0002uP-15
	for gcvg-git-2@lo.gmane.org; Thu, 03 Nov 2011 03:07:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932159Ab1KCCHv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Nov 2011 22:07:51 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:52294 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933555Ab1KCBgu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Nov 2011 21:36:50 -0400
Received: by faao14 with SMTP id o14so1010440faa.19
        for <git@vger.kernel.org>; Wed, 02 Nov 2011 18:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=7dIreNpCfuNDX+uIZdAkU3hPqQ6dufnqqsHwwqo7QX0=;
        b=Oc5wxn7Lw87Bkss4F6trDo61hIUeqzNDE3ZZjAR1m4XcwDfu7aQEhwk9jlv46vJRS1
         CXtufN0r3VTsOsEJCu0a4H2EYsSRLO8ltQ8vIHqgtAcT+/8yzorkm/1/QYkQ1ye7+Uzs
         5QkcDqg60kjgK34NlzhCUjNgNZRmbIYbKd1Xw=
Received: by 10.223.1.137 with SMTP id 9mr12226660faf.19.1320284209067; Wed,
 02 Nov 2011 18:36:49 -0700 (PDT)
Received: by 10.223.144.138 with HTTP; Wed, 2 Nov 2011 18:36:16 -0700 (PDT)
In-Reply-To: <20111102213332.GA14108@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184692>

2011/11/3 Jeff King <peff@peff.net>:
> On Wed, Nov 02, 2011 at 07:10:26PM +0700, Nguyen Thai Ngoc Duy wrote:
>
>> On Wed, Nov 2, 2011 at 7:06 PM, Nguyen Thai Ngoc Duy <pclouds@gmail.=
com> wrote:
>> > On git.git
>> >
>> > $ /usr/bin/time git fsck
>> > 333.25user 4.28system 5:37.59elapsed 99%CPU (0avgtext+0avgdata
>> > 420080maxresident)k
>> > 0inputs+0outputs (0major+726560minor)pagefaults 0swaps
>> >
>> > That's really long time, perhaps we should print progress so users
>> > know it's still running?
>>
>> Ahh.. --verbose. Sorry for the noise. Still good to show the number =
of
>> checked objects though.
>
> fsck --verbose is _really_ verbose. It could probably stand to have s=
ome
> progress meters sprinkled throughout. The patch below produces this o=
n
> my git.git repo:


Yes, I wanted something like this.

> =C2=A0$ git fsck
> =C2=A0Checking object directories: 100% (256/256), done.
> =C2=A0Verifying packs: 100% (7/7), done.
> =C2=A0Checking objects (pack 1/7): 100% (241/241), done.
> =C2=A0Checking objects (pack 2/7): 100% (176/176), done.
> =C2=A0Checking objects (pack 3/7): 100% (312/312), done.
> =C2=A0Checking objects (pack 4/7): 100% (252/252), done.
> =C2=A0Checking objects (pack 5/7): 100% (353/353), done.
> =C2=A0Checking objects (pack 6/7): 100% (375/375), done.
> =C2=A0Checking objects (pack 7/7): 100% (171079/171079), done.

Would be better if we only output one "Checking objects" line.

> which gives reasonably smooth progress. The longest hang is that
> "Verifying pack" 7 is slow (I believe it's doing a sha1 over the whol=
e
> thing). If you really wanted to get fancy, you could probably do a
> throughput meter as we sha1 the whole contents.

I'll give it a try.

> Patch is below. It would need --{no-,}progress support on the command
> line, and to check isatty(2) before it would be acceptable.

Agreed on isatty(), though I think this output should be default (with
maybe --quiet to silence it on tty). Other messages may be prepended
with severity to indicate they are not progress output.
--=20
Duy
