From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] rev-list: refuse --first-parent combined with --bisect
Date: Mon, 16 Mar 2015 11:53:08 -0700
Message-ID: <xmqqbnjsrcyz.fsf@gitster.dls.corp.google.com>
References: <1425827005-9602-1-git-send-email-me@ikke.info>
	<1425934575-19581-1-git-send-email-me@ikke.info>
	<xmqqa8zkzeq5.fsf@gitster.dls.corp.google.com>
	<20150310225509.GA5442@vps892.directvps.nl>
	<xmqqoao0xx9p.fsf@gitster.dls.corp.google.com>
	<20150311184512.GB5442@vps892.directvps.nl>
	<xmqqsidb5m2r.fsf@gitster.dls.corp.google.com>
	<20150316163306.GB11832@vps892.directvps.nl>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Kevin Daudt <me@ikke.info>
X-From: git-owner@vger.kernel.org Mon Mar 16 19:53:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YXa8b-0004NA-K3
	for gcvg-git-2@plane.gmane.org; Mon, 16 Mar 2015 19:53:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754318AbbCPSxM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Mar 2015 14:53:12 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:55233 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753045AbbCPSxL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Mar 2015 14:53:11 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B096540AD2;
	Mon, 16 Mar 2015 14:53:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tYxmpPfmLpV581ilF5E24jlK2Jc=; b=BUVpT/
	t7j+AF9zDbGX7yxYJ0TTdWiyML8wo2qCieinbtmfdjx2tBgX1jEmrP8+UchOqRT6
	9h9DlYdP8d6rTUQO7DaHeb1iZ1PE7SR/0PVF7R9EIWAZGmWPEspvlnxT3jz5iw4N
	VPnY8DoUG0Do4RYnDYP2MKAOnnf5yZS39iMqg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=d0NPm4E21SI907TqYw3+GOFGedko3Gl9
	ouJGh7fC1i3yNKIeIQJ0c8d115nEHzYO6/VqgxB6WuKNixmvnuEA1pY7IfpkOZcz
	8+5IOt7WbPFG9W0hFuoBY7a3L1m3fSsLN2mJpa73KSxhoqp0eYblkV9QIJR1K46r
	qXAYIOp6RAY=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 920D240AD0;
	Mon, 16 Mar 2015 14:53:10 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id F142840ACF;
	Mon, 16 Mar 2015 14:53:09 -0400 (EDT)
In-Reply-To: <20150316163306.GB11832@vps892.directvps.nl> (Kevin Daudt's
	message of "Mon, 16 Mar 2015 17:33:06 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B0C0E746-CC0D-11E4-BB18-A2259F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265586>

Kevin Daudt <me@ikke.info> writes:

> So this ref changes to the bad commit.
>
> For refs/bisect/good-*, I could only find an example snippet:
>
>> GOOD=$(git for-each-ref "--format=%(objectname)" refs/bisect/good-*)
>
> But it's not really clear what * might be expanded to, nor what they
> mean. I guess this could use some clarrification in the documentation.

Because the history is not linear in Git, bisection works by
shrinking a subgraph of the history DAG that contains "yet to be
tested, suspected to have introduced a badness" commits.  The
subgraph is defined as anything reachable from _the_ "bad" commit
(initially, the one you give to the command when you start) that are
not reachable from any of the "good" commits.

Suppose you started from this graph.  Time flows left to right as
usual.

  ---0---2---4---6---8---9
      \             /
       1---3---5---7

Then mark the initial good and bad commits as G and B.

  ---G---2---4---6---8---B
      \             /
       1---3---5---7

And imagine that you are asked to check 4, which turns out to be
good.  We do not _move_ G to 4; we mark 4 as good, while keeping
0 also as good.

  ---G---2---G---6---8---B
      \             /
       1---3---5---7

And if you are next asked to check 5, and mark it as good, the graph
will become like this:

  ---G---2---G---6---8---B
      \             /
       1---3---G---7

Of course, at this point, the subgraph of suspects are 6, 7, 8 and
9, and the subgraph no longer is affected by the fact that 0 is
good.  But it is crucial to keep 0 marked as good in the step before
this one, before you tested 5, as that is what allows us not having
to test any ancestors of 0 at all.

Now, one may wonder why we need multiple "good" commits but we do
not need multiple "bad" commits.  This comes from the nature of
"bisection", which is a tool to find a _single_ breakage [*1*], and
a fundamental assumption is that a breakage does not fix itself.

Hence, if you have a history that looks like this:


   G...1---2---3---4---6---8---B
                    \
                     5---7---B

it follows that 4 must also be "bad".  It used to be good long time
ago somewhere before 1, and somewhere along way on the history,
there was a single breakage event that we are hunting for.  That
single event cannot be 5, 6, 7 or 8 because breakage at say 5 would
not explain why the tip of the upper branch is broken---its breakage
has no way to propagate there.  The breakage must have happened at 4
or before that commit.

Which means that if you marked the child of 8 (the tip of the upper
branch) as bad, there is no reason for us to even look at the lower
branch.  As soon as you mark the tip of the upper branch "bad", the
bisection can become

   G...1---2---3---4---6---8---B

and without looking at the lower branch, it can find the single
breakage.


[Footnote]

*1* You may be hunting for a single _fix_, and flipping the meaning
    of "good" and "bad", say "It used to be broken but somewhere we
    seem to have fixed that bug.  Where did we do that?", marking
    the ones that still has the bug "good" and the ones that no
    longer has the bug "bad".  In that context, you would be looking
    for a single fix.  A more neutral term might be

    - we look for a single event that changes some state.

    - old state before that single event is spelled G O O D, but it
      is pronounced "not yet".

    - new state before that single event is spelled B A D, but it is
      pronounced "already".
