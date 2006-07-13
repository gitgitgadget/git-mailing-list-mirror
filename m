From: Edgar Toernig <froese@gmx.de>
Subject: Re: [PATCH 2/5] daemon: if one of the standard fds is missing open
 it to /dev/null
Date: Thu, 13 Jul 2006 15:27:25 +0200
Message-ID: <20060713152725.7a5081df.froese@gmx.de>
References: <E1G0zj7-0001c1-8q@moooo.ath.cx>
	<E1G0znB-0002IO-61@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 13 15:27:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G11EC-0006JR-Oa
	for gcvg-git@gmane.org; Thu, 13 Jul 2006 15:27:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751244AbWGMN1a (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 13 Jul 2006 09:27:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751472AbWGMN1a
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Jul 2006 09:27:30 -0400
Received: from mail.gmx.net ([213.165.64.21]:26774 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751244AbWGMN1a (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Jul 2006 09:27:30 -0400
Received: (qmail invoked by alias); 13 Jul 2006 13:27:28 -0000
Received: from p50902F5F.dip0.t-ipconnect.de (EHLO dialup) [80.144.47.95]
  by mail.gmx.net (mp029) with SMTP; 13 Jul 2006 15:27:28 +0200
X-Authenticated: #271361
To: Matthias Lederhofer <matled@gmx.net>
In-Reply-To: <E1G0znB-0002IO-61@moooo.ath.cx>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23834>

Matthias Lederhofer wrote:
>
> +/* if any standard file descriptor is missing open it to /dev/null */
> +static void sanitize_stdfds(void)
> +{
> +	int devnull = -1, i;
> +	struct stat buf;
> +	for (i = 0; i < 3; ++i) {
> +		if (fstat(i, &buf) != -1)
> +			continue;
> +		if (devnull == -1 &&
> +			(devnull = open("/dev/null", O_RDWR, 0)) == -1)
> +			die("open /dev/null failed: %s", strerror(errno));
> +		if (dup2(devnull, i) != i)
> +			die("dup2 failed: %s", strerror(errno));
> +	}
> +	if (devnull != -1)
> +		close(devnull);
> +}

This looks broken.  The open will return i as this is
the lowest free fd.  I don't know what POSIX says
about dup2(i,i) but anyway, you close it at the end
which completely defeats the intent of the function.

How's this?

	devnull = open("/dev/null", O_RDWR, 0);
	if (devnull == 0)
		devnull = dup(devnull);
	if (devnull == 1)
		devnull = dup(devnull);
	if (devnull == -1)
		die("open/dup /dev/null failed: %s", strerror(errno));
	if (devnull > 2)
		close(devnull);

Ciao, ET.
