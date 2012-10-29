From: Phil Hord <phil.hord@gmail.com>
Subject: Re: [PATCHv2] git-status: show short sequencer state
Date: Mon, 29 Oct 2012 14:05:14 -0400
Message-ID: <CABURp0o7b5aZV6jNM=DSweh-8zVgGppxVsXisAcoNk7TxHrdgQ@mail.gmail.com>
References: <1351022574-27869-1-git-send-email-hordp@cisco.com>
 <1351022574-27869-2-git-send-email-hordp@cisco.com> <20121025092919.GG8390@sigill.intra.peff.net>
 <5089633C.8030307@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>, konglu@minatec.inpg.fr,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Kong Lucien <Lucien.Kong@ensimag.imag.fr>,
	Duperray Valentin <Valentin.Duperray@ensimag.imag.fr>,
	Jonas Franck <Franck.Jonas@ensimag.imag.fr>,
	Nguy Thomas <Thomas.Nguy@ensimag.imag.fr>,
	Nguyen Huynh Khoi Nguyen 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
To: Phil Hord <hordp@cisco.com>
X-From: git-owner@vger.kernel.org Mon Oct 29 19:05:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TStif-0007lZ-Cp
	for gcvg-git-2@plane.gmane.org; Mon, 29 Oct 2012 19:05:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758830Ab2J2SFh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Oct 2012 14:05:37 -0400
Received: from mail-la0-f46.google.com ([209.85.215.46]:45162 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757098Ab2J2SFg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Oct 2012 14:05:36 -0400
Received: by mail-la0-f46.google.com with SMTP id h6so3983628lag.19
        for <git@vger.kernel.org>; Mon, 29 Oct 2012 11:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=IzxL60tH4VPhPS+C1yHoxgitbICSEeJuyqLdLzWlWpE=;
        b=JqP+HQgBhflbwD4EykttlGavYvG3EdqLCqlDp/iGsJgyfspHjHo7y2FSkEM9KuxCYJ
         HTQAxYV2dyQ5sGEldP4CdhvRCGvN9CzlubTzXJDzJwLH0Ei4Eqk/xrsi7h2oQBC6M/j9
         PpF5tFHuatLORpqZVqCFQzlKOxfBimAlEPVi2uMeX4FgWmXpOZFi/0VHAdM8w6BaE1wk
         Lv19Lfxkrj5iMZk0Q/vwPlrxSPOHk3pQbgs9iBZLbR88QQDZNUGOUEv9nBusUZ36vNSO
         ZO5Didb5kZeB3X6xWMI3gE8L+uxxNkY85Upu/UsGPhr5+mcpTqWtZJuve96/C6cNi840
         VF4Q==
Received: by 10.152.110.229 with SMTP id id5mr28027663lab.36.1351533934747;
 Mon, 29 Oct 2012 11:05:34 -0700 (PDT)
Received: by 10.114.26.166 with HTTP; Mon, 29 Oct 2012 11:05:14 -0700 (PDT)
In-Reply-To: <5089633C.8030307@cisco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208632>

On Thu, Oct 25, 2012 at 12:05 PM, Phil Hord <hordp@cisco.com> wrote:
>
> Jeff King wrote:
>> On Tue, Oct 23, 2012 at 04:02:54PM -0400, Phil Hord wrote:
>>
>>> Teach git-status to report the sequencer state in short form
>>> using a new --sequencer (-S) switch.  Output zero or more
>>> simple state token strings indicating the deduced state of the
>>> git sequencer.
>>>
>>> Introduce a common function to determine the current sequencer
>>> state so the regular status function and this short version can
>>> share common code.
>>>
>>> Add a substate to wt_status_state to track more detailed
>>> information about a state, such as "conflicted" or "resolved".
>>> Move the am_empty_patch flage out of wt_status_state and into
>> This patch ended up quite long. It might be a little easier to review
>> if it were broken into refactoring steps (I have not looked at it too
>> closely yet, but it seems like the three paragraphs above could each be
>> their own commit).

I'm currently splitting this out into a series and reconsidering some
of it along the way.  I need some guidance.

I want to support these two modes:

  A.  'git status --short' with sequence tokens added:
       ## conflicted
       ## merge
       ?? untracked-workdir-file
       etc.

  B.  Same as (A) but without workdir status:
       ## conflicted
       ## merge

The user who wants 'A' would initiate it like this:
    git status --sequencer
  or
    git status -S

How do I spell the options for 'B'?  I have come up with these three
possibilities:
    git --sequencer-only   # Another switch
    git --sequencer=only   # An OPTARG parser
    git -S -S           # like git-diff -C -C, an OPT_COUNTUP

The first one is easy but weird, imho.
The second seems silly for just one type of option.
The last one is cheap to implement, but harder to explain in Documentation/

Any opinions?

Phil
