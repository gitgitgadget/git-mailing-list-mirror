From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 1/2] sh-setup: Write a new require_clean_work_tree function
Date: Sun, 26 Sep 2010 20:51:55 +0530
Message-ID: <1285514516-5112-2-git-send-email-artagnon@gmail.com>
References: <4C9E07B1.50600@workspacewhiz.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Joshua Jensen <jjensen@workspacewhiz.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Sep 26 17:23:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ozt4r-0001ms-Jl
	for gcvg-git-2@lo.gmane.org; Sun, 26 Sep 2010 17:23:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754456Ab0IZPX2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Sep 2010 11:23:28 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:42137 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753072Ab0IZPX1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Sep 2010 11:23:27 -0400
Received: by pwj6 with SMTP id 6so992413pwj.19
        for <git@vger.kernel.org>; Sun, 26 Sep 2010 08:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=VtB9QnU/4OQbfgZd3Fv4oaIFxfCB/vk8SBPIV6a2I2c=;
        b=PD+zcTL95ski2wBKzYFSlFgDDU+Y0R245XTQyXDJncY7Ihz6Fq3bUYDimc3wCBfXLL
         3jQcCkYO51YuPs2JqGzuxpkLX5+NMD5ilkVg+5HKLBA3eh+UJr6xDNVTD1GSygm+gbc6
         RqJdV6vr/GnJpOQSj0Ba2m7uAvR19GdcbqyOk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=FOseHUR+8QyU1fUAh9iDwovNUhd6anrY4aINhXiAl61mCLAe1xz5uZOmAON1qHEDiL
         nT6omeg/7dBcIm5YWSDYGU1eUWbMXzE1feD6JkwxJ7XV7TLy2NfeavYBvYvGn8wFT/4+
         sgMuFHHvwbWfeZQWt55c4oDvkQV+Adfy+rW9w=
Received: by 10.114.130.5 with SMTP id c5mr6864706wad.125.1285514607051;
        Sun, 26 Sep 2010 08:23:27 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id d39sm8436936wam.16.2010.09.26.08.23.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 26 Sep 2010 08:23:26 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.256.g00e8a.dirty
In-Reply-To: <4C9E07B1.50600@workspacewhiz.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157233>

Write a new require_clean_work_tree function to error out when working
tree contains unstaged changes or index contains uncommitted changes.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 git-sh-setup.sh |   23 +++++++++++++++++++++++
 1 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index 6131670..3a337da 100644
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -145,6 +145,29 @@ require_work_tree () {
 	die "fatal: $0 cannot be used without a working tree."
 }
 
+require_clean_work_tree () {
+	# Update the index
+	git update-index -q --ignore-submodules --refresh
+
+	# Disallow unstaged changes in the working tree
+	if ! git diff-files --quiet --ignore-submodules --
+	then
+		echo >&2 "cannot $1: you have unstaged changes."
+		echo >&2 "Please commit or stash them."
+		git diff-files --name-status -r --ignore-submodules -- >&2
+		exit 1
+	fi
+
+	# Disallow uncommitted changes in the index
+	if ! git diff-index --cached --quiet --ignore-submodules HEAD --
+	then
+		echo >&2 "cannot $1: your index contains uncommitted changes."
+		echo >&2 "Please commit or stash them."
+		git diff-index --cached --name-status -r --ignore-submodules HEAD -- >&2
+		exit 1
+	fi
+}
+
 get_author_ident_from_commit () {
 	pick_author_script='
 	/^author /{
-- 
1.7.2.2.409.gdbb11.dirty
