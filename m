From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH] squash! tests: fix overeager scrubbing of environment
 variables
Date: Sun, 27 Mar 2011 17:17:53 -0500
Message-ID: <20110327221753.GB27445@elie>
References: <4D8FAAAC.3050905@web.de>
 <20110327213756.GD25927@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Mon Mar 28 00:18:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q3yHq-0004lL-IV
	for gcvg-git-2@lo.gmane.org; Mon, 28 Mar 2011 00:18:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751835Ab1C0WSA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 27 Mar 2011 18:18:00 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:56063 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751746Ab1C0WR6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 27 Mar 2011 18:17:58 -0400
Received: by iwn34 with SMTP id 34so3022307iwn.19
        for <git@vger.kernel.org>; Sun, 27 Mar 2011 15:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=a2Hc0gah56HRzaomSQnfyrk5LjBjSuMs1oXgOKRY28Y=;
        b=ToCz8qtVaRX/k96zX1H3MFeSsCnpBJkeLPeQ9GeeioD892ME9w/Pcfh+FU4H7nQO0i
         6N/rS6L/x8MdQCNS7Lqxg1OzGsMqUKptlX6ZnH8lGzJ3j06f4+Y5M2ehTSRePM1EOUU/
         nueKwgLHizXmI6AmxP8V3Qq8v8jSh50Fvl/0M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=SCP8HIzoJnGLrabFHAISUgD6guwXKzkWC17fyc4IC/bvleWwBu23A8pA2ypDnBuhXA
         KpoHtm7Swc6KU/i177TkO0JmpikR+Hf5y4v9zhGHpU73NM1mzuRtqnkxflY1xg5dJ0kS
         1HPKNgCwRCtBUhM7aV1ibK72xiL/VJnsFa3cs=
Received: by 10.42.147.3 with SMTP id l3mr5579356icv.353.1301264278142;
        Sun, 27 Mar 2011 15:17:58 -0700 (PDT)
Received: from elie (adsl-68-255-101-206.dsl.chcgil.sbcglobal.net [68.255.101.206])
        by mx.google.com with ESMTPS id xi12sm2358800icb.18.2011.03.27.15.17.56
        (version=SSLv3 cipher=OTHER);
        Sun, 27 Mar 2011 15:17:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110327213756.GD25927@elie>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170091>

(+cc: Jeff and =C3=86var for perl advice)
Jonathan Nieder wrote:
> Jens Lehmann wrote:

>> - GIT_SKIP_TESTS
>> - GIT_TEST*
>> - GIT_PROVE_OPTS
>>
>> Let's fix that by adding them to the exception list.
>>
>> Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
>
> Acked-by: Jonathan Nieder <jrnieder@gmail.com>
>
> It misses a few, though:
>
>  - GIT_REMOTE_SVN_TEST_BIG_FILES
>  - GIT_NOTES_TIMING_TESTS
>  - GIT_PATCHID_TIMING_TESTS
>  - GIT_VALGRIND_OPTIONS

How about something like this on top?  Would it still be safe on
platforms with ancient perl?

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/test-lib.sh |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 4a8c443..d28e647 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -46,7 +46,15 @@ unset VISUAL
 unset EMAIL
 unset $(perl -e '
 	my @env =3D keys %ENV;
-	my @vars =3D grep(/^GIT_/ && !/^GIT_(TRACE|DEBUG|USE_LOOKUP|SKIP_TEST=
S|TEST|PROVE_OPTS)/, @env);
+	my @vars =3D grep(/^GIT_/ && !m{^GIT_(
+			TRACE |
+			DEBUG |
+			USE_LOOKUP |
+			TEST |
+			.*_TEST |
+			PROVE |
+			VALGRIND
+		)}x, @env);
 	print join("\n", @vars);
 ')
 GIT_AUTHOR_EMAIL=3Dauthor@example.com
--=20
1.7.4.2
