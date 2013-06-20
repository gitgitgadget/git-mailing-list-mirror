From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: Splitting a rev list into 2 sets
Date: Thu, 20 Jun 2013 15:20:07 +0200
Message-ID: <8761x87wc8.fsf@linux-k42r.v.cablecom.net>
References: <CAC9WiBi-E+LN4hKGeu0mG7ihJWCaTg-W1Dx_PWmX_vsx-uLOaw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>
To: Francis Moreau <francis.moro@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 20 15:20:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Upemg-0007bd-KT
	for gcvg-git-2@plane.gmane.org; Thu, 20 Jun 2013 15:20:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965519Ab3FTNUN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Jun 2013 09:20:13 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:33579 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965039Ab3FTNUK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Jun 2013 09:20:10 -0400
Received: from CAS20.d.ethz.ch (172.31.51.110) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Thu, 20 Jun
 2013 15:20:04 +0200
Received: from linux-k42r.v.cablecom.net.ethz.ch (129.132.153.233) by
 CAS20.d.ethz.ch (172.31.51.110) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Thu, 20 Jun 2013 15:20:07 +0200
In-Reply-To: <CAC9WiBi-E+LN4hKGeu0mG7ihJWCaTg-W1Dx_PWmX_vsx-uLOaw@mail.gmail.com>
	(Francis Moreau's message of "Thu, 20 Jun 2013 12:14:22 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228499>

Francis Moreau <francis.moro@gmail.com> writes:

> Hello,
>
> I'd like to write a script that would parse commits in one of my repo.
> Ideally this script should accept any revision ranges that
> git-rev-list would accept.
>
> This script should consider commits in master differently than the
> ones in others branches.
>
> To get the commit set which can't be reached by master (ie commits
> which are specific to branches other than master) I would do:
>
>   # "$@" is the range spec passed to the script
>   git rev-list "$@" ^master | check_other_commit
>
> But I don't know if it's possible to use a different git-rev-list
> command to get the rest of the commits, ie the ones that are reachable
> by the specified range and master.
>
> One way to do that is to record the first commit set got by the first
> rev-list command and check that the ones returned by "git rev-list $@"
> are not in the record.
>
> But I'm wondering if someone can see another solution more elegant ?

I think there's a cute way.  Suppose your arguments are of the form

  p1 p2 ... --not n1 n2 ...

that is each pX is positive, and each nX is negative.  Then as you
observed, building the difference with master is easy: just add it to
the negative args.

Intersecting with master is harder, because you don't know what parts of
it (if any) are in the range.  But the --boundary option can help: these
are the commits where the positive and negative ranges "first" met, and
prevented the walk from continuing.

So the part of master reachable from p1, p2, etc. is exactly the set of
boundary commits of 'p1 p2 ... ^master'.  And on top of that, excluding
the parts reachable from the n's is easy.  So you can do:

  positive=$(git rev-parse "$@" | grep -v '^\^')
  negative=$(git rev-parse "$@" | grep '^\^')
  boundary=$(git rev-list --boundary $positive ^master | sed -n 's/^-//p')
  # the intersection is
  git rev-list $boundary $negative

I haven't tested it much, however.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
