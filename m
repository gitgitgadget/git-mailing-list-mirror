From: Finn Arne Gangstad <finnag@pvv.org>
Subject: Re: [RFC/PATCH] git push usability improvements and default change
Date: Tue, 10 Mar 2009 11:04:00 +0100
Message-ID: <20090310100400.GC11448@pvv.org>
References: <1236638151-6465-1-git-send-email-finnag@pvv.org> <7vfxhmdyvn.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 10 11:06:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LgyqN-0005gO-Ni
	for gcvg-git-2@gmane.org; Tue, 10 Mar 2009 11:05:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754150AbZCJKEI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Mar 2009 06:04:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754117AbZCJKEG
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Mar 2009 06:04:06 -0400
Received: from decibel.pvv.ntnu.no ([129.241.210.179]:56193 "EHLO
	decibel.pvv.ntnu.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753348AbZCJKEF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Mar 2009 06:04:05 -0400
Received: from finnag by decibel.pvv.ntnu.no with local (Exim 4.69)
	(envelope-from <finnag@pvv.ntnu.no>)
	id 1Lgyoa-0005wK-Fk; Tue, 10 Mar 2009 11:04:00 +0100
Content-Disposition: inline
In-Reply-To: <7vfxhmdyvn.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112799>

On Mon, Mar 09, 2009 at 05:07:08PM -0700, Junio C Hamano wrote:
> Finn Arne Gangstad <finnag@pvv.org> writes:
> 
> I think the last four are more or less sane, but I am not sure about the
> first three, which makes it very unfortunate that the former depends on
> the latter.

No problem splitting them up, there is just a single function that is
shared between 1-3 and 4-7 really.

[...]
>  * What's the point of having --matching option, when you can already say
>    ':', i.e.
> 
> 	$ git push origin :

If you have the name of your remote easily available, --matching is
identical to "git push remote :". As I believe I found out, getting
the name of the current remote is a bit more tedious than it should
be, which is why I also suggested being able to use "-" as the current
remote.

If a way to specify the default remote is possible, --matching would
not be necessary, but would probably be more obvious to the reader
than "git push - :" or whatever we can agree on.

>  * What's the point of having --current option, when you can already
> say HEAD, i.e.  $ git push origin HEAD

It does something very different. Maybe --tracking would be a better name.
--current does basically this:

branch=`git-symbolic-ref HEAD`
branch=${branch#refs/heads/}
remote=$(git config branch.$branch.remote)

for remotebranch in $(git config branch.$branch.merge); do
	git push $remote $branch:$remotebranch
done

This is the shortest shell script sequence I could find to mimic the
behaviour, maybe I have missed something very obvious. All error
handling is removed for clarity.

The goal here is to be able to:

git checkout -b junios-next origin/next
git push --current  <=>  git push origin junios-next:next

git push origin HEAD would do git push origin junios-next:junios-next,
which was not the intention.

It seems that there is an assumption that branch names are identical
in different repositories, we find that that is not the case at all,
people choose local names that make sense to themselves. Or, from
another viewpoint, even if branches have the same name in two
repositories, they are not necessarily (strongly) related!

"A tracks B" can be a much stronger relation than "A has the same name
as B".

>  * Is push.default still necessary if we had "remote.*.push" (where '*' is
>    literally an "asterisk") that is used as a fall-back default when there
>    is no "remote.<name>.push" for the remote we are about to push to?

The main reason for push.default is to be able to change the default
behaviour for git push to push nothing in a staged manner, and still
let people who are used to and fond of the old behavior continue as before.

You are thinking of something like this in .gitconfig?
[remote "*"]
	push = __something__

Previously you indicated that there is no way to specify the current
matching rule in a remote push line I think?

- Finn Arne
