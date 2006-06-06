From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Cleanup git-send-email.perl:extract_valid_email
Date: Mon, 05 Jun 2006 23:59:00 -0700
Message-ID: <7v1wu2zs5n.fsf@assigned-by-dhcp.cox.net>
References: <normalperson@yhbt.net>
	<200606040010.k540ANa4015204@laptop11.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 06 08:59:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FnVWt-0007RV-1F
	for gcvg-git@gmane.org; Tue, 06 Jun 2006 08:59:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932119AbWFFG7E (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Jun 2006 02:59:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932124AbWFFG7E
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Jun 2006 02:59:04 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:54449 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S932119AbWFFG7C (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jun 2006 02:59:02 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060606065901.JBQB11027.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 6 Jun 2006 02:59:01 -0400
To: Horst von Brand <vonbrand@inf.utfsm.cl>,
	Ryan Anderson <ryan@michonline.com>,
	Eric Wong <normalperson@yhbt.net>
In-Reply-To: <200606040010.k540ANa4015204@laptop11.inf.utfsm.cl> (Horst von
	Brand's message of "Sat, 03 Jun 2006 20:10:23 -0400")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21366>

Horst von Brand <vonbrand@inf.utfsm.cl> writes:

>> >  	# check for a local address:
>> > -	return $address if ($address =~ /^([\w\-]+)$/);
>> > +	return $address if ($address =~ /^([\w\-.]+)$/);
>> 
>> I keep forgetting this, '+' is a valid (and useful) setup, too.
>
> Oops...
>> 
>> Actually, I'm retracting my earlier ack on this.  This is way too
>> restrictive.  I'd rather allow an occasional invalid email address than
>> to reject valid ones.  I generally trust git users to know what they're
>> doing when entering email addresses[1].
>> 
>> *, $, ^, +, = are all valid characters in the username portion (not sure
>> about local accounts, though), and I'm sure there are more that I don't
>> know about.
>
> As a general principle, I prefer to check what is legal instead of trying
> to filter out what isn't.

If we start doing addr-spec in RFC2822 (page 17) ourselves, we
should rather be using Email::Valid.  A permissive sanity check
to catch obvious mistakes would be more appropriate here than
being RFC police.

I think something like the attached, on top of your patch, would
be appropriate for upcoming 1.4.0.

-- >8 --
send-email: be more lenient and just catch obvious mistakes.

This cleans up the pattern matching subroutine by introducing
two variables to hold regexp to approximately match local-part
and domain in the e-mail address.  It is meant to catch obvious
mistakes with a cheap check.

The patch also moves "scalar" to force Email::Valid->address()
to work in !wantarray environment to extract_valid_address;
earlier it was in the caller of the subroutine, which was way
too error prone.

---
diff --git a/git-send-email.perl b/git-send-email.perl
index a7a7797..700d0c3 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -312,16 +312,18 @@ our ($message_id, $cc, %mail, $subject, 
 
 sub extract_valid_address {
 	my $address = shift;
+	my $local_part_regexp = '[^<>"\s@]+';
+	my $domain_regexp = '[^.<>"\s@]+\.[^<>"\s@]+';
 
 	# check for a local address:
-	return $address if ($address =~ /^([\w\-.]+)$/);
+	return $address if ($address =~ /^($local_part_regexp)$/);
 
 	if ($have_email_valid) {
-		return Email::Valid->address($address);
+		return scalar Email::Valid->address($address);
 	} else {
 		# less robust/correct than the monster regexp in Email::Valid,
 		# but still does a 99% job, and one less dependency
-		$address =~ /([\w\-.]+@[\w\-.]+)/;
+		$address =~ /($local_part_regexp\@$domain_regexp)/;
 		return $1;
 	}
 }
@@ -384,7 +386,7 @@ X-Mailer: git-send-email $gitversion
 		defined $pid or die $!;
 		if (!$pid) {
 			exec($smtp_server,'-i',
-			     map { scalar extract_valid_address($_) }
+			     map { extract_valid_address($_) }
 			     @recipients) or die $!;
 		}
 		print $sm "$header\n$message";
