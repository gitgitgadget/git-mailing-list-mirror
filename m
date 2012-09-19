From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: possible bug in autocompletion
Date: Wed, 19 Sep 2012 20:23:01 +0200
Message-ID: <CAMP44s1ZVTgBTQDyBHKvos-uSo0FeOO437MvTYH0YE0Lx-xDOA@mail.gmail.com>
References: <BLU0-SMTP405CDB35308082B180185A6B4DB0@phx.gbl>
	<20120717121232.GA32571@sigill.intra.peff.net>
	<CAMP44s2X5-BUyLtkTqGMa6w5K6uT25YLEp+Q2TdVR_qCObOpeA@mail.gmail.com>
	<20120919174336.GA11699@sigill.intra.peff.net>
	<CAMP44s1Xvvs7g1quUEs2b43VciK2=Nt-AntJcwG0CPf6p8Xk_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeroen Meijer <jjgmeijer@hotmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Sep 19 20:23:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TEOvY-0004PT-Rg
	for gcvg-git-2@plane.gmane.org; Wed, 19 Sep 2012 20:23:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754097Ab2ISSXE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Sep 2012 14:23:04 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:60250 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753299Ab2ISSXC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Sep 2012 14:23:02 -0400
Received: by oago6 with SMTP id o6so1367362oag.19
        for <git@vger.kernel.org>; Wed, 19 Sep 2012 11:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=CXWNse1rZS2B5fP8UQIL4hLftNr6jkgjRIyrFqUtxfQ=;
        b=WTh1D8SiauCkI26nzZsALHOvw2B4DGA/VHeAZSGD8l5EECjK+vpPtfO6waXgoAERIE
         5i5gSDeEVUXVQ51mCi0HStM9OMo0s6Gnp9lWpN1/dUwkRgR4KbKFLRp3PGUl3qyqltWT
         TqNi0sy0PMceqBTUwgvd8TrA/S6s4kIVrQS6lBWFP2duBSh7bIF2ca/LjoKzew0+Wagt
         BV+WWAurWB4SpqGyD8HbDuLCHvi2zs2DNp/ALa6dxqrqB0+GbmL6X5thWbAfIC/qiT34
         YkzFFs/jr6UBjuEd/C2lIV/Kg8Wf2iU0ztUpf2XLz0onyzw1/rKKY8p6B3vxnN+kJ8IT
         H8aA==
Received: by 10.182.152.65 with SMTP id uw1mr3508206obb.91.1348078981660; Wed,
 19 Sep 2012 11:23:01 -0700 (PDT)
Received: by 10.60.164.7 with HTTP; Wed, 19 Sep 2012 11:23:01 -0700 (PDT)
In-Reply-To: <CAMP44s1Xvvs7g1quUEs2b43VciK2=Nt-AntJcwG0CPf6p8Xk_A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205970>

On Wed, Sep 19, 2012 at 8:16 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> On Wed, Sep 19, 2012 at 7:43 PM, Jeff King <peff@peff.net> wrote:
>> On Wed, Sep 19, 2012 at 07:08:09PM +0200, Felipe Contreras wrote:
>>
>>> On Tue, Jul 17, 2012 at 2:12 PM, Jeff King <peff@peff.net> wrote:
>>>
>>> > --- a/contrib/completion/git-completion.bash
>>> > +++ b/contrib/completion/git-completion.bash
>>> > @@ -261,7 +261,12 @@ __gitcomp ()
>>> >  __gitcomp_nl ()
>>> >  {
>>> >         local IFS=$'\n'
>>> > -       COMPREPLY=($(compgen -P "${2-}" -S "${4- }" -W "$1" -- "${3-$cur}"))
>>> > +       local words=$1
>>> > +       words=${words//\\/\\\\}
>>> > +       words=${words//\$/\\\$}
>>> > +       words=${words//\'/\\\'}
>>> > +       words=${words//\"/\\\"}
>>> > +       COMPREPLY=($(compgen -P "${2-}" -S "${4- }" -W "$words" -- "${3-$cur}"))
>>> >  }
>>>
>>> What about something like this?
>>>
>>> local words
>>> printf -v words "%q" "$w"
>>> COMPREPLY=($(compgen -P "${2-}" -S "${4- }" -W "$words" -- "${3-$cur}"))
>>
>> Thanks, I didn't know about bash's internal printf magic. That is a much
>> more elegant solution.
>>
>> Care to wrap it up in a patch?
>
> I'm trying to, but unfortunately "\n" gets converted to "\\n", so it
> doesn't get separated to words. Any ideas?

Actually, this seems to do the trick:

	local words IFS=$'\n'
	printf -v words "%q" "$1"
	COMPREPLY=($(compgen -P "${2-}" -S "${4- }" -W "${words//\\n/$IFS}"
-- "${3-$cur}"))

I don't know how to do $'\n' in the middle of double-quotes, but $IFS works.

-- 
Felipe Contreras
