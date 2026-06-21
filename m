Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7897E7260F
	for <git@vger.kernel.org>; Sun, 21 Jun 2026 10:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.3.86.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782038029; cv=none; b=dE4UEgGI97+4L50cOu3TuQIUJTs0+i3cdEo8AtH+8m2bHe8Pt0pNUrjKN4SZJwNx3xAffC2lccqxbT4ju6zRHLNZVaKnsg/tBeAWQsd5Ps/iOppJ4yIaIn+oxROGgeRWCdPsKhl6MvWfgBAsutqCV02AJI0j6Ju97yx9L6xkJLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782038029; c=relaxed/simple;
	bh=jvrHMKKompS3PBhORVgP4ZTggG09dB/nPokz7KAqdyY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TkaqIBj/1vKayNkq6CNwCcibE3JN2+ekWls1ZjQxBn92Bm1QiWAWf57aqgPZ1PmZXvSdjKmDmkcun+j7CVz6AxWIdmXs0jZtVEX2QUi+y+slx14SXgk4ESxoS9k+l+aglFhjZrz+uu3EyR1Nynzs01nuNOqWc/U7fh6Xgqcmyy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=195.3.86.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from bsmtp3.bon.at (unknown [192.168.181.107])
	by bsmtp5.bon.at (Postfix) with ESMTPS id 4gjnk06fqFz7Qw2w
	for <git@vger.kernel.org>; Sun, 21 Jun 2026 12:33:44 +0200 (CEST)
Received: from [192.168.0.101] (unknown [93.83.142.38])
	by bsmtp3.bon.at (Postfix) with ESMTPSA id 4gjnjq40NpzRq1k;
	Sun, 21 Jun 2026 12:33:35 +0200 (CEST)
Message-ID: <efc97fee-a98c-497f-94a9-6f8b77667f30@kdbg.org>
Date: Sun, 21 Jun 2026 12:33:35 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 2/1] git-gui: reduce complexity of the quiet msgfmt rule
To: Harald Nordgren <haraldnordgren@gmail.com>
Cc: git@vger.kernel.org,
 Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>
References: <pull.2339.git.git.1781459539.gitgitgadget@gmail.com>
 <pull.2339.v2.git.git.1781995570677.gitgitgadget@gmail.com>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <pull.2339.v2.git.git.1781995570677.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

In non-verbose builds (without V=1) the rule to compile *.po files with
msgfmt captures the output in a shell variable and then strips down the
text produced by --statistics to fit on a 80 column line. The previous
commit removed --statistics output of the msgfmt invocation, so that we
don't get to see anything beyond "MSGFMT po/xx.msg" anymore. Make the
rule as minimal as the other "quiet" rules.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
Am 21.06.26 um 00:46 schrieb Harald Nordgren via GitGitGadget:
> The catalog rules ran msgfmt with --statistics, whose output went to
> stderr and so survived "make -s" (gitk also echoed "Generating
> catalog").
> 
> The statistics are not needed, as in 2f12b31b746c (Makefile: don't
> invoke msgfmt with --statistics, 2021-12-17), and the "Generating
> catalog" line is not needed either. Remove them so a quiet build stays
> quiet.

I split off the git-gui part, adjusted the commit message, and then
applied the patch below to simplify the Makefile further.

 Makefile | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 48d848a59dfb..2e1711adc5a5 100644
--- a/Makefile
+++ b/Makefile
@@ -69,8 +69,7 @@ ifndef V
 	QUIET          = @
 	QUIET_GEN      = $(QUIET)echo '   ' GEN '$@' &&
 	QUIET_INDEX    = $(QUIET)echo '   ' INDEX $(dir $@) &&
-	QUIET_MSGFMT0  = $(QUIET)printf '    MSGFMT %12s ' $@ && v=`
-	QUIET_MSGFMT1  = 2>&1` && echo "$$v" | sed -e 's/fuzzy translations/fuzzy/' | sed -e 's/ messages*//g'
+	QUIET_MSGFMT   = $(QUIET)echo '   ' MSGFMT '$@' &&
 
 	INSTALL_D0 = dir=
 	INSTALL_D1 = && echo ' ' DEST $$dir && $(INSTALL) -d -m 755 "$$dir"
@@ -155,7 +154,7 @@ $(PO_TEMPLATE): $(SCRIPT_SH) $(ALL_LIBFILES)
 update-po:: $(PO_TEMPLATE)
 	$(foreach p, $(ALL_POFILES), echo Updating $p ; msgmerge -U $p $(PO_TEMPLATE) ; )
 $(ALL_MSGFILES): %.msg : %.po
-	$(QUIET_MSGFMT0)$(MSGFMT) --tcl -l $(basename $(notdir $<)) -d $(dir $@) $< $(QUIET_MSGFMT1)
+	$(QUIET_MSGFMT)$(MSGFMT) --tcl -l $(basename $(notdir $<)) -d $(dir $@) $<
 
 lib/tclIndex: $(ALL_LIBFILES) generate-tclindex.sh GIT-GUI-BUILD-OPTIONS
 	$(QUIET_INDEX)$(SHELL_PATH) generate-tclindex.sh . ./GIT-GUI-BUILD-OPTIONS $(ALL_LIBFILES)
-- 
2.55.0.rc0.230.g889306758c


