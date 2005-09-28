From: Junio C Hamano <junkio@cox.net>
Subject: Re: Cogito: cg-clone doesn't like packed tag objects
Date: Wed, 28 Sep 2005 10:22:07 -0700
Message-ID: <7virwlumyo.fsf@assigned-by-dhcp.cox.net>
References: <7virwna2oi.fsf@assigned-by-dhcp.cox.net>
	<7v3bnra20z.fsf@assigned-by-dhcp.cox.net> <43348086.2040006@zytor.com>
	<20050924011833.GJ10255@pasky.or.cz>
	<20050926212536.GF26340@pasky.or.cz>
	<7virwna2oi.fsf@assigned-by-dhcp.cox.net>
	<20050926222944.GG26340@pasky.or.cz>
	<7vr7bb5d8w.fsf@assigned-by-dhcp.cox.net>
	<8764snyufn.fsf@ualberta.net>
	<7v4q875bbj.fsf@assigned-by-dhcp.cox.net>
	<20050927094029.GA30889@pasky.or.cz>
	<7v64sm30dh.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0509271020530.3308@g5.osdl.org>
	<7v64sm1hp3.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0509271414000.3308@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@suse.cz>, Tom Prince <tom.prince@ualberta.net>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 28 19:24:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EKfeI-0003hx-BJ
	for gcvg-git@gmane.org; Wed, 28 Sep 2005 19:23:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751449AbVI1RWg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Sep 2005 13:22:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751455AbVI1RWg
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Sep 2005 13:22:36 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:56493 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1751449AbVI1RWf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Sep 2005 13:22:35 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050928172206.FBPP776.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 28 Sep 2005 13:22:06 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0509271414000.3308@g5.osdl.org> (Linus Torvalds's
	message of "Tue, 27 Sep 2005 14:16:12 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9441>

Linus Torvalds <torvalds@osdl.org> writes:

>> we could send phony entries like this:
>> 
>> b92c9c07fe2d0d89c4f692573583c4753b5355d2	deref/tags/junio-gpg-pub
>> a3eb250f996bf5e12376ec88622c4ccaabf20ea8	deref/tags/v0.99
>> 78d9d414123ad6f4f522ffecbcd9e4a7562948fd	deref/tags/v0.99.1
>
> Yes, it would work,..
> in general, it's just a really ugly special case, I think.

I think we could do this instead, to make it less ugly.

b92c9c07fe2d0d89c4f692573583c4753b5355d2	refs/tags/junio-gpg-pub!*
a3eb250f996bf5e12376ec88622c4ccaabf20ea8	refs/tags/v0.99^0

I am not sure what the syntax should be, but the idea is to
express the "refname" side using "extended SHA1" syntax.  In the
above example, I added a postfix '!*' to mean "deref tag
zero-or-more times until you get a non-tag" ('!' to mean deref
tag once and complain if the object is not tag, '!!' is deref
twice, '!!!' is to deref three times and so on).  It might be
better to spell "v0.99^0" as "v0.99!*" in this context. [*1*]

Both git-clone-pack and git-fetch-pack need to be told to ignore
funny tagnames with trailing '!*', otherwise they would ask for
the pointed-at object (which is not harmful but redundant) and
the clone would create "refs/tags/v0.99!*", a file with a funny
name.  Git-peek-remote should report that, and server-info.c
should be told to prepare these extra entries for ls-remote over
other protocols.

But I tend to agree that this is really a special case needed to
support the "tagged objects are automatically followed by tags
that tag them" model, and not needed if we stay in "tag is just
a ref, and a ref is just an object name, and asking for an
object pulls in other objects that are reachable from them"
model.  So it is not a very high priority for me, but I think
this is one way to help Cogito cleanly, and I am willing to see
how much damage this would cause to other parts of the core, *if*
Cogito wants to use this mechanism.

The alternative would be what Pasky outlined in his message --
bypassing git transport layer to fetch single object by hand,
repeatedly dereferencing it until he gets a non-tag.  I think
that is unnecessary misery for him.


[Footnote]

*1* The difference from '^0' is that '!' does not complain on
non-commit, and can be used to peel the onion one layer at a
time.  I do not know how useful the latter is in practice but
somebody may want to express chains of trust by signing tags.
