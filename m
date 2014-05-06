From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Summary of the problems with git pull
Date: Tue, 6 May 2014 05:58:03 -0500
Message-ID: <CAMP44s1tJAGVcQc=Y5L5TP7MTro9C9hPnN1NR-nDT3YczjwjTA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "W. Trevor King" <wking@tremily.us>,
	Philip Oakley <philipoakley@iee.org>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Richard Hansen <rhansen@bbn.com>, Andreas Krey <a.krey@gmx.de>,
	Marat Radchenko <marat@slonopotamus.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 06 19:55:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WhiNp-0008Bg-Pa
	for gcvg-git-2@plane.gmane.org; Tue, 06 May 2014 18:38:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934687AbaEFK6I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 May 2014 06:58:08 -0400
Received: from mail-lb0-f177.google.com ([209.85.217.177]:60841 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934579AbaEFK6F (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 May 2014 06:58:05 -0400
Received: by mail-lb0-f177.google.com with SMTP id z11so6272512lbi.8
        for <git@vger.kernel.org>; Tue, 06 May 2014 03:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=rskOgHmg6DXHOLG+H43bwTKJZPcOyN23KMOSJTSGk/8=;
        b=JVT7+bK6dJuaGGh//Wdjdne6XZW37kMtp01+gl7fSkMSMPvcJ0VmSEbWdsfiyqZndg
         AfceU1C/Ko5j3HS2BXaQ0emfsJDWLqceTXAAx50woBN3qJzsXfeH/yviKLePdIwmOctp
         Jl1mtt6eQgYmYF9ozUGoO6H7An/n1np5DmnZutGMPU+z0gqzVdt4Wi9iWSTdYkONFiZL
         Bug2ELS6yhu1/nRUtVOmC1PmpdQHMITSijSECryetUUwEU5W9itS90TOb3CMQ+uMGKa2
         tFLv0vESQKO2klsH+mtSzUS1MMtagrSX2K6K10xMdNExPSnX/YCHKj5W8VvTnFMhCN6t
         DUhg==
X-Received: by 10.112.139.166 with SMTP id qz6mr31044018lbb.13.1399373883056;
 Tue, 06 May 2014 03:58:03 -0700 (PDT)
Received: by 10.114.194.6 with HTTP; Tue, 6 May 2014 03:58:03 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248196>

Hi,

There has been a lot of discussion about why `git pull` is broken for so
many many workflows: [1][2][3][4][5], even as far back as [6].

Many issues has been brought up, and many proposed solutions, probably
too many for most people properly digest them, so here I'll try to
synthesize them.

Mainly there are two core problems with `git pull`:

 1) Many times it does a merge when it's not when people want
 2) Many times it does a merge opposite of the desired direction

The issue comes in trying to solve these problems in a way that would
not affect anybody negatively.

The simplest way to fix these issues unobtrusively would be to add
configurations for the new behavior. However, this wouldn't solve the
problem because as it has been discussed the vast majority of people
doing these "bad merges" are not advanced users, so they wouldn't
activate these options.

What is needed is to change the default behavior, but in a way that is
not obtrusive, and with backwards compatibility configuration.

The most concrete proposal is my patch series that puts everything in
place to enable fast-forward merged by default only. However, that still
doesn't solve the problem of the ordering of parents. Normally these two
issues would be independent of each other, but after further analysis I
think they are not.

== Two different kinds of pulls ==

It has become clear that the `git pull` command is in fact used to do
two very different things:

 1) Update the current branch

Most people do `git pull` like they would do `svn update`; to update
their current branch.

 2) Merge a remote branch

There are many use-cases of this.

The agreement so far is that 1) is the one that is broken, that is; a)
by default only fast-forwards should be allowed, and b) when a merge
happens the parents should be reverted (merge 'master' to
'origin/master').

It would be possible to differentiate these kinds by saying a `git pull`
that doesn't specify the location can be assumed as 1), and a
`git pull remote branch` that does as 2). Another possibility is to
assume only the upstream branch corresponds to 1).

Unfortunately it's the feeling of many people that this solution is not
"clean", because it's two very different behaviors for the same command.
Furthermore even deeper analysis of the use-cases demonstrates there
would be a need to have different configurations for the different modes
(e.g. pull.updateMode and pull.integrateMode).

== git update ==

Another proposed solution is to have a new command: `git update`. This
command would be similar to `git pull --ff-only` by default, but it
could be configured to do merges instead, and when doing so in reverse.

An interesting side-effect of this new command is that it opens the
possibility of thinking about `git update --rebase` vs.
`git pull --rebase`.

For example:

  a) git update --merge

     Merge HEAD into @{upstream}

  b) git update --rebase

     Rebase HEAD onto @{upstream}

  c) git pull --merge github john

     Merge github/john into HEAD

  d) git pull --rebase github john

     Rebase github/john onto HEAD

Notice how the relationships between them are nice and consistent. Also,
d) was not possible before.

This solves essentially all the issues people presented in their
use-cases, except the differentiation between merging topic and upstream
branches, for which we might want to add different options in
`git pull`, but that's independent from the issues I mentioned at the
beginning.

Nothing changes for the users of `git pull`, except that perhaps we
would want --rebase to work in reverse, since the current
`git pull --rebase` would already rebase HEAD onto @{upstream}.

Personally my next step would be to port the changes I did for
pull.mode = merge-ff-only into a new command `git update`, which would
probably be a copy-paste from `git pull` and see how that turns out. In
addition, when running `git pull` without arguments we might want to add
a temporary notice explaining that perhaps the user wanted to type
`git update` instead.

Cheers.

[1] http://article.gmane.org/gmane.comp.version-control.git/233554
[2] http://article.gmane.org/gmane.comp.version-control.git/234295
[3] http://article.gmane.org/gmane.comp.version-control.git/225146
[4] http://article.gmane.org/gmane.comp.version-control.git/247237
[5] http://article.gmane.org/gmane.comp.version-control.git/247939
[6] http://article.gmane.org/gmane.comp.version-control.git/130819

-- 
Felipe Contreras
