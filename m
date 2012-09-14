From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] rev-list/log: document logic with several limiting options
Date: Fri, 14 Sep 2012 09:46:32 +0200
Message-ID: <5052E0D8.3040500@drmicha.warpmail.net>
References: <b23f3c547358b79731c7a25d9ac496138e6ab74d.1347374615.git.git@drmicha.warpmail.net> <7vsjaoil6d.fsf@alter.siamese.dyndns.org> <50509171.9060604@drmicha.warpmail.net> <7vbohbdufz.fsf@alter.siamese.dyndns.org> <50518B13.5010702@drmicha.warpmail.net> <7vvcfh62l3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 14 09:46:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TCQbq-0002iT-T3
	for gcvg-git-2@plane.gmane.org; Fri, 14 Sep 2012 09:46:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756248Ab2INHqf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Sep 2012 03:46:35 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:55422 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753245Ab2INHqe (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Sep 2012 03:46:34 -0400
Received: from compute4.internal (compute4.nyi.mail.srv.osa [10.202.2.44])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 7439E203EF;
	Fri, 14 Sep 2012 03:46:33 -0400 (EDT)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute4.internal (MEProxy); Fri, 14 Sep 2012 03:46:33 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=1dcyWThkJ0yR4vf5VVkG/T
	mAYng=; b=hLb2VN+USctBOnnaRnrILgMudZyfOIVBsMSk2ypH3f90N0h+nHBpRl
	zKnV70vIPx++7s4bRxZCh1zGBPIPdlYHc/Gde283gx2GcBMkHXmqO6Csj9gw19XU
	nsPN6RUra4YX4roqkOIGSmu1nbyx42JjavvP+RbFyzFbp/sBFTr9U=
X-Sasl-enc: /QaZlkI/k2XHxunoIUklS7VPojlR21Wmxo6aQB2BwxSm 1347608793
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id F19458E03D0;
	Fri, 14 Sep 2012 03:46:32 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:15.0) Gecko/20120827 Thunderbird/15.0
In-Reply-To: <7vvcfh62l3.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205461>

Junio C Hamano venit, vidit, dixit 13.09.2012 23:21:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> Thanks for "this" ;)
> 
> Here is a replacement to "this", that adds the "--debug" option to
> "git grep" and an equivalent "--debug-grep" to "git log" family.
> 
> -- >8 --
> Subject: [PATCH] grep: teach --debug option to dump the parse tree
> 
> Our "grep" allows complex boolean expressions to be formed to match
> each individual line with operators like --and, '(', ')' and --not.
> Introduce the "--debug" option to show the parse tree to help people
> who want to debug and enhance it.
> 
> Also "log" learns "--debug-grep" option to do the same.  The command
> line parser to the log family is a lot more limited than the general
> "git grep" parser, but it has special handling for header matching
> (e.g. "--author"), and a parse tree is valuable when working on it.
> 
> Note that "--all-match" is *not* any individual node in the parse
> tree.  It is an instruction to the evaluator to check all the nodes
> in the top-level backbone have matched and reject a document as
> non-matching otherwise.

I haven't read all your responses yet, but the/my main confusion comes
from all-match. My understanding is:

--all-match == turn all top-level ORs into ANDs

(unless it's all --author at the top-level; and I'm referring to user
supplied ORs, not those added by the implementation)

Seing (OR foo true) being evaluated to false when foo is false and
all-match is in effect is terribly confusing, me thinks (debug output).

In fact, I think the behavior described above (if it's correct) is a
product of the evolution of grep.c and the current implementation
(turning former unions into intersections in some cases, inserting that
TRUE node), but not necessarily the intended or preferrable outcome in
all corner cases.

We AND different types of limit options in any case (this used to be
affected by --all-match[?]), and we OR --author options in any case. So
having --all-match turn "--grep=foo --grep=bar" from OR into AND would
make the most sense at least to me (and I mean: independent of the
presence of an --author option).

Michael
