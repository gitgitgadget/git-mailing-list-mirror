From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 0/4] Signed push
Date: Fri, 09 Sep 2011 22:19:10 -0700
Message-ID: <7vipp1otyp.fsf@alter.siamese.dyndns.org>
References: <1315512102-19022-1-git-send-email-gitster@pobox.com>
 <1315600904-17032-1-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, "Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 10 07:20:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R2Fz9-0007e7-F7
	for gcvg-git-2@lo.gmane.org; Sat, 10 Sep 2011 07:20:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751985Ab1IJFTP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Sep 2011 01:19:15 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41778 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750986Ab1IJFTO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Sep 2011 01:19:14 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6402B4A77;
	Sat, 10 Sep 2011 01:19:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ml3FTb3Mlk0GBXfVCog5NFuMTyk=; b=jx+36f
	fN8Ex7bB7lYFF4nOEbFzQrP1gpyHhxpWi4h+9OIT6O+e/NZGQbtmfRuniktHDZNW
	NajVAcOH4xcRKW/Uf8hCrgHtUkH1IkQuEpAAbzHtMzS7lLGMY4Ewhcg3XsBro2Aa
	zmwYnRwe73rv0VEgTlR0q03bLFQBdJOX1cjdE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PjTzTgmBJLHklXmniE5CtxaE2KP6CpXF
	unuaS/m8O59I9TYOxJueXUHjRZ1nfbfQWrKoz/o0uQl9ANFc5wMqumvPFcN7+VCv
	LX1EBsdwnGl/MFA3WTejSUhWI4QGeF8kCK4iipN8Or+WkJxSe/9EkkyQpKuOmZhy
	PaRfdtUfdag=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5A61F4A76;
	Sat, 10 Sep 2011 01:19:13 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AB6324A73; Sat, 10 Sep 2011
 01:19:12 -0400 (EDT)
In-Reply-To: <1315600904-17032-1-git-send-email-gitster@pobox.com> (Junio C.
 Hamano's message of "Fri, 9 Sep 2011 13:41:40 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6B787F9A-DB6C-11E0-95AF-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181138>

Now that I have tried two concrete implementations and had a chance to
play with both ideas, even though I haven't started pushing to other
repositories with signature for real, I can make some observations with a
certain degree of confidence. I have to say that there is one thing I do
not really like about this.

During my typical work day, I usually run at least one, but possibly up to
three to four integration cycles, and each cycle is concluded with these
actions (in this order):

 - Push maint/master/next/pu integration branches and optionaly todo
   branch to k.org;

 - Fetch html/man branches from k.org that are auto-updated as the result
   of the above push, if necessary;

 - Push maint/master/next/pu/html/man branches and optionally todo branch
   to repo.or.cz and code.google.com;

 - Push maint/master/html/man branches and optionally todo branch to
   sourceforge.net and sourceforge.jp; and finally

 - Mirror-push everything to github.com.

First let's make it clear what is _not_ what I do _not_ like.

I do not mind having to unlock my GPG key for each of the above set of
pushes. After all, these four classes of repositories:

 (1) the primary public repository at k.org;
 (2) its two mirrors at repo and google;
 (3) the secondary partial mirrors at two sourceforge sites; and
 (4) full mirror at github

receive different sets of branches.  It is not just I do not mind, but I
actively would prefer, making separate assertions to say "These commits
this particular site has were placed here by me to these branches with
this push", and I think it is preferrable that the assertions are
customized for destination sites. So it is natural to generate separate
push certificates to make separate assertions, and that is why unlocking
the key multiple times nor signing one document per push destination is
not a problem.

Now, with that behind us, let's discuss what I do _not_ like.

The v3 design that prepares and pushes the signed-push notes tree locally
has one major downside that I did not anticipate before starting to really
think about using signed pushes.

Think about what is contained in the signed-push notes tree that is pushed
to sourceforge during one cycle of my work day described above. The site
gets neither next nor pu branch, but because

 (1) I push out the same commit at the tip of master as I push to k.org,
     repo and sourceforge;
 (2) the push to sourceforge happens after the pushes to k.org and repo
     happens; and
 (3) in v3 design, I have to keep the notes tree prepared locally before
     pushing things out,

the push certificate note attached to the commit object at the tip of the
'master' branch becomes a concatenation of three pushes, and some of them
describe the branches that sourceforge does not get (namely, next and pu
that I pushed out to k.org and repo).

Worse yet, after I conclude this round by pushing all the topics to github
with signature, my signed-push notes history has push certificates that
describe my previous push of _all topics_ to github repository, and on top
of that notes tree, signed-push notes to describe the next push to k.org
is built, and it is sent to k.org at the beginning of the next cycle.

Now imagine a hypothetical universe where my k.org repository is the "open
source Git" (eh, that is not hypothetical), but some of the topic branches
that are not merged to pu were the "proprietary extensions" published only
to the github repository. Further imagine that in this hypothetical
universe, my github repository is not the "open source" one, but is a
proprietary "partner server" I use to work with other "Git proprietary
extensions" closed source commercial project.

You can easily understand why the behaviour of the natural consequence of
the v3 design is a horrible mistake. In such a set-up, even branch names
may contain sensitive information, yet we are exposing the record of
pushes to github to the shared signed-push notes tree at k.org during the
next round. The presense of such a partner server may even be a sensitive
piece of information that shouldn't be devulged to the open source k.org
repository.

There is no such problem with the v2 design, where the reciever site is
solely responsible to keep the push certificate and does not force me to
have copies of all the push certificates locally to preserve ordering. The
signed-push notes for each hosting site contain _only_ push certificates
that pertain to pushes to _that_ site in the v2 design.

And I think that really is the right way to do a signed push.

The primary motivation of the signed push is for me to assert "These
commits this particular site has were placed here by me to these branches
with this push", so that people can be sure that the commits near the tip
of my branches since the latest tagged commits (which are signed by my GPG
key) did come from me. In order to achieve that goal, k.org repository has
no business knowing what I pushed to github repository, and github
repository has no business knowing what I pushed to k.org repository.

Even under v2 design, if somebody who has access to both k.org (public)
and github (proprietary in the hypothetical universe) would want to
combine the signed-push notes to see a unified picture (perhaps I push to
these two sites with different frequencies), he can fetch signed-push
notes from both sites and merge them himself. But v3 design also allows
anybody who has access to k.org (which is public so by definition that
truly is anybody) to peek into signed-push notes at k.org to learn more
than he should be able to.

It is cumbersome, if not impossible, to achieve the same separation v2
design gives us by default. The pusher of course can maintain separate
signed-push branches per push destinations, but I think that is merely a
workaround.

To begin with, there is no real reason for _me_ to keep _any_ signed-push
record for places _I_ pushed. The assertion I am making by signing my
pushes is for people who get commits beyond my last tagged commits to be
sure that they do come from me, and while it is fine to have back-up
copies of them for your own use, there is no reason to _require_ me to do
so. But the "locally prepare notes tree and push that out along with what
you wanted to push out" design does exactly that.
