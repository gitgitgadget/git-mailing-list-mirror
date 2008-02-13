From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: git-branch -m interprets first argument differently when two are
 supplied
Date: Wed, 13 Feb 2008 13:48:10 -0600
Message-ID: <47B3497A.9050703@nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Feb 13 20:48:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPNb8-0003GM-St
	for gcvg-git-2@gmane.org; Wed, 13 Feb 2008 20:48:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751272AbYBMTsR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Feb 2008 14:48:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752341AbYBMTsR
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Feb 2008 14:48:17 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:47432 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751009AbYBMTsQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Feb 2008 14:48:16 -0500
Received: from starfish.gems.nrlssc.navy.mil (localhost [127.0.0.1])
	by mail.nrlssc.navy.mil (8.13.7/8.13.7) with ESMTP id m1DJmBOZ019872
	for <git@vger.kernel.org>; Wed, 13 Feb 2008 13:48:12 -0600
Received: from tick.nrlssc.navy.mil ([128.160.25.48]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 13 Feb 2008 13:48:10 -0600
User-Agent: Thunderbird 2.0.0.9 (X11/20071031)
X-OriginalArrivalTime: 13 Feb 2008 19:48:10.0508 (UTC) FILETIME=[5CAE3CC0:01C86E79]
X-TM-AS-Product-Ver: : ISVW-6.0.0.2339-5.0.0.1023-15722001
X-TM-AS-Result: : Yes--8.318400-0-31-1
X-TM-AS-Category-Info: : 31:0.000000
X-TM-AS-MatchedID: : =?us-ascii?B?NzEwOTg5LTcwNDcxMi03MDEy?=
	=?us-ascii?B?MzYtNzAyMTEzLTcwNTEwMi03MDE2MTgtNzAyNzI2LTcwMjA1MC03?=
	=?us-ascii?B?MDgxNzktNzA2MjQ5LTcwNzQ1MS0xMTE2MDQtNzAyMTQzLTcwNzc1?=
	=?us-ascii?B?MC03MDU5MDEtNzA0MDQ4LTcwMzQzNS03MDMxNTctNzAzNzEyLTcw?=
	=?us-ascii?B?MTQ1NS03MDczNjEtMTg3MDY3LTcwMjA0NC0xMTMyMTEtNzAzNDU0?=
	=?us-ascii?B?LTcwMzA4OC03MDA3MjYtNzAzNzg4LTcwNDQyNS03MDUzODgtNzA0?=
	=?us-ascii?B?MDQ5LTcwMjYzOC0xMDU3MDAtMTg4MDE5LTcwNjg5MS03MDA3ODIt?=
	=?us-ascii?B?NzAxODM3LTcwNTQ3NS0xNDgwMzktMTQ4MDUx?=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73815>


If 'git-branch -m' is supplied one argument, it changes the name of the
current branch to the name of the argument.

If two arguments are supplied, then the first argument is interpreted
as the branch whose name is to be changed, and the second argument is
the name to change it to.

The first non-option argument is interpreted differently depending on
whether one argument or two arguments have been supplied.

	git-branch -m [<oldbranch>] <newbranch>

Has anyone considered whether this is inconsistent with how other
commands operate?

For example, these commands always interpret the first argument
consistently. If a second argument is supplied, it modifies the
base or the reference from which to run the command.

	git-rebase <upstream> [<branch>]
	git-cherry <upstream> [<head>] [<limit.]
	git-tag <name> [<head>]
	git-update-ref <ref> <newvalue> [<oldvalue>]

or even

	git-branch <branchname> [<start-point>]

It's hard to describe, but I have learned to think about the ordering
of arguments (especially for rebase and cherry), by thinking about
how the single argument case would operate. For rebase, if only one
argument is supplied, you know that the thing you are rebasing is
the current branch, that's the only way it makes sense.

If I am _not_ on the branch I want to rebase, it may be tempting to
think that rebase works like:

	rebase <this> <on_to_this>

So if I am not on the branch, I think about how arguments would be
supplied if I _were_ on the branch I wanted to rebase. Then it is
clear how to specify the branch I want to rebase, namely that <this>
should be the second argument.

For 'git-branch -m', this relationship is broken. So I can't think
"How would this operate if I were on the branch whose name I'd like
to change", and then append the name, since when two arguments are
supplied the new branch name is the _second_ argument.

I guess maybe

	git-branch -m <oldname> <newname>

is supposed to work like

	mv <oldname> <newname>

but then the same could be said about the others too.

	rebase <this> <on_top_of_this>
	cherry <whats_in_here> <but_not_in_here>
	...

I'm not suggesting we change the 'branch -m' behavior, just pointing
out that it seems inconsistent and broke my git intuition. Maybe
someone can point out a thinko on my part.

-brandon
