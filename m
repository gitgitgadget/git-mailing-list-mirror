X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [RFC] Submodules in GIT
Date: Fri, 1 Dec 2006 09:19:04 +0000
Message-ID: <200612010919.06030.andyparkins@gmail.com>
References: <20061121223130.GA24909@nan92-1-81-57-214-146.fbx.proxad.net> <200611301449.55171.andyparkins@gmail.com> <456F0153.5000107@b-i-t.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 1 Dec 2006 09:19:25 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=l987Q93boz/6+vT39C8FVHaE/QskhCT0eYFJeHx0q+vE4KUIQoW6KtwC2wqprAgtY8SKtV6DjAmq4yHaEPdzNwoRXklH0W2osVfAB7lYaEEboH2Wp3StrkAC5d/BQt5UU0LU06/frsmKmN9D7kpbmbc9ZNqMnIj8lNWSqcNv/v8=
User-Agent: KMail/1.9.5
In-Reply-To: <456F0153.5000107@b-i-t.de>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32877>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gq4YE-0002Pr-Vr for gcvg-git@gmane.org; Fri, 01 Dec
 2006 10:19:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1759090AbWLAJTM (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 1 Dec 2006
 04:19:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759253AbWLAJTM
 (ORCPT <rfc822;git-outgoing>); Fri, 1 Dec 2006 04:19:12 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:40389 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1759090AbWLAJTL
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 1 Dec 2006 04:19:11 -0500
Received: by ug-out-1314.google.com with SMTP id 44so2365949uga for
 <git@vger.kernel.org>; Fri, 01 Dec 2006 01:19:10 -0800 (PST)
Received: by 10.67.97.18 with SMTP id z18mr6833430ugl.1164964750370; Fri, 01
 Dec 2006 01:19:10 -0800 (PST)
Received: from dvr.360vision.com ( [194.70.53.227]) by mx.google.com with
 ESMTP id 24sm25085342ugf.2006.12.01.01.19.09; Fri, 01 Dec 2006 01:19:09 -0800
 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On Thursday 2006 November 30 16:05, sf wrote:

> Step 2: You commit to myproject. myproject now contains a new commit
> object in path libxcb. (How to do that is up to the UI but at the
> repository level the outcome should be obvious). This commit is local to
> your repository.

Let's imagine a supermodule repository, and guess at it in more detail (I'll 
abbreviate some of the less interesting output):

$ git-cat-file -p HEAD
tree fb02e78085ecf2f29045603df858b5362e5bf8a4
parent 4f2dba685507e4a8e07dac298c4024feaec6bd7d
author Andy Parkins
committer Andy Parkins 
$ git-cat-file -p fb02e78085ecf2f29045603df858b5362e5bf8a4
100644 blob 46bd4e284a57e2faa539e7b72d62a38867075af5    Makefile
040000 tree 49ea01373a986a3db44d66702714aa75059ffa2c    doc
040000 subm d0a877464dc0198667a3e27ed3af8448ddacf947    libxcb

The "subm" type is our new ODB object that's going to store whatever we will 
need to access the submodule.  "libxcb" has already told us where this 
submodule is in the supermodule tree.

$ git-cat-file -p d0a877464dc0198667a3e27ed3af8448ddacf947
submodulecommithash ccddf1d4b0cf7fd3a699d8b33cf5bc4c5c4435b7
submoduleurlhint git://anongit.freedesktop.org/git/xcb/libxcb

Here "submodulecommithash" is telling us what commit in the submodule is 
stored in this supermodule tree.  The "submoduleurlhint" is to help when 
git-clone is used to clone this supermodule.

They key thing I wanted to point out here is the line:
  submodulecommithash ccddf1d4b0cf7fd3a699d8b33cf5bc4c5c4435b7
This is the ONLY link you have to the submodule.  I think this line represents 
the fundamental difference between our thinking on submodules.

I say:
 submodulecommithash points at a commit /in the submodule/
You say:
 "This commit is local to your repository".  i.e. it points at a commit in
 the supermodule, which in turn implies that the local commit object points
 at a local tree and local parents.

My question is therefore: tell me what that local commit's tree and parent's 
are?  At the moment I am having difficulty understanding what meaningful 
things you could have in those fields.



Andy
-- 
Dr Andy Parkins, M Eng (hons), MIEE
