From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 1/2] daemon: add tests
Date: Sat, 7 Jan 2012 00:35:50 +0100
Message-ID: <201201070035.52581.jnareb@gmail.com>
References: <7v8vlovavj.fsf@alter.siamese.dyndns.org> <m3vcoqevjm.fsf@localhost.localdomain> <20120105025154.GA7326@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Clemens Buchacher <drizzd@aon.at>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	=?utf-8?q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
	<pclouds@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Jan 07 00:36:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RjJKx-00015u-1g
	for gcvg-git-2@lo.gmane.org; Sat, 07 Jan 2012 00:36:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759322Ab2AFXgJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jan 2012 18:36:09 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:63704 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759346Ab2AFXgG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jan 2012 18:36:06 -0500
Received: by eekc4 with SMTP id c4so1371682eek.19
        for <git@vger.kernel.org>; Fri, 06 Jan 2012 15:36:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=KHnE3EAmXBpRJh+kdUy93O76DW5UU/A52tfJML4D6oI=;
        b=ixVGxCUpb+K44JX68L0a8TmsZp8qiQ9njy3A4m4EQhZ2Ytble86VVCSaFZihVXkApj
         yMK2MDt2I6EH2S96FCllSFOD4rQEBkTCsrE3OjYl6FK0EAZikL0Sz6NPc00vu/YXW+FQ
         Cpo8QE9EYXdYD+ufuiyoGtrpxc7RxDEBi/79k=
Received: by 10.14.99.132 with SMTP id x4mr2995189eef.74.1325892965101;
        Fri, 06 Jan 2012 15:36:05 -0800 (PST)
Received: from [192.168.1.13] (abwd1.neoplus.adsl.tpnet.pl. [83.8.227.1])
        by mx.google.com with ESMTPS id e12sm103378683eea.5.2012.01.06.15.36.01
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 06 Jan 2012 15:36:03 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <20120105025154.GA7326@sigill.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188056>

On Thu, 5 Jan 2012, Jeff King wrote:
> On Wed, Jan 04, 2012 at 06:24:16PM -0800, Jakub Narebski wrote:
> 
> > Jeff King <peff@peff.net> writes:
> > 
> > > As a side note, it looks like we just start the daemon with "git daemon
> > > &". Doesn't that create a race condition with the tests which
> > > immediately try to access it (i.e., the first test may run before the
> > > daemon actually opens the socket)?
> > 
> > Hmmm... perhaps the trick that git-instaweb does for "plackup" web
> > server would be of use here, waiting for socket to be ready?
> 
> It looks like it busy loops, which is kind of ugly.

Well, as far as I know you can wait for data on socket or pipe, but
you can't wait for socket to be created.

Anyway this busy-wait is not too busy, and it is better than just
adding 'sleep 1' in testsuite.

> The credential-cache helper has a similar problem. It wants to kick off
> a daemon if one is not already running, and then connect to it. So the
> daemon does:
> 
>   printf("ok\n");
>   fclose(stdout);
> 
> when it has set up the socket, and the client does:
> 
>   r = read_in_full(daemon.out, buf, sizeof(buf));
>   if (r < 0)
>           die_errno("unable to read result code from cache daemon");
>   if (r != 3 || memcmp(buf, "ok\n", 3))
>           die("cache daemon did not start: %.*s", r, buf);
>   /* now we can connect over the socket */
> 
> We could probably add a "--notify-when-ready" option to git-daemon to
> do something similar.

What would git-daemon do what it is ready?  Write to socket, raise signal,
print to STDOUT / STDERR?

BTW. I wonder if it would be worth it to add something a la systemd
trick creating sockets first to git-daemon.  Adding systemd support
doesn't make sense for daemon that is to be run from inetd / xinetd,
I guess.

-- 
Jakub Narebski
Poland
