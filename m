From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 2/2] daemon: Verify base-path and interpolated-path early
Date: Tue, 26 Feb 2008 13:00:55 +0100
Message-ID: <47C3FF77.2060902@viscovery.net>
References: <47C2C23D.1030609@viscovery.net> <7vejb0j04z.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 26 13:03:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTyWr-0003mz-4D
	for gcvg-git-2@gmane.org; Tue, 26 Feb 2008 13:03:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760004AbYBZMBo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Feb 2008 07:01:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759594AbYBZMBn
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Feb 2008 07:01:43 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:52106 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755509AbYBZMBA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Feb 2008 07:01:00 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1JTyTu-0003pw-Hn; Tue, 26 Feb 2008 13:00:22 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id B8DB1A33B; Tue, 26 Feb 2008 13:00:55 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <7vejb0j04z.fsf@gitster.siamese.dyndns.org>
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75124>

Junio C Hamano schrieb:
> Johannes Sixt <j.sixt@viscovery.net> writes:
> 
>> Any request to the daemon would fail if either interpolated-path or
>> base-path (if specified) would not be absolute. Hence, we can check those
>> paths for validity upfront and not start the daemon at all if the paths are
>> invalid.
>>
>> Additionally, we now check that the base-path is an existing directory.
> 
> Looks good.  Thanks.

I just discovered that this patch is crap. Please drop it!

We must not remove the checks from path_ok() because they verify the
*client-supplied* part of the path, which must be absolute.

Nevertheless, it would be useful to verify that --base-path points to an
existing directory. What I actually wanted to implement is this:

-- >8 --
daemon: ensure that base-path is an existing directory

Any request to the daemon would fail if base-path (if specified) is not
a directory. We now check for this condition early.

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
 daemon.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/daemon.c b/daemon.c
index dd0177f..2b4a6f1 100644
--- a/daemon.c
+++ b/daemon.c
@@ -1184,6 +1184,14 @@ int main(int argc, char **argv)
 	if (strict_paths && (!ok_paths || !*ok_paths))
 		die("option --strict-paths requires a whitelist");

+	if (base_path) {
+		struct stat st;
+
+		if (stat(base_path, &st) || !S_ISDIR(st.st_mode))
+			die("base-path '%s' does not exist or "
+			    "is not a directory", base_path);
+	}
+
 	if (inetd_mode) {
 		struct sockaddr_storage ss;
 		struct sockaddr *peer = (struct sockaddr *)&ss;
-- 
1.5.4.3.231.g5d43e
