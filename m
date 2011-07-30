From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 16/18] revert: Remove sequencer state when no commits are pending
Date: Sat, 30 Jul 2011 20:13:42 +0530
Message-ID: <CALkWK0=9kwgtZB-BA12tOQrQXS8XRbhTg6K=Ak00o2nurX16Fg@mail.gmail.com>
References: <1311736755-24205-1-git-send-email-artagnon@gmail.com>
 <1311736755-24205-17-git-send-email-artagnon@gmail.com> <20110727051755.GK18470@elie>
 <CALkWK0noPtLgr_t=DC_XFdLrWUNCLhUd00Mw1HbmWRJjeT4jew@mail.gmail.com>
 <20110727141006.GA24785@elie> <CALkWK0k8Lra7LkGJXoXScnGUjrag-xgNptaB_JCiAsgemTq0eQ@mail.gmail.com>
 <20110727154830.GA29924@elie> <CALkWK0mUGiCRQoW6UM+mF5tsn4DxRuaiXn0TS2CcEsR0OeusKg@mail.gmail.com>
 <20110729191654.GA2368@elie.dc0b.debconf.org> <CALkWK0=qXBteRjj5vXDEWGVausQ3ssOvy4hyHHz84ORFzDaHaQ@mail.gmail.com>
 <20110730131050.GA4848@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 30 16:44:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QnAlw-0003mq-KU
	for gcvg-git-2@lo.gmane.org; Sat, 30 Jul 2011 16:44:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751410Ab1G3OoG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 30 Jul 2011 10:44:06 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:35138 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751090Ab1G3OoE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 30 Jul 2011 10:44:04 -0400
Received: by wwe5 with SMTP id 5so4371228wwe.1
        for <git@vger.kernel.org>; Sat, 30 Jul 2011 07:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=/zl02RhH6KJVI81EcBxfsMjUCyd4m8UcIAspjAm+/Zw=;
        b=xWBX3GTbarccEnoO46W1wOwSdZ7w052AHwg9RT7hL1PKyUEUI5k4hkBNCBJqDWwuaW
         NTlxmkBSuDqJDO+63XwxPa4ediKDEkqCpURvlbmzAVsSaRkQkDtcRByP7jNevFwcJ3K2
         UWOTvYPZNtGAnZsEvVJc58msqdRF6QPwAUX1Q=
Received: by 10.227.41.200 with SMTP id p8mr3593370wbe.79.1312037042144; Sat,
 30 Jul 2011 07:44:02 -0700 (PDT)
Received: by 10.216.137.134 with HTTP; Sat, 30 Jul 2011 07:43:42 -0700 (PDT)
In-Reply-To: <20110730131050.GA4848@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178202>

Hi again,

Jonathan Nieder writes:
> Ramkumar Ramachandra wrote:
>> Okay, I don't follow. =C2=A0Wouldn't this function need to parse the=
 todo
>> sheet and figure out how many instructions are left? =C2=A0For that,=
 the
>> todo parsing functions can't be buried in builtin/revert.c, no? =C2=A0=
Hence
>> I said "expose" them -- or move them to sequencer.c.
>
> Oh, that makes sense. =C2=A0Sorry for the nonsense. =C2=A0If I were i=
n your
> shoes, I'd move everything below pick_commits to sequencer.c.

:sigh: I thought it would be easy too, but there are several
complications.  I'll spare you the gory details of the series I'm
preparing and tell you the main problem briefly:
Notice how the API of read_populate_todo includes opts.  Arguably, I
did this with good reason: I didn't want `git cherry-pick --continue`
to continue a pending `git revert` operation and viceversa.  However,
this means that option parsing and todo parsing are slightly tangled
up now -- I could always pass a dummy opts structure with only the
action filled in, but I think that's inelegant.  So, I'm currently
working to untangle them by changing the way a todo list is
represented -- just a commit_list won't do.  Once I change this, a
simple `git cherry-pick --continue` will be able to continue any
pending sequencer operation, but this is arguably a big patch.  Once
that is done, I can move dependent functions to sequencer.c and expose
an API in sequencer.h for commit.c to use.  Also, I don't want to move
things to sequencer.c and change the API until I can imagine other git
programs working with the generalized sequencer; I hope it'll be clear
after a weekend of work.

Long story short: I'd like it if we could bear with this slight
annoyance (removal of sequencer state when one commit is pending) and
get the series merged, so that I can work on a series to improve the
experience based on this series.

Thanks.

-- Ram
