From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH 10/10] push: teach push to be quiet if local ref is strict subset of remote ref
Date: Wed, 31 Oct 2007 22:09:21 +0100
Message-ID: <B16F7DA1-E3E5-47A4-AFD3-6680741F38F1@zib.de>
References: <1193593581312-git-send-email-prohaska@zib.de> <11935935812741-git-send-email-prohaska@zib.de> <1193593581114-git-send-email-prohaska@zib.de> <1193593581486-git-send-email-prohaska@zib.de> <11935935812185-git-send-email-prohaska@zib.de> <11935935822846-git-send-email-prohaska@zib.de> <11935935821136-git-send-email-prohaska@zib.de> <11935935823045-git-send-email-prohaska@zib.de> <11935935821800-git-send-email-prohaska@zib.de> <11935935823496-git-send-email-prohaska@zib.de> <11935935821192-git-send-email-prohaska@zib.de> <7vfxztm2dx.fsf@gitster.siamese.dyndns.org> <52171BF7-50E2-473E-A0BD-CB64D38FD502@zib.de> <7vejfcl8aj.fsf@gitster.siamese.dyndns.org> <F5F68690-68A3-4AFC-A79C-FF02910F0359@zib.de> <7v8x5jiseh.fsf@gitster.siamese.dyndns.org> <B3C76DB8-076D-4C43-AC28-99119A05325C@z
 ib.de> <7vve8nglrt.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 31 22:09:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InKoS-0000wM-6J
	for gcvg-git-2@gmane.org; Wed, 31 Oct 2007 22:09:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754885AbXJaVJG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Oct 2007 17:09:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754925AbXJaVJF
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Oct 2007 17:09:05 -0400
Received: from mailer.zib.de ([130.73.108.11]:65085 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754054AbXJaVJE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Oct 2007 17:09:04 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l9VL8BoG023511;
	Wed, 31 Oct 2007 22:08:19 +0100 (CET)
Received: from [192.168.178.21] (brln-4db1be2b.pool.einsundeins.de [77.177.190.43])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l9VL7vhj022525
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Wed, 31 Oct 2007 22:07:57 +0100 (MET)
In-Reply-To: <7vve8nglrt.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62870>


On Oct 31, 2007, at 7:51 PM, Junio C Hamano wrote:

> Steffen Prohaska <prohaska@zib.de> writes:
>
>> On Oct 31, 2007, at 9:45 AM, Junio C Hamano wrote:
>>
>>> I would not doubt it would be safer for _your_ workflow, but you
>>> should consider the risk of making things more cumbersome for
>>> workflows of others by enforcing that policy.
>>
>> Together with the '--create' flag it would be safer in all
>> cases, because it would always do _less_ than what git push
>> currently does. The safest choice would be if "git push"
>> refused to do anything until configured appropriately.
>>
>> "safer" is independent of the workflow.
>
> By your definition, a command that does not do anything by
> default is safer regardless of the workflow.
>
> That may be theoretically true --- it cannot do any harm by
> default.  But that is not useful.

If different workflows have contradicting needs, doing nothing
by default might be a good choice. Not theoretically, but in
practice.


>> I'm mainly interested in using git against a shared repo,
>> and make it as simple and as safe as possible to use in
>> such a setup. I suspect that git is more optimized for the
>> workflow used for the Linux kernel and for developing git,
>> which heavily rely on sending patches to mailing lists and
>> pulling from read-only repos.
>>
>
> You forgot a lot more important part.  Pushing into publishing
> repositories.  And the discussion is about git-push command.

Exactly, here are two examples:

If you push only to publishing repositories that are read
only by others, you'll never encounter the problem that
10/10 tried to solve. The publishing repository is never
changed by others. You are the only one who pushes to this
repository. Therefore the remote never advances unexpectedly.

A shared repository behaves differently. Others push to the
repository as well. Hence, branches can advance unexpectedly.


Another difference is the way changes are integrated. In
a workflow without shared repositories, only pull is used
for integration, while push in only used for publishing the
changes. After a push you always need to request someone else
to pull. For example:

- Alice publishes branch foo.
- Bob clones Alice's repository and checks out foo as his
   local branch bar.
- Bob later publishes his branch by pushing bar to his
   public repository and asks Alice to pull.
- Alice pulls bar from Bobs public repository and merges
   with foo. She then publishes the integrated changes
   by pushing foo to her public repository.

My point is: there is no need to push from branch bar to
branch foo. Alice and Bob both push to branches that are named
identical in their private and their public repositories.
Only pull is used to merge changes from the branch named bar
to the branch named foo.

This is different if you work with a shared repository. Bob
checks out the shared branch foo to his local branch bar and
later he needs to push bar back to the shared branch foo. Bob
needs to push changes from his local branch bar to the branch
foo in the remote repository, a branch with a different name.
This need does not emerge when working with two publishing
repositories, as described above.


This was the extended version of what I meant above. The
workflow used for the Linux kernel and for developing git is
focused on pull. Push is normally only used for publishing
branches under identical name. The interesting stuff happens
during the pull.

	Steffen
