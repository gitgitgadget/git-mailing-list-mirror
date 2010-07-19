From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH v3 05/13] parse the -L options
Date: Tue, 20 Jul 2010 00:48:17 +0200
Message-ID: <201007200048.18284.trast@student.ethz.ch>
References: <1278829141-11900-1-git-send-email-struggleyb.nku@gmail.com> <AANLkTimNAyKZNdIIc6R5ylHuOVJho7UF0fnYC8jiaF9i@mail.gmail.com> <7vwrsrnwg0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Bo Yang <struggleyb.nku@gmail.com>, <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 20 00:48:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oaz8i-0008KQ-58
	for gcvg-git-2@lo.gmane.org; Tue, 20 Jul 2010 00:48:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966754Ab0GSWsn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Jul 2010 18:48:43 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:17568 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966583Ab0GSWsm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Jul 2010 18:48:42 -0400
Received: from CAS10.d.ethz.ch (172.31.38.210) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.254.0; Tue, 20 Jul
 2010 00:48:40 +0200
Received: from thomas.localnet (84.74.100.241) by cas10.d.ethz.ch
 (172.31.38.210) with Microsoft SMTP Server (TLS) id 14.0.702.0; Tue, 20 Jul
 2010 00:48:19 +0200
User-Agent: KMail/1.13.5 (Linux/2.6.31.12-0.2-desktop; KDE/4.4.5; x86_64; ; )
In-Reply-To: <7vwrsrnwg0.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151289>

Junio C Hamano wrote:
> It almost feels as if you want to have something more like
> 
>     -L <begin>,<end>[,<path>]
> 
> where <path> is mandatory for the first use of -L (i.e. missing ,<path>
> means the same path from the previous -L that has one) to make it clear
> that this is completely different from the normal pathspec.

I think that would just needlessly break the analogy to git-blame.[0]
With the current code,

  git blame -L 2,3 <path>
  git log -L 2,3 <path>

work the same.  Multiple -L options could be retrofitted to git-blame,
making

  git {blame,log} -L 2,3 -L 4,5 <path>

work as expected.

As long as you only give a single path, even blame disambiguates in
favour of the filename:

  git blame -L 2,3 master # wants a file 'master'

It only starts breaking down as soon as you put the -L further away
from the filename:

  git blame -L 2,3 master master # looks for the file master:master
  git blame master -L 2,3 master # ditto
  git log -L 2,3 master master   # errors out since the second file has no -L [1]
  git log master -L 2,3 master   # looks for the file master:master

And as you have noted, the -- can also cause weird effects.  Currently

  git log -L 2,3 --branches      # error
  git log -L 2,3 ./--branches    # ok
  git log -L 2,3 -- --branches   # error

The last one is unfortunate, but fixing it while allowing a natural
positioning of the -L would require parsing the -L after a --.  That's
just as inconsistent, only in a different way.


[0] It also requires special support from shell completion.

[1] I agree with erroring out but I think the message wrongly
    recommends path filtering (since that doesn't work well with
    renames):

      fatal: Path master need a -L <range> option
      If you want follow the history of the whole file whether to using 'git log' without -L or using 'git log -L 1,$ <path>'

    Bo, can you please change it to e.g.:

      fatal: Path 'master' needs a -L<range> option
      If you want to follow the history of the whole file, use 'git log -L 1,$ <path>'

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
