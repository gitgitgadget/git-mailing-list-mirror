From: Junio C Hamano <gitster@pobox.com>
Subject: Re* [PATCH 2/3] t1301-*.sh: Fix the 'forced modes' test on cygwin
Date: Mon, 20 Jun 2011 12:31:59 -0700
Message-ID: <7v8vswcn9s.fsf_-_@alter.siamese.dyndns.org>
References: <4DFA6632.40607@ramsay1.demon.co.uk> <4DFB0C66.5080904@kdbg.org>
 <4DFCF6AF.3060502@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j6t@kdbg.org>,
	GIT Mailing-list <git@vger.kernel.org>,
	Jeff King <peff@peff.net>, Erik Faye-Lund <kusmabite@gmail.com>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Mon Jun 20 21:32:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QYkCf-0002UB-Gu
	for gcvg-git-2@lo.gmane.org; Mon, 20 Jun 2011 21:32:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755369Ab1FTTcF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jun 2011 15:32:05 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:49614 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752372Ab1FTTcD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jun 2011 15:32:03 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2B7655271;
	Mon, 20 Jun 2011 15:34:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3x1ofB2F/nmP/kokfTZTOHsAnkY=; b=ukKLG1
	G1rM9hgDhvOjQ/ZYzK9ot/LTEqThxh7zBPjm23ai4scVkaGlomWdi+wFbYBphYMo
	xefQasNltQg0H3qxzZ5vCPqam5HjanbPrivAQU4/fuS6+Kydv0UaUlWUVqc9ctPU
	CiAiTwvzrBISKXx02m3XJygcWQi3DwXT4urZQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FetCdJuf9Vbe+arUlIHMI2IyTKXjExY6
	58XYHZPuPrkesKXUy8Ys06lry+7YPGtPy2zLCU3ayZtEnH6nv7cDr3r4DvIv2r+6
	NyyLvMzx3hOs9j60oTr3TdMS+T0leY2xWofbSQnhUAf4igIfHW/6Y7QQhG9eWSiV
	cRseQdkwzC0=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 231BC526F;
	Mon, 20 Jun 2011 15:34:12 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 6E26C526E; Mon, 20 Jun 2011
 15:34:11 -0400 (EDT)
In-Reply-To: <4DFCF6AF.3060502@ramsay1.demon.co.uk> (Ramsay Jones's message
 of "Sat, 18 Jun 2011 20:04:15 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4608B6E0-9B74-11E0-8A59-5875C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176087>

Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:

> No, that is indeed a bug. See commit 7974843 (compat/cygwin.c: make
> runtime detection of lstat/stat lessor impact, 23-10-2008).

Let's fix it while the bug has our attention, then.

-- >8 --
Subject: cygwin: trust executable bit by default

Earlier 7974843 (compat/cygwin.c: make runtime detection of lstat/stat
lessor impact, 2008-10-23) fixed the low-level "do we use cygwin specific
hacks for stat/lstat?" logic not to call into git_default_config() from
random codepaths that are typically very late in the program, to prevent
the call from potentially overwriting other variables that are initialized
from the configuration.

However, it forgot that on Cygwin, trust-executable-bit should default to
true.

Noticed by J6t, confirmed by Ramsay Jones, and the brown paper bag is on
Gitster's head.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 compat/cygwin.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/compat/cygwin.c b/compat/cygwin.c
index b4a51b9..ba3327f 100644
--- a/compat/cygwin.c
+++ b/compat/cygwin.c
@@ -101,7 +101,7 @@ static int cygwin_stat(const char *path, struct stat *buf)
  * and calling git_default_config() from here would break such variables.
  */
 static int native_stat = 1;
-static int core_filemode;
+static int core_filemode = 1; /* matches trust_executable_bit default */
 
 static int git_cygwin_config(const char *var, const char *value, void *cb)
 {
