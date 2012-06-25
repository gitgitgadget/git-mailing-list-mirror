From: Dmitry Ivankov <divanorama@gmail.com>
Subject: Re: [PATCH/RFC] fast-import: disallow empty branches as parents
Date: Mon, 25 Jun 2012 14:00:57 +0600
Message-ID: <CA+gfSn9oWTxwhrsmE9NeD0awkghSknfNcm8CcVqRGveGg_g+Lw@mail.gmail.com>
References: <1340220841-753-1-git-send-email-divanorama@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>,
	Shawn Pearce <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 25 10:01:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sj4EQ-0002qu-NO
	for gcvg-git-2@plane.gmane.org; Mon, 25 Jun 2012 10:01:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752981Ab2FYIA7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jun 2012 04:00:59 -0400
Received: from mail-gg0-f174.google.com ([209.85.161.174]:56101 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752837Ab2FYIA6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jun 2012 04:00:58 -0400
Received: by gglu4 with SMTP id u4so2574319ggl.19
        for <git@vger.kernel.org>; Mon, 25 Jun 2012 01:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=hbOVeXBK0WD9J0e4Safmw7I8zC3lmWCE8aNG66NJmzA=;
        b=ZmeF6C64Uur0NTqkOP5I280SGvn2DIfCBQuLcbyhjq82I6vfrv+4EC5HJLjcpm46HL
         ij5j6ccpH9Tb/6w4/qoxyiSjDtMbRsoNsx6BeberVPftJsn6ovYnlUizVT6pIsOLUMdx
         yfzzP1GFIFmV2GvXxH8BcuU4MzXnNMLHHitl99EzXnHGijI4yry2xLhsjn16C6KY1Rpu
         Q1/0PnwX5goXeqKHQ4ZwjfZXgvXdccmRHqBp1oIV/JTc7CKuBvpm6UM0GzKUfoXV2VeB
         Va7ZApM8REy/xPTNshKiHR+0mrkdvzZh8AC4U2y1tCSjJj8EhUqXM5ZpSfMs7bXknISH
         087Q==
Received: by 10.50.140.4 with SMTP id rc4mr7478267igb.68.1340611257141; Mon,
 25 Jun 2012 01:00:57 -0700 (PDT)
Received: by 10.64.126.42 with HTTP; Mon, 25 Jun 2012 01:00:57 -0700 (PDT)
In-Reply-To: <1340220841-753-1-git-send-email-divanorama@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200557>

+Shawn Pearce

On Thu, Jun 21, 2012 at 1:34 AM, Dmitry Ivankov <divanorama@gmail.com> wrote:
> Combinations of "reset", "commit" with "from" and/or "merge" commands
> may make fast-import to produce bad objects (null_sha1 parents) or
> accept bad inputs (ones asking for empty branches as parents).

I was trying to split the patch into small an obvious cases and found out that
there are 4 ways to make or refer to "empty" branches:
1. reset branch_name
2. reset branch_name \n from `0{40}`
3. refer to it as `0{40}`
4. commit branch_name for a new branch name. It's empty up to the
'commit' command end.
Note: I'll use 4 to denote a reference to a branch name from the
'commit' command to this very branch name.

And these branches can be used in 'from' and 'merge' commands.

In 'from' command:
- 1,2,3 are allowed in 'from', no bug of writing 0{40} parent here as
'from' parent is checked against null_sha1
- 4 is not allowed with message "Can't create a branch from itself"

In 'merge' command:
- 1,2 are allowed in 'merge' and lead to 0{40} being actually written
as a commit parent - BUG
- 3 is not allowed with message "Not a valid commit"
- 4 without 'from' is allowed, parent is previous branch tip. May be 0{40} - BUG
- 4 with 'from' is allowed, 'merge' parent is 'from' parent - probably
a bug, also may lead to 0{40} being written - BUG

BUG stuff obviously needs to be fixed, at least we can just skip 0{40}
parents in 'merge' command.

Then difference in 3 between 'from' and 'merge' should be dealt with.
'merge' behaviour  comes from
    tags/v1.5.0.4~21^2 2f6dc35d2ad0b.. 5 Mar 2007 fast-import: Fail if
a non-existant commit is used for merge
since then 'merge sha1' just looks up commit with this sha1. But
'from' command has it's story too - it was
a 'new_branch' long ago (up to tags/v1.5.0-rc4~14^2~64) and since the
very beginning (tags/v1.5.0-rc4~14^2~76)
is had a special case to allow 0{40} as a parent. So, should we just
allow 'merge 0{40}'?

And finally 4 in 'merge' should probably always refer to the previous
tip to cause less surprise (it was the largest
part of my patch, though it turns out not the most interesting one).

P.S. At first I thought that any reference to an empty branch in
'merge' of 'from' should be rejected, but given that we
allow sha1 0{40} to be used in these and in 2, I guess we should keep
it allowed.
