From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 3/3] tests: scrub environment of GIT_* variables
Date: Tue, 15 Mar 2011 02:04:45 -0500
Message-ID: <20110315070445.GC29530@elie>
References: <20110315064909.GA25738@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Petr Onderka <gsvick@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 15 08:04:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PzOJL-0001dp-EL
	for gcvg-git-2@lo.gmane.org; Tue, 15 Mar 2011 08:04:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754389Ab1COHEu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Mar 2011 03:04:50 -0400
Received: from mail-yi0-f46.google.com ([209.85.218.46]:54686 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754223Ab1COHEu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Mar 2011 03:04:50 -0400
Received: by yia27 with SMTP id 27so115615yia.19
        for <git@vger.kernel.org>; Tue, 15 Mar 2011 00:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=9xkHRkA7d2FnS9KBKPMqmdWbG9DvblXzxqXzCE8u3m4=;
        b=NR1CZT2sjtCzO2bUJzHWGUvvvXbhZxG1Osu0vg9VQvI/hItPKP1AQCAuHokyIdxe7Y
         q/b6448+Q9sNKtAHi+Smm7zBEq+8rlVe3JauO2tWxetaGetfoTDK1V0ZN04Qn2aE+klN
         Cg1h0GVAOpnet1oqCUOghxf62V027SzPKdSF0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=rVBMZD8A/d+Wr3H6lg0nij5uPGeyRhOW/fMpQlrElh1ccVgHJW8F2IYvxuBQx32qDD
         vl45wnFRXDV8DDKFiuvsX69NyAQPdlqISP5CZs9aUt5sTYvjeaiQnBJ7m/tVisXRpyCg
         R5qlgA7aPPN52005GqurTL3mLiJv4Szd75td4=
Received: by 10.90.152.8 with SMTP id z8mr4436291agd.67.1300172689481;
        Tue, 15 Mar 2011 00:04:49 -0700 (PDT)
Received: from elie (adsl-69-209-56-53.dsl.chcgil.ameritech.net [69.209.56.53])
        by mx.google.com with ESMTPS id u20sm3410026anu.14.2011.03.15.00.04.47
        (version=SSLv3 cipher=OTHER);
        Tue, 15 Mar 2011 00:04:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110315064909.GA25738@elie>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169048>

Variables from the inherited environment that are meaningful to git
can break tests in undesirable ways.  For example,

 GIT_PAGER=more sh t5400-send-pack.sh -v -i

hangs.  So unset them in test-lib.

The variables to unset were found with 'git grep -F -e '"GIT_'.

Exception: leave the GIT_USE_LOOKUP variable from v1.5.6-rc0~134^2~1
(sha1-lookup: more memory efficient search in sorted list of SHA-1,
2007-12-29) alone, since it is about trying an alternate
implementation strategy rather than changing semantics and it can be
useful to compare performance with and without it set.

Longer term, it would be nice to just unset all GIT_* variables (with
exceptions like GIT_TRACE and GIT_USE_LOOKUP) with some magic using
the "env" command.  That is less straightforward than one might hope
because the values of environment variables can contain embedded
newlines and equal signs and "env -0" is not portable.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
IIRC the patch is based on v1.7.4.1.  So it does not handle
GIT_ASK_YESNO or GIT_TRACE_PACKET; they're too new.

Thanks for reading.  Hopefully it was not too dull.

 t/test-lib.sh |   31 +++++++++++++++++++++++++++++++
 1 files changed, 31 insertions(+), 0 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 8ae03c7..26c6707 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -43,7 +43,11 @@ TERM=dumb
 export LANG LC_ALL PAGER TERM TZ
 EDITOR=:
 unset VISUAL
+unset GIT_ASKPASS
 unset GIT_EDITOR
+unset GIT_PAGER
+unset GIT_MAN_VIEWER
+unset GIT_SSH
 unset AUTHOR_DATE
 unset AUTHOR_EMAIL
 unset AUTHOR_NAME
@@ -62,16 +66,43 @@ unset GIT_DIR
 unset GIT_WORK_TREE
 unset GIT_EXTERNAL_DIFF
 unset GIT_INDEX_FILE
+unset GIT_GRAFT_FILE
 unset GIT_OBJECT_DIRECTORY
 unset GIT_CEILING_DIRECTORIES
+unset GIT_DISCOVERY_ACROSS_FILESYSTEM
 unset SHA1_FILE_DIRECTORIES
 unset SHA1_FILE_DIRECTORY
+unset GIT_NO_REPLACE_OBJECTS
+unset GIT_CONFIG_PARAMETERS
 unset GIT_NOTES_REF
 unset GIT_NOTES_DISPLAY_REF
 unset GIT_NOTES_REWRITE_REF
 unset GIT_NOTES_REWRITE_MODE
 unset GIT_REFLOG_ACTION
 unset GIT_CHERRY_PICK_HELP
+unset GIT_CURL_FTP_NO_EPSV
+unset GIT_CURL_VERBOSE
+unset GIT_PROJECT_ROOT
+unset GIT_PROXY_COMMAND
+unset GIT_HTTP_EXPORT_ALL
+unset GIT_HTTP_LOW_SPEED_LIMIT
+unset GIT_HTTP_LOW_SPEED_TIME
+unset GIT_HTTP_MAX_REQUESTS
+unset GIT_HTTP_USER_AGENT
+unset GIT_SSL_CAINFO
+unset GIT_SSL_CAPATH
+unset GIT_SSL_CERT
+unset GIT_SSL_CERT_PASSWORD_PROTECTED
+unset GIT_SSL_KEY
+unset GIT_SSL_NO_VERIFY
+unset GIT_FLUSH
+unset GIT_PAGER_IN_USE
+unset GIT_SEND_EMAIL_NOTTY
+unset GIT_DEBUG_LOOKUP
+unset GIT_DEBUG_SEND_PACK
+unset GIT_DEBUG_TESTGIT
+unset GIT_TRANSLOOP_DEBUG
+unset GIT_TRANSPORT_HELPER_DEBUG
 unset GIT_QUIET
 GIT_MERGE_VERBOSITY=5
 export GIT_MERGE_VERBOSITY
-- 
1.7.4.1
