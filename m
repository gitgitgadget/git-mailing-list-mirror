From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] cvsexportcommit: chomp only removes trailing
 whitespace
Date: Wed, 14 May 2008 10:58:33 -0700
Message-ID: <7vskwkojhy.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.00.0805141526160.30431@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robin Rosenberg <robin.rosenberg@dewire.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed May 14 20:00:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JwLGc-0008Jz-7l
	for gcvg-git-2@gmane.org; Wed, 14 May 2008 19:59:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759179AbYENR6r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2008 13:58:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759041AbYENR6r
	(ORCPT <rfc822;git-outgoing>); Wed, 14 May 2008 13:58:47 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:61498 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758924AbYENR6p (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2008 13:58:45 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 693CA160F;
	Wed, 14 May 2008 13:58:44 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 3E6C0160A; Wed, 14 May 2008 13:58:38 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0805141526160.30431@racer> (Johannes
 Schindelin's message of "Wed, 14 May 2008 15:27:05 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 64D6731C-21DF-11DD-B162-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82122>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> In commit fef3a7cc(cvsexportcommit: be graceful when "cvs status"
> reorders the arguments), caution was taken to get the status even
> for files with leading or trailing whitespace.
>
> However, the author of that commit missed that chomp() removes only
> trailing whitespace.  But the author realized his mistake.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>
> 	Really my fault.

I am not quite sure if I understand what is going on correctly.

Is this about a filename that has leading or trailing whitespace, or
lazily not parsing a protocol message but attempting to match with
possible whitespaces around the place where a filename should be?

If you are saying that the output from cvs status is so unreliable that we
can only strip all whitespaces from both ends and hope for the best
(e.g. files " a" (two leading spaces in the name), "a " (two trailing
spaces in the name), and "a" (no such funny spaces) cannot be
distinguished from cvs status output), then perhaps you would also need to
remove as many trailing whitespaces as you can?

"chomp()" chomps only a single line terminator, and only if one exists.

        sub foo {
                my ($a) = @_;
                chomp($a);
                print join(" ", map { sprintf "%02x", ord($_) } split(//, $a)), "\n";
        }
        foo("abc");    # 61 62 63
        foo("def\n");  # 64 65 66
        foo("gh \n");  # 67 68 20
        foo("ij\n\n"); # 69 6a 0a

>  git-cvsexportcommit.perl |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/git-cvsexportcommit.perl b/git-cvsexportcommit.perl
> index b6036bd..3b20bd1 100755
> --- a/git-cvsexportcommit.perl
> +++ b/git-cvsexportcommit.perl
> @@ -211,6 +211,7 @@ if (@canstatusfiles) {
>  
>  	$basename = "no file " . $basename if (exists($added{$basename}));
>  	chomp($basename);
> +	$basename =~ s/^\s+//;
>  
>  	if (!exists($fullname{$basename})) {
>  	  $fullname{$basename} = $name;
> -- 
> 1.5.5.1.375.g1becb
