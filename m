From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: Re: [RFC/PATCH 2/3] gitweb: Support caching projects list
Date: Mon, 17 Mar 2008 17:54:05 +0100
Message-ID: <20080317165405.GD18624@mail-vs.djpig.de>
References: <1205766570-13550-1-git-send-email-jnareb@gmail.com> <1205766570-13550-3-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>,
	"J.H." <warthog19@eaglescrag.net>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 17 17:55:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JbIc1-0006tT-G8
	for gcvg-git-2@gmane.org; Mon, 17 Mar 2008 17:55:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752151AbYCQQyV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Mar 2008 12:54:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751532AbYCQQyV
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Mar 2008 12:54:21 -0400
Received: from pauli.djpig.de ([78.46.38.139]:34379 "EHLO pauli.djpig.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751355AbYCQQyU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Mar 2008 12:54:20 -0400
Received: from localhost (localhost [127.0.0.1])
	by pauli.djpig.de (Postfix) with ESMTP id 3081F90077;
	Mon, 17 Mar 2008 17:54:18 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at pauli.djpig.de
Received: from pauli.djpig.de ([127.0.0.1])
	by localhost (pauli.djpig.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hv5wC8HvXfcP; Mon, 17 Mar 2008 17:54:06 +0100 (CET)
Received: from mail-vs.djpig.de (mail-vs.djpig.de [78.47.136.189])
	by pauli.djpig.de (Postfix) with ESMTP id 66D6B90075;
	Mon, 17 Mar 2008 17:54:06 +0100 (CET)
Received: from djpig by mail-vs.djpig.de with local (Exim 4.63)
	(envelope-from <djpig@mail-vs.djpig.de>)
	id 1JbIb7-0004Zu-3d; Mon, 17 Mar 2008 17:54:05 +0100
Content-Disposition: inline
In-Reply-To: <1205766570-13550-3-git-send-email-jnareb@gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77446>

On Mon, Mar 17, 2008 at 04:09:29PM +0100, Jakub Narebski wrote:
> From: Petr Baudis <pasky@suse.cz>
> $projlist_cache_lifetime gitweb configuration variable is introduced,
> by default set to zero. If set to non-zero, it describes the number of
> minutes for which the cache remains valid. Only single project root
> per system can use the cache. Any script running with the same uid as
> gitweb can change the cache trivially - this is for secure
> installations only.

The more subtle threat is the fact that anyone with writing
rights to /tmp can give gitweb any data he wants if the file doesn't
exist yet.

At the very least you should:

 - Allow to override /tmp (via ENV{TMPDIR} or via a configuration
   variable)
 - Advise people to change that to something that is not world-writable
 - Check if the file is owned by the uid gitweb is running under and
   not word-writable.

[...]
> +	my @projects;
> +	my $stale = 0;
> +	my $now = time();
> +	if ($cache_lifetime && -f $cache_file &&
> +	    stat($cache_file)->mtime + $cache_lifetime * 60 > $now &&
> +	    open(my $fd, '<', $cache_file)) {
> +		$stale = $now - stat($cache_file)->mtime;

One stat() call instead of three would be better for performance.

Gruesse,
-- 
Frank Lichtenheld <frank@lichtenheld.de>
www: http://www.djpig.de/
