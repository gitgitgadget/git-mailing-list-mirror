From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 08/17] revert: Separate cmdline parsing from functional code
Date: Tue, 19 Jul 2011 02:23:26 +0530
Message-ID: <CALkWK0mQ0M7ZjJk=dwZjuK=fp4p1+Cz4OfeWpdi+CTO1pZVH0Q@mail.gmail.com>
References: <1310396048-24925-1-git-send-email-artagnon@gmail.com>
 <1310396048-24925-9-git-send-email-artagnon@gmail.com> <20110712182046.GD14120@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 18 22:53:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qiup7-0005eR-RX
	for gcvg-git-2@lo.gmane.org; Mon, 18 Jul 2011 22:53:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751921Ab1GRUxt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jul 2011 16:53:49 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:36261 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751281Ab1GRUxr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jul 2011 16:53:47 -0400
Received: by wwe5 with SMTP id 5so3549150wwe.1
        for <git@vger.kernel.org>; Mon, 18 Jul 2011 13:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=CsAkohkziMlrKS3r1SolHvuTubBef+7ZBEFXpsXsAFU=;
        b=teYL/Lr4270Ps+Mq239B5+JppKqew3LHoiW7NBBCuIoYM8nmN7KF/UMMeuKiVLg0k7
         2t9zhL+m67oXV9AjCDZQ5nibJAg7pNkyv0qfx3XxW1sdpyTrGXK00xN5UJb2yQjSDKJ4
         gdkryM3dH+hQt9RzWRjC5DX3Y0DqeAZrO8YuU=
Received: by 10.227.137.6 with SMTP id u6mr5342684wbt.111.1311022426121; Mon,
 18 Jul 2011 13:53:46 -0700 (PDT)
Received: by 10.216.234.143 with HTTP; Mon, 18 Jul 2011 13:53:26 -0700 (PDT)
In-Reply-To: <20110712182046.GD14120@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177409>

Hi,

Jonathan Nieder writes:
> Ramkumar Ramachandra wrote:
>> Currently, revert_or_cherry_pick does too many things including
>> argument parsing and setting up to pick the commits; this doesn't make
>> a good API.
>
> On the contrary, generally speaking single-call APIs are often very
> pleasant to work with.
[...]
> So this is probably not about the function doing too many things but
> something else.

Took me some time to figure this out.  I suppose I could also phrase
this as "prepare to make revert_or_cherry_pick the starting point for
continuing in future", but it might result in a huge explanation about
what continuing means, and why continuing won't need to do argument
parsing.  I think I'll put in a more superficial intent (Justified
because I like this change even if we never support continuing in the
future).

New commit message.

revert: Separate cmdline parsing from functional code

Currently, revert_or_cherry_pick sets up a default git config, parses
command-line arguments, before preparing to pick commits.  This makes
for a bad API as the central worry of callers is to assert whether or
not a conflict occured while cherry picking.  The current API is like:

if (revert_or_cherry_pick(argc, argv, opts) < 0)
   print "Something failed, I'm not sure what"

Simplify and rename revert_or_cherry_pick to pick_commits so that it
only has the responsibility of setting up the revision walker and
picking commits in a loop.  Transfer the remaining work to its
callers.  Now, the API is simplified as:

if (parse_args(argc, argv, opts) < 0)
   print "Can't parse arguments"
if (pick_commits(opts) < 0)
   print "Something in the picking mechanism failed"

Later in the series, pick_commits will serve as the starting point for
continuing a cherry-pick or revert.

-- Ram
