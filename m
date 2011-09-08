From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] send-mail: Add option to sleep between sending each email.
Date: Thu, 8 Sep 2011 16:14:18 +0530
Message-ID: <CALkWK0mNBG8EwysjO8uoR+fU5ZM=Pz9es3t_+s6cFgR6NSodGQ@mail.gmail.com>
References: <1315428191-9769-1-git-send-email-gf@unixsol.org>
 <CALkWK0kH+pD6ymtt9oWLhT0Bftp4EvtrwTtNVw6mjX0aObb-BQ@mail.gmail.com>
 <vpq7h5jtngj.fsf@bauges.imag.fr> <CALkWK0nuLHpG9xqAAVL4T21N-31m7=A3_amp7Mf0Sw9jobYDRg@mail.gmail.com>
 <CALkWK0nt4PXfBxGcAnavUkKM6AhKpZnw1NtZsNznzmGZiguFqA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Georgi Chorbadzhiyski <gf@unixsol.org>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Sep 08 12:44:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1c69-0008AO-OJ
	for gcvg-git-2@lo.gmane.org; Thu, 08 Sep 2011 12:44:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758230Ab1IHKok (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Sep 2011 06:44:40 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:56643 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758153Ab1IHKoj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Sep 2011 06:44:39 -0400
Received: by wwf5 with SMTP id 5so734265wwf.1
        for <git@vger.kernel.org>; Thu, 08 Sep 2011 03:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=eR7mgUms6KrO/iEiiIOsieXHGyG+znc1qrwuql6wvns=;
        b=p6ceaoefnzHJDm0KhIo4HQAEVLCC3gbkGpH3Q5qa50P5WISkPyRww/BDIzKBZettKg
         ACjIDvXH8pD/s7QNx+kLp9zPmncwAS1ykuchVX+TK6YRpm+uygauh20MdDc8ZrHMYiw2
         Om5QKi1ZMkIdHkg/up2d6DLx4oQqpacFJMZkM=
Received: by 10.216.137.232 with SMTP id y82mr553014wei.104.1315478678130;
 Thu, 08 Sep 2011 03:44:38 -0700 (PDT)
Received: by 10.216.51.135 with HTTP; Thu, 8 Sep 2011 03:44:18 -0700 (PDT)
In-Reply-To: <CALkWK0nt4PXfBxGcAnavUkKM6AhKpZnw1NtZsNznzmGZiguFqA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180962>

Hi,

I mocked up a small patch to demonstrate the "special cover letter
handling" idea.  Let me know if you think it's worth pursuing.
Warning: Untested.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>

-- 8< --
diff --git a/git-send-email.perl b/git-send-email.perl
index 98ab33a..30b8651 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -80,6 +80,7 @@ git send-email [options] <file | directory |
rev-list options >
     --[no-]suppress-from           * Send to self. Default off.
     --[no-]chain-reply-to          * Chain In-Reply-To: fields. Default off.
     --[no-]thread                  * Use In-Reply-To: field. Default on.
+    --[no-]initial-wait     <int>  * Wait <int> seconds after sending
first email.

   Administering:
     --confirm               <str>  * Confirm recipients before sending;
@@ -190,7 +191,7 @@ sub do_edit {
 }

 # Variables with corresponding config settings
-my ($thread, $chain_reply_to, $suppress_from, $signed_off_by_cc);
+my ($thread, $initial_wait, $chain_reply_to, $suppress_from,
$signed_off_by_cc);
 my ($to_cmd, $cc_cmd);
 my ($smtp_server, $smtp_server_port, @smtp_server_options);
 my ($smtp_authuser, $smtp_encryption);
@@ -205,6 +206,7 @@ my $not_set_by_user = "true but not set by the user";

 my %config_bool_settings = (
     "thread" => [\$thread, 1],
+    "initialwait" => [\$initial_wait, 0],
     "chainreplyto" => [\$chain_reply_to, $not_set_by_user],
     "suppressfrom" => [\$suppress_from, undef],
     "signedoffbycc" => [\$signed_off_by_cc, undef],
@@ -1141,6 +1143,11 @@ X-Mailer: git-send-email $gitversion
 		} else {
 			print "Result: OK\n";
 		}
+		if ($initial_wait) {
+			print "Sleeping: $initial_wait seconds.\n" if (!$quiet);
+			sleep($initial_wait);
+			$initial_wait = 0;
+		}
 	}

 	return 1;
