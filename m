From: Junio C Hamano <junkio@cox.net>
Subject: Re: please pull ppc64-2.6.git
Date: Wed, 31 Aug 2005 11:39:20 -0700
Message-ID: <7vek8aar3b.fsf@assigned-by-dhcp.cox.net>
References: <17170.25803.413408.44080@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.58.0508291006440.3243@g5.osdl.org>
	<17171.39652.237263.484079@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.58.0508291706230.3243@g5.osdl.org>
	<1125438048.9705.43.camel@localhost>
	<7v8xyjhxkd.fsf@assigned-by-dhcp.cox.net>
	<20050831170852.2f549318.vsu@altlinux.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Meder <chris@absolutegiganten.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 31 20:39:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EAXUl-00026m-TN
	for gcvg-git@gmane.org; Wed, 31 Aug 2005 20:39:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964916AbVHaSja (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 31 Aug 2005 14:39:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964919AbVHaSj3
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Aug 2005 14:39:29 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:4830 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S964916AbVHaSj3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Aug 2005 14:39:29 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050831183922.LUGL3414.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 31 Aug 2005 14:39:22 -0400
To: Sergey Vlasov <vsu@altlinux.ru>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7982>

Sergey Vlasov <vsu@altlinux.ru> writes:

> All this means that currently there is no clean way to publish a partial
> GIT repository, unless you place it at the same server where the base
> repository is located (and even in that case needing to use something
> like "echo /pub/scm/linux/kernel/git/torvalds/linux-2.6/objects >
> objects/info/alternates" looks like a horrible hack).

There has never been a way to publish a partial GIT repository.
I personally am not convinced it is even a good idea for people
to be able to do so.

$GIT_OBJECT_DIRECTORY/info/alternates is a mechanism to solve
completely different issue -- borrowing objects locally from
different object store to save space.  This is only a local
'repository organization' issue, just like packing objects or
leaving them unpacked in a repository _should_ not make any
difference to people who are interacting with it.

The use of info/alternates is internal to the git aware server
side, be it git-daemon and git-upload-pack when somebody fetches
from it, or git-receive-pack when somebody pushes into it.  The
other end _should_ never have to care if the repository uses
info/alternates, just like it _shouldn't_ matter if the
repository is packed or unpacked.  Most importantly, for people
who are interacting with it, the repository has _everything_ it
claims to have by having pointers to head commits under refs/
hierarchy, and is _not_ partial at all.

Yes, you could peek into the remote repository filesystem by
other means, and even slurp the info/alternates file via rsync,
but as stated many times before, a lot of things that rsync
does are by accident not by design.

Some historical explanation may be helpful.  info/alternates is
merely an improvement for existing ALTERNATE_OBJECT_DIRECTORIES
mechanism.  The latter required individual processes to tell git
what other object stores to consult to find missing objects when
working on a repository whose object store is a partial object
database.  This was clearly not per-process information; it was
specific to that partial object store, and that was the reason
info/alternates was invented.  The processes do not have to have
that environment variable; instead the necessary information is
recorded in the partial object store itself.

I kept saying '_should_' because commit walkers would not
currently understand alternates, just like they had trouble with
packed repositories earlier.  This _is_ a defect, but I
personally feel that this is a problem not worth solving.

Earlier, when commit walkers did not understand packed
repositories, the only workaround was 'then do not pack your
public repository'.  This was unacceptable from storage
consumption point of view, and it had to be solved in some way.
Daniel solved it for 0.99.4.

But what info/alternates does is different.  If you care about
commit walkers (and I certainly do), there are other means to
save space without using info/alternates; first try packing, and
then hard linking object files with whichever other repository
you would have placed in info/alternates, and you are done.

Now you may argue that being able to publish truly partial
repository that does not have all the objects and depends on
some other repository, very likely to be on completely different
server (otherwise you would not be advocating for a non-local
path such as URL) a worthwhile goal.  I personally do not even
believe that a repository relying on a foreign object store is a
good idea, and much less so if you are making that repository
publicly available.

I like your local-mirror-mapping idea very much, but I do not
think it is something that is specific to git.  If you have such
a mechanism to map remote URL into local filesystem namespace
and automount/mirror them on demand, I'd like to be able to use
that when I am browsing files in my Emacs (yes, there is
'ange-ftp') or even 'cat' files from it.  Its more useful that
way than limiting its use to only when git wants to find missing
object files from its alternate object store.
