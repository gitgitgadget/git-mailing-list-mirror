From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git submodules
Date: Sun, 17 Aug 2008 16:08:39 -0700
Message-ID: <7v1w0np7d4.fsf@gitster.siamese.dyndns.org>
References: <20080728162003.GA4584@artemis.madism.org>
 <320075ff0807281323l51bb6478j30e3e4c490974a70@mail.gmail.com>
 <20080728205545.GB10409@artemis.madism.org>
 <20080728205923.GC10409@artemis.madism.org>
 <32541b130807281440v64f3cb9ci50cf6d16be4f2f82@mail.gmail.com>
 <20080728220308.GF10409@artemis.madism.org>
 <m3r69dtzm9.fsf@localhost.localdomain>
 <7vfxptpr76.fsf@gitster.siamese.dyndns.org> <20080817201336.GA17148@artemis>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	Nigel Magnay <nigel.magnay@gmail.com>,
	Git ML <git@vger.kernel.org>
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Mon Aug 18 01:11:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KUrP1-0008Fr-Ss
	for gcvg-git-2@gmane.org; Mon, 18 Aug 2008 01:11:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752452AbYHQXIu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Aug 2008 19:08:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752491AbYHQXIu
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Aug 2008 19:08:50 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:38359 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752209AbYHQXIu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Aug 2008 19:08:50 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id E9E585DDF5;
	Sun, 17 Aug 2008 19:08:48 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id E173C5DDF2; Sun, 17 Aug 2008 19:08:41 -0400 (EDT)
In-Reply-To: <20080817201336.GA17148@artemis> (Pierre Habouzit's message of
 "Sun, 17 Aug 2008 22:13:36 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 733BEDDE-6CB1-11DD-8EC0-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92670>

Pierre Habouzit <madcoder@debian.org> writes:

> On Mon, Jul 28, 2008 at 10:41:17PM +0000, Junio C Hamano wrote:
>
>> I suspect the use of it may help the use case Pierre proposes, but its
>> main attractiveness as I understood it back when we discussed the facility
>> was that you could switch branches between 'maint' that did not have a
>> submodule at "path" back then, and 'master' that does have one now,
>> without losing the submodule repository.  When checking out 'master' (and
>> that would probably mean you would update 'git-submodule init' and
>> 'git-submodule update' implementation), you would instanciate subdirectory
>> "path", create "path/.git" that is such a regular file that that points at
>> somewhere inside the $GIT_DIR of superproject (say ".git/submodules/foo").
>> By storing refs and object store are all safely away in the superproject
>> $GIT_DIR, you can now safely switch back to 'maint', which would involve
>> making sure there is no local change that will be lost and then removing
>> the "path" and everything underneath it.
>
> gitfiles looks nifty for sure, though I've thought about it a bit, and
> I'm not sure if we don't want something a bit more powerful, though
> still in the same vein.
>
> If we look at submodules, I quite believe that we would benefit a lot
> from sharing the object directory accross the supermodule and all its
> submodules, because of the following reasons:

I know there are cases where sharing object store is useful.  Being able
to share is one thing.  Always having to share, without any other option,
is another.

Using gitlink to keep the true repository data out of submodule checkout
area so that branch switching can safely be done is orthogonal to the
issue of how repositories of submodules and the superproject share their
object store.  IOW, you would always use gitlink to solve the "branch
switching may make the submodule checkout disappear" issue, while you
could use alternates mechanism (or direct symlinking of $GIT_DIR/objects)
across these repositories *if* you want to share their object store.

> Though we would not like to have submodules suffer from reachability
> issues after a prune in the supermodule. That means that all references
> and reflogs of the submodules shall be accessible from the supermodule
> so that everything that could mess with the object store by removing
> objects cannot remove interesting objects (that should limit the code
> paths to really seldom places actually).

I do not think this issue is limited to use of submodules.  I'd imagine
that if you build this reachability protection into the alternates
mechanism, you would automatically solve both "multiple checkout of the
same project, via git-new-workdir" issue as well as "submodules that share
its objects with the superproject" issue.

Which leads me to conclude, at least for now, that it would not be a good
idea to make this related to gitfile in any way.  Object sharing between
equal repositories (aka new-workdir) does not use gitfile, but it still
needs to have the same kind of reachability protection.
