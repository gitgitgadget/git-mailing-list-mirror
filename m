From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] diff: resurrect the traditional empty "diff --git" behaviour
Date: Fri, 31 Aug 2007 18:27:53 -0700
Message-ID: <7vir6vw4x2.fsf@gitster.siamese.dyndns.org>
References: <20070830063810.GD16312@mellanox.co.il>
	<7v7inda5ar.fsf@gitster.siamese.dyndns.org>
	<20070830072748.GF16312@mellanox.co.il>
	<7vmyw85uml.fsf@gitster.siamese.dyndns.org>
	<20070831080651.GA17637@mellanox.co.il>
	<7vabs82kcq.fsf@gitster.siamese.dyndns.org>
	<20070831081517.GB17637@mellanox.co.il>
	<7v4pig2j91.fsf@gitster.siamese.dyndns.org>
	<20070831152120.GC17637@mellanox.co.il>
	<7vr6lj1zg3.fsf@gitster.siamese.dyndns.org>
	<20070831160335.GA17761@coredump.intra.peff.net>
	<7vtzqfzcll.fsf_-_@gitster.siamese.dyndns.org>
	<46D89844.8050605@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Michael S. Tsirkin" <mst@dev.mellanox.co.il>,
	Jeff King <peff@peff.net>
To: Steven Grimm <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Sat Sep 01 03:28:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRHmW-0002R4-HO
	for gcvg-git@gmane.org; Sat, 01 Sep 2007 03:28:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751502AbXIAB2J (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 31 Aug 2007 21:28:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751379AbXIAB2I
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Aug 2007 21:28:08 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:46344 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751369AbXIAB2G (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Aug 2007 21:28:06 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 85370129EDE;
	Fri, 31 Aug 2007 21:28:21 -0400 (EDT)
In-Reply-To: <46D89844.8050605@midwinter.com> (Steven Grimm's message of "Fri,
	31 Aug 2007 15:37:56 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57241>

Steven Grimm <koreth@midwinter.com> writes:

> Junio C Hamano wrote:
>> This commit reinstates the traditional behaviour as the default,
>> but with a twist.
>>
>> If you set diff.autorefreshindex configuration variable, it
>> squelches the empty "diff --git" output, and at the end of the
>> command, it automatically runs "update-index --refresh" without
>> even bothering the user.  In other words, with the configuration
>> variable set, people who do not care about the cache-dirtyness
>> do not even have to see the warning.
>
> As the person who submitted the patch you're reversing with this, I
> agree 100% this is the better approach. Having the system self-heal is
> far preferable to requiring user action.
>
> I would vote for reversing the sense of that config variable,

(grudgingly...) Ok.

Old timers like myself have been warned on the list that
diff output will get quieter, so why not.

This is on top of the previous one in this thread.



diff --git a/Documentation/config.txt b/Documentation/config.txt
index 903610f..cf7617a 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -396,6 +396,16 @@ color.status.<slot>::
 commit.template::
 	Specify a file to use as the template for new commit messages.
 
+diff.autorefreshindex::
+	When using `git diff` to compare with work tree
+	files, do not consider stat-only change as changed.
+	Instead, silently run `git update-index --refresh` to
+	update the cached stat information for paths whose
+	contents in the work tree match the contents in the
+	index.  This option defaults to true.  Note that this
+	affects only `git diff` Porcelain, and not lower level
+	`diff` commands, such as `git diff-files`.
+
 diff.renameLimit::
 	The number of files to consider when performing the copy/rename
 	detection; equivalent to the git diff option '-l'.
diff --git a/diff.c b/diff.c
index 75d95da..0d30d05 100644
--- a/diff.c
+++ b/diff.c
@@ -19,7 +19,7 @@
 static int diff_detect_rename_default;
 static int diff_rename_limit_default = -1;
 static int diff_use_color_default;
-int diff_auto_refresh_index;
+int diff_auto_refresh_index = 1;
 
 static char diff_colors[][COLOR_MAXLEN] = {
 	"\033[m",	/* reset */
