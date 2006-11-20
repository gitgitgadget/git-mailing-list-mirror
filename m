X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: Rename detection at git log
Date: Mon, 20 Nov 2006 13:16:20 +0100
Message-ID: <200611201216.21752.andyparkins@gmail.com>
References: <200611201157.23680.litvinov2004@gmail.com> <7virha4cnm.fsf@assigned-by-dhcp.cox.net> <7vfyce2w7d.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 20 Nov 2006 12:16:49 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Eb3Babljj7KYHP3mHlI3Axh1PItticR+XmgtenmoVRRZgVCetteP2b1i3r1dnNTDCSPVqVhCen11JlZQ3Co6B5M/aauSoj1p+To/U3FTrR96ihzeZteYmasAzUEfNCRvh7llOFcrHbzZG0x78YSOvKGi+gByUm3rhawd0dw5GT0=
User-Agent: KMail/1.9.5
In-Reply-To: <7vfyce2w7d.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31910>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gm84e-00035M-Mb for gcvg-git@gmane.org; Mon, 20 Nov
 2006 13:16:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S934111AbWKTMQ3 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 20 Nov 2006
 07:16:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934112AbWKTMQ3
 (ORCPT <rfc822;git-outgoing>); Mon, 20 Nov 2006 07:16:29 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:24359 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S934111AbWKTMQ2
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 20 Nov 2006 07:16:28 -0500
Received: by ug-out-1314.google.com with SMTP id m3so1155745ugc for
 <git@vger.kernel.org>; Mon, 20 Nov 2006 04:16:27 -0800 (PST)
Received: by 10.67.119.9 with SMTP id w9mr7739942ugm.1164024986822; Mon, 20
 Nov 2006 04:16:26 -0800 (PST)
Received: from dvr.360vision.com ( [194.70.53.227]) by mx.google.com with
 ESMTP id m4sm7596428ugc.2006.11.20.04.16.24; Mon, 20 Nov 2006 04:16:26 -0800
 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On Monday 2006 November 20 11:28, Junio C Hamano wrote:

> If people are well disciplined, code refactoring (which can
> trigger rename/copy detection) tend to affect both source and
> destination files at the same time, so many times -C finds what
> you want without --find-copies-harder.

That's true; however, I don't think that refactoring is the common operation.  
Usually it's (as Jakub says) copy-and-modify-the-copy.  In that case the 
original is untouched.

> Having said all that, I think the rename/copy as a wholesale
> operation on one file is an uninteresting special case.  The
> generic case that happens far more often in practice is the
> lines moving around across files, and the new "git blame" gives
> you better picture to answer "where the heck did this come from"
> question.

To help the version control system underneath, I have always obeyed the 
discipline of not to copy/move and modify in the same commit.  git has the 
potential to remove this necessity, but I'd still like all my old commits to 
have the copies detected correctly.

As an example: I've got a colleague who works on a project where each new 
version begins as a copy of the old one (it's not the way I'd work, but I 
think git is flexible enough to cope with anything).  So, project1/ exists 
and is copied to project2/ to begin work.  I suppose this is effectively 
branching using the filesystem rather than the version control system.  I 
noticed (and was surprised) that git didn't detect this as a copy.  No files 
were changed in the copy, so I thought git would easily spot this.

The problem is that the next project can be a copy of either project1/ or 
project2/.  All this has already gone on for a few years.  I've recently 
imported this into git and was examining the history.  I wanted to know for a 
particular subdirectory (of many) which of the others it was based off.  I 
was in qgit, and found that the commit didn't show as a copy, it showed as a 
create, and hence I couldn't tell which was the parent project.  It's a shame 
because all the mechanisms are there to show the operation, it just isn't 
shown (without --find-copies-harder).

git-blame is obviously of huge use for these detailed analyses of individual 
line history.  However, in the simple case of a commit being a 100% copy of 
another file, git lets me down.  In fact, in the case described above, it 
wouldn't necessarily help me.  What if it went like this:

project1/ copied to project2/
project2/ copied to project3/

git-blame on a file in project3/ will show that its contents came from a 
project1 commit, whereas I want to know it's direct parent.


Andy
-- 
Dr Andy Parkins, M Eng (hons), MIEE
