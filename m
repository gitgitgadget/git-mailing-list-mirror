From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH] t5570: forward git-daemon messages in a different way
Date: Thu, 26 Apr 2012 21:55:04 +0200
Message-ID: <20120426195503.GA29526@ecki>
References: <1334393070-7123-1-git-send-email-zbyszek@in.waw.pl>
 <20120414121358.GA26372@ecki>
 <20120414122127.GA31220@ecki>
 <4F8C3E0F.2040300@in.waw.pl>
 <20120416174230.GA19226@sigill.intra.peff.net>
 <20120416224424.GA10314@ecki>
 <20120419060326.GA13982@sigill.intra.peff.net>
 <4F8FB779.60004@viscovery.net>
 <20120426130129.GA27785@sigill.intra.peff.net>
 <4F999105.200@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>,
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	git@vger.kernel.org, gitster@pobox.com
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Thu Apr 26 22:15:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SNV5j-0002pm-Fe
	for gcvg-git-2@plane.gmane.org; Thu, 26 Apr 2012 22:15:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758979Ab2DZUO4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Apr 2012 16:14:56 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:29368 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756335Ab2DZUO4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Apr 2012 16:14:56 -0400
Received: from [127.0.0.1] (p5B22E546.dip.t-dialin.net [91.34.229.70])
	by bsmtp.bon.at (Postfix) with ESMTP id 601382C4004;
	Thu, 26 Apr 2012 22:15:39 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4F999105.200@kdbg.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196406>

On Thu, Apr 26, 2012 at 08:16:37PM +0200, Johannes Sixt wrote:
> 
> @@ -30,10 +30,10 @@ start_git_daemon() {
>  		"$@" "$GIT_DAEMON_DOCUMENT_ROOT_PATH" \
>  		>&3 2>git_daemon_output &
>  	GIT_DAEMON_PID=$!
> +	exec 7<git_daemon_output &&
>  	{
> -		read line
> +		read line <&7
>  		echo >&4 "$line"
> -		cat >&4 &
>  
>  		# Check expected output
>  		if test x"$(expr "$line" : "\[[0-9]*\] \(.*\)")" != x"Ready to rumble"
> @@ -43,7 +43,9 @@ start_git_daemon() {
>  			trap 'die' EXIT
>  			error "git daemon failed to start"
>  		fi
> -	} <git_daemon_output
> +		cat <&7 >&4 &
> +		exec 7<&-
> +	}

I won't pretend to understand why this works. I have to study this some
more. But if this is 'correct', then it is obviously preferable to the
comparatively complicated wrapper.

We should move the cat <&7 >&4 & and exec 7<&- part in front of the
output check, otherwise output would be truncated in an error condition.
This can be tested by passing an invalid argument to git daemon above,
for example.

Clemens
