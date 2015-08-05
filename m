From: Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH v2 0/3] am: let command-line options override saved
 options
Date: Thu, 6 Aug 2015 01:51:17 +0800
Message-ID: <20150805175117.GA6759@yoshi.chippynet.com>
References: <20150728164311.GA1948@yoshi.chippynet.com>
 <1438697331-29948-1-git-send-email-pyokagan@gmail.com>
 <xmqq37zx68uf.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 05 19:51:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZN2qs-0004br-6D
	for gcvg-git-2@plane.gmane.org; Wed, 05 Aug 2015 19:51:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751712AbbHERvY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2015 13:51:24 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:35326 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751259AbbHERvX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2015 13:51:23 -0400
Received: by pabxd6 with SMTP id xd6so23723918pab.2
        for <git@vger.kernel.org>; Wed, 05 Aug 2015 10:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=NZQVKHX8FcixlRUGyz5Y5LRywj+RmKRtAusfP2d/RfE=;
        b=zjvO+7gcVkB+qEMUl7LZE+T73+e5HAp62BxdgP/8yUmeVBTchuYYOIkjWBowCf98Rq
         pY7wEesiNfgvlz6sMRjyjWHE9d9aCMgQfT6wOu8FpDzPksEdJg1LTDNwCBULYB0ABNvt
         H4EyQ96Efa7FU6yvj7HG2Ddo+S0jNYELFAT1uc6wIn4RMFPasxzA3FZZo+ZpzzD+26PC
         NqwSTJjgj7zPXrxWdsyHyRs3HJm0JWVCAsvv0Em5uuy6iQFIOvCuiVgEnRKroqjmHYrT
         /ays9/OmVkx36tui1UVkouLQDMcqigmbxiD9ZMzErdRdP4AhCXpGS9R/KklMlZjCEKl1
         H7uw==
X-Received: by 10.68.193.169 with SMTP id hp9mr22115101pbc.39.1438797082629;
        Wed, 05 Aug 2015 10:51:22 -0700 (PDT)
Received: from yoshi.chippynet.com ([116.86.132.138])
        by smtp.gmail.com with ESMTPSA id bd5sm3619120pdb.41.2015.08.05.10.51.20
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Aug 2015 10:51:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <xmqq37zx68uf.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275383>

On Wed, Aug 05, 2015 at 08:41:44AM -0700, Junio C Hamano wrote:
> Interesting.  This seems to break test under prove.
> 
>     cd t && make T=t4153-am-resume-override-opts.sh prove
> 
> does not seem to return.

The new test-terminal.perl code is the culprit. It seems that if our
wrapped process terminates before our stdin-writing fork does, our
stdin-writing process will stall. I think this occurs with prove because
prove waits until all of its child processes terminate before returning.

So, the solution may be to send a SIGTERM to our stdin-writing fork
should our wrapped process terminate before it does, in order to ensure
that it immediately exits.

The following squash fixes it for me.

Thanks,
Paul

-- >8 --
Subject: [PATCH] squash! test_terminal: redirect child process' stdin to a pty

When the child process terminates before the copy_stdio() finishes
writing all of its data to the child's stdin slave pty, it will stall.

As such, we first move the stdin-pty-writing logic out of copy_stdio()
into its own subroutine copy_stdin() so that we can manage the forked
process ourselves, and then we send SIGTERM to the forked process should
the command we are wrapping terminate before copy_stdin() finishes
writing all of its data to un-stall it.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 t/test-terminal.perl | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/t/test-terminal.perl b/t/test-terminal.perl
index f6fc9ae..96b6a03 100755
--- a/t/test-terminal.perl
+++ b/t/test-terminal.perl
@@ -51,24 +51,26 @@ sub xsendfile {
 	copy($in, $out, 4096) or $!{EIO} or die "cannot copy from child: $!";
 }
 
-sub copy_stdio {
-	my ($in, $out, $err) = @_;
+sub copy_stdin {
+	my ($in) = @_;
 	my $pid = fork;
 	if (!$pid) {
-		close($out);
-		close($err);
 		xsendfile($in, \*STDIN);
 		exit 0;
 	}
-	$pid = fork;
+	close($in);
+	return $pid;
+}
+
+sub copy_stdio {
+	my ($out, $err) = @_;
+	my $pid = fork;
 	defined $pid or die "fork failed: $!";
 	if (!$pid) {
-		close($in);
 		close($out);
 		xsendfile(\*STDERR, $err);
 		exit 0;
 	}
-	close($in);
 	close($err);
 	xsendfile(\*STDOUT, $out);
 	finish_child($pid) == 0
@@ -91,5 +93,12 @@ my $pid = start_child(\@ARGV, $master_in->slave, $master_out->slave, $master_err
 close $master_in->slave;
 close $master_out->slave;
 close $master_err->slave;
-copy_stdio($master_in, $master_out, $master_err);
-exit(finish_child($pid));
+my $in_pid = copy_stdin($master_in);
+copy_stdio($master_out, $master_err);
+my $ret = finish_child($pid);
+# If the child process terminates before our copy_stdin() process is able to
+# write all of its data to $master_in, the copy_stdin() process could stall.
+# Send SIGTERM to it to ensure it terminates.
+kill 'TERM', $in_pid;
+finish_child($in_pid);
+exit($ret);
-- 
2.5.0.282.gdd6b4b0
