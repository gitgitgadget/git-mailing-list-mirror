From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [RFC] git-send-email: do not double-escape quotes from mutt
Date: Tue, 29 Dec 2015 02:49:30 +0000
Message-ID: <20151229024930.GA12517@dcvr.yhbt.net>
References: <20151227020810.1450-1-normalperson@yhbt.net>
 <xmqqlh8ejj79.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 29 03:49:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aDkLv-0003Yn-Mq
	for gcvg-git-2@plane.gmane.org; Tue, 29 Dec 2015 03:49:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753037AbbL2Ctc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Dec 2015 21:49:32 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:39649 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753019AbbL2Ctb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Dec 2015 21:49:31 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 599C520150;
	Tue, 29 Dec 2015 02:49:30 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <xmqqlh8ejj79.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283062>

Junio C Hamano <gitster@pobox.com> wrote:
> Eric Wong <normalperson@yhbt.net> writes:
> 
> > -			 # commas delimit multiple addresses
> > -			$aliases{$alias} = [ split_addrs($addr) ];
> > +			# commas delimit multiple addresses
> > +			my @addr = split_addrs($addr);
> > +
> > +			# quotes may be escaped in the file,
> > +			# remove them if paired so we do not
> > +			# double-escape them later.
> > +			s/^\\"(.*)\\"/"$1"/g foreach @addr;
> > +			$aliases{$alias} = \@addr
> 
> Can one address have two or more double-quoted string pieces in it?
> If that is possible, (.*) above might want to become (.*?) or even
> ([^"]*) to make it less greedy, perhaps?

Yes.  Apparently it's possible to have a double-quote inside the name,
too.  mutt understands both of the following:

alias qn \"Q. N\\\"ame\" <qn@example.org>   # becomes "Q. N\"ame"
alias dq \"Dub O.\" \"Q\" <dq@example.org>  # becomes "Dub O. Q"

The "qn" case can be taken care of using a simpler replacement
on top my original RFC:

--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -530,7 +530,7 @@ my %parse_alias = (
 			# quotes may be escaped in the file,
 			# remove them if paired so we do not
 			# double-escape them later.
-			s/^\\"(.*?)\\"/"$1"/g foreach @addr;
+			s/\\"/"/g foreach @addr;
 			$aliases{$alias} = \@addr
 		}}},
 	mailrc => sub { my $fh = shift; while (<$fh>) {

But I'm not sure how to handle the "dq" case or if that even
happens in practice, as attempting to save an alias with "Dub O." "Q"
in the From: header, mutt shortens it to the expected \"Dub O. Q\"
without extra quotes.

Saving "qn" round trips, so the \\\" in the middle is preserved.
