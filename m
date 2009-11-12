From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] gitk: Add ability to define an alternate temporary
 directory
Date: Thu, 12 Nov 2009 03:35:59 -0500
Message-ID: <20091112083559.GB17552@coredump.intra.peff.net>
References: <1257904149-44381-1-git-send-email-davvid@gmail.com>
 <4AFA368F.207@vilain.net>
 <20091111040715.GA44672@gmail.com>
 <7vr5s5y8n8.fsf@alter.siamese.dyndns.org>
 <20091111164451.GA45475@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Sam Vilain <sam@vilain.net>,
	paulus@samba.org, git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 12 09:36:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8VAD-0003XU-MN
	for gcvg-git-2@lo.gmane.org; Thu, 12 Nov 2009 09:36:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751673AbZKLIgJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Nov 2009 03:36:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751481AbZKLIgI
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Nov 2009 03:36:08 -0500
Received: from peff.net ([208.65.91.99]:34287 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751322AbZKLIgH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Nov 2009 03:36:07 -0500
Received: (qmail 20079 invoked by uid 107); 12 Nov 2009 08:39:59 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 12 Nov 2009 03:39:59 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 12 Nov 2009 03:35:59 -0500
Content-Disposition: inline
In-Reply-To: <20091111164451.GA45475@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132748>

On Wed, Nov 11, 2009 at 08:44:53AM -0800, David Aguilar wrote:

> gitk writes file@commit and file@commit^ to temporary files
> and diffs them using an external diff tool.
> 
> Shall I reroll with s/GITK_TMPDIR/TMPDIR/ ?

gitk seems to use a very predictable temp filename (".gitk-tmp.$PID").
Have you checked that you are not introducing any security holes by
creating that predictable filename in a publicly writable tmpdir?

It looks like it always tries to "mkdir" the file. Does tcl's mkdir
function barf on an existing directory? If so, then I think we may be
safe from the naive:

  tmp=.gitk-tmp.`pidof_other_users_gitk`
  mkdir $tmp
  ln -s /file/for/other/user/to/destroy /tmp/1

attack. And I think we are not susceptible to races because we fail if
the mkdir fails (instead of doing something stupid like stat followed
by mkdir).

But it has been a long time since I thought about /tmp security, so I
may be forgetting something.

-Peff
