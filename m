From: Sven Strickroth <sven.strickroth@tu-clausthal.de>
Subject: Re: [PATCH 1/2] git-svn, perl/Git.pm: add central method for prompting
 passwords honoring GIT_ASKPASS and SSH_ASKPASS
Date: Wed, 04 Jan 2012 15:13:31 +0100
Message-ID: <4F045E8B.4060200@tu-clausthal.de>
References: <4EF9ED58.8080205@tu-clausthal.de> <7vd3b967ql.fsf@alter.siamese.dyndns.org> <7vty4l4rr8.fsf@alter.siamese.dyndns.org> <4EFA5EB3.4000802@tu-clausthal.de> <CACBZZX7P9PEq0wZp0d3dSwDjF6J6Z3cO4VtWc9_frBengtqPLw@mail.gmail.com> <7vboqks8la.fsf@alter.siamese.dyndns.org> <4F038EC8.505@tu-clausthal.de> <7v39bws4xi.fsf@alter.siamese.dyndns.org> <4F0405D4.9090102@tu-clausthal.de> <4F040E46.5030001@tu-clausthal.de> <20120104133459.GA6564@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jan 04 15:13:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RiRb0-0006Kp-GF
	for gcvg-git-2@lo.gmane.org; Wed, 04 Jan 2012 15:13:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754090Ab2ADON3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jan 2012 09:13:29 -0500
Received: from poseidon.rz.tu-clausthal.de ([139.174.2.21]:19325 "EHLO
	poseidon.rz.tu-clausthal.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755311Ab2ADON1 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Jan 2012 09:13:27 -0500
Received: from poseidon.rz.tu-clausthal.de (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP id 34C6824A60;
	Wed,  4 Jan 2012 15:13:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=tu-clausthal.de; h=
	message-id:date:from:mime-version:to:cc:subject:references
	:in-reply-to:content-type:content-transfer-encoding; s=dkim1;
	 bh=h48GWuvJrz8l0TLGWJ3S1MWCKQc=; b=oQ3kC88iA6+JFISQTISoYsmOOiX9
	BftAKQ7CPEq6kTdQ9z5Gt4q1/uS2fT/FXLyHXmQj8H1Kw3W6iYfUKdBov3rsp16X
	vJBcbV38c/m93UwTbAiycUHkBztMI7+Z0uEttqwVaa87UyaTTvm5Vy0ftVdMX+M/
	cBDMLlDMZKG6aPk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=tu-clausthal.de; h=
	message-id:date:from:mime-version:to:cc:subject:references
	:in-reply-to:content-type:content-transfer-encoding; q=dns; s=
	dkim1; b=5jfUngsG/j4FDRu7pTjPpBeoNbVyAPj+VudC18jL1fgxjEOeXbV6inn
	bgoX0xaU02td/bvRyWj5Kvq1cHTmYNYlhZGt6BfDlmXs/73Ji4NR6CzUYVveaZAm
	7LoO8tdiiJoeUTxmkpjdhT5yjgrzwVET8gF8ild66QPhxVviR3HQ=
Received: from tu-clausthal.de (hathor.rz.tu-clausthal.de [139.174.2.1])
	by poseidon.rz.tu-clausthal.de (Postfix) with ESMTP id 10E6F249CE;
	Wed,  4 Jan 2012 15:13:26 +0100 (CET)
Received: from [139.174.4.12] (account sstri@tu-clausthal.de [139.174.4.12] verified)
  by tu-clausthal.de (CommuniGate Pro SMTP 5.4.3)
  with ESMTPSA id 25680820; Wed, 04 Jan 2012 15:13:26 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:9.0) Gecko/20111222 Thunderbird/9.0.1
In-Reply-To: <20120104133459.GA6564@sigill.intra.peff.net>
X-Enigmail-Version: 1.3.4
X-Virus-Scanned: by Sophos PureMessage V5.6 at tu-clausthal.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187922>

Am 04.01.2012 14:34 schrieb Jeff King:
> Wouldn't you also have to drop checking of SSH_ASKPASS in the block
> right before calling git_terminal_prompt (right before the context in
> your patch)?

of course :( Thanks for spotting this...

diff --git a/prompt.c b/prompt.c
index 72ab9de..230ac3c 100644
--- a/prompt.c
+++ b/prompt.c
@@ -45,16 +45,23 @@ char *git_prompt(const char *prompt, int flags)
 		askpass = getenv("GIT_ASKPASS");
 		if (!askpass)
 			askpass = askpass_program;
-		if (!askpass)
-			askpass = getenv("SSH_ASKPASS");
 		if (askpass && *askpass)
 			return do_askpass(askpass, prompt);
 	}

 	r = git_terminal_prompt(prompt, flags & PROMPT_ECHO);
-	if (!r)
-		die_errno("could not read '%s'", prompt);
-	return r;
+	if (r)
+		return r;
+
+	if (flags & PROMPT_ASKPASS) {
+		const char *askpass;
+
+		askpass = getenv("SSH_ASKPASS");
+		if (askpass && *askpass)
+			return do_askpass(askpass, prompt);
+	}
+
+	die_errno("could not read '%s'", prompt);
 }

 char *git_getpass(const char *prompt)
-- 
Best regards,
 Sven Strickroth
 ClamAV, a GPL anti-virus toolkit   http://www.clamav.net
 PGP key id F5A9D4C4 @ any key-server
