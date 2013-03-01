From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH v8 4/5] Implement line-history search (git log -L)
Date: Fri, 1 Mar 2013 09:49:27 +0100
Message-ID: <87vc9b1p48.fsf@pctrast.inf.ethz.ch>
References: <cover.1362069310.git.trast@student.ethz.ch>
	<9af548b2a7e4a4da9eb30e99b0223f20788b4fc1.1362069310.git.trast@student.ethz.ch>
	<7vbob4iaxh.fsf@alter.siamese.dyndns.org>
	<7vmwuogjsm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Thomas Rast <trast@student.ethz.ch>, <git@vger.kernel.org>,
	Bo Yang <struggleyb.nku@gmail.com>,
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	Will Palmer <wmpalmer@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 01 09:49:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UBLfC-0003lt-Gw
	for gcvg-git-2@plane.gmane.org; Fri, 01 Mar 2013 09:49:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752207Ab3CAItd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Mar 2013 03:49:33 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:9583 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750721Ab3CAItc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Mar 2013 03:49:32 -0500
Received: from CAS22.d.ethz.ch (172.31.51.112) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Fri, 1 Mar
 2013 09:49:18 +0100
Received: from pctrast.inf.ethz.ch.ethz.ch (129.132.211.86) by CAS22.d.ethz.ch
 (172.31.51.112) with Microsoft SMTP Server (TLS) id 14.2.298.4; Fri, 1 Mar
 2013 09:49:27 +0100
In-Reply-To: <7vmwuogjsm.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Thu, 28 Feb 2013 14:23:05 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.211.86]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217266>

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Overall, I like this better than the "log --follow" hack; as the
>> revision traversal is done without any pathspec when being "careful
>> and slow" (aka -M), you do not suffer from the "just use a singleton
>> pathspec globally regardless of what other history paths are being
>> traversed" limitation of "log --follow".
>>
>> The patch series certainly is interesting.
>
> Having said that, I notice that "careful and slow" is just "too slow
> to be usable" even on a small tree like ours.  Try running
>
>     $ git log -M -L:get_name:builtin/describe.c
>
> and see how long you have to wait until you hit the first line of
> output.

I'll dig some more.  It *should* be essentially the following times
taken together:

  $ time git log --raw -M --topo-order >/dev/null

  real    0m5.448s
  user    0m4.599s
  sys     0m0.794s
  $ time git log -L:get_name:builtin/describe.c >/dev/null

  real    0m0.832s
  user    0m0.796s
  sys     0m0.032s

  $ time git log -L:get_name:builtin-describe.c 81b50f3ce40^ >/dev/null

  real    0m0.489s
  user    0m0.465s
  sys     0m0.022s

So I'm losing a factor of about 4 somewhere, which I can't explain right
now.

It could be improved further if --follow was fixed, because then the
first step should be much faster than diffing *all* the trees.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
