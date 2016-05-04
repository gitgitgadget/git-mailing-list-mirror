From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v4 1/2] Documentation: fix linkgit references
Date: Wed, 4 May 2016 16:06:36 -0400
Message-ID: <20160504200635.GA22787@sigill.intra.peff.net>
References: <E4A56B4E-6F2E-44E3-870B-D1D3A71B2869@gmail.com>
 <1462351116-19308-1-git-send-email-larsxschneider@gmail.com>
 <1462351116-19308-2-git-send-email-larsxschneider@gmail.com>
 <F6210682-2FCA-423D-B6D3-06938C95D497@gmail.com>
 <5729DF25.7030503@ramsayjones.plus.com>
 <xmqqd1p1ivfw.fsf@gitster.mtv.corp.google.com>
 <xmqqvb2thczf.fsf@gitster.mtv.corp.google.com>
 <20160504192516.GD21259@sigill.intra.peff.net>
 <xmqq7ff9h9zo.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Lars Schneider <larsxschneider@gmail.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	git@vger.kernel.org, Matthieu.Moy@grenoble-inp.fr,
	sbeller@google.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 04 22:06:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ay34F-0006Hi-4O
	for gcvg-git-2@plane.gmane.org; Wed, 04 May 2016 22:06:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752873AbcEDUGj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2016 16:06:39 -0400
Received: from cloud.peff.net ([50.56.180.127]:34175 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751311AbcEDUGj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2016 16:06:39 -0400
Received: (qmail 877 invoked by uid 102); 4 May 2016 20:06:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 04 May 2016 16:06:38 -0400
Received: (qmail 13475 invoked by uid 107); 4 May 2016 20:06:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 04 May 2016 16:06:50 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 04 May 2016 16:06:36 -0400
Content-Disposition: inline
In-Reply-To: <xmqq7ff9h9zo.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293580>

On Wed, May 04, 2016 at 12:57:31PM -0700, Junio C Hamano wrote:

> > Is it worth just making this a perl script, rather than a shell script
> > with a giant inline perl script? Perl is actually really good at doing
> > that "grep" as it reads the file. :)
> 
> OK.

Hmm. This new version uses File::Find:

> +sub lint_it {
> +	lint($File::Find::name) if -f;
> +}
> +
> +find({ wanted => \&lint_it, no_chdir => 1 }, "Documentation");

That will inspect non-source files, too.

Would:

  open(my $files, '-|', qw(git ls-files));
  while (<$files>) {
    chomp;
    ...
  }

make sense? Or a simpler but non-streaming spelling:

  my @files = map { chomp; $_ } `git ls-files`;

Or just taking the list of files on the command line as your original
did, and feeding `ls-files` from the caller. That also lets you do
"link-gitlink git-foo.txt", etc.

-Peff
