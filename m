From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] format-patch --to: overwrite format.to contents, don't
 append it
Date: Sat, 6 Mar 2010 22:06:50 +0100
Message-ID: <20100306210650.GO27414@genesis.frugalware.org>
References: <7v7hptt0mr.fsf@alter.siamese.dyndns.org>
 <20100306003946.GD27414@genesis.frugalware.org>
 <7vr5nykx55.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steven Drake <sdrake@xnet.co.nz>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 06 22:32:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1No1D8-0002Bv-K9
	for gcvg-git-2@lo.gmane.org; Sat, 06 Mar 2010 22:06:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753068Ab0CFVGx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Mar 2010 16:06:53 -0500
Received: from virgo.iok.hu ([212.40.97.103]:33277 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751449Ab0CFVGx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Mar 2010 16:06:53 -0500
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id F2514580B9;
	Sat,  6 Mar 2010 22:06:51 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id D2C5844968;
	Sat,  6 Mar 2010 22:06:50 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id ABA3A20E0002; Sat,  6 Mar 2010 22:06:50 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7vr5nykx55.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---

On Fri, Mar 05, 2010 at 06:21:42PM -0800, Junio C Hamano <gitster@pobox.com> wrote:
> This reveals that --to does not follow the usual rule to override
> corresponding configuration.  Is that really what we want?  IOW, when the
> command line says scipient, shouldn't we stop sending to recipient that
> comes from the configuration?  How else would a user override this?

Fair enough, here is a patch to update both the testcase and the code to
the wished behaviour.

 builtin-log.c           |    6 ++++++
 t/t4014-format-patch.sh |    5 +++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/builtin-log.c b/builtin-log.c
index 5d23a67..cc28357 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -465,6 +465,7 @@ static int extra_hdr_alloc;
 static char **extra_to;
 static int extra_to_nr;
 static int extra_to_alloc;
+static int extra_to_config = 0;
 
 static char **extra_cc;
 static int extra_cc_nr;
@@ -507,6 +508,7 @@ static int git_format_config(const char *var, const char *value, void *cb)
 	if (!strcmp(var, "format.to")) {
 		if (!value)
 			return config_error_nonbool(var);
+		extra_to_config = 1;
 		ALLOC_GROW(extra_to, extra_to_nr + 1, extra_to_alloc);
 		extra_to[extra_to_nr++] = xstrdup(value);
 		return 0;
@@ -884,6 +886,10 @@ static int header_callback(const struct option *opt, const char *arg, int unset)
 
 static int to_callback(const struct option *opt, const char *arg, int unset)
 {
+	if (extra_to_config) {
+		extra_to_config = 0;
+		extra_to_nr = 0;
+	}
 	ALLOC_GROW(extra_to, extra_to_nr + 1, extra_to_alloc);
 	extra_to[extra_to_nr++] = xstrdup(arg);
 	return 0;
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 9305c98..6fc071a 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -546,9 +546,10 @@ test_expect_success 'configuration to' '
 
 test_expect_success 'additional command line to' '
 
+	git config --unset-all format.headers &&
 	git format-patch --to="S. E. Cipient <scipient@example.com>" --stdout master..side | sed -e "/^\$/q" >patch11 &&
-	grep "^To: R. E. Cipient <rcipient@example.com>,\$" patch11 &&
-	grep "^ *S. E. Cipient <scipient@example.com>\$" patch11
+	! grep "R. E. Cipient <rcipient@example.com>" patch11 &&
+	grep "^To: S. E. Cipient <scipient@example.com>\$" patch11
 '
 
 test_expect_success 'format-patch --signoff' '
-- 
1.7.0
