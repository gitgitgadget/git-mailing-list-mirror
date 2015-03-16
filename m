From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH v4] rev-list: refuse --first-parent combined with --bisect
Date: Mon, 16 Mar 2015 20:25:13 -0000
Organization: OPDS
Message-ID: <065AE7977A54488198B39564E3E174E6@PhilipOakley>
References: <1425827005-9602-1-git-send-email-me@ikke.info><1425934575-19581-1-git-send-email-me@ikke.info><xmqqa8zkzeq5.fsf@gitster.dls.corp.google.com><20150310225509.GA5442@vps892.directvps.nl><xmqqoao0xx9p.fsf@gitster.dls.corp.google.com><20150311184512.GB5442@vps892.directvps.nl><xmqqsidb5m2r.fsf@gitster.dls.corp.google.com><20150316163306.GB11832@vps892.directvps.nl> <xmqqbnjsrcyz.fsf@gitster.dls.corp.google.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>, "Kevin Daudt" <me@ikke.info>
X-From: git-owner@vger.kernel.org Mon Mar 16 21:24:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YXbYV-00080V-KF
	for gcvg-git-2@plane.gmane.org; Mon, 16 Mar 2015 21:24:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754575AbbCPUYD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Mar 2015 16:24:03 -0400
Received: from out1.ip02ir2.opaltelecom.net ([62.24.128.238]:24981 "EHLO
	out1.ip02ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753985AbbCPUYB (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Mar 2015 16:24:01 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A2CeGQDJOgdVPAO1YwJbgwaBLIY5bbdUi28EAoE4TQEBAQEBAQYBAQEBOCAbhAoFAQEBAQIBCAEBLh4BASELAgMFAgEDFQwlFAEEGgYHAxQGARIIAgECAwGIFgyzIJRwLIsXhHGDHoEWBYpVhWVhnRmCJRyBUD4xgkMBAQE
X-IPAS-Result: A2CeGQDJOgdVPAO1YwJbgwaBLIY5bbdUi28EAoE4TQEBAQEBAQYBAQEBOCAbhAoFAQEBAQIBCAEBLh4BASELAgMFAgEDFQwlFAEEGgYHAxQGARIIAgECAwGIFgyzIJRwLIsXhHGDHoEWBYpVhWVhnRmCJRyBUD4xgkMBAQE
X-IronPort-AV: E=Sophos;i="5.11,411,1422921600"; 
   d="scan'208";a="28256430"
Received: from host-2-99-181-3.as13285.net (HELO PhilipOakley) ([2.99.181.3])
  by out1.ip02ir2.opaltelecom.net with ESMTP; 16 Mar 2015 20:23:58 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265593>

From: "Junio C Hamano" <gitster@pobox.com>
> Kevin Daudt <me@ikke.info> writes:
>
>> So this ref changes to the bad commit.
>>
>> For refs/bisect/good-*, I could only find an example snippet:
>>
>>> GOOD=$(git for-each-ref "--format=%(objectname)" refs/bisect/good-*)
>>
>> But it's not really clear what * might be expanded to, nor what they
>> mean. I guess this could use some clarrification in the 
>> documentation.
>
> Because the history is not linear in Git, bisection works by
> shrinking a subgraph of the history DAG that contains "yet to be
> tested, suspected to have introduced a badness" commits.  The
> subgraph is defined as anything reachable from _the_ "bad" commit
> (initially, the one you give to the command when you start) that are
> not reachable from any of the "good" commits.
>
> Suppose you started from this graph.  Time flows left to right as
> usual.
>
>  ---0---2---4---6---8---9
>      \             /
>       1---3---5---7
>
> Then mark the initial good and bad commits as G and B.
>
>  ---G---2---4---6---8---B
>      \             /
>       1---3---5---7
>
> And imagine that you are asked to check 4, which turns out to be
> good.  We do not _move_ G to 4; we mark 4 as good, while keeping
> 0 also as good.
>
>  ---G---2---G---6---8---B
>      \             /
>       1---3---5---7
>
> And if you are next asked to check 5, and mark it as good, the graph
> will become like this:
>
>  ---G---2---G---6---8---B
>      \             /
>       1---3---G---7
>
> Of course, at this point, the subgraph of suspects are 6, 7, 8 and
> 9, and the subgraph no longer is affected by the fact that 0 is
> good.  But it is crucial to keep 0 marked as good in the step before
> this one, before you tested 5, as that is what allows us not having
> to test any ancestors of 0 at all.
>
> Now, one may wonder why we need multiple "good" commits but we do
> not need multiple "bad" commits.  This comes from the nature of
> "bisection", which is a tool to find a _single_ breakage [*1*], and
> a fundamental assumption is that a breakage does not fix itself.
>
> Hence, if you have a history that looks like this:
>
>
>   G...1---2---3---4---6---8---B
>                    \
>                     5---7---B
>
> it follows that 4 must also be "bad".  It used to be good long time
> ago somewhere before 1, and somewhere along way on the history,
> there was a single breakage event that we are hunting for.  That
> single event cannot be 5, 6, 7 or 8 because breakage at say 5 would
> not explain why the tip of the upper branch is broken---its breakage
> has no way to propagate there.  The breakage must have happened at 4
> or before that commit.

Is it not worth at least confirming the assertion that 4 is bad before
proceding, or at least an option to confirm that in complex scenarios
where the fault may be devious.
[the explicit explanation has been useful for me...]

>
> Which means that if you marked the child of 8 (the tip of the upper
> branch) as bad, there is no reason for us to even look at the lower
> branch.  As soon as you mark the tip of the upper branch "bad", the
> bisection can become
>
>   G...1---2---3---4---6---8---B
>
> and without looking at the lower branch, it can find the single
> breakage.
>
>
> [Footnote]
>
> *1* You may be hunting for a single _fix_, and flipping the meaning
>    of "good" and "bad", say "It used to be broken but somewhere we
>    seem to have fixed that bug.  Where did we do that?", marking
>    the ones that still has the bug "good" and the ones that no
>    longer has the bug "bad".  In that context, you would be looking
>    for a single fix.  A more neutral term might be
>
>    - we look for a single event that changes some state.
>
>    - old state before that single event is spelled G O O D, but it
>      is pronounced "not yet".
>
>    - new state before that single event is spelled B A D, but it is
>      pronounced "already".
> --
> 
