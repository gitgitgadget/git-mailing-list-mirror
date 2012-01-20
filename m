From: andreas.koenig.7os6VVqR@franz.ak.mind.de (Andreas J. Koenig)
Subject: Re: [BUG] Git bisect not finding the right commit
Date: Fri, 20 Jan 2012 08:56:50 +0100
Message-ID: <87ehuu958d.fsf@franz.ak.mind.de>
References: <87r4yw8j4i.fsf@franz.ak.mind.de>
	<7vlip4je87.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 20 08:57:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ro9Lb-0004OF-22
	for gcvg-git-2@lo.gmane.org; Fri, 20 Jan 2012 08:57:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752333Ab2ATH5L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jan 2012 02:57:11 -0500
Received: from rz1.akoenig.de ([83.223.90.65]:58834 "EHLO rz1.akoenig.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751953Ab2ATH45 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jan 2012 02:56:57 -0500
Received: from franz.ak.mind.de (p4FC97530.dip.t-dialin.net [79.201.117.48])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "franz.ak.mind.de", Issuer "franz.ak.mind.de" (not verified))
	by rz1.akoenig.de (Postfix) with ESMTPS id 9F1BF20034;
	Fri, 20 Jan 2012 08:37:19 +0100 (CET)
Received: from k75.linux.bogus (localhost.localdomain [127.0.0.1])
	by k75.linux.bogus (8.14.3/8.14.3/Debian-9.4) with ESMTP id q0K7upDM018394
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 20 Jan 2012 08:56:51 +0100
Received: (from k@localhost)
	by k75.linux.bogus (8.14.3/8.14.3/Submit) id q0K7uoQX018393;
	Fri, 20 Jan 2012 08:56:50 +0100
X-Authentication-Warning: k75.linux.bogus: k set sender to andreas.koenig.7os6VVqR@franz.ak.mind.de using -f
In-Reply-To: <7vlip4je87.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Thu, 19 Jan 2012 00:20:08 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188869>

>>>>> On Thu, 19 Jan 2012 00:20:08 -0800, Junio C Hamano <gitster@pobox.com> said:

 jch> andreas.koenig.7os6VVqR@franz.ak.mind.de (Andreas J. Koenig) writes:
 >> A v5.15.5
 >> B v5.15.5-20-gfd76d40
 >> C v5.15.5-81-gcfe287a
 >> D v5.15.5-159-ga71d67b
 >> E v5.15.4-110-g27b29ec
 >> F v5.15.4-169-g3582575
 >> 
 >> The change in perl I tried to locate was v5.15.5-13-gff0cf12, between A
 >> and B. Bisect did not find it, it returned me E instead. Here the wrong
 >> bisect output:

 jch> Just for the sake of simplicity, I'll call ff0cf12 "Q" (the Questionable
 jch> one).

 >> % git bisect start v5.15.5-159-ga71d67b v5.15.5

 jch> You start by telling Git that D is bad and A is good.

 jch> I can see that D does contain Q (i.e. "git log D..Q" gives nothing), which
 jch> you should read as "D is _contaminated_ by the breakage Q introduced", so
 jch> D is indeed bad.

 jch> On the other hand, A does _not_ contain Q (i.e. "git log A..Q" gives
 jch> output), which you should read as "A is _not_ contaminated by the breakage
 jch> Q introduced", so A is indeed good.

 jch> So far so good...

 >> Already on 'blead'
 >> Bisecting: 77 revisions left to test after this (roughly 6 steps)
 >> [cfe287a06b2ed98c25aebb477f6b400409f1fc85] Merge remote-tracking branch 'p5p/smoke-me/gsoc-pod' into blead
 >> % git describe
 >> v5.15.5-81-gcfe287a

 jch> This is your "C", and "git log C..Q" does not give anything. C is
 jch> contaminated by Q, hence it is bad.

 >> % git bisect bad
 >> Bisecting: 40 revisions left to test after this (roughly 5 steps)
 >> [baf7658bacfa659cdab08050470b20ebd5973384] Update htmlview.t for new Pod::Html
 >> % git describe
 >> v5.15.4-149-gbaf7658

 jch> Here, baf7658 does not contain Q, so you are supposed to answer it is
 jch> GOOD.

 >> % git bisect bad

 jch> But you answered that it is BAD.

 jch> Why?

The reason turned out to be that a perl module that was involved in the
testing had been upgraded in the meantime (YAML-0.77 to 0.78). So your
whole answer was correctly describing the situation. From this point
GiGo started to happen because the rest of the tests involved also used
the newer version of that module while some other tests were done with
the older version.

So thank you for clearing that up!

 jch> [...]

>>>>> On Thu, 19 Jan 2012 09:23:01 +0100, Johannes Sixt <j.sixt@viscovery.net> said:

 js> Am 1/19/2012 4:29, schrieb Andreas J. Koenig:
 >> - A -> B      ->     C - D ->
 >>          \         /
 >>           - E - F -
 >> 
 >> A v5.15.5
 >> B v5.15.5-20-gfd76d40
 >> C v5.15.5-81-gcfe287a
 >> D v5.15.5-159-ga71d67b
 >> E v5.15.4-110-g27b29ec
 >> F v5.15.4-169-g3582575

 js> I haven't looked at the actual history, but given the names of the commits
 js> as produced by git-describe, I doubt that your history graph sketched
 js> above is correct. Doesn't it look more like this:

 js>       A -- B -- C -- D --
 js>      /         /
 js>  -- X -- E -- F

 js> where X is v5.15.4?

Yes, thank you for finding that out. X is actually v5.15.4-109-g3ea0c58
and since there was a long timespan between the start of the development
of the code and the merge (May-Nov), the gitk presentation got a bit
complex to read.

 js> To find a commit between A and B, you must declare F as "good".

Correct! The reason it happened described above.

Thank you folks for taking the time and making such a careful assessment!
-- 
andreas
