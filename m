From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: 2.0.0 regression? request pull does not seem to find head
Date: Wed, 4 Jun 2014 21:40:33 +0300
Message-ID: <20140604184033.GB11756@redhat.com>
References: <20140602210131.GA17171@redhat.com>
 <CA+55aFyuj=B4jhc9vPkxHotSgJnRXMj_P_QkHCt-TKXtj8tOFQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Jun 04 20:40:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WsG6g-00035l-AY
	for gcvg-git-2@plane.gmane.org; Wed, 04 Jun 2014 20:40:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751240AbaFDSkH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jun 2014 14:40:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:29035 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750933AbaFDSkG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jun 2014 14:40:06 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s54Ie4PC032517
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 4 Jun 2014 14:40:05 -0400
Received: from redhat.com (ovpn-116-26.ams2.redhat.com [10.36.116.26])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id s54Ie3kf011975;
	Wed, 4 Jun 2014 14:40:03 -0400
Content-Disposition: inline
In-Reply-To: <CA+55aFyuj=B4jhc9vPkxHotSgJnRXMj_P_QkHCt-TKXtj8tOFQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.22
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250754>

On Mon, Jun 02, 2014 at 02:36:01PM -0700, Linus Torvalds wrote:
> On Mon, Jun 2, 2014 at 2:01 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > [mst@robin linux]$ git request-pull net-next/master  git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git net-next
> > warn: No match for commit 2ae76693b8bcabf370b981cd00c36cd41d33fabc found at git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git
> > warn: Are you sure you pushed 'net-next' there?
> 
> git request-pull is clearly correct. There is no "net-next" in that
> public repository.

OK, I see that it's correct.
It used to match commit and go from there, but it does not anymore, and
I didn't know this.

However, it does not tell me this.
It tells me there's no match for commit
2ae76693b8bcabf370b981cd00c36cd41d33fabc:
that commit is there.
Also "match" implies some matching still going on, might be best
to drop this.

> It *used* to be that request-pull then magically tried to fix it up
> for you, which in turn resulted in the guess not being right, like
> pointing to the wrong branch that just happened to have the same SHA1,
> or pointing to a branch when it _should_ have pointed to a tag.

Why not just put the SHA1 in there?
In fact it would be a bit more robust in case of
non-signed pull requests, won't it?

> Now, if you pushed your local "net-next" branch to another branch name
> (I can find a branch name called "vhost-next" at that repository, then
> you can *tell* git that, using the same syntax you must have used for
> the push.
> 
> So something like
> 
>   git request-pull net-next/master
> git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git
> net-next:vhost-next
> 
> should work so that git doesn't end up having to guess (and
> potentially guessing wrong).
> 
> But it may actually be a simpler driver error, and you wanted to use
> "vhost-next", and that "net-next" was actually incorrect?
> 
>        Linus

Yes: net-next is a local name, on the remote it's called vhost-next.


I realize now that with
       git request-pull [-p] <start> <url> [<end>]
<end> actually is a name of commit in the *remote*
tree, not the local one.
Documentation could be improved a bit:

           Commit to end at (defaults to HEAD). This names the commit at
		the tip of the history you are asking to be pulled.

           When the repository named by <url> has the commit at a tip of
		a ref that is different from the ref you have locally, you can use
           the <local>:<remote> syntax, to have its local name, a colon
		:, and its remote name.

It does not have to be commit (could be signed tag), and
that text does not make it very clear what is different from what
until you re-read it a couple of times.
How about:
           Object (commit or tag) to end at (defaults to HEAD). This names the object at
		the tip of the history you are asking to be pulled.
		The name <end> must refer to the same object in both the
		local tree and the remote tree pointed at by <url>.
	
           If the object that you want pulled has a different name
	   in the local and the remote trees, you can use
           the <local>:<remote> syntax, to have its local name, a colon
		:, and its remote name.



The error message could be improved too, it asks me whether
I pushed net-next which I did.
Would be nicer if it asked "Pushed net-next to net-next there?"

Also, how is it supposed to work without <end>?

 git request-pull net-next/master
git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git
warn: No match for commit 2ae76693b8bcabf370b981cd00c36cd41d33fabc found
at git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git
warn: Are you sure you pushed 'HEAD' there?

Where should I push HEAD, and how?
In fact does git let you push to HEAD?


Finally, the output even with a warning could be better:

git request-pull net-next/master
git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git
warn: No match for commit 2ae76693b8bcabf370b981cd00c36cd41d33fabc found
at git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git
warn: Are you sure you pushed 'HEAD' there?
The following changes since commit
96b2e73c5471542cb9c622c4360716684f8797ed:

  Revert "net/mlx4_en: Use affinity hint" (2014-06-02 00:18:48 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git 


If someone does not notice the warning (e.g. the warning is
on stderr and script could only redirect stdout)
then pull request is actually wrong.
It would be better to find the commit on both sides and
if it's there, just use the hash name.



-- 
MST
