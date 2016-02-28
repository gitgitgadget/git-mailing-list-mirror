From: Moritz Neeb <lists@moritzneeb.de>
Subject: Re: [RFC/PATCH] lockfile: improve error message when lockfile exists
Date: Sun, 28 Feb 2016 23:58:21 +0100
Message-ID: <56D37B8D.9090001@moritzneeb.de>
References: <1456690276-13914-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Gregory.Mounie@grenoble-inp.fr
To: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 28 23:58:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaAII-0006kF-U1
	for gcvg-git-2@plane.gmane.org; Sun, 28 Feb 2016 23:58:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755448AbcB1W60 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Feb 2016 17:58:26 -0500
Received: from moritzneeb.de ([78.47.1.106]:38923 "EHLO moritzneeb.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755277AbcB1W6Z (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Feb 2016 17:58:25 -0500
Received: from [192.168.1.3] (x4db4d017.dyn.telefonica.de [77.180.208.23])
	by moritzneeb.de (Postfix) with ESMTPSA id 733191C058;
	Sun, 28 Feb 2016 23:58:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=moritzneeb.de;
	s=mail; t=1456700301;
	bh=UJxdvJo0CO+/2z50Alh2sQcWZEfEVrJLsjNud8Dyw4Y=;
	h=Subject:To:References:Cc:From:Date:In-Reply-To:From;
	b=Pkr8aPVPHhbH8O2COyaZqeUdhlFOnRRFOo7fQjgDJS0xRd0PzTBshRuU1xO/bUSWv
	 MZlhqcipnvYGl1AjRzqp1hQLB76e0QWmflK88mhxVwlgnCTRwN1o9JIkyASZsPs2Jd
	 ln8cxTFRErL8Sgpzprb8uvJMhMeGvndgLd1A/rqU=
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
In-Reply-To: <1456690276-13914-1-git-send-email-Matthieu.Moy@imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287793>

On 02/28/2016 09:11 PM, Matthieu Moy wrote:
> A common mistake leading a user to see this message is to launch "git
> commit", let the editor open (and forget about it), and try again to
> commit.
> 
> The previous message was going too quickly to "a git process crashed"
> and to the advice "remove the file manually".
> 
> This patch modifies the message in two ways: first, it considers that
> "another process is running" is the norm, not the exception, and it
> explicitly hints the user to look at text editors.
> 
> The message is 2 lines longer, but this is not a problem since
> experienced users do not see the message often.
> 
> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
> ---
> This patch was written after seen one more time a student panicked
> because he had a "git commit" backgrounded.

I think git commit is almost the only case where this would happen.
If the goal is have it shorter, then the editor example could be boiled down to
something like "e.g. a commit". But then it is less clear on what the
necessary action would be. 
> 
> I'm not 100% satisfied with the new message. I don't think it harms to
> have a 5-lines message here but it's probably possible to be a bit
> more concise.

I adapted it a bit, it has about the same length but I tried to
take out some repeating:

-- 8< --
diff --git a/lockfile.c b/lockfile.c
index 80d056d..ffb4c8d 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -150,9 +150,11 @@ void unable_to_lock_message(const char *path, int err, struct strbuf *buf)
 {
     if (err == EEXIST) {
         strbuf_addf(buf, "Unable to create '%s.lock': %s.\n\n"
-            "If no other git process is currently running, this probably means a\n"
-            "git process crashed in this repository earlier. Make sure no other git\n"
-            "process is running and remove the file manually to continue.",
+            "Another git process seems to be running in this repository,\n"
+            "e.g. an editor opened by git. Please make sure all processes\n"
+            "are terminated then try again. If it still fails, a git process\n"
+            "may have crashed in this repository earlier:\n"
+            "remove the file manually to continue.",
                 absolute_path(path), strerror(err));
     } else
         strbuf_addf(buf, "Unable to create '%s.lock': %s",
