From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] perl: redirect stderr to /dev/null instead of closing
Date: Thu, 4 Apr 2013 01:16:53 +0000
Message-ID: <20130404011653.GA28492@dcvr.yhbt.net>
References: <f3d238a4c6cfbc6d68f2c4fa285aefa93acf4b7d.1365027616.git.trast@inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Marcin Owsiany <marcin@owsiany.pl>,
	Petr Baudis <pasky@suse.cz>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Apr 04 03:17:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNYnq-0002q7-PA
	for gcvg-git-2@plane.gmane.org; Thu, 04 Apr 2013 03:17:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762267Ab3DDBQy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Apr 2013 21:16:54 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:40090 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761846Ab3DDBQx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Apr 2013 21:16:53 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C1BF1F5B8;
	Thu,  4 Apr 2013 01:16:53 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <f3d238a4c6cfbc6d68f2c4fa285aefa93acf4b7d.1365027616.git.trast@inf.ethz.ch>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219981>

Thomas Rast <trast@inf.ethz.ch> wrote:
> Closing stderr is a bad idea anyway: there is a very real chance that
> we print fatal error messages to some other file that just happens to
> be opened on the now-free FD 2.  So let's not do that.

100% agreed.  FD 0, 1, and 2 should not be closed, way too much
potential for triggering rare bugs and interop issues like these to be
worth it.

> --- a/perl/Git.pm
> +++ b/perl/Git.pm
> @@ -1495,6 +1495,9 @@ sub _command_common_pipe {
>  			if ($opts{STDERR}) {
>  				open (STDERR, '>&', $opts{STDERR})
>  					or die "dup failed: $!";
> +			} elsif (defined $opts{STDERR}) {
> +				open (STDERR, '>', '/dev/null')
> +					or die "opening /dev/null failed: $!";
>  			}
>  			_cmd_exec($self, $cmd, @args);
>  		}

Perhaps we should also do the following:

--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -1489,9 +1489,6 @@ sub _command_common_pipe {
 		if (not defined $pid) {
 			throw Error::Simple("open failed: $!");
 		} elsif ($pid == 0) {
-			if (defined $opts{STDERR}) {
-				close STDERR;
-			}
 			if ($opts{STDERR}) {
 				open (STDERR, '>&', $opts{STDERR})
 					or die "dup failed: $!";
