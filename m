From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Quick hack to avoid double qp encoding
Date: Wed, 10 Jan 2007 13:29:32 -0800
Message-ID: <7vd55ma7ur.fsf@assigned-by-dhcp.cox.net>
References: <17829.12657.814000.514351@lapjr.intranet.kiel.bmiag.de>
	<11684596371612-git-send-email-j.ruehle@bmiag.de>
	<17829.20111.652000.250228@lapjr.intranet.kiel.bmiag.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 10 22:29:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4l17-0003Nk-1M
	for gcvg-git@gmane.org; Wed, 10 Jan 2007 22:29:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965107AbXAJV3u (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 10 Jan 2007 16:29:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965116AbXAJV3u
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Jan 2007 16:29:50 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:34867 "EHLO
	fed1rmmtao10.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965107AbXAJV3t (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jan 2007 16:29:49 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070110212948.TWAH20715.fed1rmmtao10.cox.net@fed1rmimpo01.cox.net>;
          Wed, 10 Jan 2007 16:29:48 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 9ZUx1W00U1kojtg0000000; Wed, 10 Jan 2007 16:28:58 -0500
To: Juergen Ruehle <j.ruehle@bmiag.de>
In-Reply-To: <17829.20111.652000.250228@lapjr.intranet.kiel.bmiag.de> (Juergen
	Ruehle's message of "Wed, 10 Jan 2007 21:37:35 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36532>

Juergen Ruehle <j.ruehle@bmiag.de> writes:

> Juergen Ruehle writes:
>
> Ok, i should have also reverted the ' ' to '_' conversion, but it
> seems that send-email is to blame, because it simply copies the
> (possibly) QP encoded author address into the body of a (possibly) not
> QP encoded message.

Thanks.  I think other people would want to hack on this, so I
would make a separete sub to make it easier, like this:

diff --git a/git-send-email.perl b/git-send-email.perl
index ba39d39..8dc2ee0 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -402,6 +402,15 @@ sub make_message_id
 $cc = "";
 $time = time - scalar $#files;
 
+sub unquote_rfc2047 {
+	local ($_) = @_;
+	if (s/=\?utf-8\?q\?(.*)\?=/$1/g) {
+		s/_/ /g;
+		s/=([0-9A-F]{2})/chr(hex($1))/eg;
+	}
+	return "$_ - unquoted";
+}
+
 sub send_message
 {
 	my @recipients = unique_email_list(@to);
@@ -555,6 +564,7 @@ foreach my $t (@files) {
 	}
 	close F;
 	if (defined $author_not_sender) {
+		$author_not_sender = unquote_rfc2047($author_not_sender);
 		$message = "From: $author_not_sender\n\n$message";
 	}
 
