From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 09/14] t1301-*.sh: Fix the 'forced modes' test on cygwin
Date: Tue, 14 Dec 2010 18:30:43 +0000
Message-ID: <4D07B7D3.80601@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>, dpotapov@gmail.com,
	j6t@kdbg.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 14 19:47:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSZu0-0005Vk-6J
	for gcvg-git-2@lo.gmane.org; Tue, 14 Dec 2010 19:47:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758715Ab0LNSqs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Dec 2010 13:46:48 -0500
Received: from lon1-post-1.mail.demon.net ([195.173.77.148]:52754 "EHLO
	lon1-post-1.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758534Ab0LNSqr (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Dec 2010 13:46:47 -0500
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by lon1-post-1.mail.demon.net with esmtp (Exim 4.69)
	id 1PSZte-00077O-WI; Tue, 14 Dec 2010 18:46:46 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163672>


The 'forced modes' test fails on cygwin because the post-update
hook loses it's executable bit when copied from the templates
directory by git-init. The template loses it's executable bit
because the lstat() function resolves to the "native Win32 API"
implementation.

This call to lstat() happens after git-init has set the "git_dir"
(so has_git_dir() returns true), but before the configuration has
been fully initialised. At this point git_config() does not find
any config files to parse and returns 0. Unfortunately, the code
used to determine the cygwin l/stat() function bindings did not
check the return from git_config() and assumed that the config
was complete and accessible once "git_dir" was set.

In order to fix the test, we simply change the binding code to
test the return value from git_config(), to ensure that it actually
had config values to read, before determining the requested binding.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---
 compat/cygwin.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/compat/cygwin.c b/compat/cygwin.c
index b4a51b9..b38dbd7 100644
--- a/compat/cygwin.c
+++ b/compat/cygwin.c
@@ -114,8 +114,7 @@ static int git_cygwin_config(const char *var, const char *value, void *cb)
 
 static int init_stat(void)
 {
-	if (have_git_dir()) {
-		git_config(git_cygwin_config, NULL);
+	if (have_git_dir() && git_config(git_cygwin_config,NULL)) {
 		if (!core_filemode && native_stat) {
 			cygwin_stat_fn = cygwin_stat;
 			cygwin_lstat_fn = cygwin_lstat;
-- 
1.7.3
