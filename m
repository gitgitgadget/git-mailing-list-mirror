From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] require_work_tree: Look for top-level instead of is-inside-work-tree
Date: Tue, 03 Aug 2010 09:57:35 +0200
Message-ID: <4C57CBEF.2070102@drmicha.warpmail.net>
References: <1280335624-90132-1-git-send-email-tor.arne.vestbo@nokia.com> <4C56D83F.3050507@drmicha.warpmail.net> <7v8w4onc0l.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: =?ISO-8859-1?Q?Tor_Arne_Vestb=F8?= <tor.arne.vestbo@nokia.com>,
	git@vger.kernel.org, trast@student.ethz.ch
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 03 09:57:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OgCNR-00021r-GV
	for gcvg-git-2@lo.gmane.org; Tue, 03 Aug 2010 09:57:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753953Ab0HCH50 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Aug 2010 03:57:26 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:48591 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752192Ab0HCH5Z (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Aug 2010 03:57:25 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 7CFA018BA97;
	Tue,  3 Aug 2010 03:57:24 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Tue, 03 Aug 2010 03:57:24 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=3MoD1pvgSlLmaFBaVt/JSvAVkVI=; b=IIBco8JJWGy+UWkCu0+YqlQutwI539nr3RtYjTsFRYYKAOB6ze0Ly+WmUuJA1aos01CE7pOqv+c658wdOJavaE6j5pN0qon1ewpz84Z7w1f5v3BlNZtQwkfjcNLv8jqCAHJzQgzezuqRCHm/8LlNwDzdH8GQdcAzRfaRZdyu6h8=
X-Sasl-enc: 565CD8NXDYpBO6qr7M6zI/lPiFRr4ZkNaXkzqxXC9v3Q 1280822244
Received: from localhost.localdomain (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 48C39738ED;
	Tue,  3 Aug 2010 03:57:23 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.8pre) Gecko/20100714 Lightning/1.0b2pre Lanikai/3.1.2pre
In-Reply-To: <7v8w4onc0l.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152490>

Junio C Hamano venit, vidit, dixit 02.08.2010 19:46:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> An alternative which does not change the established behavior of
>> require_work_tree would be changing the order of require_work_tree and
>> cd_to_top_level in the callers where possible along the lines of
>>
>> http://mid.gmane.org/96abf622ca2cf92998ce4ed393ccaa75d95dd9a8.1279112025.git.git@drmicha.warpmail.net
>>
>> which got lost somehow. (The other callers, as mentioned by Junio, would
>> need to be changed differently, e.g. by moving cd_to... earlier.)
> 
> Doesn't it sound stupid to "cd-to-toplevel" and then "require-work-tree"?

It sounds outright silly, agreed.
Though, unless you know the implementation, "cd_to_toplevel" may succeed
cd'ing to what "rev-parse --show-toplevel" returns without
require_work_tree being happy.

But don't we try to preserve existing behavior unless it's a bug? We
certainly have a mismatch of behavior and documentation here. The
question is whether we want to break anyone who relied on
"require_work_tree" dieing when cwd is not within the work-tree.

> 
> If you can go to the top-level, and once you successfully got there, you
> already _know_ that you have a work tree (and also you already know at
> that point you are in the work tree).  The reason why "require-work-tree"
> has been placed before "cd-to-toplevel" is exactly for that purpose, I
> think.  It is possible that some callers wanted to "require-work-tree" to
> mean "I want you to not just _have_ a work tree, but actually be _in_ it",
> but I somehow doubt it.  It is more like "I am going to ask you to go to
> the top, but let's make sure that you do have a top before doing so", I
> think.

Well, if people relied on current behavior...
I didn't, I don't mind changing this, in fact I'm usually in "changing
mood" and running into the "preserve behavior" wall ;)

In any case, I think "require_work_tree" should really test whether we
can cd into the worktree, i.e. whether a cd_to_toplevel would succeed,
and not just whether "rev-parse --show-toplevel" returns a non-empty string.

> 
> I on the other hand do not think it is wrong to lose the existing calls to
> require-work-tree if you know that you are going to call cd-to-toplevel
> before doing any git operation that needs to have a work-tree, though.
> 
>> Another problem I noticed back then (I was away since) was that a
>> relative GIT_WORK_TREE is left in place after a cd_to_top_level and
>> messes things up completely - it does not seem to be relative to
>> GIT_DIR. So, there seems to be more to fix in this area.
> 
> I agree; I don't think GIT_WORK_TREE was designed to be anything but an
> absolute path to begin with.  If a command chdir's around and exports the
> environment to its hooks and subcommands, it should be prepared to adjust
> it before doing so.

We do have some magic to re-export a relative GIT_DIR as absolute, and
the doc says GIT_WORK_TREE is relative to GIT_DIR. We even have a test
which succeeds by pure chance, as playing around with different layouts
shows. I'll try to come up at least with tests for this when I get to it.

Cheers,
Michael
