From: David Woodhouse <dwmw2@infradead.org>
Subject: Re: Features ask for git-send-email
Date: Tue, 02 May 2006 13:36:57 +0100
Message-ID: <1146573417.14059.21.camel@pmac.infradead.org>
References: <4fb292fa0604290630r19edd7ejf88642e33b350d1d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 02 14:37:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fau7r-00042v-Tw
	for gcvg-git@gmane.org; Tue, 02 May 2006 14:37:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932174AbWEBMhE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 2 May 2006 08:37:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932229AbWEBMhE
	(ORCPT <rfc822;git-outgoing>); Tue, 2 May 2006 08:37:04 -0400
Received: from canuck.infradead.org ([205.233.218.70]:49573 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S932174AbWEBMhC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 May 2006 08:37:02 -0400
Received: from pmac.infradead.org ([81.187.2.168])
	by canuck.infradead.org with esmtpsa (Exim 4.61 #1 (Red Hat Linux))
	id 1Fau7f-0008ND-Cv; Tue, 02 May 2006 08:37:00 -0400
To: Bertrand Jacquin <beber.mailing@gmail.com>
In-Reply-To: <4fb292fa0604290630r19edd7ejf88642e33b350d1d@mail.gmail.com>
X-Mailer: Evolution 2.6.1 (2.6.1-1.fc5.2.dwmw2.1) 
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19417>

On Sat, 2006-04-29 at 15:30 +0200, Bertrand Jacquin wrote:
> Could it be possible to add a features in git-send-email.perl to
> accept a differrent charset as iso-8859-1 ? I would like to send
> fr_FR.utf8 mail as I use git to manager a latex files tree which are
> written in utf8.
> 
> Any objection ?

Seems reasonable. I think we just forgot to include the Content-Type:
header. This fixes it...

Signed-off-by: David Woodhouse <dwmw2@infradead.org>

diff --git a/git-send-email.perl b/git-send-email.perl
index ecfa347..1df75f5 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -37,7 +37,7 @@ # Constants (essentially)
 my $compose_filename = ".msg.$$";
 
 # Variables we fill in automatically, or via prompting:
-my (@to,@cc,@initial_cc,$initial_reply_to,$initial_subject,@files,$from,$compose,$time);
+my (@to,@cc,@initial_cc,$initial_reply_to,$initial_subject,@files,$from,$compose,$time,$charset);
 
 # Behavior modification variables
 my ($chain_reply_to, $smtp_server, $quiet, $suppress_from, $no_signed_off_cc) = (1, "localhost", 0, 0, 0);
@@ -58,6 +58,7 @@ my $rc = GetOptions("from=s" => \$from,
 		    "chain-reply-to!" => \$chain_reply_to,
 		    "smtp-server=s" => \$smtp_server,
 		    "compose" => \$compose,
+		    "charset=s" => \$charset,
 		    "quiet" => \$quiet,
 		    "suppress-from" => \$suppress_from,
 		    "no-signed-off-cc|no-signed-off-by-cc" => \$no_signed_off_cc,
@@ -135,6 +136,10 @@ if (!defined $smtp_server) {
 	$smtp_server = "localhost";
 }
 
+if (!defined $charset) {
+	$charset = "UTF-8";
+}
+
 if ($compose) {
 	# Note that this does not need to be secure, but we will make a small
 	# effort to have it be unique
@@ -214,6 +219,9 @@ Options:
    --cc           Specify an initial "Cc:" list for the entire series
                   of emails.
 
+   --charset      Specify a character set, if legacy character sets are
+                  used in change logs instead of UTF-8.
+
    --compose      Use \$EDITOR to edit an introductory message for the
                   patch series.
 
@@ -299,6 +307,7 @@ Subject: $subject
 Reply-To: $from
 Date: $date
 Message-Id: $message_id
+Content-Type: text/plain; charset=$charset
 X-Mailer: git-send-email @@GIT_VERSION@@
 ";
 	$header .= "In-Reply-To: $reply_to\n" if $reply_to;

-- 
dwmw2
