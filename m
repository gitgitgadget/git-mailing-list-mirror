X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Fast access git-rev-list output: some OS knowledge required
Date: Wed, 6 Dec 2006 20:24:42 +0100
Message-ID: <e5bfff550612061124jcd0d94em47793710866776e7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 6 Dec 2006 19:24:49 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=ouGHOHkpgGhzatwXBwSbj3wuegU9f8dbXcQxvAOR1+dd5xrjUb4dEnvgEDeUg1Y/JRxcbfMyAH6UbuWh+Pqg6YPk3SZcuGkmZeiRSGiOQWY95p5u2MYvSO7RQ2Nb2X+C2ZlPn5vAOhvFZyZLJsss9kcUATiJ5JtnmV9bZ7eh3yU=
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33508>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gs2Nr-0000hT-U0 for gcvg-git@gmane.org; Wed, 06 Dec
 2006 20:24:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S937236AbWLFTYo (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 6 Dec 2006
 14:24:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937344AbWLFTYo
 (ORCPT <rfc822;git-outgoing>); Wed, 6 Dec 2006 14:24:44 -0500
Received: from nz-out-0506.google.com ([64.233.162.239]:54174 "EHLO
 nz-out-0102.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with
 ESMTP id S937236AbWLFTYo (ORCPT <rfc822;git@vger.kernel.org>); Wed, 6 Dec
 2006 14:24:44 -0500
Received: by nz-out-0102.google.com with SMTP id s1so198390nze for
 <git@vger.kernel.org>; Wed, 06 Dec 2006 11:24:42 -0800 (PST)
Received: by 10.35.125.16 with SMTP id c16mr2047618pyn.1165433082218; Wed, 06
 Dec 2006 11:24:42 -0800 (PST)
Received: by 10.35.93.11 with HTTP; Wed, 6 Dec 2006 11:24:42 -0800 (PST)
To: "Git Mailing List" <git@vger.kernel.org>
Sender: git-owner@vger.kernel.org

I ask help to the list because my knowledge on this is not enough.

Currently qgit uses, socket based, QProcess class to read data from
'git rev-list'  when loading the repository at startup.

The time it takes to read, without processing, the whole Linux tree
with this approach it's almost _double_ of the time it takes 'git
rev-list' to write to a file:

$git rev-list --header --boundary --parents --topo-order HEAD >> tmp.txt

We are talking of about 7s against less then 4s, on my box (warm cache).

So I have a patch to make 'git rev-list' writing into a temporary file
and then read it in memory, perhaps it's not the cleaner way, but it's
faster, about 1s less.

I have browsed Qt sources and found that QProcess uses internal
buffers that are then copied again before to be used by the
application. File approach uses a call to read() /fread() buired
inside the Qt's QFile class, and no intermediate buffers, so perhaps
this could be the reason the second way it's faster.


Anyway there are some issues:

1) File tmp.txt is deleted as soon as read, but this is not enough
sometimes to avoid a costly and wasteful write access to disk by the
OS. What is the easiest, portable way to create a temporary 'in memory
only' file, with no disk access? Or at least delay the HD write access
enough to be able to read and delete the file before the fist block of
tmp.txt is flushed to disk?

2) There is a faster/cleaner (and *safe* ) way to access directly 'git
rev-list' output, something like (just as an example):

$git rev-list --header --boundary --parents --topo-order HEAD >> /dev/mem

Or something similar, possibly _simple_ and _portable_ , so to be able
to copy the big amount of 'git rev-list' output just once (about 30MB
with current tree).


3) Other suggestions?  ;-)


Thanks
