From: Ingo Molnar <mingo@elte.hu>
Subject: Re: q: faster way to integrate/merge lots of topic branches?
Date: Wed, 23 Jul 2008 16:09:59 +0200
Message-ID: <20080723140959.GB9537@elte.hu>
References: <20080723130518.GA17462@elte.hu> <20080723174140.b749191a.vsu@altlinux.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sergey Vlasov <vsu@altlinux.ru>
X-From: git-owner@vger.kernel.org Wed Jul 23 16:11:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLf3g-00071u-Fj
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 16:11:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753223AbYGWOKN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2008 10:10:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753249AbYGWOKM
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 10:10:12 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:51209 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752976AbYGWOKL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 10:10:11 -0400
Received: from elvis.elte.hu ([157.181.1.14])
	by mx3.mail.elte.hu with esmtp (Exim)
	id 1KLf2X-0004RM-Bg
	from <mingo@elte.hu>; Wed, 23 Jul 2008 16:10:09 +0200
Received: by elvis.elte.hu (Postfix, from userid 1004)
	id 402753E21AB; Wed, 23 Jul 2008 16:09:55 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080723174140.b749191a.vsu@altlinux.ru>
User-Agent: Mutt/1.5.18 (2008-05-17)
Received-SPF: neutral (mx3: 157.181.1.14 is neither permitted nor denied by domain of elte.hu) client-ip=157.181.1.14; envelope-from=mingo@elte.hu; helo=elvis.elte.hu;
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -1.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.5 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.2.3
	-1.5 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89660>

* Sergey Vlasov <vsu@altlinux.ru> wrote:

> On Wed, 23 Jul 2008 15:05:18 +0200 Ingo Molnar wrote:
> 
> > Anyone can simulate it by switching to the linus/master branch of the
> > current Linux kernel tree, and doing:
> >
> >    time for ((i=0; i<140; i++)); do git-merge v2.6.26; done
> >
> >    real    1m26.397s
> >    user    1m10.048s
> >    sys     0m13.944s
> 
> Timing results here (E6750 @ 2.66GHz):
> 41.61s user 3.71s system 99% cpu 45.530 total
> 
> However, testing whether there is something new to merge could be
> performed significantly faster:
> 
> $ time sh -c 'for ((i=0; i<140; i++)); do [ -n "$(git rev-list --max-count=1 v2.6.26 ^HEAD)" ]; done'
> sh -c   5.49s user 0.26s system 99% cpu 5.786 total
> 
> The same loop with "git merge-base v2.6.26 HEAD" takes about 40 
> seconds here - apparently finding the merge base is the expensive 
> part, and it makes sense to avoid it if you expect that most of your 
> branches do not contain anything new to merge.

using git-fastmerge i get 2.4 seconds:

  $ time for ((i=0; i<140; i++)); do git-fastmerge v2.6.26; done
  [...]
  real    0m2.388s
  user    0m1.211s
  sys     0m1.131s

for something that 'progresses' in a forward manner (which merges do 
fundamentally) nothing beats the performance of a timestamped cache i 
think.

at least for my usecase.

Even assuming that the filesystem is sane, is my merge-cache 
implementation semantically equivalent to a git-merge? One detail is 
that i suspect it is not equivalent in the git-merge --no-ff case. (but 
that is a not too interesting non-default case anyway)

	Ingo
