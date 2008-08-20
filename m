From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH/RFC] feeding Maildir to git-am
Date: Tue, 19 Aug 2008 22:25:57 -0700
Message-ID: <7vbpzotfyy.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 20 07:27:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVgEH-0006jP-PR
	for gcvg-git-2@gmane.org; Wed, 20 Aug 2008 07:27:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752148AbYHTF0L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Aug 2008 01:26:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751770AbYHTF0J
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Aug 2008 01:26:09 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:61592 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751715AbYHTF0I (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Aug 2008 01:26:08 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id BE69157973;
	Wed, 20 Aug 2008 01:26:05 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 1821B57972; Wed, 20 Aug 2008 01:25:59 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 7CAAA54A-6E78-11DD-A027-B29498D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92963>

I do not use Maildir myself but people who do not know how Maildir look
like (including myself) would be left wondering why there is even no error
message when giving a random directory full of format-patch output to am.

I am wondering if something like this would be helpful...

 builtin-mailsplit.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git i/builtin-mailsplit.c w/builtin-mailsplit.c
index 71f3b3b..829abbb 100644
--- i/builtin-mailsplit.c
+++ w/builtin-mailsplit.c
@@ -122,16 +122,17 @@ static int populate_maildir_list(struct string_list *list, const char *path)
 	char name[PATH_MAX];
 	char *subs[] = { "cur", "new", NULL };
 	char **sub;
+	int found = 0;
 
 	for (sub = subs; *sub; ++sub) {
 		snprintf(name, sizeof(name), "%s/%s", path, *sub);
 		if ((dir = opendir(name)) == NULL) {
 			if (errno == ENOENT)
 				continue;
-			error("cannot opendir %s (%s)", name, strerror(errno));
-			return -1;
+			return error("cannot opendir %s (%s)", name, strerror(errno));
 		}
 
+		found = 1;
 		while ((dent = readdir(dir)) != NULL) {
 			if (dent->d_name[0] == '.')
 				continue;
@@ -142,6 +143,8 @@ static int populate_maildir_list(struct string_list *list, const char *path)
 		closedir(dir);
 	}
 
+	if (!found)
+		return error("'%s' is not a Maildir (no 'cur' nor 'new' found)", path);
 	return 0;
 }
 
