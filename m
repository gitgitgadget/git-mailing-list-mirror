From: Sam Vilain <sam@vilain.net>
Subject: Re: Apology/Bug report: git-send-email sends everything on Ctrl+C
Date: Wed, 26 May 2010 21:27:15 +1200
Message-ID: <4BFCE973.3000304@vilain.net>
References: <4BFCB9D0.3010400@vilain.net> <4BFCC4B5.6070408@vilain.net> 	<1274861112.2074.2.camel@wpalmer.simply-domain> <4BFCE12E.4070009@vilain.net> <AANLkTin51a4RONmN6j3GXGJQ3UtE8bt3e_PF5t75mZTC@mail.gmail.com> <4BFCE6DD.4030403@drmicha.warpmail.net>
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Will Palmer <wmpalmer@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed May 26 11:36:55 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OHD2l-0005xR-4Q
	for gcvg-git-2@lo.gmane.org; Wed, 26 May 2010 11:36:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754632Ab0EZJgu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 May 2010 05:36:50 -0400
Received: from bertrand.catalyst.net.nz ([202.78.240.40]:39117 "EHLO
	mail.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752517Ab0EZJgt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 May 2010 05:36:49 -0400
X-Greylist: delayed 405 seconds by postgrey-1.27 at vger.kernel.org; Wed, 26 May 2010 05:36:49 EDT
Received: from localhost (localhost [127.0.0.1])
	by mail.catalyst.net.nz (Postfix) with ESMTP id 3B3A5336A2;
	Wed, 26 May 2010 21:30:03 +1200 (NZST)
X-Virus-Scanned: Debian amavisd-new at catalyst.net.nz
Received: from mail.catalyst.net.nz ([127.0.0.1])
	by localhost (bertrand.catalyst.net.nz [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GOSm+Ck3hePE; Wed, 26 May 2010 21:30:02 +1200 (NZST)
Received: from wilber.wgtn.cat-it.co.nz (unknown [IPv6:2404:130:0:1000:21d:7dff:fe90:5fe0])
	by mail.catalyst.net.nz (Postfix) with SMTP id 719B633697;
	Wed, 26 May 2010 21:30:02 +1200 (NZST)
Received: (nullmailer pid 25793 invoked by uid 1000);
	Wed, 26 May 2010 09:30:02 -0000
In-Reply-To: <4BFCE6DD.4030403@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147789>

Michael J Gruber wrote:
> > > Hard to know what could have possibly stopped this from happening.
> > > PEBKAC.
> > Perhaps git can be smart and ask for confirmation for huge (>20 ?)
> > patchsets.
> to be overriden by an option "--no-villain"...
> 
> Sorry, bad joke, but couldn't resist. Feel free to pick on my name ;)

I went with the simpler and pre-existing --confirm=never :-)

Subject: [PATCH] send-email: confirm for really large patch sets

It is possible to send a lot of e-mails using quite simple user errors
with git send-email; if they were not intended this could be quite a
lot of spam.  Ask a final question if there are a lot of messages
before sending.

Signed-off-by: Sam Vilain <sam@vilain.net>
---
 untested: after what just happens there is no way I'm testing this :-)

 git-send-email.perl |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 12622fc..093b7f2 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -257,6 +257,11 @@ Administering
 Default is the value of 'sendemail.confirm' configuration value; if that
 is unspecified, default to 'auto' unless any of the suppress options
 have been specified, in which case default to 'compose'.
++
+If you are sending a very large patch sequence (more than 20 parts),
+you will be asked for a second final confirmation before anything is
+sent.  This can be suppressed by setting this configuration value to
+'never'.
 
 --dry-run::
        Do everything except actually send the emails.
diff --git a/git-send-email.perl b/git-send-email.perl
index 111c981..2775506 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1096,6 +1096,19 @@ $references = $initial_reply_to || '';
 $subject = $initial_subject;
 $message_num = 0;
 
+if ($needs_confirm ne "never" and @files > 20) {
+	$_ = ask(
+		"That's a big patch set - ".@files." parts.  "
+		."Are you sure you want to do this? ([y]es|[n]o): ",
+		valid_re => qr/^(?:yes|y|no|n)/i,
+		default => "n",
+	       );
+	if (/^n/i) {
+		cleanup_compose_files();
+		exit(0);
+	}
+}
+
 foreach my $t (@files) {
 	open(F,"<",$t) or die "can't open file $t";
 
-- 
1.7.1.rc2.333.gb2668
