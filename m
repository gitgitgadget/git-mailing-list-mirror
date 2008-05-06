From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: [PATCH] Use perl instead of tac
Date: Tue, 6 May 2008 00:32:02 -0400
Message-ID: <638987EF-5822-4CC6-A895-5650A3237603@silverinsanity.com>
References: <8D73338C-4EC3-4078-8A34-51DAC1842C2B@silverinsanity.com> <20080427064250.GA5455@sigill.intra.peff.net> <739FA851-F7F5-4CF9-B384-25AA7022B0C2@silverinsanity.com> <slrng1be8l.25r.joerg@alea.gnuu.de> <86k5iib0g9.fsf@blue.stonehenge.com> <slrng1bqhb.25r.joerg@alea.gnuu.de> <04EB077D-CB35-4253-A9EA-2085890C3639@silverinsanity.com> <20080430090206.GA21826@alea.gnuu.de> <5374CF8E-3E6E-480B-A23B-13BE85C7ABCF@silverinsanity.com> <20080504221319.GA14584@alea.gnuu.de>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?ISO-8859-1?Q?J=F6rg_Sommer?= <joerg@alea.gnuu.de>
X-From: git-owner@vger.kernel.org Tue May 06 06:33:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JtErW-0006eM-Ni
	for gcvg-git-2@gmane.org; Tue, 06 May 2008 06:33:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751046AbYEFEcK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 May 2008 00:32:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750839AbYEFEcJ
	(ORCPT <rfc822;git-outgoing>); Tue, 6 May 2008 00:32:09 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:54166 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750822AbYEFEcI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 May 2008 00:32:08 -0400
Received: from [192.168.1.7] (cpe-69-205-115-17.rochester.res.rr.com [69.205.115.17])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id A012D1FFC250;
	Tue,  6 May 2008 04:31:54 +0000 (UTC)
In-Reply-To: <20080504221319.GA14584@alea.gnuu.de>
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81328>


On May 4, 2008, at 6:13 PM, J=F6rg Sommer wrote:

> Hallo Brian,
>
> Brian Gernhardt schrieb am Wed 30. Apr, 11:25 (-0400):
>> On Apr 30, 2008, at 5:02 AM, J=F6rg Sommer wrote:
>>> Yes. How to get all tags of a commit?
>>>
>>> % git tag foo v1.5.5
>>> % git describe --exact-match 9d831805195ba40b62f632acc6bb6e53d3
>>> warning: tag 'v1.5.5' is really 'foo' here
>>> v1.5.5
>
> And how can I get only tags no annotated tags? We can't recreate
> annotated tags with git rebase.

Yes, the tag list has to stay.  I had missed several bits of what it =20
was trying to do.

>> Those concerns being: overrunning the length of a shell variable,
>
> Are you shure there is any such bounding? I didn't saw anything =20
> about the
> size of a variables in IEEE 1003.1-2004, but didn't look very =20
> carfully.
> All my shells (bash, dash, zsh) can handle more than 16777217 =20
> characters:
>
> dash -c 'a=3Da; while :; do a=3D$a$a; echo $a | wc -c; done'

My concern is that some shell somewhere (like the ever problematic =20
Solaris) would have a limit and it would silently fail.  It may be an =20
unfounded concern, but I thought I'd mention it to the list and see if =
=20
anyone agreed.

> This would be a new version of create_extended_todo_list() without =20
> tac.
> What do you think about it? Is it better readable? But there's a bug.

I find it more readable and am pleased about the lack of perl and tac.

> create_extended_todo_list () {
> 	# The idea of this function is to
> 	# 1. build a list of tags
> 	# 2. go through the list and
> 	#    * issue a reset command to the parent of the commit, if the las=
t
> 	#      commit was not the parent of the current commit,
> 	#    * issue a pick command for simple commits,
> 	#    * issue for each merge commit a merge command with the hashs of
> 	#      the parent commits,
> 	#    * register each parent of a merge and issue a mark command
> 	#      (without an ID) after the commit for each registered commit =20
> and
> 	#    * issue a tag command, if the commit is in the tag list.
> 	# 3. Then go through the created list and
> 	#    * add an ID to each mark command and
> 	#    * replace all occurences of the hash in reset and merge command=
s
> 	#      by the mark ID

Comment is excellent, although I'd prefer that the three parts were =20
simply next to the code they're referring to.

> 	test -e "$DOTEST"/cetl.tmp \
> 		&& die "Someone else uses our filename cetl.tmp." \
> 			"That's not nice"

Is this just to catch a bug where another part of rebase -i uses the =20
same file?  Or is there a way this could be triggered by user =20
actions?  (I am under the impression that we'd never get this far if =20
$DOTEST already existed.)

> 	mark_these_commits=3D
> 	while IFS=3D_ read commit parents subject
> 	do
> 		first_parent=3D${parents%% *}
> 		if test "${last_commit:-$SHORTUPSTREAM}" !=3D $first_parent
> 		then
> 			test "$first_parent" =3D $SHORTUPSTREAM &&
> 				first_parent=3D$SHORTONTO
> 			echo reset $first_parent
> 		fi
> 		unset first_parent
> 		last_commit=3D$commit
>
> 		case "$parents" in
> 		*' '*)
> 			new_parents=3D
> 			for p in $parents
> 			do

To avoid unneeded marks, you need one more variable and an if =20
statement.  Instead of unconditionally marking every parent, keep =20
track of the previous commit and add a line like this:

                                if test "$p" !=3D "$prev_commit"
                                then
> 				mark_these_commits=3D$(insert_value_at_key_into_list \
> 					"$commit" "$p" "$mark_these_commits")
                                fi
>
> 				if test "$p" =3D $SHORTUPSTREAM
> 				then
> 					new_parents=3D"$new_parents $SHORTONTO"
> 				else
> 					new_parents=3D"$new_parents $p"
> 				fi
> 			done
> 			unset p
> 			echo merge $commit ${new_parents# * }
> 			unset new_parents
> 			;;
> 		*)
> 			echo "pick $commit $subject"
> 			;;
> 		esac
>
> 		if tmp=3D$(get_value_from_list $commit "$tag_list")
> 		then
> 			for t in $(echo $tmp | tr : ' ')
> 			do
> 				echo tag $t
> 			done
> 		fi
>
> 	done > "$DOTEST"/cetl.tmp
> 	unset commit parents subject
>
> 	commit_mark_list=3D
> 	next_mark=3D0
> 	last_commit=3D
> 	while read cmd args

I'd personally do "cat cetl.tmp | while" instead of "while .... done < =
=20
cetl.tmp", just so that where we're reading from is obvious from the =20
start.

> The problem is the mark command. If you walk from ONTO to HEAD =20
> trough the
> list, you must know for a commit, if it is used _later_. But don't =20
> create
> a mark if it is used immediately, e.g. pick; merge not pick; mark; =20
> merge.
>
> If you walk from HEAD to ONTO, this is much easier. I delayed the mar=
k
> for the first head of a merge and checked if the next commit is this
> commit. This way I keep the todo list clean and don't get something =20
> like
> this for --first-parent:
>
> pick abc
> pick def
> mark :0
> merge 012 foreign-branch

(See above.)

~~ Brian