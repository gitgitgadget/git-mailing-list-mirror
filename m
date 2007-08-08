From: bdowning@lavos.net (Brian Downing)
Subject: Re: git on Cygwin: Not a valid object name HEAD
Date: Tue, 7 Aug 2007 23:25:13 -0500
Message-ID: <20070808042513.GP21692@lavos.net>
References: <Pine.LNX.4.64.0708071257350.14781@racer.site> <f99nm6$9vi$1@sea.gmane.org> <f99rei$ou$1@sea.gmane.org> <20070807143616.GO9527@spearce.org> <20070807145825.GO21692@lavos.net> <66DD7425-6073-4CA8-BF01-BF07213A4804@zib.de> <30e4a070708071042g5623cb7ak724a8b8e588bd1da@mail.gmail.com> <07BB2580-4406-496F-8ACE-F6A03D1687BE@zib.de> <alpine.LFD.0.999.0708071439021.5037@woody.linux-foundation.org> <A80CCC35-DE1E-4A0B-9144-A8165AF6C98A@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Sebastian Schuberth <sschuberth@gmail.com>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Wed Aug 08 06:25:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IId7C-0003st-QJ
	for gcvg-git@gmane.org; Wed, 08 Aug 2007 06:25:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751599AbXHHEZ0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Aug 2007 00:25:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751892AbXHHEZ0
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Aug 2007 00:25:26 -0400
Received: from gateway.insightbb.com ([74.128.0.19]:7716 "EHLO
	asav07.insightbb.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751599AbXHHEZY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Aug 2007 00:25:24 -0400
Received: from 74-134-246-243.dhcp.insightbb.com (HELO mail.lavos.net) ([74.134.246.243])
  by asav07.insightbb.com with ESMTP; 08 Aug 2007 00:25:23 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AnA9ALTiuEZKhvbzRmdsb2JhbACBU4w7AQEBNQE
Received: by mail.lavos.net (Postfix, from userid 1000)
	id E2782309F31; Tue,  7 Aug 2007 23:25:13 -0500 (CDT)
Content-Disposition: inline
In-Reply-To: <A80CCC35-DE1E-4A0B-9144-A8165AF6C98A@zib.de>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55299>

On Wed, Aug 08, 2007 at 12:46:49AM +0200, Steffen Prohaska wrote:
> I started to run the tests on cygwin in textmode. I chose the
> following setup.

In addition to all the other stuff discussed, I believe you also need
to worry about the binaryness of stdin and stdout.

Looking at:

http://www.cygwin.com/cygwin-ug-net/using-textbinary.html

I think this can be achieved by putting something like:

	setmode(0, O_BINARY);
	setmode(1, O_BINARY);

at the start of git's main().

When I was trying to get this to work, I did this as well as fixing up
open() and fopen() calls as has already been discussed.  What got me
to quit, however, was that I never found a decent way to make the Git
shell scripts binary safe, and enough of the system was in shell as to
make it pretty much useless for everyday use.

Looking at the examples on the above page:

    To illustrate the various rules, we provide scripts to delete CRs from
    files by using the tr program, which can only write to standard output.
    The script

    #!/bin/sh
    # Remove \r from the file given as argument
    tr -d '\r' < "$1" > "$1".nocr

    will not work on a text mounted systems because the \r will be
    reintroduced on writing. However scripts such as

    #!/bin/sh
    # Remove \r from the file given as argument
    tr -d '\r' | gzip | gunzip > "$1".nocr

    work fine. In the first case (assuming the pipes are binary) we rely
    on gunzip to set its output to binary mode, possibly overriding the
    mode used by the shell.

was all it took to convince me this was probably a fool's errand.

I wound up fixing our software so it would build on a binary mount,
which I decided was a much more sane solution.

-bcd
