From: Junio C Hamano <gitster@pobox.com>
Subject: Re: branch description
Date: Sat, 19 Apr 2008 10:43:14 -0700
Message-ID: <7v1w51g2q5.fsf@gitster.siamese.dyndns.org>
References: <9b3e2dc20804150951scf8b3c7x26f3a56eab1f9840@mail.gmail.com>
 <200804161029.18601.johan@herland.net> <200804182358.31041.jnareb@gmail.com>
 <200804191118.50105.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	Matt Graham <mdg149@gmail.com>,
	Brian Gernhardt <benji@silverinsanity.com>,
	Russ Dill <russ.dill@gmail.com>,
	Stephen Sinclair <radarsat1@gmail.com>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Sat Apr 19 20:32:07 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JnH72-0007kx-Ta
	for gcvg-git-2@gmane.org; Sat, 19 Apr 2008 19:44:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755495AbYDSRnu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Apr 2008 13:43:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755436AbYDSRnu
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Apr 2008 13:43:50 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:47676 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755343AbYDSRns (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Apr 2008 13:43:48 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 218FD250B;
	Sat, 19 Apr 2008 13:43:45 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 5B857250A; Sat, 19 Apr 2008 13:43:35 -0400 (EDT)
In-Reply-To: <200804191118.50105.johan@herland.net> (Johan Herland's message
 of "Sat, 19 Apr 2008 11:18:49 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79912>

Johan Herland <johan@herland.net> writes:

> The problem with (3) vs. (4) is that in (3) we must make sure that whenever
> a branch is moved/renamed (e.g. "git clone", "git branch -m", probably more
> as well), the corresponding description is moved/renamed as well. This is
> elegantly solved in (4).

If your "elegently solved" is coming from an assumption that it is enough
for "git mv" (for example) to just copy whatever is in .git/refs/heads/foo
to .git/refs/heads/bar without understanding what is contained in it, that
assumption unfortunately does not hold.

You must support packed refs, so you need to teach the refs infrastructure
what per-branch attributes there are other than the commit object name it
points at anyway.

And we already do -- when you do "branch -m foo bar", corresponding config
entries are also renamed.  We also move reflogs.

A possible approach that would work, which contains elements from (4), is
to change implementations of loose ref to have this extra info in loose
ref files (that is what (4) is), *and* introduce another separate
mechanism to store corresponding information for packed refs elsewhere.
Propagation needs to deal with both representations, renaming needs to
deal with both representations, looking up needs to deal with both
representations, everybody needs to deal with both representations.

If you are going to invent "another separate mechanism" to support packed
refs anyway, why not use that same mechanism to record information for
loose ones as well?  That is the approach suggested by (3).  In either way
we need to teach relevant parts of the code for propagation, renaming,
looking up etc about the new mechanism.
