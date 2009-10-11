From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH] disallow refs containing successive slashes
Date: Sun, 11 Oct 2009 12:42:44 +0200
Message-ID: <4AD1B6A4.8060405@web.de>
References: <4AD0C93C.6050306@web.de> <7vws327wbp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Oct 11 12:50:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mww09-0007Xs-2U
	for gcvg-git-2@lo.gmane.org; Sun, 11 Oct 2009 12:50:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756655AbZJKKss (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Oct 2009 06:48:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756352AbZJKKsr
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Oct 2009 06:48:47 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:48609 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755229AbZJKKsq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Oct 2009 06:48:46 -0400
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate02.web.de (Postfix) with ESMTP id F35AB12D582B0;
	Sun, 11 Oct 2009 12:42:49 +0200 (CEST)
Received: from [80.128.51.209] (helo=[192.168.178.26])
	by smtp05.web.de with asmtp (WEB.DE 4.110 #314)
	id 1Mwvt3-0002rw-00; Sun, 11 Oct 2009 12:42:49 +0200
User-Agent: Thunderbird 2.0.0.23 (X11/20090812)
In-Reply-To: <7vws327wbp.fsf@alter.siamese.dyndns.org>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1/P3TzyCqf+7nEezTR0mY56dUOWgQdPKgZ0S/rA
	tvoAT937mwqsekWXuCrvs/H8sGi4bKv0cmYxgmtR+JcoWTefJ2
	y2pP400W/JmCoS5nkcMw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129915>

Junio C Hamano schrieb:
> Jens Lehmann <Jens.Lehmann@web.de> writes:
> 
>> When creating branches using names starting with '/' or containing a '//',
>> a leading slash would just vanish and successive slashes were 'compressed'
>> into just one slash.
> 
> Hmm.  We already do that without your patch.
> 
>     $ git branch /foo//bar
>     $ git for-each-ref --format='%(refname)'
>     refs/heads/foo/bar
>     refs/heads/master
>     $ git branch -d /foo//bar
>     Deleted branch /foo//bar (was deadbeef)
>     $ git for-each-ref --format='%(refname)'
>     refs/heads/master

Yes, but git changes the name silently from '/foo//bar' to 'foo/bar'!

The automagical removal of some slashes leads to strange behaviour when
using such names:

    $ git checkout -b foo/bar
    Switched to a new branch 'foo/bar'
    $ git checkout -b /foo//bar
    fatal: A branch named '/foo//bar' already exists.
    $ git for-each-ref --format='%(refname)'
    refs/heads/foo/bar
    refs/heads/master

git claims wrongly that "A branch named '/foo//bar' already exists.".

And that same happens to tag and repo names, leading to other strange
effects:

    $ git tag /foo//bar
    $ git tag
    foo/bar

That is not the tagname the user provided.

    $ git remote add /foo//bar git://git.kernel.org/pub/scm/git/git.git
    $ git remote show
    warning: Config remote shorthand cannot begin with '/': /foo//bar.url
    warning: Config remote shorthand cannot begin with '/': /foo//bar.fetch
    $ git fetch /foo//bar
    warning: Config remote shorthand cannot begin with '/': /foo//bar.url
    warning: Config remote shorthand cannot begin with '/': /foo//bar.fetch
    fatal: 'foo/bar' does not appear to be a git repository
    fatal: The remote end hung up unexpectedly

Note: git fetch uses both versions of the remote name in its output.


>> I became aware of this issue while looking into problems occuring
>> when a user created a branch starting with a '/' in git gui (e.g.
>> "/foo"). Strange things happen, while git gui shows the current
>> branch as "/foo" under the hood a branch "foo" (without the slash)
>> had been created. But then you can't delete "/foo" from git gui,
>> because a branch of that name doesn't exist.
> 
> Perhaps an interface to give a cleaned-up version, e.g.
> 
>     $ git check-ref-format --print refs/heads//foo/bar
>     refs/heads/foo/bar
> 
> is what you want in order to fix git-gui?  I dunno.

Yes, one solution could be to fix every application handling branch, tag
or repo names to mimic the namechange done in the bowels of git. But i
think it is not worth the hassle. Every application i tested (git gui,
gitk and a handful of git commands) just assumes - and i think rightfully
so - that refnames will not change while they are being created (And they
do call "git check-ref-format" or strbuf_check_branch_ref() and friends
to make sure they have a valid refname, but it gets changed nonetheless).

With this patch you get an error every time you try to create such a
refname in the first place and the strange effects and the ambiguity
of refnames ('/foo//bar' is a synonym for 'foo/bar' right now) just
go away.

The motivation for this patch was a confused user at my dayjob. IMHO
most people don't use '/foo//bar' on purpose but the extra slashes get
there through typos, copy & paste errors and such. Then generating an
error might just be the Right Thing to do to avoid the problems with
the changed refname afterwards.
