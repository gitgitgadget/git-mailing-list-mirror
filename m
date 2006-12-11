X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andreas Ericsson <ae@op5.se>
Subject: Re: Using GIT to store /etc (Or: How to make GIT store all file permission
 bits)
Date: Mon, 11 Dec 2006 11:39:47 +0100
Message-ID: <457D3573.2010001@op5.se>
References: <787BE48C-1808-4A33-A368-5E8A3F00C787@mac.com> <elh91b$v6r$1@sea.gmane.org> <A52817B6-0265-4164-8E5D-334AF92DC267@mac.com> <200612101926.33307.jnareb@gmail.com> <19476830-E30A-42B7-AD9B-4C417D830C8E@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 11 Dec 2006 10:39:58 +0000 (UTC)
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
In-Reply-To: <19476830-E30A-42B7-AD9B-4C417D830C8E@mac.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33989>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GtiZd-0007Gw-IT for gcvg-git@gmane.org; Mon, 11 Dec
 2006 11:39:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1762712AbWLKKju (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 11 Dec 2006
 05:39:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762760AbWLKKjt
 (ORCPT <rfc822;git-outgoing>); Mon, 11 Dec 2006 05:39:49 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:37774 "EHLO
 smtp-gw1.op5.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id
 S1762712AbWLKKjt (ORCPT <rfc822;git@vger.kernel.org>); Mon, 11 Dec 2006
 05:39:49 -0500
Received: from [192.168.1.20] (unknown [213.88.215.14]) by smtp-gw1.op5.se
 (Postfix) with ESMTP id E72116BCBF; Mon, 11 Dec 2006 11:39:47 +0100 (CET)
To: Kyle Moffett <mrmacman_g4@mac.com>
Sender: git-owner@vger.kernel.org

Kyle Moffett wrote:
> On Dec 10, 2006, at 13:26:32, Jakub Narebski wrote:
>> The idea is to not store /etc in git directly, but use import/export 
>> scripts, which for example saves permissions and ownership in some 
>> file also tracked by git on import, and restores correct permissions 
>> on export. That is what I remember from this discussion. This of 
>> course means that you would have to write your own porcelain...
>>
>> What about mentioned in other email IsiSetup?
> 
> The real problem I have with that is you literally have to duplicate all 
> sorts of functionality.  I want to run "foo-status" in /etc and get 
> something useful, but if /etc is not a git directory in and of itself 
> then you have to duplicate most of "git-status" anyways.

Make /etc/.git a symlink to where you store your repo and go to the 
other directory when you want to *restore* configuration. The only "own 
porcelain" you need to write is a simple program that understands "save" 
and "restore" (or some such) and tucks away the meta-data in a file 
somewhere inside the git tree. If you make it in the format

octal-mode path/to/file

you can even get decently human-readable permission diffs, which will 
most likely be prettier and easier to read than anything git currently has.

> 
> GIT already has _some_ idea about file permissions, it just discards 
> most of the data before writing to disk.   Of course, adding POSIX ACLs
> and user-extended-attributes requires a new data format, but those are 
> very similar to filesystem permissions; they differ only in amount of 
> data stored, not in purpose.
> 

The amount of data stored is the issue here. The current implementation 
(which works just fine and does The Right Thing(tm) for code-repos) only 
stores what it has to and uses the spare bits to do other things.

> Import/export scripts literally require wrapping every single GIT 
> command with a script that changes directory a few times, reads from a 
> different checked-out tree, and permutes some extended-attribute data 
> slightly before storing it in the underlying GIT tree.  Even without 
> adding any new functionality whatsoever that doubles the amount of code 
> just for finding your repository and checking command-line arguments, 
> and that's a crazy trade-off to make in any situation.
> 

GIT_DIR=/some/where/else/.git git log -p

Why would you want to read from a different checked-out tree? 
Non-committed data is "changes", committed data is "HEAD" (or 
commit-ish) and marked data is "index". I see no reason what so ever for 
a second checked-out tree.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
