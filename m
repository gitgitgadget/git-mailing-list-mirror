From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bad objects error since upgrading GitHub servers to 1.6.1
Date: Tue, 27 Jan 2009 17:32:10 -0800
Message-ID: <7vk58gz04l.fsf@gitster.siamese.dyndns.org>
References: <bab6a2ab0901271504j73dce7afjf8436c3c7c83b770@mail.gmail.com>
 <bab6a2ab0901271510y1e3e6912t82ff16e0f912d4b6@mail.gmail.com>
 <alpine.DEB.1.00.0901280034310.3586@pacific.mpi-cbg.de>
 <20090127233939.GD1321@spearce.org>
 <7v1vuo1f6d.fsf@gitster.siamese.dyndns.org>
 <bab6a2ab0901271634x7201130bx4a565bd8bea6967b@mail.gmail.com>
 <7vvds0z1c1.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: PJ Hyett <pjhyett@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 28 02:33:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRzJI-0002fC-PB
	for gcvg-git-2@gmane.org; Wed, 28 Jan 2009 02:33:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751545AbZA1BcT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jan 2009 20:32:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751325AbZA1BcT
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jan 2009 20:32:19 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:39740 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750862AbZA1BcS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jan 2009 20:32:18 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id B033594651;
	Tue, 27 Jan 2009 20:32:17 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id D90FD94650; Tue,
 27 Jan 2009 20:32:11 -0500 (EST)
In-Reply-To: <7vvds0z1c1.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue, 27 Jan 2009 17:06:06 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 7FCC8644-ECDB-11DD-8A88-CC4CC92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107443>

Junio C Hamano <gitster@pobox.com> writes:

> PJ Hyett <pjhyett@gmail.com> writes:
> ...
>> The new alternates code in 1.6.1 sounds like that could be the issue.
>
> It could be.
>
> With the old server, when project A has a forked project A1, and A1
> borrows (via alternates) objects from A, pushing into A1 did not look at
> refs in A's repository (this all happens on the server end).
>
> With the new server, the server side also advertises the tips of A's
> branches as commits that are fully connected, when the client side tries
> to push into A1.  Older clients ignored this advertisement, so when they
> pushed into A1, because their push did not depend on what's in repository
> A on the server end, did not get affected if repository A (not A1) is
> corrupted.  A new client talking to the server would be affected because
> it believes what the server says.
>
> Older client ignores this advertisement, so if you are seeing trouble
> reports from people who use older clients, then you can dismiss this
> conjecture as unrelated.  But if you see the issue only from people with
> new clients, this could be just exposing a repository corruption of A (not
> A1) on the server end that people did not know about before.

The extra "we also have these" advertisement happened as a result of this
discussion:

    http://thread.gmane.org/gmane.comp.version-control.git/95072/focus=95256

I think I know what is going on.

Consider this sequence of events.

 (0) Alice creates a project and pushes to public.

    alice$ cd $HOME/existing-tarball-extract
    alice$ git init
    alice$ git add .
    alice$ git push /pub/alice.git master
    

 (1) Bob forks it.

    bob$ git clone --bare --reference /pub/alice.git /pub/bob.git

 (2) Bob clones his.

    bob$ cd $HOME && git clone /pub/bob.git bob

 (3) Alice works more and pushes

    alice$ edit foo
    alice$ git add foo
    alice$ git commit -a -m 'more'
    alice$ git push /pub/alice.git master

 (4) Bob works more and tries to push to his.

    bob$ cd $HOME/bob
    bob$ edit bar
    bob$ git add bar
    bob$ git commit -a -m 'yet more'
    bob$ git push /pub/bob.git master

Now, the new server advertises the objects reachable from alice's branch
tips as usable cut-off points for pack-objects bob will run when sending.

And new builtin-send-pack.c has new code that feeds "extra" refs as

	^SHA1\n

to the pack-objects process.

The latest commit Alice created and pushed into her repository is one such
commit.

But the problem is that Bob does *NOT* have it.  His "push" will run pack
object telling it that objects reachable from Alice's top commit do not
have to be sent, which was the whole point of doing this new "we also have
these" advertisement, but instead of ignoring that unknown commit,
pack-objects would say "Huh?  I do not even know that commit" and dies.

This can and should be solved by client updates, as 1.6.1 server can work
with older client just fine.
