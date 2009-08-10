From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/8] Add a config option for remotes to specify a foreign
 vcs
Date: Sun, 09 Aug 2009 18:15:10 -0700
Message-ID: <7v1vnk79lt.fsf@alter.siamese.dyndns.org>
References: <alpine.LNX.2.00.0908091526060.27553@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Brian Gernhardt <benji@silverinsanity.com>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Mon Aug 10 03:15:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MaJUG-0006Pv-PZ
	for gcvg-git-2@gmane.org; Mon, 10 Aug 2009 03:15:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754344AbZHJBPb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Aug 2009 21:15:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754196AbZHJBPa
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Aug 2009 21:15:30 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:40294 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754204AbZHJBPa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Aug 2009 21:15:30 -0400
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9C19C4279;
	Sun,  9 Aug 2009 21:15:30 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C43904276; Sun,  9 Aug
 2009 21:15:26 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 4BA72E4C-854B-11DE-9FED-EAC21EFB4A78-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125393>

Daniel Barkalow <barkalow@iabervon.org> writes:

> If this is set, the url is not required, and the transport always uses
> a helper named "git-remote-<value>".
>
> It is a separate configuration option in order to allow a sensible
> configuration for foreign systems which either have no meaningful urls
> for repositories or which require urls that do not specify the system
> used by the repository at that location. However, this only affects
> how the name of the helper is determined, not anything about the
> interaction with the helper, and the contruction is such that, if the
> foreign scm does happen to use a co-named url method, a url with that
> method may be used directly.

Personally, I do not like this.

Why isn't it enough to define the canonical remote name git takes as
"<name of the helper>:<whatever string the helper understands>"?

Then <whatever string the helper understands> part does not have to
resemble URL at all, if the foreign system does not have such a concept
(i.e. "have no meaning urls for repositories").  

Your "let's eject curl based transport out of core" helper (already in
'next') will become something like these in the canonical form:

	curl:http://git.kernel.org/pub/scm/git/git.git
	curl:ftp://git.kernel.org/pub/scm/git/git.git
	curl:https://git.kernel.org/pub/scm/git/git.git

that are handled by a single helper binary git-remote-curl, but nobody has
to use these canonical forms for well-known transports, because we can
have an obvious set of backward-compatible synonyms that are understood by
the transport layer to choose that helper program, so that usual

	http://git.kernel.org/pub/scm/git/git.git

will be understood to choose git-remote-curl backend.  We do not need to
have three git-remote-{http,https,ftp} helpers at all.

That way, a Subversion repository people may want to interact with would
be spelled, if the helper is "git-remote-svn", like this:

	svn:https://scummvm.svn.sourceforge.net/svnroot/scummvm/

and it would be crystal clear that it is not a git native repository that
is accessed over curl based walkers, and also the folks who still have not
migrated to git can simply drop the leading "svn:" and learn the name of
the repository they could access natively with Subversion.  Nobody on the
Subversion side would think svn:https://... is the URL to use with
Subversion (after all they will see that on the communication in the git
circle).

And from the git side, we can tell users: "if you want to interact with
Subversion repositories, you can use traditional git-svn, or you can use
the unified remote mechanism.  To use the latter, just prefix 'svn:' in
front of the URL used to refer to the repository in the Subversion world".

If you spell the "URL" as https://scummvm.svn.sourceforge.net/svnroot/scummvm/
then you wouldn't be able to give that directly to git from the command
line, without using this new configuration.  I do not quite understand why
this indirection is desired.  I think it only confuses users.

I recall somebody earlier mentioned a possibility to have more than one
helper that deals with one type of foreign system.  In such a case, a pair
of URL and vcs configuration can be used to identify what helper to use on
what foreign "repository":

	(https://scummvm.svn.sourceforge.net/svnroot/scummvm/, svn)
	(https://scummvm.svn.sourceforge.net/svnroot/scummvm/, svn-ng)

and it might become easier to switch the helper without changing the URL
part.  But I do not particularly think that would be a practical
advantage, unless we can assume that the next-generation version of the
helper can somehow reuse the metadata the old version of the helper left
in the repository and incrementally operate on the repository.  Even in
that case, I think spelling everything out in a single configuration
(i.e.. remote.$name.url) would make it clearer to see what is going on.
