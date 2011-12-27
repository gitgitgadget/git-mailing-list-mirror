From: Sven Strickroth <sven.strickroth@tu-clausthal.de>
Subject: [PATCH 1/5] add central method for prompting a user using GIT_ASKPASS
 or SSH_ASKPASS
Date: Tue, 27 Dec 2011 17:05:20 +0100
Message-ID: <4EF9ECC0.606@tu-clausthal.de>
References: <4EC52508.9070907@tu-clausthal.de> <CABPQNSZ0iPAE+BnDU6Nz8_PkrAtPbjL4RoJuQS=Um2wxPt-2DQ@mail.gmail.com> <4EC65DE4.90005@tu-clausthal.de> <CABPQNSbfM0JRVPk3fxfSEq7QaO-fynHM8FBGpPribdgeRqpZKA@mail.gmail.com> <4ED0CE8B.70205@tu-clausthal.de> <20111130064401.GC5317@sigill.intra.peff.net> <4EF907F1.1030801@tu-clausthal.de> <m3d3baf5kd.fsf@localhost.localdomain> <4EF9D8B9.9060106@tu-clausthal.de> <4EF9EBF4.7070200@tu-clausthal.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>, Jeff King <peff@peff.net>,
	gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 27 17:06:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RfZY1-00013X-N0
	for gcvg-git-2@lo.gmane.org; Tue, 27 Dec 2011 17:06:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754621Ab1L0QGh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Dec 2011 11:06:37 -0500
Received: from hades.rz.tu-clausthal.de ([139.174.2.20]:40653 "EHLO
	hades.rz.tu-clausthal.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754166Ab1L0QGg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Dec 2011 11:06:36 -0500
Received: from hades.rz.tu-clausthal.de (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP id 327B5422116;
	Tue, 27 Dec 2011 17:05:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=tu-clausthal.de; h=
	message-id:date:from:mime-version:to:cc:subject:references
	:in-reply-to:content-type:content-transfer-encoding; s=dkim1;
	 bh=JCoA1Pkyn/Snw7nYtfQo4v05BHE=; b=h9iaFmtGJs090HqcR90xPC+jxHJ3
	Cjn/HFVZV1gqPQX9eQqG/gZVqaemJfL+H5abA8mIMoc6RkiZgNmNIROqIrUmofIA
	y1igBxxSXp0ICr3lpVZbvLDmJ1N3i2Yo7EFUYTNHUmAzVaE4xI6Juwq+dhxXoqiq
	nSVbZfg9IXXS3Sg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=tu-clausthal.de; h=
	message-id:date:from:mime-version:to:cc:subject:references
	:in-reply-to:content-type:content-transfer-encoding; q=dns; s=
	dkim1; b=gnRDAK8uCWoODsCE0Z1QhYZSEO5z6pIMcPZWueVAmpVfdYQX3sohhOO
	34VT6LhAbTuVceZlIumx/YvqF/V4gFzHUDXQi8SE38AZ8VUM5epezy2u3XMi8juS
	6rAp9royu/CyAX/A+zUFH2lnftXz5iRlGbJO+O3OGmy7YnnHoVpk=
Received: from tu-clausthal.de (hathor.rz.tu-clausthal.de [139.174.2.1])
	by hades.rz.tu-clausthal.de (Postfix) with ESMTP id E94BE422114;
	Tue, 27 Dec 2011 17:05:19 +0100 (CET)
Received: from [91.4.99.60] (account sstri@tu-clausthal.de HELO [192.168.178.20])
  by tu-clausthal.de (CommuniGate Pro SMTP 5.4.3)
  with ESMTPSA id 25242390; Tue, 27 Dec 2011 17:05:19 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:9.0) Gecko/20111222 Thunderbird/9.0.1
In-Reply-To: <4EF9EBF4.7070200@tu-clausthal.de>
X-Enigmail-Version: 1.3.4
X-Virus-Scanned: by Sophos PureMessage V5.6 at tu-clausthal.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187717>


Signed-off-by: Sven Strickroth <email@cs-ware.de>
---
 perl/Git.pm |   36 +++++++++++++++++++++++++++++++++++-
 1 files changed, 35 insertions(+), 1 deletions(-)

diff --git a/perl/Git.pm b/perl/Git.pm
index f7ce511..7fdf805 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -58,7 +58,7 @@ require Exporter;
                 command_output_pipe command_input_pipe command_close_pipe
                 command_bidi_pipe command_close_bidi_pipe
                 version exec_path html_path hash_object git_cmd_try
-                remote_refs
+                remote_refs askpass_prompt
                 temp_acquire temp_release temp_reset temp_path);


@@ -512,6 +512,40 @@ C<git --html-path>). Useful mostly only internally.
 sub html_path { command_oneline('--html-path') }


+=item askpass_prompt ( PROMPT)
+
+Asks user using *_ASKPASS programs and return answer from user.
+
+Checks if GIT_ASKPASS or SSH_ASKPASS is set, and use first matching for querying
+user and returns answer.
+
+If no *_ASKPASS variable is set, the variable is empty or an error occours,
+it returns undef and the caller has to ask the user (e.g. on terminal).
+
+=cut
+
+sub askpass_prompt {
+	my ($self, $prompt) = _maybe_self(@_);
+	if (exists $ENV{'GIT_ASKPASS'}) {
+		return _askpass_prompt($ENV{'GIT_ASKPASS'}, $prompt);
+	} elsif (exists $ENV{'SSH_ASKPASS'}) {
+		return _askpass_prompt($ENV{'SSH_ASKPASS'}, $prompt);
+	} else {
+		return undef;
+	}
+}
+
+sub _askpass_prompt {
+	my ($self, $askpass, $prompt) = _maybe_self(@_);
+	my $ret;
+	open my $fh, "-|", $askpass, $prompt || return undef;
+	$ret = <$fh>;
+	$ret =~ s/[\012\015]//g; # strip \n\r, chomp does not work on all systems (i.e. windows) as expected
+	close ($fh);
+	return $ret;
+}
+
+
 =item repo_path ()

 Return path to the git repository. Must be called on a repository instance.

-- 
Best regards,
 Sven Strickroth
 ClamAV, a GPL anti-virus toolkit   http://www.clamav.net
 PGP key id F5A9D4C4 @ any key-server
