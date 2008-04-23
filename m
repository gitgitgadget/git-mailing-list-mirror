From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] Moving "git remote add --mirror blah" functionality to
 "git clone --bare --origin=blah"
Date: Wed, 23 Apr 2008 09:07:28 -0700
Message-ID: <7vhcdstv0f.fsf@gitster.siamese.dyndns.org>
References: <480EF334.1090907@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Wed Apr 23 18:08:46 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JohWN-0001bh-W3
	for gcvg-git-2@gmane.org; Wed, 23 Apr 2008 18:08:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752939AbYDWQHn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2008 12:07:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753120AbYDWQHn
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Apr 2008 12:07:43 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:33260 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752815AbYDWQHm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2008 12:07:42 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id A0B7D35E6;
	Wed, 23 Apr 2008 12:07:39 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id BCE0F35E2; Wed, 23 Apr 2008 12:07:35 -0400 (EDT)
In-Reply-To: <480EF334.1090907@gnu.org> (Paolo Bonzini's message of "Wed, 23
 Apr 2008 10:28:36 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80226>

Paolo Bonzini <bonzini@gnu.org> writes:

> In the thread "git remote update -> rejected" Junio and Johannes came
> to the conclusion that "--mirror means that you do not have local
> branches", because "you give control away to the other end on the ref
> namespace".  Furthermore, it was agreed that --mirror currently makes
> sense mostly (or only?) on a bare repository.
>
> From here I gather that if you have "git remote add --mirror", most
> likely the mirrored repository will be the only remote you have.
> There is in general no point in having other remotes in a bare
> repository. And so there is no loss of generality if this remote is
> the "origin" remote.
>
> Hence, my proposal is:
>
> 1) Add an option to "git clone", to be used with --bare, to create a
> mirror.  --bare already leaves the original refs in place, without
> moving them under refs/remotes/origin, so it makes sense to optionally
> create the remote.

I actually had a slightly different vision.  A mid-term goal should be to
reimplement "clone" that has a lot of code duplication with "fetch" and
"remote" in terms of "init + remote + fetch + checkout" [*1*].  For that
to happen, I suspect that "remote" needs to learn a few more tricks than
it currently knows (e.g. "figuring out the HEAD").

I would agree that it is useful for "clone" to create a bare repository in
a mode that can be used for further cloning by other repositories (perhaps
the former sits at the firewall boundary that it is cumbersome to cross by
the latter).  As you described above, we already have that (iow, "--bare").

And "remote add --mirror" would be an implementation detail to produce
such a clone.  It is mostly about fetching.

An option to add a back-up repository that you can maintain an exact
mirror of your working repository would be useful, but that is different
from what "remote add --mirror" is about.

[Footnote]

*1* In that sense, a more sensible order than rewriting "clone" in C in
its current form would be to make necessary enhancements to the components
in this sequence that need to implement clone, figure out how they should
fit together and first make "clone" a four-liner shell script. Then
rewriting the result in C may become more trivial.
