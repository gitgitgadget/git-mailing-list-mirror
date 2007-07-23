From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/3] Teach "git branch" about --new-workdir
Date: Mon, 23 Jul 2007 11:32:01 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707231129010.14781@racer.site>
References: <Pine.LNX.4.64.0707221956210.14781@racer.site>
 <Pine.LNX.4.64.0707222205050.23426@reaper.quantumfyre.co.uk>
 <Pine.LNX.4.64.0707222223460.14781@racer.site>
 <Pine.LNX.4.64.0707222234020.5382@reaper.quantumfyre.co.uk>
 <Pine.LNX.4.64.0707222255010.14781@racer.site>
 <Pine.LNX.4.64.0707222302170.19212@reaper.quantumfyre.co.uk>
 <Pine.LNX.4.64.0707230000020.14781@racer.site> <20070723035644.GC32566@spearce.org>
 <7v1wezohi4.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Julian Phillips <julian@quantumfyre.co.uk>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 23 12:32:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICvDA-0000CB-5i
	for gcvg-git@gmane.org; Mon, 23 Jul 2007 12:32:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759775AbXGWKcQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Jul 2007 06:32:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759677AbXGWKcQ
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jul 2007 06:32:16 -0400
Received: from mail.gmx.net ([213.165.64.20]:41573 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755979AbXGWKcP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2007 06:32:15 -0400
Received: (qmail invoked by alias); 23 Jul 2007 10:32:13 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp036) with SMTP; 23 Jul 2007 12:32:13 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+BGYgPME2BNSGYxBYWHzuq/3MYotnAd4UXDujOML
	yueYSW8Zmzy5DK
X-X-Sender: gene099@racer.site
In-Reply-To: <7v1wezohi4.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53423>

Hi,

On Sun, 22 Jul 2007, Junio C Hamano wrote:

> @@ -28,6 +28,17 @@ static void remove_lock_file_on_signal(int signo)
>  static int lock_file(struct lock_file *lk, const char *path)
>  {
>  	int fd;
> +	struct stat st;
> +
> +	if ((!lstat(path, &st)) && S_ISLNK(st.st_mode)) {
> +		ssize_t sz;
> +		static char target[PATH_MAX];
> +		sz = readlink(path, target, sizeof(target));
> +		if (sz < 0)
> +			warning("Cannot readlink %s", path);
> +		else
> +			path = target;
> +	}

I wonder if we should not make this a while loop:

	struct stat st;
	int i = 0;

	while (i++ < 10 && !lstat(path, &st) && S_ISLNK(st.st_mode)) {
		ssize_t sz;
		static char target[PATH_MAX];
		sz = readlink(path, target, sizeof(target));
		if (sz < 0)
			die("Cannot readlink %s", path);
		else
			path = target;
	}
	if (i == 10)
		die ("Too deep symlink depth: %s", path);

(As you see, I would not warn, but die if readlink fails.)

Ciao,
Dscho
