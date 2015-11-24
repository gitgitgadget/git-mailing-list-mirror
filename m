From: John Keeping <john@keeping.me.uk>
Subject: Re: [RFC/PATCH] send-email: die if CA path doesn't exist
Date: Tue, 24 Nov 2015 22:17:08 +0000
Message-ID: <20151124221708.GA18913@serenity.lan>
References: <27f354a4edb166e42006b0c1f778827a3dfd58ac.1447798206.git.john@keeping.me.uk>
 <20151120111848.GC11198@sigill.intra.peff.net>
 <20151120194651.GC21488@serenity.lan>
 <20151124195842.GA7174@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Nov 24 23:17:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a1Ltq-0000JD-Rx
	for gcvg-git-2@plane.gmane.org; Tue, 24 Nov 2015 23:17:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755409AbbKXWRV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Nov 2015 17:17:21 -0500
Received: from jackal.aluminati.org ([72.9.247.210]:52901 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755293AbbKXWRU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Nov 2015 17:17:20 -0500
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 23B50CDA5C6;
	Tue, 24 Nov 2015 22:17:20 +0000 (GMT)
X-Quarantine-ID: <jdZcEWO-gqBP>
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -2.9
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9] autolearn=no
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id jdZcEWO-gqBP; Tue, 24 Nov 2015 22:17:19 +0000 (GMT)
Received: from serenity.lan (chimera.aluminati.org [10.0.16.60])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 4C3B6CDA5B7;
	Tue, 24 Nov 2015 22:17:13 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <20151124195842.GA7174@sigill.intra.peff.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281640>

On Tue, Nov 24, 2015 at 02:58:43PM -0500, Jeff King wrote:
> On Fri, Nov 20, 2015 at 07:46:51PM +0000, John Keeping wrote:
> 
> > > For people who know their systems are broken and want to proceed anyway,
> > > what is the appropriate work-around? Obviously it involves disabling
> > > peer verification, but would we want to include instructions for doing
> > > so (either in the error message, or perhaps mentioning it in the commit
> > > message)?
> > 
> > The documentation already says:
> > 
> > 	Set it to an empty string to disable certificate verification.
> > 
> > It's a bit lost in the middle of a paragraph but I think that is the
> > best place for the detail of how to disable verification.
> > 
> > Having revisted the patch, I do think the message might be a bit terse,
> > but I can't think of a reasonably concise way to point at the
> > --smtp-ssl-cert-path argument as being the culprit.
> 
> Hrm. I was thinking that somebody might not have any clue that
> --smtp-ssl-cert-path exists, and with this patch their setup would
> suddenly go from working (well, insecure but passing mail) to broken.
> They need to know where to look to find that documentation.
> 
> But it looks like this code path only triggers if you have set
> smtp-ssl-cert-path to something bogus. So anybody who does so at least
> knows about the option.
> 
> Which makes me wonder what happens when the cert path isn't defined by
> Git. The code says:
> 
>         if (!defined $smtp_ssl_cert_path) {
>                 # use the OpenSSL defaults
>                 return (SSL_verify_mode => SSL_VERIFY_PEER());
>         }
> 
> What does OpenSSL do when there is no cert? Hopefully it reports a
> verification failure (and in that sense your patch is making our code
> consistent with that, which is a good thing).

I suspect it's not very useful; I originally got here after setting up
git-send-email to talk to a server with a certificate signed by a
corporate CA and had to resort to the perl debugger to figure out where
it was going wrong.  There isn't even any output with --smtp-debug when
the SSL handshake fails.

The error message is (all on one line):

Unable to initialize SMTP properly. Check config and use --smtp-debug.
VALUES: server=<redacted> encryption=ssl hello=<redacted>
port=465 at /usr/libexec/git-core/git-send-email line 1357.

I wonder if we should do this to help debug SSL issues:

-- >8 --
diff --git a/git-send-email.perl b/git-send-email.perl
index e057051..6d4e0ee 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1317,6 +1317,10 @@ Message-Id: $message_id
 			require Net::SMTP::SSL;
 			$smtp_domain ||= maildomain();
 			require IO::Socket::SSL;
+			if ($debug_net_smtp) {
+				no warnings 'once';
+				$IO::Socket::SSL::DEBUG = 1;
+			}
 			# Net::SMTP::SSL->new() does not forward any SSL options
 			IO::Socket::SSL::set_client_defaults(
 				ssl_verify_params());
-- 8< --

> > Maybe we shouldn't worry too much about that, but should instead put the
> > invalid path into the error message:
> > 
> > 	die "CA path \"$smtp_ssl_cert_path\" does not exist.";
> 
> Given what I wrote above, yeah, I'd agree that is sufficient (and I do
> think mentioning the path is helpful).

I'll change it to this in a re-roll.
