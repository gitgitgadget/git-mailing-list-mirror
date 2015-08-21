From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH 2/3] run-commands: add an async queue processor
Date: Fri, 21 Aug 2015 13:41:14 -0700
Message-ID: <xmqq37zc5q8l.fsf@gitster.dls.corp.google.com>
References: <1440121237-24576-1-git-send-email-sbeller@google.com>
	<1440121237-24576-2-git-send-email-sbeller@google.com>
	<xmqqegiw5uom.fsf@gitster.dls.corp.google.com>
	<20150821194454.GB26466@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
	jrnieder@gmail.com, Johannes Sixt <j6t@kdbg.org>,
	hvoigt@hvoigt.net, jens.lehmann@web.de
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Aug 21 22:41:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZSt7q-0007FN-79
	for gcvg-git-2@plane.gmane.org; Fri, 21 Aug 2015 22:41:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752492AbbHUUlR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Aug 2015 16:41:17 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:35567 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752044AbbHUUlR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Aug 2015 16:41:17 -0400
Received: by pacdd16 with SMTP id dd16so51319460pac.2
        for <git@vger.kernel.org>; Fri, 21 Aug 2015 13:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=2HOhhLk6tCRNDV4OPeqrXVqDQJ3qXJsxUaTE0W66qes=;
        b=E9OQLxslh2v/ZcUEDDTpSHnIm9JLp+rsJocqyJUL2/9m9XIJ9lUt7IZHHlb0O00Bwv
         ypCyaELQALiPNajUjQZA3tKQott+ozhQJLUqCrEd8NXa2Xb8yvDcg0uZyjlSwG0fH1z2
         oZtQiHRKusNidEwTBdVGHIVQ1K/kH004tBW+i/8MXlGDInT83YOFAUPpzRzgu9eDOBbD
         cFhHasIj2L8z3zudi4gmvmeDathzkG7+o2vPvSLzrbw2JlefdzRp1nBOavek7/MIa/G9
         TQee7h/j8eaopp+VvI0v0wwUlGSXxtycGHbjBZ7B1GEoZu0xG9G4d3hVqKK3K0c75q+r
         I9mw==
X-Received: by 10.68.104.227 with SMTP id gh3mr20938652pbb.108.1440189676621;
        Fri, 21 Aug 2015 13:41:16 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:4c7d:6904:6af7:82e1])
        by smtp.gmail.com with ESMTPSA id df2sm2338145pad.19.2015.08.21.13.41.15
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 21 Aug 2015 13:41:15 -0700 (PDT)
In-Reply-To: <20150821194454.GB26466@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 21 Aug 2015 15:44:54 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276330>

Jeff King <peff@peff.net> writes:

> On Fri, Aug 21, 2015 at 12:05:13PM -0700, Junio C Hamano wrote:
>
>> The primary reason I suspect is because you sent to a wrong set of
>> people.  Submodule folks have largely been working in the scripted
>> ones, and may not necessarily be the ones who are most familiar with
>> the run-command infrastructure.
>> 
>> "shortlog --no-merges" tells me that the obvious suspects are j6t
>> and peff.
>
> No good deed goes unpunished. ;)
>
> Before even looking at the implementation, my first question would be
> whether this pattern is applicable in several places in git (i.e., is it
> worth the extra complexity of abstracting out in the first place). I
> think there are a few task-queue patterns already in git; for example
> the delta search in pack-objects. Is the interface given here sufficient
> to convert pack-objects? Is the result nicer to read? Is it as
> efficient?
>
> We do not need to convert all possible call-sites to the new abstracted
> code at once. But I find that converting at least _one_ is a good litmus
> test to confirm that a new interface is generally useful.

Ah, thanks for saying this.  I recall saying something similar
earlier and totally agree with you.
