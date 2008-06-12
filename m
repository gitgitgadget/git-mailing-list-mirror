From: Johan Herland <johan@herland.net>
Subject: Re: To graft or not to graft... (Re: Recovering from repository corruption)
Date: Thu, 12 Jun 2008 12:21:02 +0200
Message-ID: <200806121221.02287.johan@herland.net>
References: <6dbd4d000806101026m458513ecqa8141f509bad7602@mail.gmail.com> <200806120914.22083.johan@herland.net> <20080612074752.GA507@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	"Stephen R. van den Berg" <srb@cuci.nl>,
	Denis Bueno <dbueno@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jun 12 12:23:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6jxT-0007Lw-SS
	for gcvg-git-2@gmane.org; Thu, 12 Jun 2008 12:23:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755196AbYFLKWJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2008 06:22:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754585AbYFLKWI
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jun 2008 06:22:08 -0400
Received: from sam.opera.com ([213.236.208.81]:50382 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755106AbYFLKWH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Jun 2008 06:22:07 -0400
Received: from pc107.coreteam.oslo.opera.com (pat-tdc.opera.com [213.236.208.22])
	by smtp.opera.com (8.13.4/8.13.4/Debian-3sarge3) with ESMTP id m5CAL20O018579
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 12 Jun 2008 10:21:07 GMT
User-Agent: KMail/1.9.9
In-Reply-To: <20080612074752.GA507@sigill.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84740>

On Thursday 12 June 2008, Jeff King wrote:
> On Thu, Jun 12, 2008 at 09:14:21AM +0200, Johan Herland wrote:
> > > The grafts file isn't part of the object stream and refs, and
> > > clones (and fetches) very much just copy the object database.
> >
> > AFAICS, there's already a perfectly fine way to distribute grafted
> > history: 1. Add a grafts file
> > 2. Run git-filter-branch
> > 3. Remove grafts file
> > 4. Distribute repo
> > 5. Profit!
> >
> > Since git-filter-branch turns grafted parentage into _real_
> > parentage, there's no point in ever having a grafts file at all
> > (except transiently for telling git-filter-branch what to do).
>
> But then you have rewritten all of the later commits, so you can no
> longer talk to other people about them.

Correct. My point is that if you want to talk to people about revisions, 
you'd better do it from a repo where people agree on the entire 
history. On the other hand, if you want to do archaeology with grafts, 
you should be aware that you are subverting one of the core guarantees 
provided by Git (i.e. a commit id verifies full ancestry of a commit), 
and therefore shouldn't communicate with other repos _at_ _all_, as 
other repos can easily be confused (see [1]).

> The kernel repo is split into "historical" and active repos. You can
> graft the historical repo and get more far-reaching answers to things
> like "git log" and "git blame". But if you run filter-branch, you
> can't share development on that repo via push / pull to people who
> _don't_ use the graft, since they don't share your history (and they
> probably don't want to, because of the extra resources required to
> pull in the historical chunk).

Yes, by forcing git-filter-branch, you can no longer push/pull to/from 
such a historical repo. But as this thread has already demonstrated, 
with grafts you can't clone from such a repo today (nor pull in certain 
circumstances, see [1]); so the way I see it, communication with this 
repo is _already_ limited. By disallowing grafts and forcing a rewrite 
of the entire repo, we force these communication problems to be more 
explicit/visible.

> That being said, I don't know how common such a setup is. And you did
> mention a "follow-grafts" config option for such people.

Indeed. :)

AFAICS, there's two use cases for grafts:
1. As a preparation for rewriting the history with git-filter-branch.
2. For providing historical repos (like you mention above).

My suggestion only makes life harder for people in the second use case.
If there are many people in the second use case, and they deem 
the "follow-grafts" config option unacceptable, I expect them to flame 
my suggestion to a crisp, and we'll have to think of something else...


Have fun! :)

...Johan

[1]: Consider the following:

### Create a repo with one commit, A
$ mkdir foo
$ cd foo
$ git init
Initialized empty Git repository in /path/to/foo/.git/
$ echo foo > foo
$ git add foo
$ git commit -mA
Created initial commit fe2ec02: A
 1 files changed, 1 insertions(+), 0 deletions(-)
 create mode 100644 foo
### Clone the repo
$ cd ..
$ git clone /path/to/foo bar
Initialize bar/.git
Initialized empty Git repository in /path/to/bar/.git/
### Create 3 more commits in the original repo: A---B---C---D
$ cd foo
$ echo bar >> foo && git commit -a -mB
Created commit ad10f00: B
 1 files changed, 1 insertions(+), 0 deletions(-)
$ echo baz >> foo && git commit -a -mC
Created commit be96559: C
 1 files changed, 1 insertions(+), 0 deletions(-)
$ echo xyzzy >> foo && git commit -a -mD
Created commit f2bafe5: D
 1 files changed, 1 insertions(+), 0 deletions(-)
### Create a graft removing C from the history: A---B---D
$ echo "f2bafe58175e132077285e7fbbcec30859101d2e \ 
ad10f005205f61429dccda95e1442dabe31fbfbe" > .git/info/grafts
### Pull the recent changes into the clone
$ cd ../bar
$ git pull
remote: Counting objects: 8, done.
remote: Compressing objects: 100% (2/2), done.
Unpacking objects: 100% (6/6), done.
remote: Total 6 (delta 0), reused 0 (delta 0)
error: Could not read be965599d99192f624b8d8bbf3cab412872586fc
From /path/to/foo/
 + fe2ec02...f2bafe5 master     -> origin/master  (forced update)
error: Could not read be965599d99192f624b8d8bbf3cab412872586fc
error: Could not read be965599d99192f624b8d8bbf3cab412872586fc
Auto-merged foo
CONFLICT (add/add): Merge conflict in foo
Automatic merge failed; fix conflicts and then commit the result.

AFAICS, git-pull can easily become just as confused by grafts as 
git-clone. I wouldn't be surprised by a similar example for git-push.

I can only draw the conclusion that with current versions of Git, repos 
with grafts should _never_ be made public.

-- 
Johan Herland, <johan@herland.net>
www.herland.net
