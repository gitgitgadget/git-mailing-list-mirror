From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH/RFC 15/12] Makefile: check for unnecessary dependencies
 with CHECK...
Date: Sun, 8 Aug 2010 16:52:20 -0500
Message-ID: <20100808215220.GD6962@burratino>
References: <20100808211910.GA7210@burratino>
 <20100808214859.GC6962@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Tay Ray Chuan <rctay89@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Erik Faye-Lund <kusmabite@googlemail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Andreas Schwab <schwab@linux-m68k.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 08 23:53:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OiDoX-0002BZ-3t
	for gcvg-git-2@lo.gmane.org; Sun, 08 Aug 2010 23:53:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754815Ab0HHVxs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Aug 2010 17:53:48 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:42758 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754094Ab0HHVxr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Aug 2010 17:53:47 -0400
Received: by gwb20 with SMTP id 20so3209553gwb.19
        for <git@vger.kernel.org>; Sun, 08 Aug 2010 14:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=glmgnx5sFMuY693561Ej2+ORZrBpNM/8tpVUkWokQg0=;
        b=ipfADt8tBPrXO3A3h8YC9xugYVXHcbg96ZTAy1sS5v9wBeG6QAtH9Sg9W7coIcXysa
         3xeBKAV+UaCz3Czn+YfahZ5mMeeACHWiT44QMgRy5szm9w6zOtkzDcI6iA7FWrVYwoI6
         GoBitgQEO830rxzrlCKeP4A+8B77Kl94ipk7E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=Rf88Fa23+d9Iq0LvN8mfJPiJr5/E8ozqaWVtYOvW5hSv3EWgJ4oqUwQ99Iy4OwoDRm
         0XaBl4XxtkySNV4IcMxMUt1j72aKBA3Olkbgrx9V10gJgqHofOua8vR/qdMSEYk7Eljz
         JUR7U2wJ5RsID4CiyO7piL4YG1ThItwxrHVUA=
Received: by 10.100.49.28 with SMTP id w28mr16805935anw.75.1281304426895;
        Sun, 08 Aug 2010 14:53:46 -0700 (PDT)
Received: from burratino (ip-64-32-208-34.chi.megapath.net [64.32.208.34])
        by mx.google.com with ESMTPS id t30sm7102397ann.7.2010.08.08.14.53.44
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 08 Aug 2010 14:53:46 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100808214859.GC6962@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152936>

When the CHECK_HEADER_DEPENDENCIES facility is turned on, report
files in three categories:

 a. detected dependencies missing from the hard-coded dependencies
 b. hard-coded dependencies that were neither detected nor in
    $(LIB_H)
 c. duplicate hard-coded dependencies

Unfortunately, due to my ignorance of GNU make syntax, a and b
each read the detected dependencies from disk independently,
so this is very slow when using an old laptop drive.

Stale dependency rules can easily accumulate unnoticed, so
despite the slowdown, this should be a useful automated check.
The unnecessary dependencies (b) do not include files from
$(LIB_H) to avoid noise from the $(GIT_OBJS): $(LIB_H) rule,
which avoids patch noise adjusting dependencies as files start to
use different parts of libgit.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>> That would not be hard to do, but wouldn=E2=80=99t the $(GIT_OBJS): =
$(LIB_H)
>> rule create a lot of noise?
>>
>> How about if it checks for duplicate dependencies and unnecessary
>> dependencies that are not in LIB_H?
>
> That would be ideal, I think.

Here is a mockup for that.  I still have to speed this up before I
find it bearable to use.  Currently this forks submakes twice to read
in the same computed list of dependencies, but this should be
avoidable (maybe using $(call ...)?).

 Makefile |   53 ++++++++++++++++++++++++++++++++++++-----------------
 1 files changed, 36 insertions(+), 17 deletions(-)

diff --git a/Makefile b/Makefile
index 93e1a92..ba4ea79 100644
--- a/Makefile
+++ b/Makefile
@@ -1718,11 +1718,42 @@ endif
=20
 ifdef CHECK_HEADER_DEPENDENCIES
 ifndef PRINT_HEADER_DEPENDENCIES
-missing_deps =3D $(filter-out $(notdir $^), \
-	$(notdir $(shell $(MAKE) -s $@ \
+dep =3D $(notdir $^)
+all_dep =3D $(notdir $+)
+computed_dep =3D $(notdir $(shell $(MAKE) -s $@ \
 		CHECK_HEADER_DEPENDENCIES=3DYesPlease \
 		USE_COMPUTED_HEADER_DEPENDENCIES=3DYesPlease \
-		PRINT_HEADER_DEPENDENCIES=3DYesPlease)))
+		PRINT_HEADER_DEPENDENCIES=3DYesPlease))
+
+missing_dep =3D $(filter-out $(dep), $(computed_dep))
+
+sloppy_dep :=3D $(notdir $(LIB_H)) $(notdir $(dep_files))
+extra_dep =3D $(filter-out $(sloppy_dep) $(computed_dep), $(dep))
+
+nondup_dep =3D $(foreach f, $(dep), \
+		$(word $(words $(filter $f,$(all_dep))), $f))
+# If the list of dependencies including duplicates has the same size
+# as the list without, there are no dups.
+dup_dep =3D $(if $(filter $(words $^),$(words $+)),, \
+		$(filter-out $(nondup_dep), $(dep)))
+
+cmd_check_deps =3D @set -e; echo CHECK $@; \
+	missing_dep=3D"$(missing_dep)"; \
+	extra_dep=3D"$(extra_dep)"; \
+	dup_dep=3D"$(dup_dep)"; \
+	if test "$$missing_dep"; \
+	then \
+		echo missing dependencies: $$missing_dep; \
+	fi; \
+	if test "$$extra_dep"; \
+	then \
+		echo unnecessary dependencies: $$extra_dep; \
+	fi; \
+	if test "$$dup_dep"; \
+	then \
+		echo duplicate dependencies: $$dup_dep; \
+	fi; \
+	test -z "$$missing_dep$$extra_dep$$dup_dep"
 endif
 endif
=20
@@ -1747,21 +1778,9 @@ endif
 ifndef PRINT_HEADER_DEPENDENCIES
 ifdef CHECK_HEADER_DEPENDENCIES
 $(C_OBJ): %.o: %.c $(dep_files) FORCE
-	@set -e; echo CHECK $@; \
-	missing_deps=3D"$(missing_deps)"; \
-	if test "$$missing_deps"; \
-	then \
-		echo missing dependencies: $$missing_deps; \
-		false; \
-	fi
+	$(cmd_check_deps)
 $(ASM_OBJ): %.o: %.S $(dep_files) FORCE
-	@set -e; echo CHECK $@; \
-	missing_deps=3D"$(missing_deps)"; \
-	if test "$$missing_deps"; \
-	then \
-		echo missing dependencies: $$missing_deps; \
-		false; \
-	fi
+	$(cmd_check_deps)
 endif
 endif
=20
--=20
1.7.0.rc1.457.gef7d.dirty
