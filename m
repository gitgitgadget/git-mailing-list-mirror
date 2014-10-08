From: Brandon Turner <bt@brandonturner.net>
Subject: [PATCH v3] completion: ignore chpwd_functions when cding on zsh
Date: Wed,  8 Oct 2014 16:49:48 -0500
Message-ID: <1412804988-56858-2-git-send-email-bt@brandonturner.net>
References: <xmqqh9zebfc6.fsf@gitster.dls.corp.google.com>
Cc: git@vger.kernel.org, Brandon Turner <bt@brandonturner.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 08 23:51:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xbz8x-0004yI-Lj
	for gcvg-git-2@plane.gmane.org; Wed, 08 Oct 2014 23:51:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932253AbaJHVvJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Oct 2014 17:51:09 -0400
Received: from mail-pd0-f171.google.com ([209.85.192.171]:38823 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932133AbaJHVvI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Oct 2014 17:51:08 -0400
Received: by mail-pd0-f171.google.com with SMTP id ft15so8609pdb.2
        for <git@vger.kernel.org>; Wed, 08 Oct 2014 14:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brandonturner.net; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sIhixaYnNRVvu14UUO/KoQAFXLdVx9bzeyqC7pPsemU=;
        b=JGXF5my9ZahGurXr+3A5yLvvNgU+yySzNzDwomiViyTyrtr8fr8f/KHc5W3oZlhjkg
         Z9GWh5Y2XE0iuLXbVYOfE6xDIKgzsC8wvxqrSJVPyyz+QC8Wiw5U1TidgSjpnj1GRF4x
         oTeOXq9RmEY3FHIAP3pCiURwpADqoC0JCeDsk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sIhixaYnNRVvu14UUO/KoQAFXLdVx9bzeyqC7pPsemU=;
        b=BAc6iZQ6iKeSTu679osWi5pA/p+uYy2xaBSVWFLjidgdwEraW5ixf/LidsGSiYIkfL
         Ieq+Kuhdt6tc8o0M639Lyc42bYIy/WGqkgpjOu97QXXXrMAghzmemGZ+xAJXiNjsAv8W
         SFNvUJKZFHX8/gCdQFP2Kw0MSGD43Oc09jrbJRVLV+28j1O3ekN2C8QwDnpXvpIBso2G
         itkRF4wiYQ3m5FcN1kKOXH4QG2s53T54NI4x80aZ3Gle+KdGByDNvfwNfEWXO7XHxvSv
         BdwVM0DqjvcuPzdyhGxRsU30RMF5SZCuEtTb6I431izO9xzF0HVjYARcVpXEmqDKTALa
         o2bQ==
X-Gm-Message-State: ALoCoQmM17T1uUQ6OPKrNnvYJEFLYaf28pQbb3BFLlIEA+YvOFKvQz8gAUaibrkfnQk0zOt7rihA
X-Received: by 10.68.103.4 with SMTP id fs4mr402076pbb.58.1412805067165;
        Wed, 08 Oct 2014 14:51:07 -0700 (PDT)
Received: from aus-mac-1035.aus.rapid7.com ([128.177.65.10])
        by mx.google.com with ESMTPSA id k5sm886980pdk.38.2014.10.08.14.51.05
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 08 Oct 2014 14:51:06 -0700 (PDT)
X-Mailer: git-send-email 2.1.2
In-Reply-To: <xmqqh9zebfc6.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Software, such as RVM (ruby version manager), may set chpwd functions
that result in an endless loop when cding.  chpwd functions should be
ignored.

As I've only seen this so far on ZSH, I'm applying this change only to
the git-completion.zsh overrides.

Signed-off-by: Brandon Turner <bt@brandonturner.net>
---
This applies the patch to zsh only using git-completion.zsh.

For more details on the RVM bug, see:
https://github.com/wayneeseguin/rvm/issues/3076
 contrib/completion/git-completion.zsh | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index 9f6f0fa..12ac984 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -93,6 +93,21 @@ __gitcomp_file ()
 	compadd -Q -p "${2-}" -f -- ${=1} && _ret=0
 }
 
+__git_ls_files_helper ()
+{
+	(
+		test -n "${CDPATH+set}" && unset CDPATH
+		(( ${#chpwd_functions} )) && chpwd_functions=()
+		builtin cd "$1"
+		if [ "$2" == "--committable" ]; then
+			git diff-index --name-only --relative HEAD
+		else
+			# NOTE: $2 is not quoted in order to support multiple options
+			git ls-files --exclude-standard $2
+		fi
+	) 2>/dev/null
+}
+
 __git_zsh_bash_func ()
 {
 	emulate -L ksh
-- 
2.1.2
