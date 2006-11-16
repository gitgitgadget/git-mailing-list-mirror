X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Alexander Litvinov" <litvinov2004@gmail.com>
Subject: Git can't merge two identical move file operation
Date: Thu, 16 Nov 2006 16:26:37 +0600
Message-ID: <6e1787fe0611160226r2d51d980t6899f1a1018b5fe5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 16 Nov 2006 10:27:04 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=ZtsX2VRzhEWT8qb+z4EDPPxh9yn9EKHjP1unCNx2/rLGA8TNhTay75+XLgb9nKc5ip2g+GP8rWTypnZ47PeDjSsqBSNYRp0qXqy7X2EZW4V8zxUXnmoxLZy1+MwBqIJTTHbaQ2zRV7csk4a8C6wLCmwRll/0zstpE+foLIyUb2s=
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31565>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkeSK-000307-2a for gcvg-git@gmane.org; Thu, 16 Nov
 2006 11:26:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1423688AbWKPK0j (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 16 Nov 2006
 05:26:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423710AbWKPK0j
 (ORCPT <rfc822;git-outgoing>); Thu, 16 Nov 2006 05:26:39 -0500
Received: from py-out-1112.google.com ([64.233.166.182]:48092 "EHLO
 py-out-1112.google.com") by vger.kernel.org with ESMTP id S1423688AbWKPK0i
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 16 Nov 2006 05:26:38 -0500
Received: by py-out-1112.google.com with SMTP id a29so299810pyi for
 <git@vger.kernel.org>; Thu, 16 Nov 2006 02:26:37 -0800 (PST)
Received: by 10.35.49.15 with SMTP id b15mr721599pyk.1163672797571; Thu, 16
 Nov 2006 02:26:37 -0800 (PST)
Received: by 10.35.83.2 with HTTP; Thu, 16 Nov 2006 02:26:37 -0800 (PST)
To: git <git@vger.kernel.org>
Sender: git-owner@vger.kernel.org

Hello,

I have a git repo build using cvsimport. It has 'bad' directory
structure and I want to 'fix' it after each incremental update from
cvs. Here is the idea: I have 2 permanent branches master (to work
with) and cvs (to import from cvs) and one temporary branch to move
files across the project to make directory structure better. Movement
operation is always the same: move directories/files from one place to
another. But merging from temp branch to work branch fail with error
text :
CONFLICT (rename/delete): Rename a->b/a in HEAD and deleted in 791371

Here is the example script:
>git version
git version 1.4.4
> mkdir 1 && cd 1 && git init-db
defaulting to local storage area
> echo 1 > a && git add a && git commit -a -m '1'
Committing initial tree 2ce1eef76631e82282e0f7f0cf9e6f3e9a4a0b1e
> git checkout -b fix
> mkdir b && git mv a b/ && git commit -a -m 'fix 1'
> git checkout -b work master
> git pull . fix
Updating 7be4ab0..d4909bb
Fast forward
 a => b/a |    0
 1 files changed, 0 insertions(+), 0 deletions(-)
 rename a => b/a (100%)
> git checkout -f master
> echo 2 >> a && git commit -a -m '2'
> git checkout -b fix2 master
> mkdir b && git mv a b/ && git commit -a -m 'fix 2'
> git checkout -f work
> git pull . fix2
Trying really trivial in-index merge...
fatal: Merge requires file-level merging
Nope.
Merging HEAD with 791371d91c34bc45b289319d96ebf35c8be385a0
Merging:
d4909bb fix 1
791371d fix 2
found 1 common ancestor(s):
7be4ab0 1
CONFLICT (rename/delete): Rename a->b/a in HEAD and deleted in
791371d91c34bc45b289319d96ebf35c8be385a0
Automatic merge failed; fix conflicts and then commit the result.
>

Bot fix and fix2 are temp branches and supposed to be deleted.

Why git can't merge such changes ? It should know that work holds
renamed version of file a from master and fix2 holds new renamed file
a from master too. Why it can't apply changes of a from master to work
