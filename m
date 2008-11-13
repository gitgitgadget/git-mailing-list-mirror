From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Edit recipient addresses with the --compose flag
Date: Wed, 12 Nov 2008 19:18:50 -0800
Message-ID: <7vskpwia91.fsf@gitster.siamese.dyndns.org>
References: <1226544602-1839-1-git-send-email-ian.hilt@gmx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Pierre Habouzit <madcoder@debian.org>
To: Ian Hilt <ian.hilt@gmx.com>
X-From: git-owner@vger.kernel.org Thu Nov 13 04:20:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0Sl4-000235-Ss
	for gcvg-git-2@gmane.org; Thu, 13 Nov 2008 04:20:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751081AbYKMDTX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Nov 2008 22:19:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751122AbYKMDTX
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Nov 2008 22:19:23 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:58615 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751026AbYKMDTW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Nov 2008 22:19:22 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 98832168A1;
	Wed, 12 Nov 2008 22:19:19 -0500 (EST)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 4068E168E1; Wed, 12 Nov 2008 22:18:52 -0500 (EST)
In-Reply-To: <1226544602-1839-1-git-send-email-ian.hilt@gmx.com> (Ian Hilt's
 message of "Wed, 12 Nov 2008 21:50:02 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: DC28363A-B131-11DD-A5B4-C128113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100848>

Ian Hilt <ian.hilt@gmx.com> writes:

> Sometimes specifying the recipient addresses can be tedious on the
> command-line.  This commit allows the user to edit the recipient
> addresses in their editor of choice.
>
> Signed-off-by: Ian Hilt <ian.hilt@gmx.com>
> ---
> Here's an updated commit with improved regex's from Junio and Francis.

This heavily depends on Pierre's patch, so I am CC'ing him for comments.
Until his series settles down, I cannot apply this anyway.

> @@ -489,6 +492,9 @@ GIT: for the patch you are writing.
>  GIT:
>  GIT: Clear the body content if you don't wish to send a summary.
>  From: $tpl_sender
> +To: $tpl_to
> +Cc: $tpl_cc
> +Bcc: $tpl_bcc
>  Subject: $tpl_subject
>  In-Reply-To: $tpl_reply_to
>  
> @@ -512,9 +518,31 @@ EOT
>  	open(C,"<",$compose_filename)
>  		or die "Failed to open $compose_filename : " . $!;
>  
> +	local $/;
> +	my $c_file = <C>;
> +	$/ = "\n";
> +	close(C);
> +
> +	my (@tmp_to, @tmp_cc, @tmp_bcc);
> +
> +	if ($c_file =~ /^To:\s*(\S.+?)\s*\nCc:/ism) {
> +		@tmp_to = get_recipients($1);
> +	}

Why "\S.+?" and not "\S.*?"?  A local user whose login name is 'q' is
disallowed?

Why does the user must keep "Cc:" in order for this new code to pick up
the list of recipients?  In other words, you are forbidding the user from
removing the entire "Cc:" line, even when the message should not be Cc'ed
to anywhere.  Instead there has to remain an empty Cc: line.  Worse yet,
such an empty "Cc:" line is printed to C2 with your patch and eventually
fed to sendmail.  I think it is a violation of 2822 to have Cc: that is
empty, as the format is specified as:

    cc              =       "Cc:" address-list CRLF
    bcc             =       "Bcc:" (address-list / [CFWS]) CRLF
    address-list    =       (address *("," address)) / obs-addr-list

> +	if ($c_file =~ /^Cc:\s*(\S.+?)\s*\nBcc:/ism) {
> +		@tmp_cc = get_recipients($1);
> +	}
> +	if ($c_file =~ /^Bcc:\s*(\S.+?)\s*\nSubject:/ism) {
> +		@tmp_bcc = get_recipients($1);
> +	}

Exactly the same comment applies to Bcc and Subject part of the parsing.

I think the parsing code you introduced simply suck.  Why isn't it done as
a part of the main loop to read the same file that already exists?

Unlike your additional code above that reads the whole file into a scalar
only to discard, the existing main loop processes one line at a file
(which should be more memory efficient), and you are not handling the
header continuation line anyway, processing one line at a time would make
your code much simpler (for one thing, you do not have to do /sm at all).
Also it won't be confused as your version would if the message happens to
have "To:" or "Cc:" in the message part, thanks to $in_body variable check
that is already in the code.
