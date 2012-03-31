From: Mark Lodato <lodatom@gmail.com>
Subject: Re: Maintaining historical data in a git repo
Date: Fri, 30 Mar 2012 21:04:18 -0400
Message-ID: <CAHREChiNbEVGR1+xvOhAa2Yg35N2O+JreF-mVm793bZGWzu+rw@mail.gmail.com>
References: <CA+P+rLeyEcZPudhLWavB74CiDAqpn+iNkk4F8=NK_yGaJPMmyA@mail.gmail.com>
 <201203301510.q2UFAqn6003864@no.baka.org> <CA+P+rLcWT0SZQjW2LtFXXCDRwjMp8daJ2hVup=7cnsRGbKw7xw@mail.gmail.com>
 <7vehsam3pn.fsf@alter.siamese.dyndns.org> <CA+P+rLeDFu4KgEZPw=k67iMWVVGcZ3q48VZjgXNLXn3NdyQnow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Seth Robertson <in-gitvger@baka.org>
To: Yuval Adam <yuv.adm@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 31 03:05:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDmkn-0001NF-PJ
	for gcvg-git-2@plane.gmane.org; Sat, 31 Mar 2012 03:05:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759092Ab2CaBEl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Mar 2012 21:04:41 -0400
Received: from mail-pz0-f52.google.com ([209.85.210.52]:42652 "EHLO
	mail-pz0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752932Ab2CaBEj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Mar 2012 21:04:39 -0400
Received: by dake40 with SMTP id e40so126808dak.11
        for <git@vger.kernel.org>; Fri, 30 Mar 2012 18:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=XqvXwOVuSve6O9aCWXl3lvi0mdlzZKVIRCE3fgz2h2w=;
        b=1DK4vzw6VOI82+FrguyOFoNXxRM1YBd5krY169zcJsa/B2Z76t3m2S6drJUyLjZCRe
         jC/JqIVhZw103ypiWwOFx1deqAyvTrIHik1/GNkLRRgV0rXHgOMvROwRfyHeFkWtCBOw
         J+MUwD4rued6DmP1+bw8g65Canu0K4X0d/TNVqmRLkrKVOSjBk+XPYhHX3Kmem8bty0R
         BKyR3o8kXMchWQl9OTCfdcdlJAgRf6rB0i/k8S4ibPMhpGju4Y4DVYH2QgmqGqf+awch
         AeJQSSZpKoGZHWwNrJOJsEAuBLG2bk3XgDFxDwYBbOb5AIs3fRDZ4fiHVBxhrG/Frcjd
         rlVA==
Received: by 10.68.222.165 with SMTP id qn5mr1595026pbc.88.1333155879127; Fri,
 30 Mar 2012 18:04:39 -0700 (PDT)
Received: by 10.143.39.9 with HTTP; Fri, 30 Mar 2012 18:04:18 -0700 (PDT)
In-Reply-To: <CA+P+rLeDFu4KgEZPw=k67iMWVVGcZ3q48VZjgXNLXn3NdyQnow@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194426>

On Fri, Mar 30, 2012 at 4:39 PM, Yuval Adam <yuv.adm@gmail.com> wrote:
> However, we perceive git as a very powerful tool, that can fit
> beautifully with the way legislation works today.
> The challenge for us - should we choose to accept it ;) - is to build
> a set of wrapper tools that allow us to use git in such a way, while
> enabling us to build up past history.

If you're willing to put some time into either writing new tools or
doing complicated work by hand, you could use git to keep track of the
history's history.  Have two branches: a real "master" branch and a
"meta" branch to keep track of master's history.  The former is what
end users would see: the most accurate history of the code to date.
The latter is what "developers" would use to rebuild the master branch
with new information (say, adding A before B and C).

To do this, you could try the following: Use normal git commands on
the master branch, but every time you change master (say, commit or
rebase), also make a special commit on the meta branch with the first
parent being a reference to the new value of master.  Use the
remaining parents as "normal" references to previous meta commits, and
use an empty tree.  Now, the meta branch contains a complete history
of the history, though viewing it will be extremely ugly unless you
develop a custom tool to deal with its special form.

Optionally, on the server, you could set up an update hook to disallow
updates of the master branch and disallow non-fast-forward updates of
the meta branch, and a post-receive hook to the master branch to point
to the first parent of the meta branch each time the meta branch is
updated.

One caveat is that you must be careful about merges on the meta
branch, since git's default strategy will automatically do the wrong
thing.  You could write your own merge strategy to handle this.
(Sadly there does not appear to be a way to use this strategy
automatically on per-branch basis.)  Another workaround would be to
use something that is unmergable in the tree of the meta commit,
rather than an empty tree - say, a single file with the commit ID of
the master branch - which would prevent the default strategy from
trivially and incorrectly merging.

Using such a system would be awkward by hand but not terribly
difficult to automate.  You could create a "git-meta-commit" command
to create a meta commit for the current branch.  You might find
contrib/examples/git-merge.sh useful as a guide for how to do this.
If you'd like more details, please ask.

It would be nice if you could write a hook that automatically creates
a meta commit every time master's reflog is updated, but this does not
seem possible at the moment.
