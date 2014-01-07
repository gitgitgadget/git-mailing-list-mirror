From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] format-patch: introduce format.defaultTo
Date: Tue, 7 Jan 2014 16:06:07 -0500
Message-ID: <20140107210607.GB28102@sigill.intra.peff.net>
References: <1389028732-27760-1-git-send-email-artagnon@gmail.com>
 <1389028732-27760-3-git-send-email-artagnon@gmail.com>
 <xmqqlhythrzq.fsf@gitster.dls.corp.google.com>
 <CALkWK0kZn44x98td9YXNT5VfhVs=ueeSty9M7Vh08bdoGjGQYg@mail.gmail.com>
 <xmqqa9f8j2n8.fsf@gitster.dls.corp.google.com>
 <CALkWK0nSed9vvRvTR00_vV3tHL8mSQA=8JJ_Y7=pQchoVcvhzA@mail.gmail.com>
 <xmqqha9ghhrw.fsf@gitster.dls.corp.google.com>
 <CALkWK0=Km+a7NBm9ki5MN=R28HkzUZRqnBKcpuPZDrQKdsBesg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 07 22:06:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0dqp-0001ei-4Y
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jan 2014 22:06:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753104AbaAGVGM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jan 2014 16:06:12 -0500
Received: from cloud.peff.net ([50.56.180.127]:56694 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751577AbaAGVGK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jan 2014 16:06:10 -0500
Received: (qmail 24193 invoked by uid 102); 7 Jan 2014 21:06:10 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 07 Jan 2014 15:06:10 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 07 Jan 2014 16:06:07 -0500
Content-Disposition: inline
In-Reply-To: <CALkWK0=Km+a7NBm9ki5MN=R28HkzUZRqnBKcpuPZDrQKdsBesg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240154>

On Tue, Jan 07, 2014 at 04:17:00AM +0530, Ramkumar Ramachandra wrote:

> Junio C Hamano wrote:.
> > As I said in the different subthread, I am not convinced that you
> > would need the complexity of branch.*.forkedFrom.  If you set your
> > "upstream" to the true upstream (not your publishing point), and
> > have "remote.pushdefault"set to 'publish', you can expect
> >
> >         git push
> >
> > to do the right thing, and then always say
> >
> >         git show-branch publish/topic topic
> 
> I think it's highly sub-optimal to have a local-branch @{u} for
> several reasons; the prompt is almost useless in this case, and it
> will always show your forked-branch ahead of 'master' (assuming that
> 'master' doesn't update itself in the duration of your development).

I actually use local-branch @{u} all the time to represent inter-topic
dependencies. For example, imagine I have topic "bar" which builds on
topic "foo", which is based on master. I would have:

  [branch "foo"]
    remote = origin
    merge = refs/heads/master
  [branch "bar"]
    remote = .
    merge = refs/heads/foo

When I rebase "foo", I want to rebase it against upstream's master. When
I rebase "bar", I want to rebase it against foo. And naturally, upstream
does not necessarily have a "foo", because it is my topic, not theirs (I
_may_ have published my "foo" somewhere, but that is orthogonal, and
anyway my local "foo" is the most up-to-date source, not the pushed
version).

As an aside, if you want to rebase both branches, you have to topo-sort
them to make sure you do "foo" first, then rebase "bar" on the result.
My daily procedure is something like:

  all_topics |
  while read topic; do "echo $topic $(git rev-parse $topic@{u})"; done |
  topo_sort |
  while read topic upstream; do
    git rebase $upstream $topic || exit 1
  done

> While doing respins, the prompt doesn't aid you in any way. Besides,
> on several occasions, I found myself working on the same forked-branch
> from two different machines; then the publish-point isn't necessarily
> always a publish-point: it's just another "upstream" for the branch.

Right, things get trickier then. But I don't think there is an automatic
way around that. Sometimes the published one is more up to date, and
sometimes the upstream thing is more up to date.  You have to manually
tell git which you are currently basing your work on. I find in such a
situation that it tends to resolve itself quickly, though, as the first
step is to pull in the changes you pushed up from the other machine
anyway (either via "git reset" or "git rebase").

-Peff
