From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] send-email: Fix %config_path_settings handling
Date: Fri, 14 Oct 2011 22:53:31 +0200
Message-ID: <201110142253.32695.jnareb@gmail.com>
References: <4E982B27.8050807@drmicha.warpmail.net> <201110142049.32734.jnareb@gmail.com> <7vbotjz85o.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Git Mailing List <git@vger.kernel.org>,
	Cord Seele <cowose@gmail.com>,
	Cord Seele <cowose@googlemail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 14 22:53:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1REoky-0006BV-CA
	for gcvg-git-2@lo.gmane.org; Fri, 14 Oct 2011 22:53:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754638Ab1JNUxX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Oct 2011 16:53:23 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:59731 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752157Ab1JNUxX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Oct 2011 16:53:23 -0400
Received: by bkbzt19 with SMTP id zt19so423640bkb.19
        for <git@vger.kernel.org>; Fri, 14 Oct 2011 13:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=gpoINo7JjUAokUihn5mY6BpZz2NdBgrFZKvL4pKZv2E=;
        b=qTr6eab5ak/Av2yE/3HmfIZXEaDW7mjjVNkBPdWjkMyM+U9BB8uZAztLDA54TqZqMb
         izhWDbahXJk2lDONiXeEuODbjzY1tHWNS3rNAWF7n/QKwWeKDxeDugqJEnn1jujXtYGG
         8jU7Ae8EJra9gPtD0M5yVypSmT9il7soGzJ34=
Received: by 10.223.17.91 with SMTP id r27mr6108604faa.20.1318625601458;
        Fri, 14 Oct 2011 13:53:21 -0700 (PDT)
Received: from [192.168.1.13] (abvw122.neoplus.adsl.tpnet.pl. [83.8.220.122])
        by mx.google.com with ESMTPS id m26sm5830526fac.6.2011.10.14.13.53.19
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 14 Oct 2011 13:53:20 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <7vbotjz85o.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183608>

From: Cord Seele <cowose@gmail.com>

cec5dae (use new Git::config_path() for aliasesfile, 2011-09-30) broke
the expansion of aliases.

This was caused by treating %config_path_settings, newly introduced in
said patch, like %config_bool_settings instead of like %config_settings.
Copy from %config_settings, making it more readable.

While at it add basic test for expansion of aliases, and for path
expansion, which would catch this error.


Nb. there were a few issues that were responsible for this error:

1. %config_bool_settings and %config_settings despite similar name have
   different semantic.

   %config_bool_settings values are arrays where the first element is
   (reference to) the variable to set, and second element is default
   value... which admittedly is a bit cryptic.  More readable if more
   verbose option would be to use hash reference, e.g.:

        my %config_bool_settings = (
            "thread" => { variable => \$thread, default => 1},
            [...]

   %config_settings values are either either reference to scalar variable
   or reference to array.  In second case it means that option (or config
   option) is multi-valued.  BTW. this is similar to what Getopt::Long does.

2. In cec5dae (use new Git::config_path() for aliasesfile, 2011-09-30)
   the setting "aliasesfile" was moved from %config_settings to newly
   introduced %config_path_settings.  But the loop that parses settings
   from %config_path_settings was copy'n'pasted *wrongly* from
   %config_bool_settings instead of from %config_settings.

   It looks like cec5dae author cargo-culted this change...

3. 994d6c6 (send-email: address expansion for common mailers, 2006-05-14)
   didn't add test for alias expansion to t9001-send-email.sh

Signed-off-by: Cord Seele <cowose@gmail.com>
Tested-by: Michael J Gruber <git@drmicha.warpmail.net>
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
> > From: Cord Seele <cowose@gmail.com>
> >    value... which admittedly is a bit cryptic.  More readable if more
> >    verbose option would be to use hash reference, e.g.:
> >
> >         my %config_bool_settings = (
> >             "thread" => { variable => \$thread, default => 1},
> >             [...]
> >
> >    Or something like that.
> 
> Do you really want to leave this "Or something like that" here?

Removed.  

"e.g." should be enough.

> > 3. 994d6c6 (send-email: address expansion for common mailers, 2006-05-14)
> >    didn't add test for alias expansion to t9001-send-email.sh
> 
> I was hoping that an updated patch to have a new test or two here...

Done.  I thought to add it in separate patch...
 
> > Signed-off-by: Cord Seele <cowose@gmail.com>
> > Tested-by: Michael J Gruber <git@drmicha.warpmail.net>
> > Signed-off-by: Jakub Narebski <jnareb@gmail.com>
> 
> Is this the version tested by Michael?

This one is.

[cut previous version]

 git-send-email.perl   |   12 ++++++++++--
 t/t9001-send-email.sh |   28 ++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 91607c5..6885dfa 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -337,8 +337,16 @@ sub read_config {
 	}
 
 	foreach my $setting (keys %config_path_settings) {
-		my $target = $config_path_settings{$setting}->[0];
-		$$target = Git::config_path(@repo, "$prefix.$setting") unless (defined $$target);
+		my $target = $config_path_settings{$setting};
+		if (ref($target) eq "ARRAY") {
+			unless (@$target) {
+				my @values = Git::config_path(@repo, "$prefix.$setting");
+				@$target = @values if (@values && defined $values[0]);
+			}
+		}
+		else {
+			$$target = Git::config_path(@repo, "$prefix.$setting") unless (defined $$target);
+		}
 	}
 
 	foreach my $setting (keys %config_settings) {
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 579ddb7..87b4acc 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -1168,4 +1168,32 @@ test_expect_success $PREREQ '--force sends cover letter template anyway' '
 	test -n "$(ls msgtxt*)"
 '
 
+test_expect_success $PREREQ 'sendemail.aliasfiletype=mailrc' '
+	clean_fake_sendmail &&
+	echo "alias sbd  somebody@example.org" >.mailrc &&
+	git config --replace-all sendemail.aliasesfile "$(pwd)/.mailrc" &&
+	git config sendemail.aliasfiletype mailrc &&
+	git send-email \
+	  --from="Example <nobody@example.com>" \
+	  --to=sbd \
+	  --smtp-server="$(pwd)/fake.sendmail" \
+	  outdir/0001-*.patch \
+	  2>errors >out &&
+	grep "^!somebody@example\.org!$" commandline1
+'
+
+test_expect_success $PREREQ 'sendemail.aliasfile=~/.mailrc' '
+	clean_fake_sendmail &&
+	echo "alias sbd  someone@example.org" >~/.mailrc &&
+	git config --replace-all sendemail.aliasesfile "~/.mailrc" &&
+	git config sendemail.aliasfiletype mailrc &&
+	git send-email \
+	  --from="Example <nobody@example.com>" \
+	  --to=sbd \
+	  --smtp-server="$(pwd)/fake.sendmail" \
+	  outdir/0001-*.patch \
+	  2>errors >out &&
+	grep "^!someone@example\.org!$" commandline1
+'
+
 test_done
-- 
1.7.6
