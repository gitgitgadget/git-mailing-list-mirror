From: Caleb Cushing <xenoterracide@gmail.com>
Subject: [PATCH] mergetool merge/skip/abort at prompt
Date: Wed, 28 Jan 2009 01:56:47 -0500
Message-ID: <81bfc67a0901272256t726bf206k351bb6c8b2778bd5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Junio C Hamano <gitster@pobox.com>,
	Charles Bailey <charles@hashpling.org>, git@vger.kernel.org,
	Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Wed Jan 28 07:58:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LS4NJ-0008MS-FY
	for gcvg-git-2@gmane.org; Wed, 28 Jan 2009 07:58:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751155AbZA1G4u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jan 2009 01:56:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750951AbZA1G4t
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jan 2009 01:56:49 -0500
Received: from mail-fx0-f20.google.com ([209.85.220.20]:64488 "EHLO
	mail-fx0-f20.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750814AbZA1G4t (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jan 2009 01:56:49 -0500
Received: by fxm13 with SMTP id 13so1894999fxm.13
        for <git@vger.kernel.org>; Tue, 27 Jan 2009 22:56:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=Pin4YwEj/acfvAID/NYlsyxG+ka+ZdMN6CssOhUvGhE=;
        b=B3PGb9i8VrF7u6x36N5DlQTTyLEberQHCblM/TyMEXWqkh3G1tXTbvbIxsQCjZrDwm
         z7wYxDpjA5jZVkpsVfbSas+NK+Q3C8fBGOB3df+y/HEPet/B4YMTAwgwTqzM0+pqR6sQ
         vTExNHQS/1JP7uISwT819hRL8hEhvJp6auJ+0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=Uh/SMIL1QlaLSdp0zha49Jt2A7dPkkbaVAMaL7hUoLSV75NyfseEd8h0A00CATv0eD
         6+GeH/830AMTlDxoIKIMoTgWyE/14DRxPUmhdjDkLRNhLCcDaF3crQPNbKYrU7rLOXvw
         UksPUK/OvTzAn1yK2b0FWPNMmcsNb/Cu7e6fc=
Received: by 10.223.110.6 with SMTP id l6mr561249fap.53.1233125807182; Tue, 27 
	Jan 2009 22:56:47 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107483>

previously git mergetool when run with prompt only allowed the user to continue
merging. This changes git mergetool to allow the option of skipping a file or
aborting, and includes an addtional key to explicitly select merge.

Signed-off-by: Caleb Cushing <xenoterracide@gmail.com>
---
 git-mergetool.sh |   20 ++++++++++++++++++--
 1 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/git-mergetool.sh b/git-mergetool.sh
index 00e1337..575fbb2 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -177,8 +177,24 @@ merge_file () {
     describe_file "$local_mode" "local" "$LOCAL"
     describe_file "$remote_mode" "remote" "$REMOTE"
     if "$prompt" = true; then
-	printf "Hit return to start merge resolution tool (%s): " "$merge_tool"
-	read ans
+	while true; do
+	    printf "Use (m)erge file or (s)kip file, or (a)bort? (%s): " \
+	    "$merge_tool"
+	    read ans
+	    case "$ans" in
+		[mM]*|"")
+		    break
+		    ;;
+		[sS]*)
+		    cleanup_temp_files
+		    return 0
+		    ;;
+		[aA]*)
+		    cleanup_temp_files
+		    exit 0
+		    ;;
+	    esac
+	done
     fi

     case "$merge_tool" in
-- 
1.6.1.1
