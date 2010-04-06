From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 2/2] builtins: do not commit pager choice early
Date: Mon, 5 Apr 2010 23:06:12 -0500
Message-ID: <20100406040612.GC30403@progeny.tock>
References: <1270492888-26589-1-git-send-email-pclouds@gmail.com>
 <1270492888-26589-44-git-send-email-pclouds@gmail.com>
 <20100406040145.GA30403@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 06 06:05:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nz02s-0004Vf-Dh
	for gcvg-git-2@lo.gmane.org; Tue, 06 Apr 2010 06:05:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750873Ab0DFEFm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Apr 2010 00:05:42 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:47273 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750856Ab0DFEFl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Apr 2010 00:05:41 -0400
Received: by gwb19 with SMTP id 19so1580613gwb.19
        for <git@vger.kernel.org>; Mon, 05 Apr 2010 21:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=sFMV2k4U6iLTsjFKde6vukX5bzHRNsJPgI5tyudfSpo=;
        b=lk21+sQqviO0+C+fjFtDsJ7f7/CP71wP+I3nsiUkpvJ5jW4K5EWliI7Pc3406dXg63
         kxuvc1D9L2KFcjnTc/wwmQYVG4MDHos+w7ld/ErC6hBEPPH6ZWK/a+/95EDcWEZ3DmMb
         Ua61RsD70I8ecx0pomZj7XOaVYGTgpLLXpayI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=dwWskydesO79V3ugHJHanaKsoOVJO0wXgzTZWBzeYe7kTRVFOVrqOytoAXGaPz6rKT
         VMbwmBA6RUt63OoCBfGlfmRxdrUFzZ3EUsYpTVha0Z2nbYyKg/wE7HPyLbMWx/g9/VWn
         mFBqsOaGQHA8OzVgXL+H3/DeJhG57kziFz5Po=
Received: by 10.151.61.7 with SMTP id o7mr7308641ybk.90.1270526740168;
        Mon, 05 Apr 2010 21:05:40 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 21sm2526531iwn.15.2010.04.05.21.05.39
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 05 Apr 2010 21:05:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100406040145.GA30403@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144093>

If git is passed the --paginate option, committing the pager choice
will require setting up the pager, which requires access to repository
for the core.pager configuration.

After handle_options() is called, the repository has not been searched
for yet.  Unless GIT_DIR or GIT_CONFIG is set, attempting to access
the configuration at this point results in git_dir being set to .git,
which is almost certainly not what was wanted.

=46or example, this breaks git --paginate when used from a subdirectory
of the toplevel directory in a repository with core.pager set.

There are several possible code paths after handle_options() and
commit_pager_choice() are called:

1. list_common_cmds_help() does not need a pager: it=E2=80=99s a printo=
ut of
   only 29 lines, and most operating systems have some sort of
   scrollback that can handle this.

2. run_argv() will run commit_pager_choice() inside run_builtin() if a
   command is found.

3. help_unknown_cmd() prints out only a few lines.

So removing the commit_pager_choice() after handle_options() is safe.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
That=E2=80=99s the end of the series (based against master).

Thoughts welcome.

 git.c            |    1 -
 t/t7006-pager.sh |    2 +-
 2 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/git.c b/git.c
index 6bae305..75bd387 100644
--- a/git.c
+++ b/git.c
@@ -502,7 +502,6 @@ int main(int argc, const char **argv)
 	argv++;
 	argc--;
 	handle_options(&argv, &argc, NULL);
-	commit_pager_choice();
 	if (argc > 0) {
 		if (!prefixcmp(argv[0], "--"))
 			argv[0] +=3D 2;
diff --git a/t/t7006-pager.sh b/t/t7006-pager.sh
index 4f804ed..c373342 100755
--- a/t/t7006-pager.sh
+++ b/t/t7006-pager.sh
@@ -183,7 +183,7 @@ test_expect_success TTY 'core.pager in subdir' '
 unset GIT_PAGER
 rm -f core.pager_used
 rm -fr sub
-test_expect_failure TTY 'core.pager in subdir with --paginate' '
+test_expect_success TTY 'core.pager in subdir with --paginate' '
 	PAGER=3Dwc &&
 	stampname=3D$(pwd)/core.pager_used &&
 	export PAGER stampname &&
--=20
1.7.0.4.369.g62d9d
