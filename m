From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Deleting the "current" branch in remote bare repositories
Date: Sun, 08 Feb 2009 11:05:40 -0800
Message-ID: <7v8wogzr3v.fsf@gitster.siamese.dyndns.org>
References: <20090207162754.5fb8b63f@perceptron>
 <94a0d4530902071405m33a0804er8030e14bea205898@mail.gmail.com>
 <20090208011802.2b7b9e74@perceptron>
 <7v1vu91d00.fsf@gitster.siamese.dyndns.org>
 <20090208111838.GD14359@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jan =?utf-8?Q?Kr=C3=BCger?= <jk@jk.gs>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Git ML <git@vger.kernel.org>, obrien654j@gmail.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Feb 08 20:07:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWEzu-00086u-4e
	for gcvg-git-2@gmane.org; Sun, 08 Feb 2009 20:07:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753124AbZBHTFw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Feb 2009 14:05:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753122AbZBHTFv
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Feb 2009 14:05:51 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:61003 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753081AbZBHTFv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Feb 2009 14:05:51 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id EEACD98225;
	Sun,  8 Feb 2009 14:05:49 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 0555598224; Sun,
  8 Feb 2009 14:05:42 -0500 (EST)
In-Reply-To: <20090208111838.GD14359@coredump.intra.peff.net> (Jeff King's
 message of "Sun, 8 Feb 2009 06:18:39 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 7FC70598-F613-11DD-9EA2-8B21C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108999>

Jeff King <peff@peff.net> writes:

> On Sun, Feb 08, 2009 at 01:42:07AM -0800, Junio C Hamano wrote:
>
>> I think forbidding the removal of the current branch falls into the same
>> category as forbidding the updating of the current branch.  It is what you
>> would want to avoid in many workflows, and receive.denyDeleteCurrent that
>> defaults to refuse may eventually be a good way to do this, but we need a
>> transition plan for that escape hatch.  Most people may not see why they
>> would want to do such a thing, and many people may perceive that in *their
>> own* workflow such an operation can only be a mistake, but that is not a
>> good enough reason to suddenly start forbidding something other people
>> were allowed to do so far.
>
> I thought of that, too, but note that receive.denyDeleteCurrent is about
> preventing mistakes in a _non-bare_ repo. But deleting the HEAD branch
> is also annoying in a bare repo (but not _as_ annoying; the real impact
> is that cloners get a "could not checkout" message, but you don't have
> the weird index-and-HEAD don't sync issue that non-bare repos get).
> Should such a safety valve apply to both?

If you remove the current branch from a repository, the impact that
operation causes the remote users of the repository would be the same
whether the repository has or does not have a work tree.  And in that
sense, I think it should apply equally.  The criteria is not "is it bare",
but "is it used by people remotely".  IOW, you refuse deletion of the
current branch if other people may fetch from it.

In addition, removing the current branch will affect local operations in
the repository --- the person who were working in the work tree to prepare
for the _next_ commit will now end up creating a root commit.  The effect
is similar, as you correctly point out, to the issue of the HEAD and the
work tree going out of sync that ends up creating a commit with a lot of
reverts.  They both cause the user on the work tree to create an undesired
commit.  Here, the criteria is "does this have a work tree".  I think the
current receive.denyCurrentBranch should also trigger in this case.
