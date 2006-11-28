X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [RFC] Submodules in GIT
Date: Tue, 28 Nov 2006 16:29:05 +0000
Message-ID: <200611281629.08636.andyparkins@gmail.com>
References: <20061121223130.GA24909@nan92-1-81-57-214-146.fbx.proxad.net> <200611281335.38728.andyparkins@gmail.com> <20061128154434.GD28337@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 28 Nov 2006 16:29:47 +0000 (UTC)
Cc: Shawn Pearce <spearce@spearce.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=QGELFpngOLupolFjycQNofPSEg7Jtc7ThwB6j+8aKcHkFi1ndXNlWZawFYDVBevwHlCOr3nTOm7l1WD0M/y4X38Bd1TFZ6Nwyd+GuiR2UbfgKhgRr8XwSqWmcKDKuluaB+BO5hpCt1eJ/CMcLF+BPa4fvPvYWiMcson3bsEZYQg=
User-Agent: KMail/1.9.5
In-Reply-To: <20061128154434.GD28337@spearce.org>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32546>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gp5pi-0007oI-Tq for gcvg-git@gmane.org; Tue, 28 Nov
 2006 17:29:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S935846AbWK1Q3R (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 28 Nov 2006
 11:29:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935865AbWK1Q3R
 (ORCPT <rfc822;git-outgoing>); Tue, 28 Nov 2006 11:29:17 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:4943 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S935846AbWK1Q3Q
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 28 Nov 2006 11:29:16 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1523273uga for
 <git@vger.kernel.org>; Tue, 28 Nov 2006 08:29:15 -0800 (PST)
Received: by 10.66.244.10 with SMTP id r10mr1855090ugh.1164731355119; Tue, 28
 Nov 2006 08:29:15 -0800 (PST)
Received: from dvr.360vision.com ( [194.70.53.227]) by mx.google.com with
 ESMTP id o24sm1237035ugd.2006.11.28.08.29.14; Tue, 28 Nov 2006 08:29:14 -0800
 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On Tuesday 2006 November 28 15:44, Shawn Pearce wrote:

> So HEAD in a submodule is the current content of that submodule.
> Therefore any update-index call on a submodule should load HEAD
> (totally ignoring whatever branch it refers to) into the supermodule
> index.

I was with you right up until here.

Why should a submodule do anything to the supermodule?  This is like saying, 
when I edit a working tree file, it should automatically call update-index.  
The supermodule index should only be updated in response to a manual 
update-index (or commit -a I suppose).

Worse, if you allow that to happen, the supermodule can commit a state that 
cannot be retrieved from the submodule's repository.  The ONLY thing a 
supermodule can record about a submodule is a commit.  Changing the index 
doesn't create a commit, so it can't change anything in the supermodule.

If you change the submodule index then that submodule is "dirty", this state 
has no parallel with normal git operation.  The nearest thing is that you've 
changed a file but not saved it.  Apart from showing the "dirty" state in the 
supermodule's git-status, I don't see that there is anything that the 
supermodule can do - it can't go around committing in a repository that it 
not itself.

IMO, it should always be possible to take a submodule and work on it in 
isolation - in an extreme case, by moving it out of the supermodule tree 
entirely.

In summary, from the supermodule's point of view:
 * A submodule with changed working directory is "dirty-wd"
 * A submodule with changed index is "dirty-idx" from the supermodule's
 * A submodule with changed HEAD (since the last supermodule commit) 
   is "changed but not updated" and can hence be "update-index"ed into the
   supermodule
 * A submodule with changed HEAD that has been added to the supermodule index
   is "updated but not checked in"
 * A submodule with changed HEAD (since the last supermodule update-index) is
   both "changed but not updated" _and_ "updated but not checked in", just 
   like any normal file.

What's needed then:
 * A way of telling git to treat a particular directory as a submodule instead
   of a directory
 * git-status gets knowledge of how to check for "dirty" submodules
 * git-commit-tree learns about how to store "submodule" object types in
   trees.  The submodule object type will be nothing more than the hash of the
   current HEAD commit.  (This might be my ignorance, perhaps it's just 
   update-index that needs to know this)

I don't know enough about the plumbing to know if my description above is 
using the right nomenclature - I'm sure someone will correct me.

In my head, it would look something like this:

$ mkdir supermodule; cd supermodule
$ git init-db
$ git clone proto://host/submodule.git
$ git add --submodule submodule
$ git update-index submodule
$ git commit -m "Added submodule to supermodule"
[ edit submodule ]
$ git status
submodule is dirty, the working directory has changed
[ update-index in submodule ]
$ git status
submodule is dirty, the index has changed
[ commit in submodule ]
$ git status
submodule is changed but not updated
$ git update-index submodule
$ git status
submodule is updated but not checked in
$ git commit -m "Record submodule change in supermodule"

Am I crazy?



Andy

-- 
Dr Andy Parkins, M Eng (hons), MIEE
