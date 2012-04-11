From: Tim Henigan <tim.henigan@gmail.com>
Subject: Re: [PATCH 8/9 v11] difftool: teach difftool to handle directory diffs
Date: Wed, 11 Apr 2012 12:46:41 -0400
Message-ID: <CAFouetgfPuiYO9xKPGQ1GGjr6JvMXM7et_7oYrWRrg+RMj9mCQ@mail.gmail.com>
References: <1333567265-23986-1-git-send-email-tim.henigan@gmail.com>
	<CAJDDKr76eMiA4rOHQhar3aToVThDfbc8Ki5tr2PGU_UpDMAVeA@mail.gmail.com>
	<CAFouetijF5vt9r1GfbntJ0BEqoo0FpztkeqrmeN=-6DK1Q_XRA@mail.gmail.com>
	<CAJDDKr7XXqWBRVXhEenWVcE+7526sYVV821Ytty0xbZBvshd-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, git@vger.kernel.org, ramsay@ramsay1.demon.co.uk
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 11 18:46:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SI0gx-0001uF-Qy
	for gcvg-git-2@plane.gmane.org; Wed, 11 Apr 2012 18:46:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756804Ab2DKQqn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Apr 2012 12:46:43 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:62979 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754568Ab2DKQqm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Apr 2012 12:46:42 -0400
Received: by iagz16 with SMTP id z16so1487516iag.19
        for <git@vger.kernel.org>; Wed, 11 Apr 2012 09:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=NiYgHadblkTEsYhRv2qFCosXYsG7CxMmtbPXI6keigA=;
        b=JWOpHYdHd77+uutaF+As5EeBLcGVeolSM3R1JkhqbFpc5J6hccbDsbQ1upF0y3bRZr
         xFE9eIgbIOj51Hy0yAa0c4BTc58INFeQO1OM1wezI2n3MsaDlgVuA+aZG866uvr/us2K
         ZwgnQu9IvyUZo4/X0V9pQrTlyuXzJsplCoiEXHJY5LdBWmuokOLwZrn7jSUxjFQ+0yJu
         b5EJChaJjHKepTyTEUeYwsrMvC2zEyd10y/kZH3Ctu12HVfi0HWjgJjleUxjImjCjxow
         IL1jicAJ2PsjPBQJsX4M7yvVKOVxjmu+MPG0GQ0NGgrF/QczFDL1QkIHUaQr8ylfFshV
         fxSQ==
Received: by 10.50.188.138 with SMTP id ga10mr6488283igc.51.1334162801966;
 Wed, 11 Apr 2012 09:46:41 -0700 (PDT)
Received: by 10.42.225.193 with HTTP; Wed, 11 Apr 2012 09:46:41 -0700 (PDT)
In-Reply-To: <CAJDDKr7XXqWBRVXhEenWVcE+7526sYVV821Ytty0xbZBvshd-w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195211>

On Wed, Apr 11, 2012 at 5:02 AM, David Aguilar <davvid@gmail.com> wrote=
:
> On Tue, Apr 10, 2012 at 10:24 AM, Tim Henigan <tim.henigan@gmail.com>=
 wrote:
>> On Mon, Apr 9, 2012 at 8:14 AM, David Aguilar <davvid@gmail.com> wro=
te:
>>> On Wed, Apr 4, 2012 at 12:21 PM, Tim Henigan <tim.henigan@gmail.com=
> wrote:
>
> I think the right thing to do would be to not override GIT_DIR at all=
=2E
> =C2=A0I haven't read it deeply enough to know whether it was being
> overridden for a specific reason, but I think it should be safe to
> leave it as-is.
>
> Git.pm ends up overriding these variables itself anyways when calling=
 commands.

I tried to avoid setting $GIT_DIR in earlier versions of the patch.
However as discussed here [1], either 'git update-index' or 'git
checkout-index' did not work as expected without explicitly setting
$GIT_DIR.

If $GIT_DIR is not set, 'update-index' and 'checkout-index' will only
work if 'difftool' is called from the repo root.  If 'difftool' is
called from a subdirectory, then one of the commands fails.

I suspect that when $GIT_INDEX_FILE is set but $GIT_DIR is not, then
$GIT_DIR is assumed to be 'pwd'.  However, I was not able to prove
that.


> The GIT_WORK_TREE check should use $repo->wc_path(). =C2=A0Git.pm's a=
lready
> done all the hard work ;-)

I also tried this in an earlier version of the patch.  As noted here
[2], I found that when 'difftool' was run from a subdirectory of the
repo root, '$repo->wc_path()' returned the subdirectory rather than
the repo root.

Thinking about this again now, I realize it was a side-effect of
$GIT_DIR being set in the script.  The man page for git config states
that:

    If --git-dir or GIT_DIR is specified but none of --work-tree, GIT_W=
ORK_TREE
    and core.worktree is specified, the current working directory is re=
garded as
    the top level of your working tree.

So, if I explicitly set $GIT_DIR just for the 'update-index' and
'checkout-index' commands, I need to unset it afterwards.  This should
allow '$repo->wc_path()' to behave as expected.

[1]: http://thread.gmane.org/gmane.comp.version-control.git/193296/focu=
s=3D193302
[2]: http://thread.gmane.org/gmane.comp.version-control.git/193601/focu=
s=3D193603
