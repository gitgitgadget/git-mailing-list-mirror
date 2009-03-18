From: "Marcel M. Cary" <marcel@earth.care2.com>
Subject: Re: Ability to edit message from git rebase --interactive.
Date: Wed, 18 Mar 2009 14:02:08 -0700
Message-ID: <49C16150.6070001@earth.care2.com>
References: <200903171953.23650.ogoffart@kde.org>	 <alpine.DEB.1.00.0903172329480.10279@pacific.mpi-cbg.de>	 <20090318004056.GB25454@coredump.intra.peff.net>	 <7vsklbod0l.fsf@gitster.siamese.dyndns.org> <fabb9a1e0903172242v6f67aa9er40fe0ae2a2db7bc3@mail.gmail.com> <49C0C4C5.5070802@drmicha.warpmail.net> <49C10A97.6060201@oak.homeunix.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Marcel M. Cary" <marcel@oak.homeunix.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Olivier Goffart <ogoffart@kde.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Mar 18 22:04:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lk2vT-00033D-2x
	for gcvg-git-2@gmane.org; Wed, 18 Mar 2009 22:03:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755008AbZCRVCN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2009 17:02:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755672AbZCRVCM
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Mar 2009 17:02:12 -0400
Received: from exchange01.earth.care2.com ([38.99.18.107]:41409 "EHLO
	exchange01.earth.care2.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754334AbZCRVCK (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Mar 2009 17:02:10 -0400
Received: from [10.100.1.59] (38.99.217.18) by exchange01.earth.care2.com
 (10.102.0.107) with Microsoft SMTP Server id 8.0.813.0; Wed, 18 Mar 2009
 14:02:09 -0700
User-Agent: Mozilla-Thunderbird 2.0.0.19 (X11/20090103)
In-Reply-To: <49C10A97.6060201@oak.homeunix.org>
X-PureMessage: [Scanned]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113664>

Marcel M. Cary wrote:
> Michael J Gruber wrote:
>> Sverre Rabbelier venit, vidit, dixit 18.03.2009 06:42:
>>> Heya,
>>>
>>> On Wed, Mar 18, 2009 at 02:06, Junio C Hamano <gitster@pobox.com> wrote:
>>>> Jeff King <peff@peff.net> writes:
>>>> I am not quite sure what rephrase is buying us.  Do we also want to
>>>> introduce retree that allows you to muck with the tree object recorded
>>>> without giving you a chance to clobber the commit log message?
>>> Is that a common operation? Rephrase is, at least to me...
>>>
>> Rephrase for sure is common, and for sure can be done currently... It's
>> only that "commit --amend, save&quit, continue" could be shortened.
>>
>> OTOH: Most commonly one would want to rephrase a commit message or two
>> without actually rebasing anything. And the proposed change doesn't help
>> as much as it could, in two respects:
>>
>> 1) I want to be able to say "rephrase HEAD~2" without having to edit a
>> rebase action script. (That would be useful for rewriting a single
>> commit as well, and could be added easily.)
>>
>> 2) Currently, all rebasing operations have trouble with merges. But if
>> all I want to do is rephrasing a log message then no diff/apply is
>> necessary, no rewriting of trees, no change in the DAG structure (i.e.
>> connectivity; sha1s change, of course). So there should be a special
>> mode for DAG-preserving rewrites, where one can be sure that merges are
>> fully preserved.
>>
>> 2) seems to be the most important point to make rephrasing safe and
>> convenient.
> 
> Interesting points about skipping the action script and preserving
> structure.  I just tried to do something like that with filter-branch:
> 
> git filter-branch --msg-filter 'cat > tmp;  $EDITOR tmp < '$(tty)' >
> '$(tty)' 2>&1; cat tmp' ^HEAD^ HEAD
> 
> And discovered that it will neither accept "HEAD^^..HEAD^" nor "HEAD^"
> as a shortcut for a rev-list containing a single commit.  But if you're
> content to save and quit each message through the branch tip and specify
> the range, it seems to work.
> 
> I have no idea what it would take to make filter-branch support the
> additional kinds of rev and rev list specifications, or if that would be
> undesirable.
> 
> I'm assuming it accomplishes (2) because of the nature of filter-branch.

Ok, so I guess you have to explicity tell filter-branch all the commits 
that reach the ones you want to rewrite so it will know to fixup their 
parents.  Below is a rough way of doing that, but sometimes it will find 
too many commits, and it's rather slow, even on a git.git.

git-rephrase:
#!/bin/sh

if [ -z "$EDITOR" ]; then
     export EDITOR=vim
fi
# Does change tags
refs=$(git for-each-ref --format='%(refname)' 'refs/heads/*' |
     while read ref; do
         # This is the slow part
         if git rev-list $ref | grep -q $(git rev-parse --verify $1); then
             echo $ref
         else
             echo ^$ref
         fi;
     done
)
parents=$(git rev-list --max-count=1 --parents $1 | {
     read hash parents
     for hash in $parents; do
         echo ^$hash
     done
})
git filter-branch --msg-filter "
     if [ \$GIT_COMMIT = $(git rev-parse $1) ]; then
         cat > tmp
         \$EDITOR tmp < $(tty) > $(tty) 2>&1
         cat tmp
     else
         cat
     fi
" $refs $parents
