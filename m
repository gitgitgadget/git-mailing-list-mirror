From: Chris Johnsen <chris_johnsen@pobox.com>
Subject: Re: [PATCH/RFD] builtin-revert.c: release index lock when
 cherry-picking an empty commit
Date: Sat, 7 Mar 2009 16:57:40 -0600
Message-ID: <EEE56CB5-BBC7-45F4-801B-062349E07730@pobox.com>
References: <1236418251-16947-1-git-send-email-chris_johnsen@pobox.com>
 <alpine.DEB.1.00.0903071212350.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Miklos Vajna <vmiklos@frugalware.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Mar 07 23:59:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lg5UC-0002bO-Pd
	for gcvg-git-2@gmane.org; Sat, 07 Mar 2009 23:59:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750783AbZCGW5J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Mar 2009 17:57:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751046AbZCGW5H
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Mar 2009 17:57:07 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:44575 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750872AbZCGW5G (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Mar 2009 17:57:06 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id DF11A9F8D1;
	Sat,  7 Mar 2009 17:57:01 -0500 (EST)
Received: from [192.168.1.241] (unknown [76.201.177.183]) (using TLSv1 with
 cipher AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id B87AC9F8D0; Sat,
  7 Mar 2009 17:56:57 -0500 (EST)
In-Reply-To: <alpine.DEB.1.00.0903071212350.10279@pacific.mpi-cbg.de>
X-Mailer: Apple Mail (2.753.1)
X-Pobox-Relay-ID: 453FB3A8-0B6B-11DE-A6C7-CFA5EBB1AA3C-07245699!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112594>

On 2009 Mar 7, Johannes Schindelin wrote:
> I wonder, though, if the real root of the problem is that there is
> copied code.

Agreed.

> IOW I think it would be better to introduce a global
> function that writes the index to a tree.

I am not quite sure I follow your meaning here.

We have write_cache_as_tree in cache-tree.c. Is something like that  
what you had in mind for "write the index to a tree"?

Could you elaborate on how an "index to tree" function could be  
applied to the problem of the inconsistent lock releasing around  
commit_locked_index calls? Sorry, for my lack of a clue, I am fairly  
new to the code base. Or are you seeing a different code duplication  
problem here?

The general form of the code around calls to commit_locked_index  
seems to be of the this form:

	if (some_condition) /* not all call sites use this */
		if (write_cache(...) || commit_locked_index(...))
			die(...); /* or return error(...) */
	rollback_lock_file(...); /* sometimes missing or distant */

In most cases some_condition is active_cache_changed, but not always  
(builtin-apply.c, rerere.c).

The problem with cherry-picking empty commits was that  
active_cache_changed (used as some_condition in the general pattern  
shown above) would be false, so the write and commit was skipped, but  
there was also never any rollback. Later, when cherry-pick exec-ed  
commit, the lock file still existed and commit dies.

To make sure a commit or a rollback always happens at every call  
site, each one would have to unconditionally call some global  
function (write_and_commit_or_rollback_locked_index?, ick) that  
conditionally did the write and commit, but unconditionally did the  
rollback (basically a no-op if the commit went OK).

> A quick "git grep commit_locked_index" reveals quite a few code  
> sites...

Indeed, would such a cleanup be worth the churn? I do not have any  
modifications for which this cleanup could be considered preparatory.

Thank you for your help!

-- 
Chris
