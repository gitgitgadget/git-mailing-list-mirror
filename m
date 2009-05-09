From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCHv2 1/2] completion: add __git_config_get_set_variables() to get config variables
Date: Fri,  8 May 2009 18:23:32 -0700
Message-ID: <1241832213-23070-2-git-send-email-bebarino@gmail.com>
References: <1241832213-23070-1-git-send-email-bebarino@gmail.com>
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat May 09 03:23:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M2bI6-0007z8-Kv
	for gcvg-git-2@gmane.org; Sat, 09 May 2009 03:23:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754597AbZEIBXl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 May 2009 21:23:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753739AbZEIBXk
	(ORCPT <rfc822;git-outgoing>); Fri, 8 May 2009 21:23:40 -0400
Received: from wf-out-1314.google.com ([209.85.200.171]:28172 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754394AbZEIBXj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 May 2009 21:23:39 -0400
Received: by wf-out-1314.google.com with SMTP id 26so1570775wfd.4
        for <git@vger.kernel.org>; Fri, 08 May 2009 18:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=NWcbL6des4Bj+pD309lA39r4l2ulAo6h8rj/RAAClLI=;
        b=fHmgCgiASfo8yiPpnLGFME7tTROEavblsEK1CxFFUnfA89QzZGLMJFOST9C7S3P/jA
         TviV6kCnWHbCRK/GUHwgJLiDpWdo3WXxsA8/n2MCZbAmPlGqWVE0o192b5Qccbo2Gong
         4umRedX7W8zxiFAJAe1O0t7h2UjkYmXGAMNPU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=j9n0WvsVLHj2CWsPn/9zQxLY44vCL6cujvrjM6cowCVtNe2PvQhXB5cznRgeXxNGXF
         uzUH91QoXYJCOwDCKIdAxUYSN9jePeTetoLXi2cmyZvf7ygdNdpgEY0ooiNczCbC24Ru
         7u522rzTWgvuzdCHnV/OT3XJNtJWpdi8tZI18=
Received: by 10.142.87.4 with SMTP id k4mr1695369wfb.82.1241832219661;
        Fri, 08 May 2009 18:23:39 -0700 (PDT)
Received: from earth ([76.89.212.195])
        by mx.google.com with ESMTPS id 22sm789881wfd.39.2009.05.08.18.23.37
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 08 May 2009 18:23:39 -0700 (PDT)
Received: by earth (sSMTP sendmail emulation); Fri, 08 May 2009 18:23:36 -0700
X-Mailer: git-send-email 1.6.3
In-Reply-To: <1241832213-23070-1-git-send-email-bebarino@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118645>

This function retrieves the set configuration variables from the
appropriate configuration file. For example, if the user has previously
specified --global only the global variables are returned. The same
applies for --system, and --file. If no location has been specified, all
set variables are returned.

Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---
 contrib/completion/git-completion.bash |   29 +++++++++++++++++++++++++++++
 1 files changed, 29 insertions(+), 0 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 1683e6d..e73359c 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1322,6 +1322,35 @@ _git_send_email ()
 	COMPREPLY=()
 }
 
+__git_config_get_set_variables ()
+{
+	local prevword word config_file= c=$COMP_CWORD
+	while [ $c -gt 1 ]; do
+		word="${COMP_WORDS[c]}"
+		case "$word" in
+		--global|--system|--file=*)
+			config_file="$word"
+			break
+			;;
+		-f|--file)
+			config_file="$word $prevword"
+			break
+			;;
+		esac
+		prevword=$word
+		c=$((--c))
+	done
+
+	for i in $(git --git-dir="$(__gitdir)" config $config_file --list \
+			2>/dev/null); do
+		case "$i" in
+		*.*)
+			echo "${i/=*/}"
+			;;
+		esac
+	done
+}
+
 _git_config ()
 {
 	local cur="${COMP_WORDS[COMP_CWORD]}"
-- 
1.6.3
