From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] grep: do not do external grep on skip-worktree entries
Date: Mon, 4 Jan 2010 03:09:40 -0500
Message-ID: <20100104080940.GA4815@coredump.intra.peff.net>
References: <87ljgfgbl0.fsf@catnip.gol.com>
 <fc339e4a1001021847hf1e1a7fq894de7908839ff77@mail.gmail.com>
 <877hrzga16.fsf@catnip.gol.com>
 <alpine.LFD.2.00.1001031124420.3630@localhost.localdomain>
 <7v3a2mzzg4.fsf@alter.siamese.dyndns.org>
 <20100104053125.GA5083@coredump.intra.peff.net>
 <7vbphaquwl.fsf@alter.siamese.dyndns.org>
 <20100104064408.GA7785@coredump.intra.peff.net>
 <7vhbr2pcsh.fsf@alter.siamese.dyndns.org>
 <20100104072659.GA10611@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Miles Bader <miles@gnu.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 04 09:09:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NRi0b-0001wI-A4
	for gcvg-git-2@lo.gmane.org; Mon, 04 Jan 2010 09:09:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753141Ab0ADIJo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Jan 2010 03:09:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752917Ab0ADIJo
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jan 2010 03:09:44 -0500
Received: from peff.net ([208.65.91.99]:56975 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752842Ab0ADIJo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jan 2010 03:09:44 -0500
Received: (qmail 13265 invoked by uid 107); 4 Jan 2010 08:14:28 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 04 Jan 2010 03:14:28 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 04 Jan 2010 03:09:40 -0500
Content-Disposition: inline
In-Reply-To: <20100104072659.GA10611@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136102>

On Mon, Jan 04, 2010 at 02:26:59AM -0500, Jeff King wrote:

> The pcre analysis there came from just using the "pcreposix" header, I
> think. From my limited research, modern pcre may have some tuning
> options (including a DFA engine!) that could do a lot better.

Hmm. I was able to get some improvements by using pcre_dfa_exec, but
still not as good as external grep. For "git grep 'foo.*bar'" in the
linux-2.6 repo, I got:

  external grep: 0.76s
  pcre_dfa_exec: 1.85s
      pcre_exec: 3.21s
          glibc: 4.00s

However, gprof reports that for the pcre dfa case, we spend more time in
grep.c:end_of_line than we do actually running the regex. So clearly
there are some other micro-optimizations in GNU grep that are making a
difference, too.

By the way, you can see the abysmal performance of our internal code by
doing a "git grep foo". It uses the "fixed" internal engine and weighs
in at 3.24s on the same machine, _slower_ than pcre doing an actual
regex.

-Peff
