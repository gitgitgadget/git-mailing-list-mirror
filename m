From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [RFC PATCH] An option parser for the sequencer
Date: Mon, 11 Jul 2011 11:41:50 +0530
Message-ID: <CALkWK0nqiCQ5VMh7RXOJ7Z8tR6x-OJ4wWvNgUKcFuyBGY9Pj4w@mail.gmail.com>
References: <1310226118-10201-1-git-send-email-artagnon@gmail.com> <201107101015.29762.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Mon Jul 11 08:12:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qg9j7-0005RQ-8F
	for gcvg-git-2@lo.gmane.org; Mon, 11 Jul 2011 08:12:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757072Ab1GKGMM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 11 Jul 2011 02:12:12 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:61030 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754580Ab1GKGML convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Jul 2011 02:12:11 -0400
Received: by wyg8 with SMTP id 8so2348577wyg.19
        for <git@vger.kernel.org>; Sun, 10 Jul 2011 23:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=d5OmyTyVir9aCzsCTS6pqLDOeEcbcOjaljtorpYrhdk=;
        b=Up/T/73bZerKWn+oo8RJQqy7VIUPqveVCi8V+f8ehGlmmGET2B7Am1hD/n9H5T9ekH
         eeGgdR0QQdvurfb7vgLUsGQMje6b9QdbwomBnnxu8jAAb32LlzjvBFiD5SPoBgbx0484
         ZF/P3GIxNwcgT5FeWtuFPCYUyO5aqXM9Y13nM=
Received: by 10.216.187.75 with SMTP id x53mr2711390wem.92.1310364730131; Sun,
 10 Jul 2011 23:12:10 -0700 (PDT)
Received: by 10.216.175.198 with HTTP; Sun, 10 Jul 2011 23:11:50 -0700 (PDT)
In-Reply-To: <201107101015.29762.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176832>

Hi,

Christian Couder writes:
> On Saturday 09 July 2011 17:41:57 Ramkumar Ramachandra wrote:
>> I've decided not to support arbitrary command-line options in the
>> instruction sheet.
>
> It may be a good decision, but could you explain why? You could say f=
or
> example that the series would be already an improvement over what we =
have if
> we don't parse arbitrary command line options.

Here's an elaborate justification:
1. Parsing arbitrary command-line options means that we'd have to
support two versions of every command: the short version and the long
version.  As a result, two configuration files may be functionally
identical, but not really identical because one uses short versions
and the other uses long versions.   This is ugly/ inelegant.
2. The format can be quite loose: for example "--ff -s" is equivalent
to "---ff   '-s'".  We'll either have to go through the trouble to
sanitize everything at the time of persistence, or go through that
trouble while reading.  We can't entirely avoid this ugliness.
3. Where do we stop? Is something like "for i in "moo foo"; do $i;
done;" allowed?  How do we draw clear boundaries?
4. Most importantly, we're NOT building a fast git shell.  There's no
point implementing a reduced shell parser inside Git -- there are many
existing shells we can leverage, if that's what we want.

Besides, I can't think of a good enough usecase for per-instruction
command-line options right now.  How often would someone want to
cherry-pick 10 commits, but signoff on 3 of them somewhere in the
middle?  Not to say that we should not support per-instruction
command-line options: just that we can wait until someone figures out
a great usecase + a good implementation.  It's not critical.

Let's go back to the problem at hand -- what are we trying to do?  The
problem is to get cherry-pick/ revert to support '--continue', and
'--reset' as soon as possible and get it merged.  So, all we need is
one set of options to persist along with the head and todo.  A simple
"key =3D value" format is both simple and elegant; so we can go ahead
with it, and see how things play out later.  Since none of this is
exposed to the end-user, I don't see us locking ourselves into
short-sighted design at any rate.

>> A typical instruction sheet will looks like this
>> (inspired heavily by the rebase -i instruction sheet format):
>
>> pick 3b36854 t: add tests for cloning remotes with detached HEAD
>> pick 61adfd3 consider only branches in guess_remote_head
>> pick 8537f0e submodule add: test failure when url is not configured =
in
>> superproject pick 4d68932 submodule add: allow relative repository p=
ath
>> even when no url is set pick f22a17e submodule add: clean up duplica=
ted
>> code
>> pick 59a5775 make copy_ref globally available
>> pick c1921c1 clone: always fetch remote HEAD
>
> Would it be easy to change the format to support arbitrary command li=
ne
> options if we want to do it afterwards, especially after the end of t=
he GSoC?

Why not?  We aren't explicitly showing this to the end-user yet, so I
see no problem with changing it.  We should worry about that only when
we develop a feature like "cherry-pick -i".

>> For persisting one set of options for every "git cherry-pick"/ "git
>> revert" invocation, I've decided to use a simple "key =3D value" for=
mat
>> and put it in .git/sequencer/opts (to sit beside .git/sequencer/head
>> and .git/sequencer/todo). =C2=A0For strategy-option, I thought it wo=
uld be
>> cute to separate the various options using ' | '. =C2=A0So, it'll lo=
ok
>> something like this in the end:
>>
>> signoff =3D true
>> mainline =3D 1
>> strategy-option =3D recursive | ours
>
> Is it the same format as the .git/config file format? Would it be pos=
sible to
> reuse some config parsing/writing code?

Yes; I'm currently working on it.  I just wanted to show a simple PoC,
but I will try to avoid introducing new parsers and the bugs that come
along with it.

Thanks.

-- Ram
