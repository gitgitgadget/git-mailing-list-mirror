From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] include/asm-arm/: Spelling fixes
Date: Mon, 17 Dec 2007 18:05:58 -0500
Message-ID: <20071217230558.GD2105@coredump.intra.peff.net>
References: <5703e57f925f31fc0eb38873bd7f10fc44f99cb4.1197918889.git.joe@perches.com> <20071217195658.GB13515@fieldses.org> <1197921847.27386.16.camel@localhost> <20071217201219.GC13515@fieldses.org> <1197922971.27386.32.camel@localhost> <20071217205134.GB2105@coredump.intra.peff.net> <7vy7bt57wn.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Joe Perches <joe@perches.com>,
	"J. Bruce Fields" <bfields@fieldses.org>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 18 00:06:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4P2a-0005U5-Ci
	for gcvg-git-2@gmane.org; Tue, 18 Dec 2007 00:06:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758178AbXLQXGE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2007 18:06:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759932AbXLQXGD
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Dec 2007 18:06:03 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4714 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758178AbXLQXGB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2007 18:06:01 -0500
Received: (qmail 14386 invoked by uid 111); 17 Dec 2007 23:05:59 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Mon, 17 Dec 2007 18:05:59 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 17 Dec 2007 18:05:58 -0500
Content-Disposition: inline
In-Reply-To: <7vy7bt57wn.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68652>

On Mon, Dec 17, 2007 at 01:27:20PM -0800, Junio C Hamano wrote:

> >  	my $sanitized_sender = sanitize_address($sender);
> > -	make_message_id();
> > +	make_message_id() unless defined($message_id);
> 
> Isn't this called inside a loop?  If the outgoing message does not
> originally have "Message-Id:", does the loop correctly reinitialize
> $message_id to undef, or does this change make everybody reuse the same
> $message_id over and over again?

Yes, sorry. I realized it right after I sent the other out, but then a
repairman showed up to fix my non-working furnace. :)

The following needs to be squashed in (alternatively, the message_id
doesn't need to be a loop variable, so it could be cleaned up. But part
of me says that git-send-email is beyond hope for being clean).

diff --git a/git-send-email.perl b/git-send-email.perl
index 083466a..248d035 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -808,6 +808,7 @@ foreach my $t (@files) {
 			$references = "$message_id";
 		}
 	}
+	$message_id = undef;
 }
 
 if ($compose) {

> I have a feeling that --thread to format-patch is a misfeature.  Why is
> it needed if you are feeding the output to send-email?

I think it is a case of --thread being added for people not using
send-email, and then getting it misused. I am just trying to add a
sanity check to send-email in case the user does something silly (though
one could certainly argue that it is already hopelessly tied to
git-format-patch, and fixing git-format-patch is the right way to go).

> I wonder if stripping existing "Message-Id:" away just like we strip
> away "Date:" from @xh would be a much saner fix.

That is definitely wrong if we expect to re-use the in-reply-to and
references headers that already exist (though obviously we could strip
out all three of those headers and re-add our own).

I don't have a strong opinion. I never use git-send-email myself, but
was just trying to fix a reported bug.

-Peff
