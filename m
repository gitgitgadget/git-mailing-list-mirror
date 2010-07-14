From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: git rebase does not understand --work-tree
Date: Wed, 14 Jul 2010 14:54:46 +0200
Message-ID: <4C3DB396.2040109@drmicha.warpmail.net>
References: <AANLkTimnk6tflv9ZZCydlX1la35GjsRfvjgTk44uDFbO@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Alexander Gladysh <agladysh@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 14 14:56:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OZ1VH-0006nl-P7
	for gcvg-git-2@lo.gmane.org; Wed, 14 Jul 2010 14:56:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756570Ab0GNMzy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jul 2010 08:55:54 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:46416 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754703Ab0GNMzy (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Jul 2010 08:55:54 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id D7F8F16F08A;
	Wed, 14 Jul 2010 08:55:48 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Wed, 14 Jul 2010 08:55:48 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=agNlRk8O3TMou7Oh/vkjLbCyaZc=; b=abqO2xLQA5sV5av4soqbKpEyMCLRdwCQ3gntcVFh2uYcjm20nn7HeMDP3g6hpw3tN6xCDiAHBukzBpze75OwqBzHy486rAkfgMZFleqrTH5QEUCJ92TmCYjKmJcq/RP4IFUIOXhTqb6O5UgrI2lBCPsSBg0erW2BgCujNfgEf5c=
X-Sasl-enc: SRMul21cukL91rO3VpHC6bu1qYQcEnO5iGUrUHMtWePu 1279112147
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id F1FD94DD17;
	Wed, 14 Jul 2010 08:55:46 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.8pre) Gecko/20100714 Lightning/1.0b2pre Lanikai/3.1.2pre
In-Reply-To: <AANLkTimnk6tflv9ZZCydlX1la35GjsRfvjgTk44uDFbO@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150984>

Alexander Gladysh venit, vidit, dixit 14.07.2010 11:04:
> Hi, list!
> 
> $ git --version
> git version 1.7.1.1
> 
> I often use --work-tree and --git-dir to avoid doing cd in my scripts.
> 
> However, I've found that git rebase does not understand --work-tree
> option (see test below). Is this fixable?
> 
> Thanks,
> Alexander.

In your case, omitting --work-tree almost works, as well as using
"--work-tree=." (note the dot). "Almost" meaning that rebase does not
complain. It just doesn't find the work-tree.

I think the main problem here is a problem with relative work trees.

First of all, work tree is meant to be relative to (the repo specified
by) GIT_DIR, but that's not what "git rev-parse --top-level" is doing.
Experimenting with relative --git-dir and --work-tree here shows that
it's relative to cwd.

Second, several git shell commands (such as rebase) cd to the toplevel
of the repo only after checking whether we are in a work tree already.
This is brain dead and should be cured by the upcoming patch. With that,
absolute paths for work-tree will work with rebase.

Third, git's setup code exports GIT_DIR as an absolute path but
GIT_WORK_TREE as a relative path. Together with the fact that the work
tree is interpreted relative to the current directory, this is doomed
for failure when you cd around - as rebase does automatically!

I'm not sure I find time for the latter point, but until then the patch
enables you to work with absolute paths.

Michael
