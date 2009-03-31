From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: [PATCH 1/2] send-email: refactor and ensure prompting doesn't  loop forever
Date: Tue, 31 Mar 2009 11:32:15 +0200
Message-ID: <vpqvdpq9gww.fsf@bauges.imag.fr>
References: <1238290751-57461-1-git-send-email-jaysoffian@gmail.com>
	<vpqd4bzjlk1.fsf@bauges.imag.fr>
	<76718490903300717x5cc5e33ax1cf91471efd242bd@mail.gmail.com>
	<vpqwsa7gjlh.fsf@bauges.imag.fr>
	<76718490903300845x14897599jc73f50a16b21605d@mail.gmail.com>
	<76718490903300904k7e8c1054m99edb92d8d582387@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 31 11:42:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoaRv-0004NF-GN
	for gcvg-git-2@gmane.org; Tue, 31 Mar 2009 11:40:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751366AbZCaJia (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Mar 2009 05:38:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751348AbZCaJia
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Mar 2009 05:38:30 -0400
Received: from imag.imag.fr ([129.88.30.1]:60758 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751075AbZCaJi3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Mar 2009 05:38:29 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id n2V9ZPsl028893
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 31 Mar 2009 11:35:26 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1LoaKO-0007fZ-1D; Tue, 31 Mar 2009 11:32:16 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1LoaKN-0002zi-V6; Tue, 31 Mar 2009 11:32:15 +0200
In-Reply-To: <76718490903300904k7e8c1054m99edb92d8d582387@mail.gmail.com> (Jay Soffian's message of "Mon\, 30 Mar 2009 12\:04\:50 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.91 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Tue, 31 Mar 2009 11:35:26 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115237>

Jay Soffian <jaysoffian@gmail.com> writes:

> On Mon, Mar 30, 2009 at 11:45 AM, Jay Soffian <jaysoffian@gmail.com> wrote:
>> Okay, well, I figured out how to work the polish. Term::ReadLine is
>> attempting to use /dev/tty for input/output, which is closed. And
>> because send-email enables warnings, its attempt to do so emits the
>> messages you are seeing. Can you confirm that this patch squelches the
>> warnings?
>
> Ugh, not that. This:
>
> diff --git a/git-send-email.perl b/git-send-email.perl
> index f0405c8..81240ef 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -612,6 +612,9 @@ sub ask {
>         my $default = $arg{default};
>         my $resp;
>         my $i = 0;
> +       return defined $default ? $default : undef
> +               unless defined $term->IN and defined fileno($term->IN) and
> +                      defined $term->OUT and defined fileno($term->OUT);
>         while ($i++ < 10) {
>                 $resp = $term->readline($prompt);
>                 if (!defined $resp) { # EOF

Surprising. I did the test with 3 commits to send (titled "hello",
"hello-again" and "hello-oncemore"). the log says this
  
Send this email reply required at /home/moy/local/usr/libexec/git-core//git-send-email line 866.
OK. Log says:
Sendmail: /usr/sbin/sendmail -i Matthieu.Moy@imag.fr
From: Matthieu.Moy@imag.fr
To: Matthieu.Moy@imag.fr
Subject: [PATCH 1/3] hello
Date: Tue, 31 Mar 2009 10:47:59 +0200
Message-Id: <1238489281-5518-1-git-send-email-Matthieu.Moy@imag.fr>
X-Mailer: git-send-email 1.6.2.1.413.gf2ad.dirty

Result: OK
(mbox) Adding cc: moy <moy@973704de-e02c-4a59-87bb-087b52aa604b> from line 'From: moy <moy@973704de-e02c-4a59-87bb-087b52aa604b>'

From: Matthieu.Moy@imag.fr
To: Matthieu.Moy@imag.fr
Subject: [PATCH 2/3] hello-again
Date: Tue, 31 Mar 2009 10:48:00 +0200
Message-Id: <1238489281-5518-2-git-send-email-Matthieu.Moy@imag.fr>
X-Mailer: git-send-email 1.6.2.1.413.gf2ad.dirty
In-Reply-To: <1238489281-5518-1-git-send-email-Matthieu.Moy@imag.fr>
References: <1238489281-5518-1-git-send-email-Matthieu.Moy@imag.fr>

(line 866 is this: die "Send this email reply required" unless defined $_;)

And I received only patch 1/3.

Actually, this seems to be a totally separate issue. What happens is
that for the first email, the script executes :

		if ($needs_confirm eq "inform") {
			$confirm_unconfigured = 0; # squelch this message for the rest of this run
			$ask_default = "y"; # assume yes on EOF since user hasn't explicitly asked for confirmation
			... (show message, ...)
		}
		$_ = ask("Send this email? ([y]es|[n]o|[q]uit|[a]ll): ",
		         valid_re => qr/^(?:yes|y|no|n|quit|q|all|a)/i,
		         default => $ask_default);

and the second time, since $confirm_unconfigured = 0 has been set, the
message is not shown again, _and_ $ask_default not set (since
$needs_confirm is set according to $confirm_unconfigured). I think the
solution is to use a variable different from $confirm_unconfigured to
say whether the message has already been displayed, along the lines
of:

diff --git a/git-send-email.perl b/git-send-email.perl
index 5916c86..9e36c35 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -357,6 +357,7 @@ if ($confirm_unconfigured) {
 };
 die "Unknown --confirm setting: '$confirm'\n"
        unless $confirm =~ /^(?:auto|cc|compose|always|never)/;
+my $confirm_msg_shown = undef;
 
 # Debugging, print out the suppressions.
 if (0) {
@@ -844,17 +849,21 @@ X-Mailer: git-send-email $gitversion
                print "\n$header\n";
                my $ask_default;
                if ($needs_confirm eq "inform") {
-                       $confirm_unconfigured = 0; # squelch this message for the rest of this run
                        $ask_default = "y"; # assume yes on EOF since user hasn't explicitly asked for confirmation
-                       print "    The Cc list above has been expanded by additional\n";
-                       print "    addresses found in the patch commit message. By default\n";
-                       print "    send-email prompts before sending whenever this occurs.\n";
-                       print "    This behavior is controlled by the sendemail.confirm\n";
-                       print "    configuration setting.\n";
-                       print "\n";
-                       print "    For additional information, run 'git send-email --help'.\n";
-                       print "    To retain the current behavior, but squelch this message,\n";
-                       print "    run 'git config --global sendemail.confirm auto'.\n\n";
+                       if (!defined $confirm_msg_shown) {
+                               $confirm_msg_shown = 0; # squelch this message for the rest of this run
+                               print "    The Cc list above has been expanded by additional\n";
+                               print "    addresses found in the patch commit message. By default\n";
+                               print "    send-email prompts before sending whenever this occurs.\n";
+                               print "    This behavior is controlled by the sendemail.confirm\n";
+                               print "    configuration setting.\n";
+                               print "\n";
+                               print "    For additional information, run 'git send-email --help'.\n";
+                               print "    To retain the current behavior, but squelch this message,\n";
+                               print "    run 'git config --global sendemail.confirm auto'.\n\n";
+                       }
                }
                $_ = ask("Send this email? ([y]es|[n]o|[q]uit|[a]ll): ",
                         valid_re => qr/^(?:yes|y|no|n|quit|q|all|a)/i,


(worksforme at least)

-- 
Matthieu
