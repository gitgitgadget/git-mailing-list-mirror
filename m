From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 0/5] Split .git/config in multiple worktree setup
Date: Thu, 3 Dec 2015 09:07:07 +0100
Message-ID: <CACsJy8AOeFEKhhmH-TCK6gWZQAJX0kbTS0-=iyCji9eXwBr9QA@mail.gmail.com>
References: <1449083626-20075-1-git-send-email-pclouds@gmail.com> <20151203061505.GA4314@wheezy.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Max Kirillov <max@max630.net>
X-From: git-owner@vger.kernel.org Thu Dec 03 09:07:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a4OvW-0008AL-82
	for gcvg-git-2@plane.gmane.org; Thu, 03 Dec 2015 09:07:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758728AbbLCIHj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 Dec 2015 03:07:39 -0500
Received: from mail-lf0-f52.google.com ([209.85.215.52]:35257 "EHLO
	mail-lf0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757165AbbLCIHi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Dec 2015 03:07:38 -0500
Received: by lfdl133 with SMTP id l133so81486011lfd.2
        for <git@vger.kernel.org>; Thu, 03 Dec 2015 00:07:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=lwmTMoyOfmmEvZZHDEP6YRRnkAdaVulCGHtlA5L3Fgo=;
        b=dLmGBWtTTe+1w5CLWvW5+x5X+RXj4X3OkX6QAVt2ElVMy5DZOrVJPt9reNOhshDUkL
         NDHXb3/K54Z2DcRjkFE2FhcNgj6ECRKUmQpuPts25y7vgK79e1k2awtOqjOvZDfrnaVK
         wwtF4OpkLQtfV8iaHjvEXr0v8eGCPJSKaLoXaw1CruWudxZxg9dn36VW8bj163+CExiJ
         0Rnd/QHjS9s9AdqLHUgf7o24TR2aj9zaFtYyt7jHPVb9N+CisidlIJMVOS6/8R3Mcd+L
         gLiNJLRWSijzkMMxV6A0wCqZY4Z++D/nRzTpZ2ZRd2BBMh92aFw3whJtyvoqSWolG5dz
         e+Mw==
X-Received: by 10.112.168.70 with SMTP id zu6mr5058967lbb.26.1449130056876;
 Thu, 03 Dec 2015 00:07:36 -0800 (PST)
Received: by 10.112.199.5 with HTTP; Thu, 3 Dec 2015 00:07:07 -0800 (PST)
In-Reply-To: <20151203061505.GA4314@wheezy.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281947>

On Thu, Dec 3, 2015 at 7:15 AM, Max Kirillov <max@max630.net> wrote:
> On Wed, Dec 02, 2015 at 08:13:41PM +0100, Nguy=E1=BB=85n Th=C3=A1i Ng=
=E1=BB=8Dc Duy wrote:
>> Let's restart this. From the last discussion [1], we need to make
>> core.worktree per-worktree for submodules to work. We also need
>> core.sparseCheckout per-worktree.
>
> Thank you. It would be nice to have it, so that features
> like submodules work fully.
>
> Now there are extensions support, would it make sense to
> mark repositories which use per-worktree config with an
> extension? It could clearly separate 2.5-style
> multi-worktree repositories (which might exist already
> around) from the new format. The extension could be set by
> 'worktree add' while creating first worktree, for example.

Hmm.. I didn't think of this. If we add this as a repo extension, then
we could use git/config for shared vars only, main worktree specific
vars can stay in .git/config.worktree while linked worktree's in
=2Egit/worktrees/*/config.worktree. Neat.

>> This series adds a pattern list, with .gitignore syntax mostly, that
>> split config var set into two sets, the per-worktree set will be
>> stored in .git/worktrees/*/config.worktree instead. The pattern list
>> consists of default patterns, built in git binary, and user ones in
>> .git/info/config.worktree.
>
> Using builtin defaults might be confusing for users -
> editing the info/config.worktree they must keep in mind the
> list of defaults (which they seem to don't know).

All per-worktree variables are marked so in config.txt

> Also, if
> anybody wants to extend the default list (like myself, for
> submodules), should they edit the info/config.worktree in
> provided template of extend the builtin list? What was wrong
> with the default in template?

If a variable _must_ be per-worktree or something will break, then it
should belong to the builtin list (so the user is less likely to mess
with it). If it may or may not be per-worktree, depending on one's
preference, then we can keep this in info/config.worktree. I made the
builtin list for that reason (user not breaking stuff accidentally)
and another one, which is upgrade issue. Suppose you introduce a new
per-worktree variable in the new git version. If it's in the builtin
list, we don't have to update every repo's info/config,worktree.
--=20
Duy
