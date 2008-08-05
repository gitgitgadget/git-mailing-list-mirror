From: Jim Meyering <jim@meyering.net>
Subject: Re: [PATCH] git-cvsimport.perl: Print "UNKNOWN LINE..." on stderr, not stdout.
Date: Tue, 05 Aug 2008 17:44:03 +0200
Message-ID: <87tzdzo4ak.fsf@rho.meyering.net>
References: <87zlnro6kt.fsf@rho.meyering.net>
	<20080805152836.GB21901@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Aug 05 17:45:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQOih-0004wB-8Y
	for gcvg-git-2@gmane.org; Tue, 05 Aug 2008 17:45:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757871AbYHEPoH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Aug 2008 11:44:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756654AbYHEPoH
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Aug 2008 11:44:07 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:45501 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758866AbYHEPoG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Aug 2008 11:44:06 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id AA15B1AB2FC
	for <git@vger.kernel.org>; Tue,  5 Aug 2008 17:44:03 +0200 (CEST)
Received: from mx.meyering.net (mx.meyering.net [82.230.74.64])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 961D31AB2CD
	for <git@vger.kernel.org>; Tue,  5 Aug 2008 17:44:03 +0200 (CEST)
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000)
	id 7A58D6A82B; Tue,  5 Aug 2008 17:44:03 +0200 (CEST)
In-Reply-To: <20080805152836.GB21901@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 5 Aug 2008 11:28:36 -0400")
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91445>

Jeff King <peff@peff.net> wrote:
> On Tue, Aug 05, 2008 at 04:54:42PM +0200, Jim Meyering wrote:
>
>> I'm used to filtering git-cvsimport's noisy stderr, but this
>> diagnostic appears on stdout.  Looks like an oversight.
>> Now that I'm using cvsps-2.2b1, I see tons of these.
>
> There are a ton of things that go to stdout:
>
>   $ perl -ne '/print (\S+)/ && print "$1\n" git-cvsimport.perl |
>     grep '^#' | wc -l
>   18
>
> though many are only activated via "-v". Maybe it is worth putting all
> of them to stderr? I really don't see why cvsimport should ever produce
> any output on stdout.

A quick scan (post-patch)

    $ grep 'print ' git-cvsimport.perl|grep -vE 'STDERR|opt_v'
    print $f "$_=$conv_author_name{$_} <$conv_author_email{$_}>\n";
    print $fh $line;
    print $fh $buf;
    print $cvspsfh $_;
    print $fh
    print "SKIPPING $fn v $rev\n";

suggests that if you don't count the "SKIPPING..." diagnostic you'd get
for each "-S REGEXP"-skipped name, the "UNKNOWN LINE" diagnostic is the
only one that goes to stdout but that is not protected by an $opt_v guard.
