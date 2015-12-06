From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 2/5] config.c: move worktree-specific variables to .git/worktrees/...
Date: Sun, 6 Dec 2015 11:22:16 +0100
Message-ID: <CACsJy8BDCGxkLuFTwoyNYZqThe9mZYh1OpL8R1R4-BFvB_1coA@mail.gmail.com>
References: <1449083626-20075-1-git-send-email-pclouds@gmail.com>
 <1449083626-20075-3-git-send-email-pclouds@gmail.com> <CAPig+cST=UGG8VAG94qb9M8vcOXfmWAhLoP65yWJGywR9R84LA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Max Kirillov <max@max630.net>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sun Dec 06 11:22:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a5WSz-0003XR-Dy
	for gcvg-git-2@plane.gmane.org; Sun, 06 Dec 2015 11:22:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753432AbbLFKWt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 6 Dec 2015 05:22:49 -0500
Received: from mail-lb0-f171.google.com ([209.85.217.171]:32973 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753259AbbLFKWs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 Dec 2015 05:22:48 -0500
Received: by lbbkw15 with SMTP id kw15so41546290lbb.0
        for <git@vger.kernel.org>; Sun, 06 Dec 2015 02:22:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=HGeJWXHNxzP6CUhNxRe317CmwV6vFgqkZ7dsKLSKD1s=;
        b=PuvZbitcRLZrDUFjAgPxxI/aTamVvAq60i0lRT2ruRbOoxeHXu7hAmfPvHEMHWH1ii
         l12jvY2DcXqw7jNd1UxhpPl3/Vh2GFikG0L3/FdmYl2iJCNU1viJ0lTT5A5u2hymNZyS
         IaX8Ha6DL2KEdJX0gQmwOG3EnRkvMQdxpt8hzkHmvAdHgy8kE0HdPFFQFA6COJ8cTjKl
         qOC2AX/dgWcBCnOpBsxAQRleJti7Yki0FtogIR1mOC6BUtzFsv0hKU2NWCNxhRchxNhV
         Jb1H90Cc/fVfw9nWSeNp6umjXY2a0iNF5k6rLsnW7JOQpVp9il/8cyTWEPucizxdgN30
         3e1w==
X-Received: by 10.112.134.169 with SMTP id pl9mr11438405lbb.145.1449397366755;
 Sun, 06 Dec 2015 02:22:46 -0800 (PST)
Received: by 10.112.199.5 with HTTP; Sun, 6 Dec 2015 02:22:16 -0800 (PST)
In-Reply-To: <CAPig+cST=UGG8VAG94qb9M8vcOXfmWAhLoP65yWJGywR9R84LA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282046>

On Sun, Dec 6, 2015 at 8:47 AM, Eric Sunshine <sunshine@sunshineco.com>=
 wrote:
> On Wed, Dec 2, 2015 at 2:13 PM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc=
 Duy <pclouds@gmail.com> wrote:
>> .git/info/config.worktree is a pattern list that splits .git/config =
in
>> to sets: the worktree set matches the patterns, the commmon set does
>> not.
>>
>> In normal worktrees, both sets are stored in .git/config. The
>> config.worktree has no effect. Nothing is changed.
>>
>> In linked worktrees, the common and worktree sets are read from and
>> saved to .git/config and .git/config.worktree respectively. Config
>> keys in .git/config that belong to the worktree set is ignored. Thos=
e
>> are for the main worktree only. Similarly, keys not matching the
>> patterns come from .git/config, duplicate keys from
>> .git/config.worktree are ignored.
>>
>> The effect is similar to the $GIT_DIR/$GIT_COMMON_DIR split, we can
>> define that some vars can be shared and some cannot. And as a result
>> of the $GIT_DIR/$GIT_COMMON_DIR split, config.worktree is actually
>> found at .git/worktrees/<id>/config.worktree.
>
> Why does this worktree-specific file need/have a .worktree suffix?

I think in the beginning it was supposed to support git-new-workdir as
well. With a separate name, you can symlink .git/config back to
original repo and create a new .git/config.worktree. The actual code
in this patch does not support this though. I guess as 'git worktree'
is maturing, we probably don't have to worry about git-new-workdir and
could drop .worktree suffix.

>> +static int is_config_local(const char *key_)
>> +{
>> +       static struct strbuf key =3D STRBUF_INIT;
>> +       int i, dtype;
>> +
>> +       if (!config_local.nr)
>> +               return 0;
>> +
>> +       strbuf_reset(&key);
>> +       strbuf_addstr(&key, key_);
>
> Why does 'key' need to be static considering that it is overwritten o=
n
> each call and its value is never accessed after the function returns?

Mostly to avoid re-allocation because this function will be called for
every configuration variable. But this may be premature optimization.
On top of that, if we go with builtin per-worktree list only as being
discussed, then we can drop exclude machinery, we don't have to
preprocess "key" and we can finally kill this "strbuf key".

>> @@ -198,4 +198,30 @@ test_expect_success 'local clone from linked ch=
eckout' '
>> +test_expect_success 'setting worktree.foo goes to config.worktree' =
'
>> +       echo worKtree.Foo >> .git/info/config.worktree &&
>
> Perhaps? s/>> />/

Yeah. In the previous iteration, config.worktree would contain the
default list (core.worktree and stuff) so > may force following tests
to re-initialize config.worktree again. But that's now gone and >
makes more sense.

>> +test_expect_success 'shared config still goes to config' '
>> +       git config random.key randomValue &&
>> +       git --git-dir=3Dwt.foo/.git config random.key >actual &&
>
> What about also testing the opposite scenario?
>
>     git --git-dir=3Dwt.foo/.git  config random.key randomValue &&
>     git config random.key >actual &&

Yep. Will do.
--=20
Duy
