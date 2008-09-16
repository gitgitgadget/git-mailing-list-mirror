From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [IRC/patches] Failed octopus merge does not clean up
Date: Mon, 15 Sep 2008 17:20:44 -0700
Message-ID: <7vhc8h7xgj.fsf@gitster.siamese.dyndns.org>
References: <200809160048.31443.trast@student.ethz.ch>
 <7v63ox9e20.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Miklos Vajna <vmiklos@frugalware.org>,
	Jakub Narebski <jnareb@gmail.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Sep 16 02:22:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KfOKf-0005PP-K9
	for gcvg-git-2@gmane.org; Tue, 16 Sep 2008 02:22:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753998AbYIPAUz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Sep 2008 20:20:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754188AbYIPAUz
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Sep 2008 20:20:55 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:50042 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753653AbYIPAUy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Sep 2008 20:20:54 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 2B06361AE4;
	Mon, 15 Sep 2008 20:20:53 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id BA29961AE0; Mon, 15 Sep 2008 20:20:46 -0400 (EDT)
In-Reply-To: <7v63ox9e20.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 15 Sep 2008 16:36:55 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 52A849E2-8385-11DD-B0BC-D0CFFE4BC1C1-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95965>

Junio C Hamano <gitster@pobox.com> writes:

> Thomas Rast <trast@student.ethz.ch> writes:
>
>> The merge says
>>
>>   Trying simple merge with 5b3e4bb1c2d88d6967fb575729fbfc86df5eaec9
>>   Simple merge did not work, trying automatic merge.
>>   Auto-merging foo
>>   ERROR: Merge conflict in foo
>>   fatal: merge program failed
>>   Automated merge did not work.
>>   Should not be doing an Octopus.
>>   Merge with strategy octopus failed.
> ...
> Read the second from the last line of what you were told by git.  Run "git
> reset --hard" after that, perhaps.

By the way, there are three failure modes in Octopus.

 (0) your index (not work tree) is dirty; this is not limited to octopus
     merge but any merge will be refused;

 (1) while it merges other heads one-by-one, it gets conflicts on an
     earlier one, before it even attempts to merge all of them.  Recording
     the heads that it so far attempted to merge in MERGE_HEAD is wrong
     (the result won't be an Octopus the end user wanted to carete), and
     recording all the heads the user gave in MERGE_HEAD is even more
     wrong (it hasn't even looked at the later heads yet, so there is no
     way for the index or work tree to contain anything from them).

     The above is hitting this case.

 (2) it gets conflicts while merging the _last_ head.  It records
     MERGE_HEAD and allows you to record the resolved result.

I think originally we treated (1) and (2) the same way, because an Octopus
is to record the most trivial merge with more than 2 legs, and a rough
definition of "the most trivial" is "tracks of totally independent works;
you could merge them one by one and _in any order_, and the result won't
matter because they are logically independent.  However if they are _so_
independent, why not record them as merged in one step (i.e. octopus),
instead of insisting on recording in what order you merged them".

Obviously, if you get a conflict during Octopus creation, they were not
tracks of totally independent works, and that is where the "Should not" in
the message comes from.

We later relaxed it to allow a conflict at the last step, not because
recording an Octopus with nontrivial merge is particuarly a good idea we
should encourage, but because there simply weren't reason not to.
