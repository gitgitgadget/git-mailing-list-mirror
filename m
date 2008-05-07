From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Make rebase save ORIG_HEAD if using current branch
Date: Wed, 07 May 2008 07:30:21 -0700
Message-ID: <7vbq3ifapu.fsf@gitster.siamese.dyndns.org>
References: <20080506051920.GA9165@Hermes.local>
 <481FFB62.9090804@viscovery.net>
 <54536F65-3A06-482E-9806-2E4F643C1024@silverinsanity.com>
 <482164F6.4010205@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brian Gernhardt <benji@silverinsanity.com>,
	Git List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed May 07 16:32:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JtkgB-0001uE-2K
	for gcvg-git-2@gmane.org; Wed, 07 May 2008 16:31:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756168AbYEGOal (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2008 10:30:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755709AbYEGOal
	(ORCPT <rfc822;git-outgoing>); Wed, 7 May 2008 10:30:41 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:56462 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753131AbYEGOaj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2008 10:30:39 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 39318494B;
	Wed,  7 May 2008 10:30:37 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 43F944949; Wed,  7 May 2008 10:30:31 -0400 (EDT)
In-Reply-To: <482164F6.4010205@viscovery.net> (Johannes Sixt's message of
 "Wed, 07 May 2008 10:14:46 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 28FF3FE2-1C42-11DD-BA30-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81440>

Johannes Sixt <j.sixt@viscovery.net> writes:

>>> 3. Should ORIG_HEAD better be set at the end of the rebase, not at the
>>> beginning? Because if the rebase stops for some reason, and then you do a
>>> 'git reset', you'll have overwritten the ORIG_HEAD that you have set
>>> here.

Very true.  If the purpose of this is to view "diff/log ORIG_HEAD.." after
"pull --rebase", setting it there does not make much sense.  In any case,
"diff/log branch@{1}..." will give you the same information unless you are
rebasing an already detached HEAD, so letting ORIG_HEAD get overwritten
like this patch does is not the end of the world, but then the original
issue of the lack of ORIG_HEAD is not much of an issue either with that
logic.

What the patch implements would be an ORIG_HEAD that only sometimes works
(iow, does not work if you did reset during rebasing session), which is
not what people can rely on.  Teaching people a more reliable way of using
reflog, which incidentally is also a consistent way between "pull" and
"pull --rebase", might be better than that.  I would agree that the ideal
thing is an ORIG_HEAD that always works, because it gives us the
consistency between the normal "pull" and "pull --rebase", though.

>> ...  Also, might you want to access the original HEAD during a
>> rebase conflict?  (Although that would argue that ORIG_HEAD should be
>> set for all rebases, to $upstream.)

I often find it useful to say "show-branch HEAD topic" while rebasing the
topic (gitk HEAD...topic would work equally well), taking advantage of the
fact that the topic stays at the original position until rebase completes.
You do not need ORIG_HEAD pointing at anywhere to help that history
inspection.

I do not think setting ORIG_HEAD to $upstream (actually, it should be
"onto") makes much sense.  After a normal "pull", what you can inspect
with "diff/log ORIG_HEAD" is the newly acquired history.  If we were to
allow ORIG_HEAD to be used after a "pull --rebase" in a similar way, if
you make it point at "the onto" commit, "diff/log ORIG_HEAD" would show
the changes _you_ had before you did rebase that you carried forward, not
the new history you acquired with the "pull --rebase" operation.
