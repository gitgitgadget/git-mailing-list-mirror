From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/4] Teach git-add--interactive to accept a file path
	to patch
Date: Wed, 21 Nov 2007 10:21:18 -0500
Message-ID: <20071121152118.GG24108@sigill.intra.peff.net>
References: <1195648601-21736-1-git-send-email-win@wincent.com> <1195648601-21736-2-git-send-email-win@wincent.com> <1195648601-21736-3-git-send-email-win@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Wed Nov 21 16:22:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IurOY-00023B-P8
	for gcvg-git-2@gmane.org; Wed, 21 Nov 2007 16:21:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756452AbXKUPVW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Nov 2007 10:21:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755971AbXKUPVW
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Nov 2007 10:21:22 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2674 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755404AbXKUPVV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Nov 2007 10:21:21 -0500
Received: (qmail 8357 invoked by uid 111); 21 Nov 2007 15:21:19 -0000
Received: from c-24-125-35-113.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (24.125.35.113)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Wed, 21 Nov 2007 10:21:19 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 21 Nov 2007 10:21:18 -0500
Content-Disposition: inline
In-Reply-To: <1195648601-21736-3-git-send-email-win@wincent.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65663>

On Wed, Nov 21, 2007 at 01:36:39PM +0100, Wincent Colaiuta wrote:

> If supplied a single file path parameter the git-add--interactive script
> now bypasses the command loop and jumps straight to the patch subcommand
> using the passed path. After returning from the subcommand the main
> command loop is entered. If a non-resolvable path is supplied the
> operation is a no-op and the command loop is entered.

Great, the lack of this feature has bugged me in the past. Thank you for
working on it. However...

> diff --git a/git-add--interactive.perl b/git-add--interactive.perl
> index fb1e92a..8f21c03 100755
> --- a/git-add--interactive.perl
> +++ b/git-add--interactive.perl
> @@ -803,6 +803,11 @@ sub main_loop {
>  	}
>  }
>  
> +die "add --interactive may take only 1 optional parameter" if ($#ARGV > 0);
>  refresh();
> +if ($#ARGV == 0) {
> +	patch_update_file($ARGV[0]);
> +}
>  status_cmd();
>  main_loop();
> +

Why only one file? How about something like this instead:

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index fb1e92a..8036c95 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -804,5 +804,8 @@ sub main_loop {
 }
 
 refresh();
+foreach my $file (@ARGV) {
+	patch_update_file($file);
+}
 status_cmd();
 main_loop();


On top of that, it would be great to be able to do something like

  git-add -i *.c

and just get prompted for changed files (right now, you only get
prompted for changed files, but unchanged files seem to print a spurious
newline).

And at any rate, this would require fixing 3/4 to handle the multiple
files from git-add.

What do you think?

-Peff
