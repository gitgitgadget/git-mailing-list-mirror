From: Junio C Hamano <junkio@cox.net>
Subject: Re: Cogito: cg-clone doesn't like packed tag objects
Date: Mon, 26 Sep 2005 21:46:39 -0700
Message-ID: <7vr7bb5d8w.fsf@assigned-by-dhcp.cox.net>
References: <43348086.2040006@zytor.com> <20050924011833.GJ10255@pasky.or.cz>
	<20050926212536.GF26340@pasky.or.cz>
	<7virwna2oi.fsf@assigned-by-dhcp.cox.net>
	<20050926222944.GG26340@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 27 06:48:53 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EK7Me-0004KI-1F
	for gcvg-git@gmane.org; Tue, 27 Sep 2005 06:46:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964803AbVI0Eqn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Sep 2005 00:46:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964804AbVI0Eqn
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Sep 2005 00:46:43 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:65466 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S964803AbVI0Eqm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Sep 2005 00:46:42 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050927044642.RNSZ16347.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 27 Sep 2005 00:46:42 -0400
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20050926222944.GG26340@pasky.or.cz> (Petr Baudis's message of
	"Tue, 27 Sep 2005 00:29:45 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9367>

Petr Baudis <pasky@suse.cz> writes:

> Yes - so you can't save the tag objects either, but then
> you'll re-slurp them again and again, which is kind of
> silly. Alternatively, you could actually make git-fsck-object
> silent about the case when an unreachable (not referenced in
> refs/) tag object references a non-existing object - perhaps
> unless --strict is passed to it. If you think the rest of my
> logic is ok, I think this change to facilitate this "tags
> caching" is not unreasonable.

Now you completely lost me.  I really do not understand what you
mean by tags caching and re-slurping.

If your user _is_ interested in the tag, say v0.99.7d, wouldn't
it make sense to make sure that, after the user fetches the tag,
the user can build v0.99.7d point release as well?  What do you
think the reason is when your user says he is interested in
another tag, junio-gpg-pub?  Wouldn't it be the most natural
interpretation that he wants to get the blob the tag refers to,
so that he can use it with git-verify-tag?  What good does it do
for the user if you get only the tag object and do not get the
blob the tag refers to?  Yes, he can say "git cat-file tag
junio-gpg-pub", but that by itself is not that interesting if it
cannot be used to validate the other tags (or itself).

If the users ask for a tag, I think it is easier for them to
understand if you made sure you give them the complete set of
objects that need to support that tag, at least by default.
Giving the user an option to override it to make a sparse,
incomplete, fsck-unclean repository is fine as a spacesaver
option, but I think that should be left for "more advanced
users" who understand the ramification of using the option.

I happen to publish maint branch, but I could have done without.
I can make a temporary branch out of v0.99.7c tag, add fixes to
extend that branch, tag the branch head as v0.99.7d, and delete
the temporary branch without publishing it at all.

The tree needed to build v0.99.7d point release would be only
reachable by fetching that tag (and here, "fetching the tag"
really means "making sure the receiving repository has the tag
object, and all the objects that are reachable from that tag
object"), so "fetching only the tag object and not the object it
refers to" in that case does not make much sense for the end
user.  Yes, he can say "git cat-file tag v0.99.7d", but that by
itself is not that interesting if he cannot use it to build that
release.
