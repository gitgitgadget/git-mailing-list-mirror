From: Brandon Turner <bt@brandonturner.net>
Subject: [PATCH v2] completion: ignore chpwd_functions when cding
Date: Wed,  8 Oct 2014 16:49:47 -0500
Message-ID: <1412804988-56858-1-git-send-email-bt@brandonturner.net>
References: <xmqqh9zebfc6.fsf@gitster.dls.corp.google.com>
Cc: git@vger.kernel.org, Brandon Turner <bt@brandonturner.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 08 23:51:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xbz8x-0004yI-3B
	for gcvg-git-2@plane.gmane.org; Wed, 08 Oct 2014 23:51:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932250AbaJHVu6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Oct 2014 17:50:58 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:47225 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932133AbaJHVu5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Oct 2014 17:50:57 -0400
Received: by mail-pa0-f50.google.com with SMTP id kx10so9728032pab.37
        for <git@vger.kernel.org>; Wed, 08 Oct 2014 14:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brandonturner.net; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Geg844L0/eJFi4WZ4+T+/LbjN1K011LhN9wlLQqucHo=;
        b=LF3NASctE0SWTTfqePJvVSdOgq0GMyUwlFHb3x7YacAzIKp4l6ruyMs0P6tJlYDmzl
         0004nnP98jI9Jjpp+/7JaaZdWdkhNLSPmpBSRcoHdmmM0lbz73r77bC10NowBRHX24Te
         NheJf6NTvWSTRYy500MvRguAcTqFpw71z4ytQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Geg844L0/eJFi4WZ4+T+/LbjN1K011LhN9wlLQqucHo=;
        b=bc/ZEjTtzhD2pSk7pOe26oxB7ev2RBZ3oiIA6Gp2rymcYeQEyD7+32QfFly+MnIYCY
         8DJsNoF64evXoq7ZEAvDFJpmG+ceLge7PUP4iPvAukROYEzRMSX7vimzh5nkbkXRo8pY
         ZgLpOebsjqUrwMETjVj2OMD4c6plYATBKNtyNIkCnXRs0Tm6Zk3Ndi7vU4Wv+MdyclMR
         Eeabf4v8sU6jiPNts0XHhAE/kx+pkanFKweG7F6e100g/4sIB350dVikWx2AMdb6dix7
         OLLDbYJWQ8ghPkMPNG6OFBX7nl9+wxXwD4phzmzWA760+gIZWYO0OqWfmLV/BD+41UZC
         z2bQ==
X-Gm-Message-State: ALoCoQk+QVzscH9gMGtudGky8zU+fs132lCW340omo4xw0/HXoXJVsTbs1j6FuW2O6i0bdGb3OIW
X-Received: by 10.66.66.75 with SMTP id d11mr14080951pat.85.1412805057363;
        Wed, 08 Oct 2014 14:50:57 -0700 (PDT)
Received: from aus-mac-1035.aus.rapid7.com ([128.177.65.10])
        by mx.google.com with ESMTPSA id k5sm886980pdk.38.2014.10.08.14.50.56
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 08 Oct 2014 14:50:56 -0700 (PDT)
X-Mailer: git-send-email 2.1.2
In-Reply-To: <xmqqh9zebfc6.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Software, such as RVM (ruby version manager), may set chpwd functions
that result in an endless loop when cding.  chpwd functions should be
ignored.

I have only noticed the RVM bug on ZSH, bash seems unaffected.  However
this change seems safe to apply to both bash and zsh as we cannot
control what functions users add to chpwd_functions.

Signed-off-by: Brandon Turner <bt@brandonturner.net>
---
This addresses Junio's request to update the log message.  The patch
still applies to bash and zsh.

For more information on the RVM bug, see:
https://github.com/wayneeseguin/rvm/issues/3076
 contrib/completion/git-completion.bash | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 06bf262..996de31 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -283,7 +283,8 @@ __git_ls_files_helper ()
 {
 	(
 		test -n "${CDPATH+set}" && unset CDPATH
-		cd "$1"
+		(( ${#chpwd_functions} )) && chpwd_functions=()
+		builtin cd "$1"
 		if [ "$2" == "--committable" ]; then
 			git diff-index --name-only --relative HEAD
 		else
-- 
2.1.2
