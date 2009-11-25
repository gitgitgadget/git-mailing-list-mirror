From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: cvsexportcommit dies when applying an (empty) merge commit
Date: Wed, 25 Nov 2009 14:06:13 +0100
Message-ID: <4B0D2BC5.1000002@drmicha.warpmail.net>
References: <4B0D1C1A.60707@yahoo.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Nick Woolley <nickwoolley@yahoo.co.uk>
X-From: git-owner@vger.kernel.org Wed Nov 25 14:07:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDHae-0006Yy-HG
	for gcvg-git-2@lo.gmane.org; Wed, 25 Nov 2009 14:07:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934689AbZKYNHO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2009 08:07:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934662AbZKYNHN
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Nov 2009 08:07:13 -0500
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:45006 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S934675AbZKYNHM (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Nov 2009 08:07:12 -0500
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id BD043C1BF8;
	Wed, 25 Nov 2009 08:07:18 -0500 (EST)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Wed, 25 Nov 2009 08:07:18 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=/GWD0KSSbsGudHJWPkY++ubju4o=; b=rClo5SQ0vfDxP/GsIuC63iOx6gCfhIyb60yD1gNPGOvETLPuLV2O9YgBzI2FaAyQSKOtGnZcrCDbZQ2f/oPaO1lL2K1subQDM3Jjm9lqqIb+Uwn5OgaPzfivMoUNfqcLVPpV2X76rslZ0GNusmmRBmlAjSJoVsm6XOOeu/pTwrc=
X-Sasl-enc: bjKLVP4K2sSJBxl0A0o29+kTVxWfd9fP2LGz15Iydd1Q 1259154438
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 17C705C471;
	Wed, 25 Nov 2009 08:07:17 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.6pre) Gecko/20091125 Lightning/1.0pre Shredder/3.0.1pre
In-Reply-To: <4B0D1C1A.60707@yahoo.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133637>

Nick Woolley venit, vidit, dixit 25.11.2009 12:59:
> Hi,
> 
> I have a git repository with a merge point on the master branch.  This merge
> commit is empty, and just contains a commit message:
> 
>   Merge commit 'otherbranch'
> 
> I'm trying to export this branch into CVS using git-cvsexportcommit (the latest
> version from the master branch). It's actually done in a wrapper script [1] but
> the command that gets invoked is essentially:
> 
>  git cvsexportcommit -p -v -u -w  'cvscheckout/HEAD/my-cvs-module' -c \
>     <parent commit> <commit>
> 
> Where <commit> is the empty merge commit.  However this invocation dies and
> aborts the process of exporting the branch half way.
> 
> The fatal error I get is:
> 
>  Applying to CVS commit <commit> from parent <parent commit>
>  Checking if patch will apply
>  Applying
>  error: No changes
>  cannot patch at /usr/lib/git-core/git-cvsexportcommit line 324.
> 
> The vicinity of line 324 is (with some lines wrapped):
> 
>  print "Applying\n";
>  if ($opt_W) {
>      system("git checkout -q $commit^0") && die "cannot patch";
>  } else {
>      `GIT_DIR= git-apply $context --summary --numstat --apply
> <.cvsexportcommit.diff` || die "cannot patch";
>  }
> 
> It seems that the file .cvsexportcommit.diff is empty, so git-apply is refusing
> to apply it.
> 
> Presumably the application would be a no-op, so this git-apply step could be
> skipped.  So I tried modifying the script to do that and it seems to work:
> 
>  print "Applying\n";
>  if ($opt_W) {
>      system("git checkout -q $commit^0") && die "cannot patch";
>  } elsif (-s ".cvsexportcommit.diff") {
>      `GIT_DIR= git-apply $context --summary --numstat --apply
> <.cvsexportcommit.diff` || die "cannot patch";
>  } else {
>     print "No changes\n";
>  }
> 
> The modified git-cvsexportcommit script completes without errors, but
> unsurprisingly, seems to export nothing, so that when imported back into git,
> there is no empty commit.  There appears to be no log message added in CVS, either.
> 
> This does seem more acceptable than dying, although it doesn't faithfully
> reproduce the git history.  However I'm not sure if that would be possible in
> this case.
> 
> Is the existing behaviour deliberately fatal, or is this worth supplying a patch
> for?

I think the behavior is correct in the sense that you're telling git
cvsexportcommit to make a commit to cvs, and it can't, because there is
no change to commit. A merge can't be represented.

It leaves you the choice between omitting the trivial merge from cvs
history (that's what one would do for a merge based cvs<->git workflow)
and generating a fake commit in cvs. I don't know if it has something
like --allow-empty - it's file base, after all.

Michael
