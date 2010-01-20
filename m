From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH 1/2] Allow to override mergetool.prompt with $GIT_MERGETOOL*_PROMPT
Date: Wed, 20 Jan 2010 17:10:21 +0100
Message-ID: <4B572AED.1040801@gmail.com>
References: <4B572192.2020606@gmail.com> <4B572870.6090001@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, davvid@gmail.com
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Jan 20 17:10:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXd8l-00015t-M4
	for gcvg-git-2@lo.gmane.org; Wed, 20 Jan 2010 17:10:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752309Ab0ATQKl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jan 2010 11:10:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752366Ab0ATQKl
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Jan 2010 11:10:41 -0500
Received: from gv-out-0910.google.com ([216.239.58.188]:8622 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751497Ab0ATQKk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jan 2010 11:10:40 -0500
Received: by gv-out-0910.google.com with SMTP id n8so145503gve.37
        for <git@vger.kernel.org>; Wed, 20 Jan 2010 08:10:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=Wmp7aY4aXz6wBylalIz4fXOm6iCp1IiCi7ui1SKWnpQ=;
        b=imDbKkWhc2RnEwlp3Qja26GvP+iyIA7waKCNKOudxGueEzhdMlk0vwSwNGQafp3lwv
         BaUMjKUWYfwaI1+Dv0uWFIzx0x7sANvwycodJOumd1NZh9V91kB9VMy8CORSv8GCE3a5
         /UOIeefMUNw/XkEuYUCqSdR+Cs+1S2XR6VbF4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=kXehH1l7MoI/eTVDMiPhh/55PzbofT9OkSL6fHk1QJyczJTvllziso6TkPZSLOM5YP
         856HOgp6TEqktnrilfe6OpAXLz9ygXW7o4lJ785o2DVj1VuCQwJvcIq+pwU2KTXU+E3f
         1R7LHUzakyOhieyCbSVfxWWc4iuIOjutIkggU=
Received: by 10.103.122.14 with SMTP id z14mr93630mum.10.1264003838487;
        Wed, 20 Jan 2010 08:10:38 -0800 (PST)
Received: from ?192.168.1.11? (91-67-62-42-dynip.superkabel.de [91.67.62.42])
        by mx.google.com with ESMTPS id 12sm159414muq.18.2010.01.20.08.10.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 20 Jan 2010 08:10:36 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12) Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
In-Reply-To: <4B572870.6090001@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137555>

This is for symmetry with git-difftool, and to make should_prompt_merge ()
reusable from within git-difftool--helper.

Signed-off-by: Sebastian Schuberth <sschuberth@gmail.com>
---
 git-mergetool--lib.sh |    9 +++++++++
 git-mergetool.sh      |    2 +-
 2 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
index 5b62785..b0e4156 100644
--- a/git-mergetool--lib.sh
+++ b/git-mergetool--lib.sh
@@ -7,6 +7,15 @@ merge_mode() {
 	test "$TOOL_MODE" = merge
 }
 
+should_prompt_merge () {
+	prompt=$(git config --bool mergetool.prompt || echo true)
+	if test "$prompt" = true; then
+		test -z "$GIT_MERGETOOL_NO_PROMPT"
+	else
+		test -n "$GIT_MERGETOOL_PROMPT"
+	fi
+}
+
 translate_merge_tool_path () {
 	case "$1" in
 	vimdiff)
diff --git a/git-mergetool.sh b/git-mergetool.sh
index b52a741..69f1627 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -202,7 +202,7 @@ merge_file () {
     return 0
 }
 
-prompt=$(git config --bool mergetool.prompt || echo true)
+prompt=$(should_prompt_merge && echo true || echo false)
 
 while test $# != 0
 do
-- 
1.6.6.266.g55d982.dirty
