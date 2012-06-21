From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: how to benchmark git commands
Date: Thu, 21 Jun 2012 09:28:40 +0200
Message-ID: <87k3z1rumv.fsf@thomas.inf.ethz.ch>
References: <jrt88s$h70$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: <git@vger.kernel.org>
To: Neal Kreitzinger <nkreitzinger@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 21 09:28:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Shbou-0001lj-Dx
	for gcvg-git-2@plane.gmane.org; Thu, 21 Jun 2012 09:28:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758548Ab2FUH2n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jun 2012 03:28:43 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:34336 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757585Ab2FUH2n (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jun 2012 03:28:43 -0400
Received: from CAS20.d.ethz.ch (172.31.51.110) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Thu, 21 Jun
 2012 09:28:36 +0200
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by CAS20.d.ethz.ch
 (172.31.51.110) with Microsoft SMTP Server (TLS) id 14.2.298.4; Thu, 21 Jun
 2012 09:28:40 +0200
In-Reply-To: <jrt88s$h70$1@dough.gmane.org> (Neal Kreitzinger's message of
	"Wed, 20 Jun 2012 14:28:28 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200397>

Neal Kreitzinger <nkreitzinger@gmail.com> writes:

> I want to benchmark how long it takes commands like git-gc, git-fsck,
> etc. to run against our canonical repo.  What is the correct way to do
> this?  I am being asked how much time such commands would add to
> automated on-demand push scripts.

Umm, what's wrong with

$ time git fsck

The bigger question is: do you want to measure hot or cold performance?
For most operations it is more useful to measure the hot performance, as
the repo will be hot anyway.  But in the fsck case I wouldn't be so
sure; it's entirely possible that it "usually" faults a bunch of loose
objects that were otherwise unused, taking some extra time.  So there
may be some value in first running (as root)

$ echo 3 >/proc/sys/vm/drop_caches

to get cold-cache measurements.

Besides, if you feel like properly evaluating performance in your
repository, you can look in t/perf/README.  Then point GIT_PERF_REPO at
your repo of choice, and write tests as needed (for example, there is
currently no perf test for fsck).

That said, both gc and fsck are so slow on even medium-size repositories
(like git.git) that you should probably put them in a nightly cronjob
instead.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
