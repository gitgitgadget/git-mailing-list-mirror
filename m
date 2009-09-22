From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: Re: [PATCH] Re: Gitk --all error when there are more than 797 refs in a repository
Date: 22 Sep 2009 23:48:59 +0100
Message-ID: <87y6o6a944.fsf@users.sourceforge.net>
References: <6F87406399731F489FBACE5C5FFA04584BFA53@ex2k.bankofamerica.com>
	<878wgcbb52.fsf@users.sourceforge.net>
	<19124.8378.975976.347711@cargo.ozlabs.ibm.com>
	<6F87406399731F489FBACE5C5FFA0458518DE8@ex2k.bankofamerica.com>
	<4AB78910.7010402@viscovery.net>
	<6F87406399731F489FBACE5C5FFA0458518E11@ex2k.bankofamerica.com>
	<4AB7A2E7.5000601@viscovery.net>
	<874oqvc0n3.fsf@users.sourceforge.net>
	<7v1vlzvjtg.fsf@alter.siamese.dyndns.org>
	<7vws3ru4w8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	"Murphy\, John" <john.murphy@bankofamerica.com>,
	Paul Mackerras <paulus@samba.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 23 00:50:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MqEBk-0006GJ-5V
	for gcvg-git-2@lo.gmane.org; Wed, 23 Sep 2009 00:50:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751524AbZIVWtJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Sep 2009 18:49:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751281AbZIVWtJ
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Sep 2009 18:49:09 -0400
Received: from smtp-out4.blueyonder.co.uk ([195.188.213.7]:33865 "EHLO
	smtp-out4.blueyonder.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751102AbZIVWtI (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Sep 2009 18:49:08 -0400
Received: from [172.23.170.137] (helo=anti-virus01-08)
	by smtp-out4.blueyonder.co.uk with smtp (Exim 4.52)
	id 1MqEAR-0007Hh-1J; Tue, 22 Sep 2009 23:49:03 +0100
Received: from [92.238.221.8] (helo=badger.patthoyts.tk)
	by asmtp-out1.blueyonder.co.uk with esmtp (Exim 4.52)
	id 1MqEAQ-0008Nk-Bt; Tue, 22 Sep 2009 23:49:02 +0100
Received: by badger.patthoyts.tk (Postfix, from userid 1000)
	id 6511C51843; Tue, 22 Sep 2009 23:49:01 +0100 (BST)
X-Face: .`d#euqz@6H{";Ysmx2IVe_7M3vA+2w1X[QLk?ZO&QRauXQL{*L'$3getx}9+zK.-KWDx3.
 qrlR)76MFb`6bgoGvLpLtcQKB=X~;*<JKLtwLBM(IA'?rVjs1*tq\VHn?WMNsB,3XXWF@5.)4SRFa+
 '?a?.s#@hl7CiTo'F"O!fvbL0
X-Url: http://www.patthoyts.tk/
In-Reply-To: <7vws3ru4w8.fsf@alter.siamese.dyndns.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128960>

(nobody) writes:

>Junio C Hamano <gitster@pobox.com> writes:
>
>> Pat Thoyts <patthoyts@users.sourceforge.net> writes:
>>
>> That looks like an ugly hack (aka sweeping the issue under the rug).
>>
>> What if there are many tags and the user used --tags?  Don't you have
>> exactly the same problem?  Likewise, what if $revs were "..master"?
>
>Sorry, I meant "--all --not master" to grab all the topics not merged to
>master yet.
>
>But my point still stands.

Not exactly. The problem is that the call to parseviewrevs will expand
--all into a tcl list containing all the revision ids. We can do some
testing if we dig into this with the tcl console:
 % llength [set revs [parseviewrevs {} --all]]
 1001
 % string length $revs
 41040
In start_rev-list this list gets added to the command line for git-log
in the $args variable. This is always going to exceed windows'
commandline limit (32k).

Some testing shows that a number of rev-parse arguments do not get
expanded into a list of ids. All these can be ignored. But --all,
--tags and --branches do. Maybe --remotes as well.
These arguments are accetable to git-log so it looks to me like they
can be left as-is.

The vposids and vnegids arrays are getting used for something
though. So the patch is not complete. They appear to be caching the
set of revisions present in the current view for use in updatecommits
to do something.

So - needs more work.

-- 
Pat Thoyts                            http://www.patthoyts.tk/
PGP fingerprint 2C 6E 98 07 2C 59 C8 97  10 CE 11 E6 04 E0 B9 DD
