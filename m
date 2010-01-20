From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH 2/2] Make difftool.prompt fall back to mergetool.prompt
Date: Wed, 20 Jan 2010 17:10:58 +0100
Message-ID: <4B572B12.50907@gmail.com>
References: <4B5721B2.5050703@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, davvid@gmail.com
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Wed Jan 20 17:11:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXd9N-0001Q3-R2
	for gcvg-git-2@lo.gmane.org; Wed, 20 Jan 2010 17:11:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752386Ab0ATQLS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jan 2010 11:11:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751760Ab0ATQLR
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Jan 2010 11:11:17 -0500
Received: from mail-yx0-f187.google.com ([209.85.210.187]:38070 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751497Ab0ATQLQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jan 2010 11:11:16 -0500
Received: by yxe17 with SMTP id 17so6349698yxe.33
        for <git@vger.kernel.org>; Wed, 20 Jan 2010 08:11:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=6hneJPRRz+MRe09oq4MpdZm2MM+bCBhjNRphjXVbG9Y=;
        b=wGQ4ZC0kGMu3DetgXi/6r25p1p5JSroMDy/79zDEo6S8cbkQ/a7LbKnBx84x+nPllq
         3kkIVU4EGpirwL/UfozkkgSpw/bo/EDicZ/zKZ629eYXDvxwhrq1SIhzS+xS8YthrQpG
         IhN+1Y3ad0LfGMo/POv38y2Z3iaYlp1Ti7YXE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        b=p/s8ei36lxyZ8L7tLotvcDhT+KEIZkzvm+sCNDfAzblojWQjfeOsiIDFTIBBnnos6D
         9o6JqNaHQd/nc9dG9cCDNzDQpNsX97ER7jOtFOxfncuk1rdg/2xL8qraOjN54tuG7Xbg
         mT/AwWdQSeaAAzXLGAU4LaKcJxgwtPPSvQTy0=
Received: by 10.103.48.13 with SMTP id a13mr92510muk.14.1264003874848;
        Wed, 20 Jan 2010 08:11:14 -0800 (PST)
Received: from ?192.168.1.11? (91-67-62-42-dynip.superkabel.de [91.67.62.42])
        by mx.google.com with ESMTPS id g1sm155284muf.37.2010.01.20.08.11.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 20 Jan 2010 08:11:13 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12) Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
In-Reply-To: <4B5721B2.5050703@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137556>

The documentation states that "git-difftool falls back to git-mergetool
config variables when the difftool equivalents have not been defined".
Until now, this was not the case for "difftool.prompt".

Signed-off-by: Sebastian Schuberth <sschuberth@gmail.com>
---
 git-difftool--helper.sh |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/git-difftool--helper.sh b/git-difftool--helper.sh
index 57e8e32..1c1fad4 100755
--- a/git-difftool--helper.sh
+++ b/git-difftool--helper.sh
@@ -11,8 +11,9 @@ TOOL_MODE=diff
 
 # difftool.prompt controls the default prompt/no-prompt behavior
 # and is overridden with $GIT_DIFFTOOL*_PROMPT.
-should_prompt () {
-	prompt=$(git config --bool difftool.prompt || echo true)
+should_prompt_diff () {
+	prompt_merge=$(should_prompt_merge && echo true || echo false)
+	prompt=$(git config --bool difftool.prompt || echo $prompt_merge)
 	if test "$prompt" = true; then
 		test -z "$GIT_DIFFTOOL_NO_PROMPT"
 	else
@@ -33,7 +34,7 @@ launch_merge_tool () {
 
 	# $LOCAL and $REMOTE are temporary files so prompt
 	# the user with the real $MERGED name before launching $merge_tool.
-	if should_prompt; then
+	if should_prompt_diff; then
 		printf "\nViewing: '$MERGED'\n"
 		printf "Hit return to launch '%s': " "$merge_tool"
 		read ans
-- 
1.6.6.266.g55d982.dirty
