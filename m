From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-rerere observations and feature suggestions
Date: Mon, 16 Jun 2008 13:50:13 -0700
Message-ID: <7vskvd9kai.fsf@gitster.siamese.dyndns.org>
References: <20080616110113.GA22945@elte.hu>
 <7vej6xb4lr.fsf@gitster.siamese.dyndns.org> <20080616190911.GA7047@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
X-From: git-owner@vger.kernel.org Mon Jun 16 22:51:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8Lfb-0001ji-Mk
	for gcvg-git-2@gmane.org; Mon, 16 Jun 2008 22:51:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752948AbYFPUuZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2008 16:50:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753355AbYFPUuZ
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jun 2008 16:50:25 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:58532 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752948AbYFPUuY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2008 16:50:24 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id CC310D083;
	Mon, 16 Jun 2008 16:50:22 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id BF17DD082; Mon, 16 Jun 2008 16:50:17 -0400 (EDT)
In-Reply-To: <20080616190911.GA7047@elte.hu> (Ingo Molnar's message of "Mon,
 16 Jun 2008 21:09:11 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: D6CC36A8-3BE5-11DD-BFAF-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85231>

Ingo Molnar <mingo@elte.hu> writes:

> * Junio C Hamano <gitster@pobox.com> wrote:
>
>> >  - Automation: would be nice to have a git-rerere modus operandi where
>> >    it would auto-commit things if and only if all conflicting files were 
>> >    resolved.
>> 
>> I am not sure how safe this is.  rerere as originally designed does 
>> not even update the index with merge results so that the application 
>> of earlier resolution can be manually inspected, and this is exactly 
>> because I consider a blind textual reapplication of previous 
>> resolution always iffy, even though I invented the whole mechanism.
> ...
> So i'd not mind if git-rerere was safe by default, but it would be nice 
> to have some knob to turn it into something fast and automatic. For us 
> it would be much _safer_, because right now most of our manual energy is 
> spent on checking something that could be automated.

Oh, "unsafe switch" that is off by default will not hurt anybody, and I do
not mind it as a new feature.  We are in agreement in that sense.

Perhaps the way forward would be (and this is independent of the issue of
recording removal as a possible form of resolution):

 (1) Introduce a new configuration rerere.autoupdate that is off by
     default, but when it is on, paths cleanly resolved by rerere will
     also be updated in the index (if we have capability to record
     removal, this may remove such a path from the index as the result).

 (2) The callers of rerere that expects rerere to resolve needs to be
     changed to see if the resulting index after rerere is fully merged,
     and continue.  Currently the callers are "merge", "rebase" and "am",
     I think.  This step might be a bit more involved than you might
     think, as rerere currently happens in the codepath that knows the
     caller does _not_ go further than leaving the failed conflict to be
     sorted out by the user (rerere is designed as merely a way to help).

     Also you _might_ want a separate configuration rerere.autocommit to
     control this --- the user (but not you) might be willing to allow
     autoupdate but you may still want to eyeball the result.

Independent of the above, we have two potential new features:

 * Introduce "git rerere revert paths..."  that brings the index and
   working tree back to the conflicted state after a previous resolution
   is applied, because that resolution is incorrect.  The old resolution
   cached in rr-cache is also removed.

   This however will become much less useful if you allow autoresolution
   to be committed automatically, as the caller will move ahead without
   giving you a chance to say "oh, that one is bad -- do not proceed".

 * Somehow record the fact that the resolution for a particular conflict
   signature is to remove the resulting path.
