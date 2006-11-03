X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: git bug? + question
Date: Fri, 03 Nov 2006 00:51:32 -0800
Message-ID: <7v3b90gbfv.fsf@assigned-by-dhcp.cox.net>
References: <buoejsme6ho.fsf@dhapc248.dev.necel.com>
	<7v4pthmew1.fsf@assigned-by-dhcp.cox.net>
	<20061103074857.GA15972@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Fri, 3 Nov 2006 08:52:07 +0000 (UTC)
Cc: Miles Bader <miles@gnu.org>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061103074857.GA15972@diana.vm.bytemark.co.uk> (Karl
	=?iso-8859-1?Q?Hasselstr=F6m's?= message of "Fri, 3 Nov 2006 08:48:57
 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30799>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gfum2-00059f-CR for gcvg-git@gmane.org; Fri, 03 Nov
 2006 09:51:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751026AbWKCIvf convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Fri, 3 Nov 2006 03:51:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752331AbWKCIvf
 (ORCPT <rfc822;git-outgoing>); Fri, 3 Nov 2006 03:51:35 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:38098 "EHLO
 fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP id S1751026AbWKCIve
 convert rfc822-to-8bit (ORCPT <rfc822;git@vger.kernel.org>); Fri, 3 Nov 2006
 03:51:34 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao07.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061103085133.CVIC13632.fed1rmmtao07.cox.net@fed1rmimpo02.cox.net>; Fri, 3
 Nov 2006 03:51:33 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id i8re1V0071kojtg0000000 Fri, 03 Nov 2006
 03:51:38 -0500
To: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Sender: git-owner@vger.kernel.org

Karl Hasselstr=F6m <kha@treskal.com> writes:

> On 2006-11-02 18:40:30 -0800, Junio C Hamano wrote:
>
>> I still need to remember to process "master" first, so all things
>> considered, this is a regression in usability for my workflow.
>
> Where does this constraint come from?

    With separate remotes, I'd need something like:

            for b in master maint next pu
            do
                    git checkout $b && git pull && make || break
            done

    And I also would need to have per-branch configuration to merge
    from ". remotes/origin/$b" without re-fetching while on a
    non-master branch $b, for the above to work.  I still need to
    remember to process "master" first, so all things considered,
    this is a regression in usability for my workflow.

Because I'll have to have the per-branch configuration that
would say something like this:

	[remote."gitster"]
		url =3D gitster.example.com:/home/junio/git.git/
        	fetch =3D heads/maint:remotes/gitster/maint
        	fetch =3D heads/master:remotes/gitster/master
        	fetch =3D heads/next:remotes/gitster/next
        	fetch =3D +heads/pu:remotes/gitster/pu

	[branch."master"]
        	remote =3D gitster
                merge =3D heads/master
	[branch."maint"]
        	remote =3D .
                merge =3D remotes/gitster/maint
	[branch."next"]
        	remote =3D .
                merge =3D remotes/gitster/next
	...

Side note: the above would not actually work because I am
missing an earlier patch by Santi to special case 'dot' as the
value of "branch.$name.remote", but I think you get the idea.

This requires that by the time we update maint, next and pu
branches with what is in the upstream, their corresponding
remotes/gitster/* branches are already up-to-date and do not
have to be re-fetched, and processing master first is what
guarantees it.

I do not mind treating "master" specially at all; my otherwise
idle repositories with working tree (read: ones on secondary
machines I use primarily to build git binary for that machine or
that platform, not to develop on) always have "master" checked
out; I start working in them while "master" is checked out, and
I'll be on "master" before I leave that machine.

If I keep using the traditional layout, where master is fetched
to origin and next, maint and pu are used to track the remote, I
do not have to do any of the above remote/branch configuration
in the .git/config file, and after one "git pull" while on
"master", I'd have all four branches up to date, ready to be
checked out and compiled.

But I suspect this "following multiple branches at the same
time, switch between them only to compile, test and install but
never develop on them" workflow is rather specific to top-level
maintainer's workflow and that is why I said defaulting to
separate-remote would be an inconvenience to a minority.
