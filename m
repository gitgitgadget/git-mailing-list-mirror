From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] rev-list/log: document logic with several limiting options
Date: Thu, 13 Sep 2012 09:28:19 +0200
Message-ID: <50518B13.5010702@drmicha.warpmail.net>
References: <b23f3c547358b79731c7a25d9ac496138e6ab74d.1347374615.git.git@drmicha.warpmail.net> <7vsjaoil6d.fsf@alter.siamese.dyndns.org> <50509171.9060604@drmicha.warpmail.net> <7vbohbdufz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 13 09:28:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TC3r5-0000xY-Gb
	for gcvg-git-2@plane.gmane.org; Thu, 13 Sep 2012 09:28:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756435Ab2IMH2m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Sep 2012 03:28:42 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:44398 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756519Ab2IMH2V (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Sep 2012 03:28:21 -0400
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 3BC2C20981;
	Thu, 13 Sep 2012 03:28:21 -0400 (EDT)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute5.internal (MEProxy); Thu, 13 Sep 2012 03:28:21 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=/QuiKlmMvoGuQ5K7ZRXwbt
	4doWo=; b=KTuYkzxvHTwdf3Ybr9hraD0CDWtYT+zq1ZUzLklkSpv1m6vygJztT1
	x0uWnNvbZkYfw2EtIHg1ddYK1zjm8HBy9LR8GyESU+Rx0ONCgZNodJegAC+RtMhV
	WOmf+T85sNS9VrYmEtLzntq6mVzxLWQzP9bHrAOKfCclwd+BjdPVY=
X-Sasl-enc: 9muSJW5aFegDJBdsnaNXi0pZMj1SkJrl+SIHZd8+7Hr4 1347521300
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id B3BAA8E01C8;
	Thu, 13 Sep 2012 03:28:20 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:15.0) Gecko/20120827 Thunderbird/15.0
In-Reply-To: <7vbohbdufz.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205360>

Junio C Hamano venit, vidit, dixit 12.09.2012 19:25:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> It was introduced in 0ab7befa with a clear meaning (AND everything),
>> then the general logic (without --all-match) was modified in 80235ba7
>> (to take headermatch AND (all greps ORed)), and 5aaeb733 finally made
>> multiple authors resp. committers get ORed among each other. All of this
>> in an attempt to make the standard usage most useful, of course. As a
>> consequence, --all-match does not influence multiple --author options at
>> all (contrary to the doc), e.g.
>>
>> I don't see any of this reflected in the doc, though. I noticed only by
>> reading t/t7810-grep.sh. Before that, I had only gone by my own testing
>> which didn't reveal the multiple author multiple special casing effect.
>>
>> I guess I'll have to wrap my head around the current implementation a
>> few more times before trying to describe the status quo in the
>> documentation...
> 
> This is what I used to use when adding these generalized grep
> boolean expressions.
> 
> With this applied, you can try things like these:
> 
>     $ git log --grep=regexp --grep=nosuch --all-match >/dev/null
>     $ git log --grep=regexp --grep=nosuch --author=Michael >/dev/null
> 
> For example, "--all-match --grep=regexp --author=Michael --author=Linus" turns
> into
> 
>     [all-match]
>     (or
>      pattern_body<body>regexp
>      (or
>       (or
>        pattern_head<head 0>Linus
>        pattern_head<head 0>Michael
>       )
>       true
>      )
>     )
> 
> that says "body must have 'regexp' in it, and authored by either
> Linus or Michael".
> 
> The semantics of "--all-match" is different from "--and" (which,
> together with "--or", ")", and "(", is not availble to rev-list
> command line parser primarily because "--not" is not available).
> After applying all the "or"-ed terms, it checks the top-level nodes
> that are "or"-ed and makes sure all of them fired (possibly and
> usually on different lines).

Thanks for "this" ;)

I'll recheck my understanding and update the doc then. Maybe even
putting the above in-tree with a "--debug" option seems inline with
things such as "git describe --debug" (and maybe a preparation for
exposing a richer interface).

Michael
