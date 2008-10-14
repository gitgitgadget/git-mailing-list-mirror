From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [BUG?] git remote rm repo nukes local refs for mirror repo
Date: Tue, 14 Oct 2008 13:34:00 +0200
Message-ID: <48F483A8.4070103@drmicha.warpmail.net>
References: <48F460DB.9030209@drmicha.warpmail.net> <alpine.DEB.1.00.0810141131130.22125@pacific.mpi-cbg.de.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Oct 14 13:35:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KpiBM-0002zb-LP
	for gcvg-git-2@gmane.org; Tue, 14 Oct 2008 13:35:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755247AbYJNLeI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Oct 2008 07:34:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755084AbYJNLeH
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Oct 2008 07:34:07 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:40080 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754648AbYJNLeG (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Oct 2008 07:34:06 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 9BB5717B6DF;
	Tue, 14 Oct 2008 07:34:03 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Tue, 14 Oct 2008 07:34:03 -0400
X-Sasl-enc: WbwksqYnMdEfnVRyAqr1QHBYWA1UZOBkhctx0SivlUCP 1223984042
Received: from [139.174.44.12] (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id B81532C08B;
	Tue, 14 Oct 2008 07:34:02 -0400 (EDT)
User-Agent: Thunderbird 2.0.0.17 (X11/20080914)
In-Reply-To: <alpine.DEB.1.00.0810141131130.22125@pacific.mpi-cbg.de.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98181>

Johannes Schindelin venit, vidit, dixit 14.10.2008 11:32:
> Hi,
> 
> On Tue, 14 Oct 2008, Michael J Gruber wrote:
> 
>> I just noticed the hard way that "git remote rm repo" nukes all local 
>> (mirrored) refs if repo had been setup with "git remote add --mirror 
>> repo url".
>>
>> Some may argue that this behaviour fits the description "deletes all 
>> remote tracking branches" but I would claim it does not: mirrored 
>> branches are not remote tracking branches in the proper sense.
> 
> Count me into the former group.  If you set up a "--mirror" repository, it 
> defeats the purpose to mix that with _true_ local branches.
> 
> I'd color this a pilot error,
> Dscho

OK, I'll give some background about the motivation:

I have a "local" repo.
I want to create a "backup repo" which contains the same branches
(including proper remotes, svn remotes).

So, I create an empty bare repo somewhere (say store:backuprepo.git),
and in the local repo I do:

git remote add --mirror backup store:backuprepo.git
git push backup

I need "mirror=true" because otherwise branches are not created
automatically (on push) on the remote side. I need the '+refs/*:refs/*'
refspec because otherwise not all refs are mirrored. But now I can't use
"git remote rm backup" to remove the configuration because that would
take away all my local branches, too.

Instead, I could set up things with

git remote add backup store:backuprepo.git
git config remote.backup.push '+refs/*:refs/*'

Then all branches are mirrored on the remote automatically. But
interesting things happen after fetch and push... Read "recursion". So,
in order to avoid any remote/backup/foo branches on the local side I
would have to use

git remote add backup store:backuprepo.git
git config remote.backup.push '+refs/*:refs/*'
git config --unset remote.backup.fetch

in order to create a "backup remote" configuration. Maybe I'm just being
dense (which is actually OK for a functional analyst); I'd be happy
about any more direct solution. At least I think there should be one, a
backup bare remote mirror is a common use case, and the config massaging
above is not something to recommend to novice users.

Michael

P.S.: Yeah I know, git's no backup tool, there's rsync... ;)
