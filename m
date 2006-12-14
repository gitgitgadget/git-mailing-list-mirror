X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: changing log entries
Date: Thu, 14 Dec 2006 10:37:34 +0000
Message-ID: <200612141037.35061.andyparkins@gmail.com>
References: <1166051281.1808.1.camel@jcm.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 14 Dec 2006 10:37:53 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=MbqLwgRDv+inxVBoahh7+c1XtA+5vkB9GXUQWVs3yN779KXT2ZXZqOL5mMqnVXKkypXRRIHLY3Ow1jZjM8G0A5+yTpX43asbqTTV7uDHr2V/jN+leNMmnKtjGGCHw7V7RFpjKBsBogiUSvSHehIVVzks9c6lFTyJGR53/DpeR/k=
User-Agent: KMail/1.9.5
In-Reply-To: <1166051281.1808.1.camel@jcm.boston.redhat.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34303>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GunyE-0007Hw-4e for gcvg-git@gmane.org; Thu, 14 Dec
 2006 11:37:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751919AbWLNKhm (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006
 05:37:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751917AbWLNKhl
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 05:37:41 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:12963 "EHLO
 ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1751919AbWLNKhl (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec
 2006 05:37:41 -0500
Received: by ug-out-1314.google.com with SMTP id 44so454048uga for
 <git@vger.kernel.org>; Thu, 14 Dec 2006 02:37:39 -0800 (PST)
Received: by 10.66.255.7 with SMTP id c7mr1196078ugi.1166092659652; Thu, 14
 Dec 2006 02:37:39 -0800 (PST)
Received: from dvr.360vision.com ( [194.70.53.227]) by mx.google.com with
 ESMTP id 34sm1861030uga.2006.12.14.02.37.38; Thu, 14 Dec 2006 02:37:39 -0800
 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On Wednesday 2006 December 13 23:08, Jon Masters wrote:

> Anyway, now I would like to change an existing log entry to make it a
> bit cleaner (read: add a first line that's under 80 characters). What's
> the best way to change an existing log entry for a commit?

If it's HEAD you want to change:
 git-commit --amend

If it's not, it's a bit harder.  You could pull each commit out as a patch and 
apply them again later after a git-reset.  However, git has a tool for 
automating a lot of that:  git-rebase.  man git-rebase has some excellent 
examples.

 * -- A -- B -- C (master)

Let's say you want to edit A; make a new branch at A:

$ git branch temp-edit-branch master^^
 
 * -- A (temp-edit-branch)
       \
        B -- C (master)

Edit A with git-commit --amend.  This makes a new A, A' that has the new 
commit message:

 * -- A' (temp-edit-branch)
  \
   A -- B -- C (master)

Then you switch to "master" and rebase master onto temp-edit-branch; you can 
then delete temp-edit-branch

$ git-checkout master
$ git-rebase temp-edit-branch
$ git branch -D temp-edit-branch

 * -- A' -- B' -- C' (master)
  \
   A -- B -- C

Note that A-B-C are now dangling commits; a git-prune would be needed to clean 
them out of the repository.

The important thing to realise is that you can never really edit a commit.  
The best you can do is reapply it.  In this example, the fact that B' makes 
the same change as B is irrelevant - they are two separate commits.

Note: this is only workable if you haven't pushed this branch to another 
repository.  The other repository would retain the original A--B--C branch 
and you will get "won't fast forward" errors if you try to push the 
new "A'--B'--C'" branch.


Andy
-- 
Dr Andy Parkins, M Eng (hons), MIEE
