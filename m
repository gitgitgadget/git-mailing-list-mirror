From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC/PATCH 2/2] git-send-email: Do not require that addresses added from  body be valid
Date: Thu, 5 May 2011 16:01:44 +0200
Message-ID: <201105051601.46012.jnareb@gmail.com>
References: <20110415034251.GC19621@sigill.intra.peff.net> <1304525528-24757-1-git-send-email-jnareb@gmail.com> <20110504213535.GB27779@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Paul Gortmaker <paul.gortmaker@windriver.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 05 16:02:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHz84-0006kB-5U
	for gcvg-git-2@lo.gmane.org; Thu, 05 May 2011 16:02:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754354Ab1EEOBx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2011 10:01:53 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:52571 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754378Ab1EEOBv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2011 10:01:51 -0400
Received: by fxm17 with SMTP id 17so1544119fxm.19
        for <git@vger.kernel.org>; Thu, 05 May 2011 07:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=BzDxB1rygZ70vLo+6ewf+svz6vNd9DjyDxh6+pAwDIA=;
        b=c/cgEibMTyH+gYqMpg/3LGYNlN0RaaRARNjV6224x7chdk7Zc7aVOzD6zmzIzTrhwf
         +pctyxItd/dBUzFXZ+J78XauNqZMJC3yTSpMDcGht6tAV1LdnZ6C0zh8pk0+LKMlGGII
         5aViK6BUtQO4XZkEX91MlJnx+BfQUN1wLUOp4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=augkEIMviHsfdpyW5ctiuFlsY0uofncZSpnq6d0f5HrfN90Zazk+b3CCT1sIzUewpz
         Rdo181bhrGCbkG6C4bOeOwOJJzsmPV+l/2J9krngwqWPI17OOUiQ2d6ljhe2v/M8ZuWb
         Lz5od/T89KVQeAMfzhwegGBHy238y62IBz1/0=
Received: by 10.223.159.134 with SMTP id j6mr1098367fax.74.1304604110452;
        Thu, 05 May 2011 07:01:50 -0700 (PDT)
Received: from [192.168.1.13] (abwg161.neoplus.adsl.tpnet.pl [83.8.230.161])
        by mx.google.com with ESMTPS id j18sm771574faa.18.2011.05.05.07.01.48
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 05 May 2011 07:01:49 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20110504213535.GB27779@sigill.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172830>

On Wed, 4 May 2011, Jeff King wrote:
> On Wed, May 04, 2011 at 06:12:08PM +0200, Jakub Narebski wrote:
> > On Fri, 15 Apr 2011, Jeff King wrote:
> > >
> > > Sure. Since you are actually doing SMTP, you have much more flexibility
> > > in knowing what errors happen. Look in git-send-email.perl's
> > > send_message, around line 1118. We use the Mail::SMTP module, but we
> > > just feed it the whole recipient list and barf if any of them is
> > > rejected. You could probably remember which recipients are "important"
> > > (i.e., given on the command line) and which were pulled automatically
> > > from the commit information, and then feed each recipient individually.
> > > If important ones fail, abort the message. If an unimportant one fails,
> > > send the message anyway, but remember the bad address and report the
> > > error at the end.
> > [...]
> > This is an RFC patch preparing the way, so to speak, by remembering
> > where each Cc address came from.  We could in the future treat
> > $cc{'body'} / all_cc('body') differently from the rest of all_cc().
> > 
> > Is the approach taken here sane?
> 
> Yeah, from my cursory read, it looks like a good step forward, and I
> didn't see any obvious bugs.
> 
> You'll need still more refactoring in send_message to treat them
> differently at the SMTP level. We collapse all of the addresses down to
> a single list via unique_email_list (and we obviously want to keep this
> unique-ifying step), but that final list will have to remember where
> each address came from.

Below there is RFC patch that implements it by separating @cc and @cc_extra
and later @recipients and @recipients_extra.

How about it?

It does not warn about bad addresses from body, and there are no tests yet!

> > +sub all_cc {
> > +	my @keys = @_;
> > +	@keys = qw(initial from cc body cc-cmd) unless @keys;
> > +	return map { ref($_) ? @$_ : () } @cc{@keys};
> > +
> > +	#return map { ref($_) ? @$_ : () } values %cc;
> > +}
> 
> Nit: debugging cruft. :)

Right, I'll fix it in final version.

-- >8 ---------- >8 --
Subject: [PATCH] git-send-email: Do not require that addresses added from
 body be valid

Do not barf if any of recipients that was pulled automatically from
commit information is rejected.  This covers [currently] addresses
from 'Cc:' and 'Signed-off-by:' lines in message body.

