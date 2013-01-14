From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] clone: do not export and unexport GIT_CONFIG
Date: Mon, 14 Jan 2013 10:11:13 -0800
Message-ID: <7v1udneita.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 14 19:11:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TuoVV-0000jk-2E
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jan 2013 19:11:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756574Ab3ANSLR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jan 2013 13:11:17 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61926 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756500Ab3ANSLQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jan 2013 13:11:16 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D6BEAB617;
	Mon, 14 Jan 2013 13:11:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=n
	leEXm75Kv2jg9ZBUh40Edosl6g=; b=l3MsDwibqN27NiVu6c8/pSatlikEudjrm
	tl+nIPLNN94prEZBCYYEB+SNU3W/XzXY8ud4W63MdAKjWt/RWLMERktqbzrE/Uxu
	RrNIPewDwBIzgsoHA9XCfv9ZQFoLTTWSrO/da/RRqwg11Bw9wzdFHmc7ycmJ+y4o
	r9ZLVP4IfA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=TwH
	UHGapVO9yPRgRSKyfGvK3RfYegJ9Rc1m4GgsaP81vqd6K10A5RqsEVcr+yS4ygei
	DDbzcnVZNQ1DEtfCbu/iQI/AZG8zv9m3HFIS3aPI2kBVkOh4gq5CmRxmnlW8pMQo
	5KEzkUV4MVUR0STn0R2vDjjjIueW/pCiCu1yu8aU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CB927B615;
	Mon, 14 Jan 2013 13:11:15 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 33BD1B611; Mon, 14 Jan 2013
 13:11:15 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C912FE04-5E75-11E2-86E7-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213511>

Earlier, dc87183 (use GIT_CONFIG only in "git config", not other
programs, 2008-06-30) made sure that the environment variable is
never used outside "git config", but "git clone", after creating a
directory for the new repository and until the init_db() function
populates its .git/ directory, exported the variable for no good
reason.  No hook will run from init_db() and more importantly no
hook can run until init_db() finishes creation of the new
repository, so it cannot be used by any invocation of "git config"
by definition.

Stop doing the useless export/unexport.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/clone.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index a4d8d25..6f0c1c6 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -714,8 +714,6 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	atexit(remove_junk);
 	sigchain_push_common(remove_junk_on_signal);
 
-	setenv(CONFIG_ENVIRONMENT, mkpath("%s/config", git_dir), 1);
-
 	if (safe_create_leading_directories_const(git_dir) < 0)
 		die(_("could not create leading directories of '%s'"), git_dir);
 
@@ -732,13 +730,6 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	init_db(option_template, INIT_DB_QUIET);
 	write_config(&option_config);
 
-	/*
-	 * At this point, the config exists, so we do not need the
-	 * environment variable.  We actually need to unset it, too, to
-	 * re-enable parsing of the global configs.
-	 */
-	unsetenv(CONFIG_ENVIRONMENT);
-
 	git_config(git_default_config, NULL);
 
 	if (option_bare) {
-- 
1.8.1.407.g91cb4ac
