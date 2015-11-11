From: Clemens Buchacher <clemens.buchacher@intel.com>
Subject: Re: [PATCH] allow hooks to ignore their standard input stream
Date: Wed, 11 Nov 2015 15:42:22 +0100
Organization: Intel Deutschland GmbH - Registered Address: Am Campeon 10-12, 85579 Neubiberg, Germany - Tel: +49 89 99 8853-0, www.intel.de - Managing Directors: Prof. Dr. Hermann Eul, Christin Eisenschmid - Chairperson of the Supervisory Board: Tiffany Doon Silva - Registered Office: Munich - Commercial Register: Amtsgericht Mnchen HRB 186928
Message-ID: <20151111144222.GA24717@musxeris015.imu.intel.com>
References: <20151111143920.GA30409@musxeris015.imu.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: junio@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 11 15:42:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZwWbc-00059g-GT
	for gcvg-git-2@plane.gmane.org; Wed, 11 Nov 2015 15:42:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752521AbbKKOm1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Nov 2015 09:42:27 -0500
Received: from mga02.intel.com ([134.134.136.20]:2697 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752455AbbKKOmZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Nov 2015 09:42:25 -0500
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP; 11 Nov 2015 06:42:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.20,276,1444719600"; 
   d="scan'208";a="598304490"
Received: from musxeris015.imu.intel.com (HELO localhost) ([10.216.40.13])
  by FMSMGA003.fm.intel.com with ESMTP; 11 Nov 2015 06:42:24 -0800
Content-Disposition: inline
In-Reply-To: <20151111143920.GA30409@musxeris015.imu.intel.com>
User-Agent: Mutt/1.4.2.2i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281166>

On Wed, Nov 11, 2015 at 03:39:20PM +0100, Clemens Buchacher wrote:
> +		if (write_in_full(proc.in, buf.buf, buf.len) < 0) {
> +			/* We do not mind if a hook does not read all refs. */
> +			if (errno != EPIPE)
> +				ret = -1;

I can reproduce the pipe error reliably with the test below. I did not
include it in the patch since I am in doubt if we should add an optional
sleep to the code.

-->o--
diff --git a/t/t5571-pre-push-hook.sh b/t/t5571-pre-push-hook.sh
index 6f9916a..8cfe59a 100755
--- a/t/t5571-pre-push-hook.sh
+++ b/t/t5571-pre-push-hook.sh
@@ -109,23 +109,13 @@ test_expect_success 'push to URL' '
        diff expected actual
 '

-# Test that filling pipe buffers doesn't cause failure
-# Too slow to leave enabled for general use
-if false
-then
-       printf 'parent1\nrepo1\n' >expected
-       nr=1000
-       while test $nr -lt 2000
-       do
-               nr=$(( $nr + 1 ))
-               git branch b/$nr $COMMIT3
-               echo "refs/heads/b/$nr $COMMIT3 refs/heads/b/$nr $_z40" >>expected
-       done
-
-       test_expect_success 'push many refs' '
-               git push parent1 "refs/heads/b/*:refs/heads/b/*" &&
-               diff expected actual
-       '
-fi
+write_script "$HOOK" <<\EOF
+exit 0
+EOF
+
+test_expect_success 'hook does not consume input' '
+    git branch noinput &&
+    GIT_TEST_SIGPIPE=t git push parent1 noinput
+'

 test_done
diff --git a/transport.c b/transport.c
index 23b2ed6..d83ef1c 100644
--- a/transport.c
+++ b/transport.c
@@ -1129,6 +1129,8 @@ static int run_pre_push_hook(struct transport *transport,

        strbuf_init(&buf, 256);

+       if (getenv("GIT_TEST_SIGPIPE"))
+               sleep_millisec(10);
        for (r = remote_refs; r; r = r->next) {
                if (!r->peer_ref) continue;
                if (r->status == REF_STATUS_REJECT_NONFASTFORWARD) continue;
