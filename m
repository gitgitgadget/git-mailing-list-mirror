From: Krzysztof Mazur <krzysiek@podlesie.net>
Subject: Re: Failure to extra stable@vger.kernel.org addresses
Date: Mon, 19 Nov 2012 16:18:45 +0100
Message-ID: <20121119151845.GA29678@shrek.podlesie.net>
References: <20121119095747.GA13552@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>
To: Felipe Balbi <balbi@ti.com>
X-From: git-owner@vger.kernel.org Mon Nov 19 16:20:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TaT7s-0003zl-Vg
	for gcvg-git-2@plane.gmane.org; Mon, 19 Nov 2012 16:19:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753110Ab2KSPSu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Nov 2012 10:18:50 -0500
Received: from [93.179.225.50] ([93.179.225.50]:54013 "EHLO shrek.podlesie.net"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1753033Ab2KSPSt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Nov 2012 10:18:49 -0500
Received: by shrek.podlesie.net (Postfix, from userid 603)
	id B6BA0F0C; Mon, 19 Nov 2012 16:18:45 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20121119095747.GA13552@arwen.pp.htv.fi>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210044>

On Mon, Nov 19, 2012 at 11:57:47AM +0200, Felipe Balbi wrote:
> Hi guys,
> 
> for whatever reason my git has started acting up with
> stable@vger.kernel.org addresses. It doesn't manage to extract a valid
> adress from the string:
> 
>  Cc: <stable@vger.kernel.org> # v3.4 v3.5 v3.6
> 
> Removing the comment at the end of the line makes things work again. I
> do remember, however, seeing this working since few weeks back I sent a
> mail to stable (in fact the same one I'm using to test), so this could
> be related to some perl updates, who knows ?!?

You probably just installed Email::Valid package.

The current git-send-email works a little better and just prints an error:

W: unable to extract a valid address from: <stable@vger.kernel.org> #v3.4 v3.5 v3.6


This patch should fix the problem, now after <email> any garbage is
removed while extracting address.

diff --git a/git-send-email.perl b/git-send-email.perl
index 5a7c29d..bb659da 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -828,7 +828,7 @@ sub extract_valid_address {
 	# check for a local address:
 	return $address if ($address =~ /^($local_part_regexp)$/);
 
-	$address =~ s/^\s*<(.*)>\s*$/$1/;
+	$address =~ s/^\s*<(.*)>.*$/$1/;
 	if ($have_email_valid) {
 		return scalar Email::Valid->address($address);
 	} else {

Krzysiek