This is possible only if we are using Net::SMTP or Net::SMTP::SSL
(it means that --smtp-server / sendemail.smtpserver is set to
internet address of outgoing SMTP server to use), because only then we
have control over which addresses are to be checked.

Currently no warnings that "unimportant" addresses were rejected are
shown; we should report errors at the end.

No test for this new behavior: perhaps we could adapt some test from
Net::SMTP module distribution...

Cc: Jeff King <peff@peff.net>
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 git-send-email.perl |   40 +++++++++++++++++++++++++---------------
 1 files changed, 25 insertions(+), 15 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 7d75a1e..e758fd9 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -968,22 +968,32 @@ sub maildomain {
 sub send_message {
 	my @recipients = unique_email_list(@to);
 	my $to = join(",\n\t", @recipients);
-	my @cc =
-		grep {
-			my $cc = extract_valid_address($_);
-			not grep { $cc eq $_ || $_ =~ /<\Q${cc}\E>$/ } @recipients
-		}
-		map { sanitize_address($_) }
-		all_cc();
-	@recipients = unique_email_list(@recipients,@cc,@bcclist);
+	my $sanitize_cc = sub {
+		return
+			grep {
+				my $cc = extract_valid_address($_);
+				not grep { $cc eq $_ || $_ =~ /<\Q${cc}\E>$/ } @recipients
+			}
+			map { sanitize_address($_) }
+			all_cc(@_);
+	};
+	my @cc = $sanitize_cc->(qw(initial from cc cc-cmd));
+	my @cc_extra = $sanitize_cc->(qw(body));
+
+	my (%seen, @recipients_extra);
+	@recipients = unique_email_list(\%seen,@recipients,@cc,@bcclist);
 	@recipients = (map { extract_valid_address($_) } @recipients);
+	@recipients_extra =
+		map { extract_valid_address($_) }
+		unique_email_list(\%seen,@cc_extra);
+
 	my $date = format_2822_time($time++);
 	my $gitversion = '@@GIT_VERSION@@';
 	if ($gitversion =~ m/..GIT_VERSION../) {
 	    $gitversion = Git::version();
 	}
 
-	my $cc = join(",\n\t", unique_email_list(@cc));
+	my $cc = join(",\n\t", unique_email_list(@cc,@cc_extra));
 	my $ccline = "";
 	if ($cc ne '') {
 		$ccline = "\nCc: $cc";
@@ -1007,7 +1017,7 @@ X-Mailer: git-send-email $gitversion
 		$header .= join("\n", @xh) . "\n";
 	}
 
-	my @sendmail_parameters = ('-i', @recipients);
+	my @sendmail_parameters = ('-i', @recipients,@recipients_extra);
 	my $raw_from = $sanitized_sender;
 	if (defined $envelope_sender && $envelope_sender ne "auto") {
 		$raw_from = $envelope_sender;
@@ -1126,6 +1136,7 @@ X-Mailer: git-send-email $gitversion
 
 		$smtp->mail( $raw_from ) or die $smtp->message;
 		$smtp->to( @recipients ) or die $smtp->message;
+		$smtp->to( @recipients_extra, { Notify => ['NEVER'], SkipBad => 1 });
 		$smtp->data or die $smtp->message;
 		$smtp->datasend("$header\n$message") or die $smtp->message;
 		$smtp->dataend() or die $smtp->message;
@@ -1138,8 +1149,8 @@ X-Mailer: git-send-email $gitversion
 		if ($smtp_server !~ m#^/#) {
 			print "Server: $smtp_server\n";
 			print "MAIL FROM:<$raw_from>\n";
-			foreach my $entry (@recipients) {
-			    print "RCPT TO:<$entry>\n";
+			foreach my $entry (@recipients,@recipients_extra) {
+				print "RCPT TO:<$entry>\n";
 			}
 		} else {
 			print "Sendmail: $smtp_server ".join(' ',@sendmail_parameters)."\n";
@@ -1375,13 +1386,12 @@ sub cleanup_compose_files {
 $smtp->quit if $smtp;
 
 sub unique_email_list {
-	my %seen;
+	my $seen = ref $_[0] eq 'HASH' ? shift : {};
 	my @emails;
 
 	foreach my $entry (@_) {
 		if (my $clean = extract_valid_address($entry)) {
-			$seen{$clean} ||= 0;
-			next if $seen{$clean}++;
+			next if $seen->{$clean}++;
 			push @emails, $entry;
 		} else {
 			print STDERR "W: unable to extract a valid address",
-- 
1.7.5
