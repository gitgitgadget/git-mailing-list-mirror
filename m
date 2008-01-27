From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] cvsserver: Fix for histories with multiple roots
Date: Sat, 26 Jan 2008 17:56:47 -0800
Message-ID: <7v8x2cyqsg.fsf@gitster.siamese.dyndns.org>
References: <12013412461111-git-send-email-prohaska@zib.de>
	<12013412462758-git-send-email-prohaska@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Sun Jan 27 02:57:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JIwmC-0008QZ-A0
	for gcvg-git-2@gmane.org; Sun, 27 Jan 2008 02:57:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752470AbYA0B4z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jan 2008 20:56:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752487AbYA0B4y
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Jan 2008 20:56:54 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:51573 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752330AbYA0B4y (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jan 2008 20:56:54 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 3EDC740F1;
	Sat, 26 Jan 2008 20:56:52 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 9950040F0;
	Sat, 26 Jan 2008 20:56:49 -0500 (EST)
In-Reply-To: <12013412462758-git-send-email-prohaska@zib.de> (Steffen
	Prohaska's message of "Sat, 26 Jan 2008 10:54:06 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71796>

Steffen Prohaska <prohaska@zib.de> writes:

> Git histories may have multiple roots, which can cause
> git merge-base to fail and this caused git cvsserver to die.
>
> This commit teaches git cvsserver to handle a failing git
> merge-base gracefully, and modifies the test case to verify this.
> All the test cases now use a history with two roots.
>
> Signed-off-by: Steffen Prohaska <prohaska@zib.de>
> ---
>  git-cvsserver.perl              |    5 +++++
>  t/t9400-git-cvsserver-server.sh |   10 +++++++++-
>  2 files changed, 14 insertions(+), 1 deletions(-)
>
> diff --git a/git-cvsserver.perl b/git-cvsserver.perl
> index ecded3b..534b41e 100755
> --- a/git-cvsserver.perl
> +++ b/git-cvsserver.perl
> @@ -2543,6 +2543,11 @@ sub update
>                      if ($parent eq $lastpicked) {
>                          next;
>                      }
> +                    # or it may fail to find a merge base.  In this
> +                    # case we just ignore this merge.
> +                    if (system("git merge-base $lastpicked $parent >/dev/null 2>/dev/null")) {
> +                        next;
> +                    }
>                      my $base = safe_pipe_capture('git-merge-base',
>  						 $lastpicked, $parent);
>                      chomp $base;

That is a "Yes, but..." patch.

Running merge-base always twice, due to fear of uncommon case of
failure, feels quite backwards.

Doesn't this work equally well without running a rather
expensive merge-base twice?

 git-cvsserver.perl |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index ecded3b..afe3d0b 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -2543,8 +2543,15 @@ sub update
                     if ($parent eq $lastpicked) {
                         next;
                     }
-                    my $base = safe_pipe_capture('git-merge-base',
+		    my $base = eval {
+			    safe_pipe_capture('git-merge-base',
 						 $lastpicked, $parent);
+		    };
+		    # The two branches may not be related at all,
+		    # in which case merge base simply fails to find
+		    # any, but that's Ok.
+		    next if ($@);
+
                     chomp $base;
                     if ($base) {
                         my @merged;
