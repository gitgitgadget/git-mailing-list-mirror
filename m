From: Junio C Hamano <gitster@pobox.com>
Subject: Re: C internals cleanup
Date: Sun, 12 Apr 2009 21:06:44 -0700
Message-ID: <7v4owtw623.fsf@gitster.siamese.dyndns.org>
References: <22578EEA-DB8B-4DAF-B217-FF13DC8A3EC7@petdance.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andy Lester <andy@petdance.com>
X-From: git-owner@vger.kernel.org Mon Apr 13 06:08:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LtDTE-0007W8-2w
	for gcvg-git-2@gmane.org; Mon, 13 Apr 2009 06:08:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752158AbZDMEGv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Apr 2009 00:06:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751149AbZDMEGv
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Apr 2009 00:06:51 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:39552 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751098AbZDMEGu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Apr 2009 00:06:50 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 6B325E787;
	Mon, 13 Apr 2009 00:06:49 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id BAB93E786; Mon,
 13 Apr 2009 00:06:46 -0400 (EDT)
In-Reply-To: <22578EEA-DB8B-4DAF-B217-FF13DC8A3EC7@petdance.com> (Andy
 Lester's message of "Sun, 12 Apr 2009 22:15:05 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 8327B92C-27E0-11DE-B6ED-DC76898A30C1-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116411>

Andy Lester <andy@petdance.com> writes:

> I've been poking around in the source for git, and wanted to pitch in
> and clean some things up.
>
> Two biggies that tend to get overlooked: Applying the const keyword
> where possible, and localizing variables to innermost blocks.
>
> Also, want to to get a target going in the Makefile for running under
> splint.
>
> Just want to make sure my internal cleanups are not going to be seen
> as a nuisance.

I and my lieutenants are most likely polite enough to avoid using a word
like nuisance, but I think you will hear words like code churn, especially
if such a change affects too many places and conflicts with too many
patches that are still in the queue to be merged.  IOW, you need to be
careful.

The general rule of thumb is to do such a clean-up before you start to
work on something of substance.

Your series may look like this:

 * [Patch 1/2] hello.c: tighten constness and scope

   Many functions in this file do not have to be called from other files,
   and goodmorning() takes "char *" parameters but does not modify them in
   any way (others like goodafternoon() and goodevening() are already
   correct in this regard, both taking "const char *" parameters).

   Make all of tese functions file scope static, and tighten constness to
   the parameters to gootmorning().  By making their function signatures
   compatible, this change will help the next patch that refactors the
   three greeting functions.

 * [Patch 2/2] hello.c: refactor goodmorning(), goodafternoon() and goodnight()

   These functions do mostly the same thing; implement a common helper
   function greeting() and share code among them.

Otherwise, unless the tree is really quiet, a patch that is only clean-up
and nothing else will have a high maintenance-cost vs reward ratio, and
needs to be split and timed carefully.  A patch that applies cleanly to
master and then the result merges cleanly to both next and pu would be Ok
even if you do not add any value other than code cleanliness.
