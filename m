From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH] tests: simplify "missing PREREQ" message
Date: Tue, 24 Aug 2010 02:34:10 -0500
Message-ID: <20100824073410.GA5562@burratino>
References: <20100811014325.GA4169@burratino>
 <1281528278-15659-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 24 09:36:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ono3F-0002rC-W0
	for gcvg-git-2@lo.gmane.org; Tue, 24 Aug 2010 09:36:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752172Ab0HXHgE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Aug 2010 03:36:04 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:34093 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751488Ab0HXHgD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Aug 2010 03:36:03 -0400
Received: by iwn5 with SMTP id 5so4299941iwn.19
        for <git@vger.kernel.org>; Tue, 24 Aug 2010 00:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=UuIs4qI7NRcTClfveCi+lziu8XEmE3JOl2vgceRG4hg=;
        b=IspEW1yoScSVJWbDaZTaSOCV69fVQL5w8+MoObp1ekN4hi+bn+d0gpUxK5L9FYvK9J
         VHhooeFL8EQeYCICd/wn+wgm0qxWekjmrulT/cIeozBdvrzredLlAOauHsHFfCecxD2T
         FUK+U5WLMgrRsAR7dnMKszokpGjxv4w6EXmZw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=KcWY123LbaRCKsvMpAL09H3SYwUem95U2llR1PUn8120mr9b4ZN25Xg9xHBCvqpGXK
         R6qpsOmbnEdu8mECGaYW+TSspq7wJAlZ9WKXLG5XPEE4wHBZLgyzJf7hqQpBS28UHtcI
         rRQ9rNHm0SckuvgTUHNV60uisO45+q+4ql4A4=
Received: by 10.231.35.199 with SMTP id q7mr8074683ibd.47.1282635362146;
        Tue, 24 Aug 2010 00:36:02 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id g31sm7102614ibh.16.2010.08.24.00.36.01
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 24 Aug 2010 00:36:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1281528278-15659-1-git-send-email-avarab@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154306>

When a test has no prerequisites satisfied (the usual case), instead
of "missing THING of THING", just say "missing THING".  This does not
affect the output when a test is skipped due to a missing
prerequisites if another prerequisite is satisfied.

=46or example: instead of

 ok 8 # skip notes work (missing EXPENSIVE of EXPENSIVE)
 ok 9 # skip notes timing with /usr/bin/time (missing EXPENSIVE of USR_=
BIN_TIME,EXPENSIVE)

write

 ok 8 # skip notes work (missing EXPENSIVE)
 ok 9 # skip notes timing with /usr/bin/time (missing EXPENSIVE of USR_=
BIN_TIME,EXPENSIVE)

Cc: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Noticed this when building "next".  Thoughts?

 t/test-lib.sh |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 4617998..c9193cb 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -417,8 +417,14 @@ test_skip () {
 	fi
 	case "$to_skip" in
 	t)
+		of_prereq=3D
+		if test "$missing_prereq" !=3D "$prereq"
+		then
+			of_prereq=3D" of $prereq"
+		fi
+
 		say_color skip >&3 "skipping test: $@"
-		say_color skip "ok $test_count # skip $1 (missing $missing_prereq of=
 $prereq)"
+		say_color skip "ok $test_count # skip $1 (missing $missing_prereq${o=
f_prereq})"
 		: true
 		;;
 	*)
--=20
1.7.2.2
