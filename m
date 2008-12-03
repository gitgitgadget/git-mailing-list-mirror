From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] git-svn: Make branch use correct svn-remote
Date: Wed, 03 Dec 2008 10:33:13 +0100
Message-ID: <49365259.5090803@drmicha.warpmail.net>
References: <1228185780-22938-1-git-send-email-deskinm@umich.edu> <20081202215157.GB9650@hand.yhbt.net> <7vbpvtj4kl.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Wong <normalperson@yhbt.net>,
	Deskin Miller <deskinm@umich.edu>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Dec 03 10:34:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7o7x-0008HC-2B
	for gcvg-git-2@gmane.org; Wed, 03 Dec 2008 10:34:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751096AbYLCJdU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2008 04:33:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751079AbYLCJdU
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Dec 2008 04:33:20 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:54676 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751078AbYLCJdT (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Dec 2008 04:33:19 -0500
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id A27F51CAF08;
	Wed,  3 Dec 2008 04:33:18 -0500 (EST)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Wed, 03 Dec 2008 04:33:18 -0500
X-Sasl-enc: pJyCqUsujeDzJxM0itK0QZTDYS6Hgn5TVSl8CPfAc3Mj 1228296798
Received: from [139.174.44.12] (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id C72A6167DC;
	Wed,  3 Dec 2008 04:33:17 -0500 (EST)
User-Agent: Thunderbird 2.0.0.18 (X11/20081105)
In-Reply-To: <7vbpvtj4kl.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102234>

Junio C Hamano venit, vidit, dixit 03.12.2008 04:55:
> Eric Wong <normalperson@yhbt.net> writes:
> 
>> Deskin Miller <deskinm@umich.edu> wrote:
>>> The 'branch' subcommand incorrectly had the svn-remote to use hardcoded
>>> as 'svn', the default remote name.  This meant that branches derived
>>> from other svn-remotes would try to use the branch and tag configuration
>>> for the 'svn' remote, potentially copying would-be branches to the wrong
>>> place in SVN, into the branch namespace for another project.
>>>
>>> Fix this by using the remote name extracted from the svn info for the
>>> specified git ref.  Add a testcase for this behaviour.
>>>
>>> Signed-off-by: Deskin Miller <deskinm@umich.edu>
>> Looks alright to me, thanks Deskin.
>>
>> Acked-by: Eric Wong <normalperson@yhbt.net>
> 
> Does not work for me X-<.
> 
> * expecting success:
>         (svn co "$svnrepo" svn &&
>         cd svn &&
>         mkdir mirror &&
>         svn add mirror &&
>         svn copy trunk tags branches mirror/ &&
>         svn ci -m "made mirror" ) &&
>         rm -rf svn &&
>         git svn init -s -R mirror --prefix=mirror/ "$svnrepo"/mirror &&
>         git svn fetch -R mirror &&
>         git checkout mirror/trunk &&
>         base=$(git rev-parse HEAD:) &&
>         git svn branch -m "branch in mirror" d &&
>         test $base = $(git rev-parse remotes/mirror/d:) &&
>         test_must_fail git rev-parse remotes/d
> 
> A    svn/trunk
> A    svn/trunk/foo
> A    svn/branches
> A    svn/branches/a
> A    svn/branches/a/foo
> A    svn/branches/b
> A    svn/branches/b/foo
> A    svn/tags
> A    svn/tags/tag4
> A    svn/tags/tag4/foo
> A    svn/tags/tag1
> A    svn/tags/tag1/foo
> A    svn/tags/tag2
> A    svn/tags/tag2/foo
> A    svn/tags/tag3
> A    svn/tags/tag3/foo
> Checked out revision 8.
> A         mirror
> svn: Client error in parsing arguments
> * FAIL 4: branch uses correct svn-remote
> 
>                 (svn co "$svnrepo" svn &&
>                 cd svn &&
>                 mkdir mirror &&
>                 svn add mirror &&
>                 svn copy trunk tags branches mirror/ &&

With my svn (1.4.6) it fails already here: "svn copy" allows two
arguments only. That may be different in svn 1.5.

>                 svn ci -m "made mirror" ) &&
>                 rm -rf svn &&
>                 git svn init -s -R mirror --prefix=mirror/ "$svnrepo"/mirror &&
>                 git svn fetch -R mirror &&
>                 git checkout mirror/trunk &&
>                 base=$(git rev-parse HEAD:) &&
>                 git svn branch -m "branch in mirror" d &&
>                 test $base = $(git rev-parse remotes/mirror/d:) &&
>                 test_must_fail git rev-parse remotes/d

If I split the above copy into three lines then the test passes (svn
1.4.6, Deskin's patch applied onto 1.6.1-rc1 with the fix.

Patch coming. (Sorry I always forget the ccs with send-email.)

Michael
