From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Extend "checkout --track" DWIM to support more cases
Date: Thu, 21 Aug 2008 22:54:35 -0700
Message-ID: <7vy72pd278.fsf@gitster.siamese.dyndns.org>
References: <20080820185028.GA16626@blimp.local>
 <alpine.DEB.1.00.0808202151320.24820@pacific.mpi-cbg.de.mpi-cbg.de>
 <20080820200440.GF16626@blimp.local>
 <alpine.DEB.1.00.0808202213340.24820@pacific.mpi-cbg.de.mpi-cbg.de>
 <20080820202952.GH16626@blimp.local>
 <7vd4k3nx7m.fsf@gitster.siamese.dyndns.org>
 <20080821172320.GA5119@blimp.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 22 07:55:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWPcj-00068K-Cn
	for gcvg-git-2@gmane.org; Fri, 22 Aug 2008 07:55:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752274AbYHVFyo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2008 01:54:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752427AbYHVFyo
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Aug 2008 01:54:44 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:34852 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752253AbYHVFyn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2008 01:54:43 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 9EEBA6289F;
	Fri, 22 Aug 2008 01:54:42 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 863A26289A; Fri, 22 Aug 2008 01:54:37 -0400 (EDT)
In-Reply-To: <20080821172320.GA5119@blimp.local> (Alex Riesen's message of
 "Thu, 21 Aug 2008 19:23:20 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: D0D3BEE4-700E-11DD-8FD3-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93255>

Alex Riesen <raa.lkml@gmail.com> writes:

> The code handles additionally "refs/remotes/<something>/name",
> "remotes/<something>/name", and "refs/<namespace>/name".
>
> Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
> ---
> ...
> I just have another quiet evening, so I did that. Johannes, I changed
> your fix a bit: I see that argv[0] is used later (or if I'm blind and
> it actually isn't, it may be used in future: I have a feeling that
> builtint-checkout.c will be popular place).

Thanks; the documentation looks good to me.

> +		char *argv0 = argv[0];
> +		if (!argc || !strcmp(argv0, "--"))
>  			die ("--track needs a branch name");
> +		slash = strchr(argv0, '/');
> +		if (slash && !prefixcmp(argv0, "refs/")) {
> +			argv0 = slash + 1;
> +			slash = strchr(argv0, '/');
> +		}
> +		if (slash && !prefixcmp(argv0, "remotes/"))
>  			slash = strchr(slash + 1, '/');
>  		if (!slash || !slash[1])
>  			die ("Missing branch name; try -b");

I however wonder if this is clearer.

 * "enum branch_track" was unsigned; comparing equality with -1 was Ok but
   we couldn't say 0 < opts.track;

 * argv[] is an array of constant strings; cannot point into it with
   opts.newbranch without making the latter also a constant string.

 * the logic is to strip "refs/" if there is one, "remotes/" if there is
   one after that, and then strip one level after that unconditionally.
   No need to look explicitly for a slash while doing the first two steps.

 cache.h            |    1 +
 builtin-checkout.c |   26 +++++++++++++-------------
 2 files changed, 14 insertions(+), 13 deletions(-)

diff --git i/cache.h w/cache.h
index 928ae9f..a097a95 100644
--- i/cache.h
+++ w/cache.h
@@ -451,6 +451,7 @@ enum safe_crlf {
 extern enum safe_crlf safe_crlf;
 
 enum branch_track {
+	BRANCH_TRACK_UNSPECIFIED = -1,
 	BRANCH_TRACK_NEVER = 0,
 	BRANCH_TRACK_REMOTE,
 	BRANCH_TRACK_ALWAYS,
diff --git i/builtin-checkout.c w/builtin-checkout.c
index e95eab9..b380ad6 100644
--- i/builtin-checkout.c
+++ w/builtin-checkout.c
@@ -157,7 +157,7 @@ struct checkout_opts {
 	int force;
 	int writeout_error;
 
-	char *new_branch;
+	const char *new_branch;
 	int new_branch_log;
 	enum branch_track track;
 };
@@ -437,27 +437,27 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 
 	git_config(git_default_config, NULL);
 
-	opts.track = -1;
+	opts.track = BRANCH_TRACK_UNSPECIFIED;
 
 	argc = parse_options(argc, argv, options, checkout_usage,
 			     PARSE_OPT_KEEP_DASHDASH);
 
 	/* --track without -b should DWIM */
-	if (opts.track && opts.track != -1 && !opts.new_branch) {
-		char *slash;
-		if (!argc || !strcmp(argv[0], "--"))
+	if (0 < opts.track && !opts.new_branch) {
+		const char *argv0 = argv[0];
+		if (!argc || !strcmp(argv0, "--"))
 			die ("--track needs a branch name");
-		slash = strchr(argv[0], '/');
-		if (slash && !prefixcmp(argv[0], "refs/"))
-			slash = strchr(slash + 1, '/');
-		if (slash && !prefixcmp(argv[0], "remotes/"))
-			slash = strchr(slash + 1, '/');
-		if (!slash || !slash[1])
+		if (!prefixcmp(argv0, "refs/"))
+			argv0 += 5;
+		if (!prefixcmp(argv0, "remotes/"))
+			argv0 += 8;
+		argv0 = strchr(argv0, '/');
+		if (!argv0 || !argv0[1])
 			die ("Missing branch name; try -b");
-		opts.new_branch = slash + 1;
+		opts.new_branch = argv0 + 1;
 	}
 
-	if (opts.track == -1)
+	if (opts.track == BRANCH_TRACK_UNSPECIFIED)
 		opts.track = git_branch_track;
 
 	if (opts.force && opts.merge)
