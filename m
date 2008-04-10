From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Intricacies of submodules
Date: Wed, 09 Apr 2008 22:53:06 -0700
Message-ID: <7v63uqz265.fsf@gitster.siamese.dyndns.org>
References: <47F15094.5050808@et.gatech.edu> <47FBB448.3060900@et.gatech.edu>
 <32541b130804081306q6e06af20u794357eba9d434e@mail.gmail.com>
 <47FBDA77.2050402@et.gatech.edu>
 <32541b130804081401n743f39c9o3f016da9dee2eb92@mail.gmail.com>
 <8FE3B7A7-4C2D-4202-A5FC-EBC4F4670273@sun.com>
 <32541b130804082033q55c795b5ieaa4e120956ff030@mail.gmail.com>
 <49E9DCEC-8A9E-4AD7-BA58-5A40F475F2EA@sun.com>
 <32541b130804082334s604b62b0j82b510c331f48213@mail.gmail.com>
 <7vhcebcyty.fsf@gitster.siamese.dyndns.org>
 <6CFA8EC2-FEE0-4746-A4F6-45082734FEEC@sun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Avery Pennarun <apenwarr@gmail.com>, stuart.freeman@et.gatech.edu,
	git@vger.kernel.org
To: Roman Shaposhnik <rvs@sun.com>
X-From: git-owner@vger.kernel.org Thu Apr 10 07:54:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jjpji-0003RT-Nf
	for gcvg-git-2@gmane.org; Thu, 10 Apr 2008 07:54:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752198AbYDJFx1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Apr 2008 01:53:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752171AbYDJFx1
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Apr 2008 01:53:27 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:64290 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752081AbYDJFx0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Apr 2008 01:53:26 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 0E455161D;
	Thu, 10 Apr 2008 01:53:25 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id BC8B1161C; Thu, 10 Apr 2008 01:53:19 -0400 (EDT)
In-Reply-To: <6CFA8EC2-FEE0-4746-A4F6-45082734FEEC@sun.com> (Roman
 Shaposhnik's message of "Wed, 09 Apr 2008 20:43:34 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79167>

Roman Shaposhnik <rvs@sun.com> writes:

> ... Yet, even with the latest version of Git we don't have
> "git submodule add" updating .git/config. So here comes the first  
> question:
>      * Do you consider this behavior to be a bug or do you a have a  
> reasonable
>          explanation for it?

I would say that the part is simply underdeveloped.  I do not think many
people from the core circle of the git community are heavy users of
submodules.

The "submodule add" command was done primarily by and for people who
wanted to initially register a commit as a submodule from a subdirectory
repository, back when there was not much actual propagation support (that
is, "what should happen when somebody cloned such a toplevel project with
submodule?") designed yet.  The command simply records the global hint to
the .gitmodules file, so that people who get such a commit that records a
submodule in its tree can also learn where to turn to when they do want to
get to the submodule by looking at in-tree .gitmodules file.

However, the way others will obtain a copy of the submodule repository
will be quite different from the way you access it (you already have it,
so you do not need to clone it from elsewhere to initialize it).  It may
not make much sense to record the URL that you tell others to use in your
own .git/config in the repository of the originator of such a superproject
vs submodule combination.  So in that sense, I am not sure if not mucking
with .git/config is even a bad thing.

The side that registers data in .git/config using what is in .gitmodules
as a hint, which is what "git submodule init" is about, is not very much
developed either (yet).  It does not have enough user interaction to allow
the user to tailor the URL for his own needs, for example.  There is no
duplication per-se; .gitmodules may give you git:// URL but you might need
to rewrite it to corresponding http:// URL because of your networking
situation.  And that is the reason why .git/config should be the
authoritative copy.  There may be bugs in the implementation -- I dunno --
but at least that is the intent.  IOW, at runtime, .gitmodules should not
be consulted for purposes other than to update .git/config entries.

The original discussion that led to the current implementation dates back
in May-June timeframe of 2007.  I would not be surprised if not all of the
good ideas were incorporated in the current implementation.  For example,
one thing that we may want to do is to record what contents we've seen in
the .gitmodules file in order to prime each entry in .git/config, so that
we can give users a chance to adjust what is in .git/config when we notice
the entry in .gitmodules has changed.

For example, consider that .gitmodules said the submodule should be taken
from repository URL git://A.xz/project.git when you cloned.  You may have
used the given URL as-is to prime your .git/config, or you may have chosen
to use http://A.xz/project.git/ for networking reasons.

After working with the project for a while (i.e. you pull and perhaps push
back or send patches upstream), .gitmodules file changes and it now says
the repository resides at host B.xz because the project relocated.  You
would want the next "git submodule update" to notice that your .git/config
records a URL you derived from git://A.xz/project.git/, and that you have
not seen this new URL git://B.xz/project.git/, and give you a chance to
make adjustments if needed.

After that happens, if you seeked to an old version (perhaps you wanted to
work on an old bug), .gitmodules file that is checked out of that old
version may say the "upstream" is at A.xz, but the entry in .git/config
may already be based on B.xz.  But because you have already seen this old
URL in .gitmodules, you may not want to get asked about adjusting the
entry in .git/config merely because you checked out an old version.  What
this means is that it is not enough to just record "What the current URL
you chose to use is" in .git/config (which is obvious), and it is also not
enough to record "what URL .gitmodules had when you made that choice", but
you would also need to record "What URLs you have _seen_ when making that
choice".

The above is one thing I remember seeing in the original discussion but I
do not think implemented in the current code.  I strongly suspect there
are other good design bits left unimplemented in the discussion.  There
definitely are other things people who are interested in submodules may
want to improve.

>       * Has an idea of having a regular file (subject to having  
> history, etc.)
>         called something like .gitconfig at the top level of Git's  
> repository ever
>         been considered (implemented?). That way you a repository  
> maintainer
>         would be able to force a particular set of settings on all of  
> its clones
>         yet clones will be able to override then in .git/config if  
> needed.

Considered, yes, implemented, no.  Not because nobody bothered to, but
because it is unclear if it is a good thing to do in general to begin
with.  What's recorded in .git/config is pretty much personal (e.g. "who
you are known as to this project?", "what's the SMTP host, user and
password when sending out patches from here?", "do you want to use color
in diff?"), dependent on local needs (e.g. "what protocol a particular
remote repository should be reached via"), or what the repository (as
opposed to "project") is about (e.g. "is this a bare, shared distribution
point, or is this a developer repository with a work tree?").

Project policies do not belong to .git/config and should be propagated
in-tree.  For example, "indenting with more than 8 spaces is a whitespace
error for *.c files" is described in .gitattributes and given to all
cloners.

There may be some behaviour that is currently controlled by what is
recorded in .git/config but should be enforced project-wide.  If there are
such things, we may want to have a mechanism that reads from in-tree data,
just like the attributes code does.
