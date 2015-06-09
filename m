From: Duy Nguyen <pclouds@gmail.com>
Subject: On undoing a forced push
Date: Tue, 9 Jun 2015 19:12:21 +0700
Message-ID: <20150609121221.GA14126@lanh>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 09 14:12:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2IO4-000569-Fs
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jun 2015 14:12:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753886AbbFIMMI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jun 2015 08:12:08 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:36757 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753809AbbFIMMG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jun 2015 08:12:06 -0400
Received: by pabqy3 with SMTP id qy3so12662530pab.3
        for <git@vger.kernel.org>; Tue, 09 Jun 2015 05:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        bh=8K6qVPE1yUODuJgrTo+1qkpdnYoVoL+850YHTJuGfsk=;
        b=SW/Z99fOwXn21bX+THg2rTa3mTBku+DZ/GJ/Q78Hjcw0N/TX3OM3f0OqjHxPKqHF3N
         8z514vzo2MUaQXUGZLd5XMdezMUkFzoM6kyezv13Y3Oro/wZvg0BI4vdhMwcvIC4yJ+m
         e75QjaZEfSjNbUZxmAgBWR8m2bt2ndP6GlBQBo5R4a1+dlwjScM8vmp8l+3EQ5BHFo+K
         Ngah0hdqy4a5g/F2DwL0KPtk3EUiAmCuI7yhqb+E1f/YXlC7ESCDqkcP5lKZd3rfyotu
         6OBswTNH0/vOYZ/JTvefV31+YKbAewgQ2TyaXBflf/Sf2yhDfxYYEsVkRXxHbCyWNA/e
         8yfg==
X-Received: by 10.68.99.197 with SMTP id es5mr38723671pbb.131.1433851926028;
        Tue, 09 Jun 2015 05:12:06 -0700 (PDT)
Received: from lanh ([115.73.5.228])
        by mx.google.com with ESMTPSA id bn5sm5491678pbc.82.2015.06.09.05.12.03
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jun 2015 05:12:05 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Tue, 09 Jun 2015 19:12:21 +0700
Content-Disposition: inline
X-Clacks-Overhead: GNU Terry Pratchett
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271170>

>From a thread on Hacker News. It seems that if a user does not have
access to the remote's reflog and accidentally forces a push to a ref,
how does he recover it? In order to force push again to revert it
back, he would need to know the remote's old SHA-1. Local reflog does
not help because remote refs are not updated during a push.

This patch prints the latest SHA-1 before the forced push in full. He
then can do

    git push <remote> +<old-sha1>:<ref>

He does not even need to have the objects that <old-sha1> refers
to. We could simply push an empty pack and the the remote will happily
accept the force, assuming garbage collection has not happened. But
that's another and a little more complex patch.

Is there any other way to undo a forced push?

-- 8< --
diff --git a/transport.c b/transport.c
index f080e93..6bd6a64 100644
--- a/transport.c
+++ b/transport.c
@@ -657,16 +657,17 @@ static void print_ok_ref_status(struct ref *ref, int porcelain)
 			"[new branch]"),
 			ref, ref->peer_ref, NULL, porcelain);
 	else {
-		char quickref[84];
+		char quickref[104];
 		char type;
 		const char *msg;
 
-		strcpy(quickref, status_abbrev(ref->old_sha1));
 		if (ref->forced_update) {
+			strcpy(quickref, sha1_to_hex(ref->old_sha1));
 			strcat(quickref, "...");
 			type = '+';
 			msg = "forced update";
 		} else {
+			strcpy(quickref, status_abbrev(ref->old_sha1));
 			strcat(quickref, "..");
 			type = ' ';
 			msg = NULL;
-- 8< --
