From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Summary of the problems with git pull
Date: Sun, 04 May 2014 19:29:40 -0500
Message-ID: <5366db742d494_18f9e4b308aa@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: "W. Trevor King" <wking@tremily.us>,
	Philip Oakley <philipoakley@iee.org>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Richard Hansen <rhansen@bbn.com>, Andreas Krey <a.krey@gmx.de>,
	Marat Radchenko <marat@slonopotamus.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 06 18:21:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Whhr8-0005Yp-2R
	for gcvg-git-2@plane.gmane.org; Tue, 06 May 2014 18:04:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753944AbaEEAkZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 May 2014 20:40:25 -0400
Received: from mail-ob0-f182.google.com ([209.85.214.182]:65369 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753891AbaEEAkY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 May 2014 20:40:24 -0400
Received: by mail-ob0-f182.google.com with SMTP id wn1so2943996obc.27
        for <git@vger.kernel.org>; Sun, 04 May 2014 17:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:subject:mime-version:content-type
         :content-transfer-encoding;
        bh=rskOgHmg6DXHOLG+H43bwTKJZPcOyN23KMOSJTSGk/8=;
        b=X/BFibaNWIh05p5NNL/YYQxur9H0XSTlwy7L6GZTcSH7Rwi7stFGW0zJOvP786Cpye
         GQS8146oGNs+K/9RKSZ9ES/nS0kv23fC9sai/hogXfhTgYwA1ijh01xqeHlDY+yZqSFj
         8/phin0QL1lEseAZpe6dqhdffExwNH0WdOIW+H0OXoY+ej+hPzAGYRXfEef9d9W0rln9
         mgQdLXqvtE9Ek0G/D60hNFhtmwW9z9AMHvetkTn4l/37HKNfo65+iW+HWjv26kgoQRBM
         E5t0hPL7MyRv4a3fDtlDJ6fmutNEwIEYF47cc1WiM/Y/1mNu6LcgiEpPkiHfgG/Nqo7T
         akYg==
X-Received: by 10.60.63.12 with SMTP id c12mr29581703oes.23.1399250423727;
        Sun, 04 May 2014 17:40:23 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id cn1sm30189537oeb.11.2014.05.04.17.40.19
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 04 May 2014 17:40:21 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248130>

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
