From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] send-email: quiet some warnings
Date: Sun, 14 May 2006 23:04:20 -0700
Message-ID: <7vlkt3x1qz.fsf@assigned-by-dhcp.cox.net>
References: <1147660345772-git-send-email-normalperson@yhbt.net>
	<11476606883991-git-send-email-normalperson@yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 15 08:04:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FfWBt-0004Cj-CJ
	for gcvg-git@gmane.org; Mon, 15 May 2006 08:04:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932114AbWEOGEW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 May 2006 02:04:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932230AbWEOGEW
	(ORCPT <rfc822;git-outgoing>); Mon, 15 May 2006 02:04:22 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:52133 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S932114AbWEOGEW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 May 2006 02:04:22 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060515060421.HZIR27967.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 15 May 2006 02:04:21 -0400
To: Eric Wong <normalperson@yhbt.net>
In-Reply-To: <11476606883991-git-send-email-normalperson@yhbt.net> (Eric
	Wong's message of "Sun, 14 May 2006 19:38:08 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20025>

Eric Wong <normalperson@yhbt.net> writes:

> @@ -507,8 +507,16 @@ sub unique_email_list(@) {
>  	my @emails;
>  
>  	foreach my $entry (@_) {
> -		my $clean = extract_valid_address($entry);
> -		next if $seen{$clean}++;
> +		if (my $clean = extract_valid_address($entry)) {
> +			$seen{$clean} ||= 0;
> +			next if $seen{$clean}++;
> +		} else {
> +			# it could still be a local email address without '@',
> +			# which neither Email::Valid or our own small regex says
> +			# is valid...
> +			$seen{$entry} ||= 0;
> +			next if $seen{$entry}++;
> +		}

Wouldn't you want three kinds of return values from
sub extract_valid_address() if you want to do this?  That is, 

 (1) address is valid and this is the cleaned up value;
 (2) address is known to be bogus; do not use it.
 (3) address might be local.

And (1) and (3) are probably the same thing in practice.  In a
localsite setting, it is often convenient to be able to use
addr-spec that is local-part only, so something like the
attached change, with your error squelching for 'undef' return
in the second case, might be more appropriate.

-- >8 --

diff --git a/git-send-email.perl b/git-send-email.perl
index d8c4b1f..7a89e26 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -300,6 +300,9 @@ our ($message_id, $cc, %mail, $subject, 
 
 sub extract_valid_address {
 	my $address = shift;
+
+	return $address if ($address =~ /^(\w+)$/);
+
 	if ($have_email_valid) {
 		return Email::Valid->address($address);
 	} else {
