From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/8] revert: decouple sequencer actions from builtin
 commands
Date: Wed, 11 Jan 2012 07:40:12 -0600
Message-ID: <20120111134011.GH32173@burratino>
References: <20120110183857.GC22184@burratino>
 <CALkWK0k=44znLr2oYSx61Mk=qdAurona0f0H4i4=YXNSAeQhHQ@mail.gmail.com>
 <CALkWK0=bEPPv4rtPrMrQnk3MK=JY4-wwAByWPmzg86NBm_56iQ@mail.gmail.com>
 <20120111050404.GA13507@burratino>
 <CALkWK0kJpEXvBMV=D7h91sz7U2sLvXdW1UzomW0kG2bbM+byYA@mail.gmail.com>
 <CALkWK0muXXKu37_qQ8E+LEZiCxebWvWghkc8QjyfdBazjLOstw@mail.gmail.com>
 <20120111054954.GB13507@burratino>
 <CALkWK0=o+KkV08G9JuTaG8Vtb-AzHQVMQPzMy8td_iBVnGX4Dg@mail.gmail.com>
 <20120111095236.GB31670@burratino>
 <CALkWK0mv2jzmDA==pJg5R4jH0yxo=OopYM_WzAWusiffnb+4HQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 11 14:35:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RkyKq-0000OW-Gc
	for gcvg-git-2@lo.gmane.org; Wed, 11 Jan 2012 14:35:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757226Ab2AKNfS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jan 2012 08:35:18 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:45595 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754864Ab2AKNfR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jan 2012 08:35:17 -0500
Received: by yhjj63 with SMTP id j63so276626yhj.19
        for <git@vger.kernel.org>; Wed, 11 Jan 2012 05:35:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=yv+ybBN8YO2L4P+8FeJrXLC+Sh9cx+TfRJ7xLF/Sf6I=;
        b=bq20bptCJh4oIBZh8g64w8VtofT50U88LjiH8dGGezSrAaakzGg5zQN9FEpflO1uwn
         2NTg/wf4/i64NtBPhgZ2pCUVDD3PtfVJJnDzJk54lwlEDHjtw4f6p/hGmL7EQNzP8e+q
         3EWlAKIYZQ6cHFEbkfF6ybJvq04omX+uVNoxQ=
Received: by 10.236.124.15 with SMTP id w15mr32020662yhh.120.1326288916659;
        Wed, 11 Jan 2012 05:35:16 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id e66sm2359805yhk.6.2012.01.11.05.35.14
        (version=SSLv3 cipher=OTHER);
        Wed, 11 Jan 2012 05:35:15 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CALkWK0mv2jzmDA==pJg5R4jH0yxo=OopYM_WzAWusiffnb+4HQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188366>

Ramkumar Ramachandra wrote:

> We'd be prematurely locking ourselves into a design where we can't
> tell which top-level command issued the continue/ abort

The .git/sequencer/todo file already doesn't record which top-level
command initiated the sequence and doesn't seem to operate under a
model in which that is a useful question.  Honestly, that's my only
objection to the "git revert --continue during git cherry-pick" check.

I think it is not premature to think about whether that matters.  I've
already said a little about related cases where it seemed to matter
but there was instead something else at play.  Can you offer some
examples of how people might use the "git cherry-pick" / "git revert"
commands and get stuck or run into trouble, and how git can help them?

[...]
>                                                           My sincere
> suggestion is to procrastinate the problem until we have a tighter
> usecase (a new top-level command or action added, for instance).

Thinking carefully about sequencer use cases also seems like a good
idea.  Is it intended that "git am" and "git rebase" should be
reimplemented on top of the sequencer?  Do you have goals in mind for
commands like "git sequence --step" that could be used to examine,
influence, and carry out git's idea of what should happen next?

If we have no use case, then there's no reason to change the code.  It
already works[*] for cherry-pick and revert.  I think we shouldn't be
moving this code to sequencer.c or cleaning up the API to suit other
commands (e.g., introducing two ways to sane "am I picking or
reverting") without having one in mind.

[*] Modulo bugs and some missing features such as --skip.
