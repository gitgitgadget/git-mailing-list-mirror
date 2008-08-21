From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 1/2] Make xdi_diff_outf interface for running
 xdiff_outf diffs
Date: Wed, 20 Aug 2008 22:24:22 -0700
Message-ID: <7vzln7j5yx.fsf@gitster.siamese.dyndns.org>
References: <20080814053156.GE4396@lavos.net>
 <1218692211-26045-1-git-send-email-bdowning@lavos.net>
 <7v1w0sf7bl.fsf@gitster.siamese.dyndns.org>
 <20080821033756.GC31114@lavos.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: bdowning@lavos.net (Brian Downing)
X-From: git-owner@vger.kernel.org Thu Aug 21 07:25:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KW2fv-0001JF-8U
	for gcvg-git-2@gmane.org; Thu, 21 Aug 2008 07:25:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751817AbYHUFYa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Aug 2008 01:24:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751827AbYHUFYa
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Aug 2008 01:24:30 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:39759 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751526AbYHUFYa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Aug 2008 01:24:30 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 9C43A55670;
	Thu, 21 Aug 2008 01:24:27 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id E09CE5566F; Thu, 21 Aug 2008 01:24:24 -0400 (EDT)
In-Reply-To: <20080821033756.GC31114@lavos.net> (Brian Downing's message of
 "Wed, 20 Aug 2008 22:37:57 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 6C9519C8-6F41-11DD-9F1F-B29498D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93112>

bdowning@lavos.net (Brian Downing) writes:

> On Wed, Aug 13, 2008 at 11:18:22PM -0700, Junio C Hamano wrote:
>> Much nicer.  xdi_diff() is just a performance thing that only kicks in
>> when you are running -U0 diff, so it is unsurprising that you did not see
>> any test failures.
>
> Interesting point here.  In playing with trying to cache the diff hashes
> to speed up blame, I had to basically disable the xdi_diff tail trimming
> when building the hash the first time, because it needed to see the
> whole file.  In doing this, I discovered that just changing from
> xdi_diff to xdl_diff /does/ change the blame -M -C -C --incremental
> result for my test case.  (Unfortunately, my test case is proprietary
> code...)

Is the reason why you mention "incremental" specifically because you only
tested incremental, or you get identical result in non-incremental mode?

If your material is repetitive, say you have lines "A A A B C A A A" in
the parent blob and "A A A B A A A" in the child blob, and you are trying
to pass blame on three line block "A A A" at the beginning of the child,
we can pass blame to the three lines at the beginning part, or to the end
part, without Linus's common tail trimming optimization.  But there is no
way it can match the end part with the optimization.

You cannot say one result is more correct than the other --- both are
equally correct.  Of course, you could argue that with such a highly
repetitive material, it may be better to match closer ones, but it's a
judgement call.
