From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Uses git-credential for git-imap-send
Date: Sat, 26 Apr 2014 14:08:35 -0400
Message-ID: <20140426180835.GE21493@sigill.intra.peff.net>
References: <CAFVaGhudmcrh32_h3RPmR_E7e3Jo9xc6AEt5AtN2W5NVbEMg6w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Dan Albert <danalbert@google.com>
X-From: git-owner@vger.kernel.org Sat Apr 26 20:08:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1We71o-00063b-TI
	for gcvg-git-2@plane.gmane.org; Sat, 26 Apr 2014 20:08:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751928AbaDZSIh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Apr 2014 14:08:37 -0400
Received: from cloud.peff.net ([50.56.180.127]:39172 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751661AbaDZSIh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Apr 2014 14:08:37 -0400
Received: (qmail 27442 invoked by uid 102); 26 Apr 2014 18:08:36 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 26 Apr 2014 13:08:36 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 26 Apr 2014 14:08:35 -0400
Content-Disposition: inline
In-Reply-To: <CAFVaGhudmcrh32_h3RPmR_E7e3Jo9xc6AEt5AtN2W5NVbEMg6w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247174>

On Sat, Apr 26, 2014 at 10:50:26AM -0700, Dan Albert wrote:

> git-imap-send was directly prompting for a password rather than using
> git-credential. git-send-email, on the other hand, supports
> git-credential.

Yay. These sorts of conversions were definitely on my mind when I did
the original credential work, and have mostly been waiting on somebody
who cares enough about specific tools to switch them over.

>  static struct imap_store *imap_open_store(struct imap_server_conf *srvc)
>  {
> + struct credential cred = CREDENTIAL_INIT;

Your patch seems to have been whitespace-damaged in transit (there are
hints for gmail in the format-patch and send-email manpages).

> + cred.username = xstrdup(srvc->user);
> + cred.protocol = xstrdup("imap");
> + cred.host = xstrdup(srvc->host);
> + credential_fill(&cred);
> + srvc->pass = xstrdup(cred.password);

The "imap" protocol will get passed along to any helpers. I think the
only one which actually cares about the specific content is the
osxkeychain helper, which differentiates between "imap" and "imaps". I
think we can know which is which at this point and do:

  cred.protocol = xstrdup(srvc->use_ssl ? "imaps" : "imap");

Other than that, the patch looks good. Tests would be wonderful, but we
have no infrastructure at all, so it would involve writing a mock IMAP
server. Having implemented both IMAP servers and clients in a previous
life, I could not ask anyone to go through that pain. :)

-Peff
