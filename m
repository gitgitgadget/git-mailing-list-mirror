From: Junio C Hamano <gitster@pobox.com>
Subject: Re: behaviour of git diff, GIT_DIR & checked out tree
Date: Mon, 24 Sep 2007 09:47:08 -0700
Message-ID: <7v6420au43.fsf@gitster.siamese.dyndns.org>
References: <e1dab3980709240545o32eeefcdkd4bc67abab0e5343@mail.gmail.com>
	<Pine.LNX.4.64.0709241400410.28395@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Tweed <david.tweed@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Sep 24 18:48:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IZr6n-0005gi-Nm
	for gcvg-git-2@gmane.org; Mon, 24 Sep 2007 18:48:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763964AbXIXQrT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Sep 2007 12:47:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763578AbXIXQrS
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Sep 2007 12:47:18 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:52802 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763964AbXIXQrR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Sep 2007 12:47:17 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 2A50C13B357;
	Mon, 24 Sep 2007 12:47:32 -0400 (EDT)
In-Reply-To: <Pine.LNX.4.64.0709241400410.28395@racer.site> (Johannes
	Schindelin's message of "Mon, 24 Sep 2007 14:03:11 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59061>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Mon, 24 Sep 2007, David Tweed wrote:
>
>> ... In
>> a different directory, OUTSIDE of $HOME/V, I tried
>> 
>> env GIT_DIR=$HOME/V/.git git diff master@{midnight}
>> 
>> to get the same effect but, whilst I do get a diff output, it
>> looks like a diff of the commit against an empty tree.
>
> Yes, this is fully expected.
>
> The @{time} notation accesses the _reflogs_, which are purely local 
> beasts.  They are not transmitted when cloning.

Yeah, but my reading of the problem description suggests the two
cases refer to the same repository (hence the same reflogs).

The issue is that the second case runs "git diff <one-tree>" in
a random directory.  This form is about comparing the part of
work tree you are in with a given tree, and does not make _any_
sense when outside the work tree.  Usually without GIT_DIR
environment, the command would give you an error message.

With $GIT_DIR, but without $GIT_WORK_TREE, the user is telling
the command that it is being run at the top level of the work
tree and the repository metadata is not in the usual ".git"
subdirectory of the top level of the work tree (in this case, by
definition that is "$PWD/.git") but elsewhere where $GIT_DIR
specifies.  Because it is very likely that the files under the
random location does not share much resemblance to what are in
$HOME/V, it is not surprising that the output consisted of many
deletions.

It would be illustrative if David did the following.

	$ cd $HOME
        $ cp -a V W
        $ rm -fr W/.git
        $ cd W
        $ GIT_DIR=$HOME/V/.git git diff @{midnight}

Now we are in a random place outside of the work tree
(i.e. "W"), and we drive "git diff" with GIT_DIR specified,
telling it to pretend that we are at the top level of the work
tree.  So ~/W/frotz is compared with "frotz" at the top level of
the commit (which usually is compared with ~/V/frotz), etc.  But
the directory we happen to be in very much resembles the work
tree, so it would give identical results to

	$ cd $HOME/V
        $ git diff @{midnight}
