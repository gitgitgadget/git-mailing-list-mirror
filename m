Return-Path: <SRS0=mjbR=3L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B4B4C2D0CE
	for <git@archiver.kernel.org>; Wed, 22 Jan 2020 02:06:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A30124656
	for <git@archiver.kernel.org>; Wed, 22 Jan 2020 02:06:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727817AbgAVCG5 convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 21 Jan 2020 21:06:57 -0500
Received: from filter02.dlls.pa.frontiernet.net ([199.224.80.229]:48652 "EHLO
        filter02.dlls.pa.frontiernet.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726780AbgAVCG5 (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 21 Jan 2020 21:06:57 -0500
Received: from localhost (localhost [127.0.0.1])
        by filter02.dlls.pa.frontiernet.net (Postfix) with ESMTP id D3D3717A0CB;
        Wed, 22 Jan 2020 02:06:55 +0000 (UTC)
Received: from relay02.dlls.pa.frontiernet.net ([199.224.80.245])
        by localhost (filter02.dlls.pa.frontiernet.net [199.224.80.229]) (amavisd-new, port 10024)
        with LMTP id TipCz9jdku_l; Wed, 22 Jan 2020 02:06:53 +0000 (UTC)
X-Originating-IP: [50.53.161.182]
X-Previous-IP: 50.53.161.182
Received: from AHSNB1 (static-50-53-161-182.bvtn.or.frontiernet.net [50.53.161.182])
        by relay02.dlls.pa.frontiernet.net (Postfix) with ESMTPA id 24CD67FC3;
        Wed, 22 Jan 2020 02:06:53 +0000 (UTC)
From:   "JunkYardMail1" <JunkYardMail1@Frontier.com>
To:     "'Derrick Stolee'" <stolee@gmail.com>, <git@vger.kernel.org>
References: <062301d5d0bc$c3e17760$4ba46620$@Frontier.com> <d4056731-c13b-c89d-dfd2-e6235e29fed6@gmail.com>
In-Reply-To: <d4056731-c13b-c89d-dfd2-e6235e29fed6@gmail.com>
Subject: RE: Sparse Checkout Trouble (2.5.0)
Date:   Tue, 21 Jan 2020 18:06:54 -0800
Message-ID: <062f01d5d0c8$9ec6c140$dc5443c0$@Frontier.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQEda7xdZLTIa2ZHGjpcQmJNT0saUQJmrfuyqVOALrA=
Content-Language: en-us
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Yes.  Using git for Windows with bash terminal and Git Extensions GUI.

The reason for the sparse checkout pattern is that the repo is very large, approximately a gigabyte, and I only need of few sub-directories that amount to only about 60 megabytes.
The first sparse checkout rule "!/*/" is expected to exclude everything.
The second sparse checkout rule "/*/directory-*/" is expected to include only sub-directories that contain "directory-" as the leading part of a directory element.

Looks like you're able to reproduce the issue and are hot on the trail.  Thanks.


-----Original Message-----
From: Derrick Stolee [mailto:stolee@gmail.com] 
Sent: Tuesday, January 21, 2020 5:19 PM
To: JunkYardMail1 <JunkYardMail1@Frontier.com>; git@vger.kernel.org
Subject: Re: Sparse Checkout Trouble (2.5.0)

On 1/21/2020 7:42 PM, JunkYardMail1 wrote:
> I have a shallow repository clone and using sparse-checkout of just a 
> handful of directories.  When I upgraded from git version 2.24.1 to 
> 2.25.0 some files not in the sparse-checkout were staged to be 
> deleted.  The directory path of these files contain the Windows reserved name of "prn".
> Ex: "japanese/prn/. . ."  Unable to un-stage these files and reset the 
> changes.

Are you using Git for Windows? I'm not sure why the "prn" would be important otherwise.

> !/*/
> /*/directory-*/

I don't see anything complicated with these patterns, although they seem a bit strange. Why would you not want anything in a directory except one named "<something>/directory-<anotherthing>/"? Is this actually the exact pattern set?
 
> Reverting back to the previous version (2.24.1) allowed to un-stage 
> the files and reset the changes.

This is definitely pointing to a regression, and the feature did get a bit of an overhaul. The goal was to not change how existing users interacted with it, though, so this is a bit alarming.

I did find a behavior change related to these paths in Git for Windows
2.25.0 versus 2.24.1:

  $ git clone https://github.com/derrickstolee/git-sparse-checkout-test
  Cloning into 'git-sparse-checkout-test'...
  remote: Enumerating objects: 6, done.
  remote: Counting objects: 100% (6/6), done.
  remote: Compressing objects: 100% (4/4), done.
  remote: Total 6 (delta 0), reused 6 (delta 0), pack-reused 0
  Receiving objects: 100% (6/6), done.
  error: invalid path 'directory-1/prn/a'
  fatal: unable to checkout working tree
  warning: Clone succeeded, but checkout failed.
  You can inspect what was checked out with 'git status'
  and retry with 'git restore --source=HEAD :/'
  
The checkout here is _expected_ to fail, due to the protected filenames. What is troublesome is the following sparse-checkout commands fail, and the read-tree command fails in a way that
2.24.1 does not:
 
  $ git sparse-checkout init
  error: invalid path 'directory-1/prn/a'
  error: invalid path 'directory-1/prn/a'
  
  $ git sparse-checkout set "/*" "\!/*/"
  error: invalid path 'directory-1/prn/a'
  error: invalid path 'directory-1/prn/a'
  
  $ git read-tree -mu HEAD
  error: invalid path 'directory-1/prn/a'

The double error messages are due to the "try with an in-memory pattern set, then roll back if there is a failure." The patterns we are trying to create do not include the directory that is failing.

I'll keep looking into this.

Thanks,
-Stolee

