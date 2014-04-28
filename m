From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Uses git-credential for git-imap-send
Date: Mon, 28 Apr 2014 15:23:49 -0400
Message-ID: <20140428192349.GC25993@sigill.intra.peff.net>
References: <20140426180835.GE21493@sigill.intra.peff.net>
 <907d1444a8e17a43c03ee0c2bb04038bdd3372b8.1398620231.git.danalbert@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Dan Albert <danalbert@google.com>
X-From: git-owner@vger.kernel.org Mon Apr 28 21:24:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wer9f-0005dr-FB
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 21:23:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754660AbaD1TXw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 15:23:52 -0400
Received: from cloud.peff.net ([50.56.180.127]:40589 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754294AbaD1TXv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 15:23:51 -0400
Received: (qmail 12555 invoked by uid 102); 28 Apr 2014 19:23:50 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 28 Apr 2014 14:23:50 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 28 Apr 2014 15:23:49 -0400
Content-Disposition: inline
In-Reply-To: <907d1444a8e17a43c03ee0c2bb04038bdd3372b8.1398620231.git.danalbert@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247401>

On Sun, Apr 27, 2014 at 10:58:51AM -0700, Dan Albert wrote:

> git-imap-send was directly prompting for a password rather than using
> git-credential. git-send-email, on the other hand, supports git-credential.
> 
> This is a necessary improvement for users that use two factor authentication, as
> they should not be expected to remember all of their app specific passwords.
> 
> Signed-off-by: Dan Albert <danalbert@google.com>

Thanks, this version looks good to me.

I noticed that we are just filling in the password here, since we'll
always fill cred.username from srvc->user. The lines directly above are:

	if (!srvc->user) {
		fprintf(stderr, "Skipping server %s, no user\n", srvc->host);
		goto bail;
	}

That comes from the imap.user config variable. I wonder if we should
just pass it off to credential_fill() in this case, too, which will fill
in the username if necessary.

It probably doesn't matter much, though, as nobody is complaining. And
if we were designing from scratch, I would say that "imap.user" and
"imap.pass" would not need to exist, as you can configure
"credential.imaps://host/.*" for the same purpose. But since we would
have to keep supporting them anyway for compatibility, it's not worth
trying to transition.

-Peff
