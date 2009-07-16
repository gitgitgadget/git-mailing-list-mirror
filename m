From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: [PATCHv2 2/2] pull: support rebased upstream + fetch + pull 
	--rebase
Date: Thu, 16 Jul 2009 18:32:39 +0200
Message-ID: <adf1fd3d0907160932r313de6e8lec23e4f3409b8c05@mail.gmail.com>
References: <adf1fd3d0907152329v7f49999u42b0d0fc4d39f5e9@mail.gmail.com>
	 <1247731921-2290-1-git-send-email-santi@agolina.net>
	 <alpine.DEB.1.00.0907161035060.3155@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 16 18:32:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MRTt4-0006WC-Ft
	for gcvg-git-2@gmane.org; Thu, 16 Jul 2009 18:32:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932695AbZGPQcm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 16 Jul 2009 12:32:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932664AbZGPQcm
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Jul 2009 12:32:42 -0400
Received: from mail-bw0-f228.google.com ([209.85.218.228]:49369 "EHLO
	mail-bw0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932651AbZGPQcl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 Jul 2009 12:32:41 -0400
Received: by bwz28 with SMTP id 28so232356bwz.37
        for <git@vger.kernel.org>; Thu, 16 Jul 2009 09:32:39 -0700 (PDT)
Received: by 10.204.124.7 with SMTP id s7mr8854448bkr.105.1247761959621; Thu, 
	16 Jul 2009 09:32:39 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0907161035060.3155@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123408>

2009/7/16 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
> Hi,
>
> On Thu, 16 Jul 2009, Santi B=E9jar wrote:
>
>> Use the fork commit of the current branch (where
>> the tip of upstream branch used to be) as the upstream parameter of
>> "git rebase". Compute it walking the reflog to find the first commit
>> which is an ancestor of the current branch.
>
> I finally understand what this patch is about. =A0Thanks.

Thanks, it was hard (at least for me) to provide a short and good
commit message.

>
>> diff --git a/git-pull.sh b/git-pull.sh
>> index 4b78a0c..31d3945 100755
>> --- a/git-pull.sh
>> +++ b/git-pull.sh
>> @@ -125,9 +125,14 @@ test true =3D "$rebase" && {
>> =A0 =A0 =A0 die "refusing to pull with rebase: your working tree is =
not up-to-date"
>>
>> =A0 =A0 =A0 . git-parse-remote &&
>> - =A0 =A0 reflist=3D"$(get_remote_merge_branch "$@" 2>/dev/null)" &&
>> - =A0 =A0 oldremoteref=3D"$(git rev-parse -q --verify \
>> - =A0 =A0 =A0 =A0 =A0 =A0 "$reflist")"
>> + =A0 =A0 remoteref=3D"$(get_remote_merge_branch "$@" 2>/dev/null)" =
&&
>> + =A0 =A0 num=3D0 &&
>> + =A0 =A0 while oldremoteref=3D"$(git rev-parse -q --verify "$remote=
ref@{$num}")"
>> + =A0 =A0 do
>
> How about
>
> =A0 =A0 =A0 =A0oldremoteref=3D"$(git rev-list --boundary HEAD --not \
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0$(git rev-list -g $rem=
oteref | sed 's/$/^@/') |
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sed -e '/^[^-]/d' -e q)"
>
> Explanation: the "git rev-list -g $remoteref" lists the previous comm=
its
> the remote ref pointed to, and the ^@ appended to them means all thei=
r
> parents. =A0Now, the outer rev-list says to take everything in HEAD b=
ut
> _not_ in those parents, showing the boundary commits. =A0The "sed" ca=
ll
> lists the first such boundary commit (which must, by construction, be=
 one
> of the commits shown by the first rev-list).

It almost works, thanks. In fact this is how I represent it in my
head, but I couldn't find a working command (hint, hint, the
--boundaries trick). Based on yours here it is the one I am using
right now:

	oldremoteref=3D"$(git rev-list --boundary HEAD --not \
		$(git rev-list -g $remoteref 2>/dev/null) |
		sed -e '/^[^-]/d' -e 's/^-//;q' )"

i.e. without the ^@ as you want the commits in the reflog as boundary
commits, and also remove the - in front of the commit.

Your version performs equally than mine for the normal case but much
better if it has to walk many reflog entries. Also mine has the
problem, at least currently, that it does not give up as "git
rev-parse -q --verify $branch@{n}" does not return an error when n is
too large:

  $ git rev-parse -q --verify origin/next@{18} ; echo $?
warning: Log for 'origin/next' only has 17 entries.
37eb784cfce07ba0048d64e352c5137454396d87
0

even with "-q --verify"!

So, I'll take yours and will send an updated patch (saying that is is
based on a command by you). With your Signed-off-by?

Thanks,
Santi
