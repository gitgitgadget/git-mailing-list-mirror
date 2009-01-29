From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-cvsserver: handle CVS 'noop' command.
Date: Thu, 29 Jan 2009 14:45:15 -0800
Message-ID: <7v7i4denpg.fsf@gitster.siamese.dyndns.org>
References: <1232144521-21947-1-git-send-email-stefan.karpinski@gmail.com>
 <1233264914-7798-1-git-send-email-stefan.karpinski@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Stefan Karpinski <stefan.karpinski@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 29 23:47:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSfep-0002M3-KT
	for gcvg-git-2@gmane.org; Thu, 29 Jan 2009 23:46:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753290AbZA2WpW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jan 2009 17:45:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751921AbZA2WpW
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jan 2009 17:45:22 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:33625 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751775AbZA2WpV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jan 2009 17:45:21 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 59A5F2A094;
	Thu, 29 Jan 2009 17:45:20 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 96E492A08D; Thu,
 29 Jan 2009 17:45:17 -0500 (EST)
In-Reply-To: <1233264914-7798-1-git-send-email-stefan.karpinski@gmail.com>
 (Stefan Karpinski's message of "Thu, 29 Jan 2009 13:35:14 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 81D1287E-EE56-11DD-B7C0-F63E8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107744>

Stefan Karpinski <stefan.karpinski@gmail.com> writes:

> The implementation is trivial: ignore the 'noop' command
> if it is sent. This command is issued by some CVS clients,
> notably TortoiseCVS. Without this patch, TortoiseCVS will
> choke when git-cvsserver complains about the unsupported
> command.
>
> Signed-off-by: Stefan Karpinski <stefan.karpinski@gmail.com>
> ---
>
> Since this change has no negative impact, is too simple to
> be wrong, and improves interaction with some clients, it
> seem to me like a no-brainer to apply it.
>
>  git-cvsserver.perl |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/git-cvsserver.perl b/git-cvsserver.perl
> index fef7faf..c1e09ea 100755
> --- a/git-cvsserver.perl
> +++ b/git-cvsserver.perl
> @@ -188,7 +188,7 @@ while (<STDIN>)
>          # use the $methods hash to call the appropriate sub for this command
>          #$log->info("Method : $1");
>          &{$methods->{$1}}($1,$2);
> -    } else {
> +    } elsif ($1 ne 'noop') {
>          # log fatal because we don't understand this function. If this happens
>          # we're fairly screwed because we don't know if the client is expecting
>          # a response. If it is, the client will hang, we'll hang, and the whole
> -- 
> 1.6.0.3.3.g08dd8

Not a no-brainer at all, sorry.

Imagine what you would do when you discover another request a random other
client sends that you would want to ignore just like you did for 'noop'.
Viewed in this light, your patch is a very short sighted one that has a
big negative impact on maintainability.

A true no-brainer that has no negative impact would have been something
like the attached patch, that adds a method that does not do anything.

Even then, between req_CATCHALL and req_EMPTY, I am not sure which one is
expected by the clients, without consulting to the protocol documentation
for cvs server/client communication.  In the attached patch, I am guessing
from your patch that at least Tortoise does not expect any response to
it.

 git-cvsserver.perl |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git i/git-cvsserver.perl w/git-cvsserver.perl
index fef7faf..ca47e08 100755
--- i/git-cvsserver.perl
+++ w/git-cvsserver.perl
@@ -71,6 +71,7 @@ my $methods = {
     'log'             => \&req_log,
     'rlog'            => \&req_log,
     'tag'             => \&req_CATCHALL,
+    'noop'            => \&req_CATCHALL,
     'status'          => \&req_status,
     'admin'           => \&req_CATCHALL,
     'history'         => \&req_CATCHALL,
