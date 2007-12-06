From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] git config --get-colorbool
Date: Wed, 05 Dec 2007 22:12:07 -0800
Message-ID: <7vve7cgxmw.fsf@gitster.siamese.dyndns.org>
References: <475697BC.2090701@viscovery.net>
	<1196906706-11170-1-git-send-email-gitster@pobox.com>
	<1196906706-11170-2-git-send-email-gitster@pobox.com>
	<20071206053059.GF5499@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Dec 06 07:12:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J09yO-0003hf-MQ
	for gcvg-git-2@gmane.org; Thu, 06 Dec 2007 07:12:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752224AbXLFGMP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Dec 2007 01:12:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752339AbXLFGMP
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Dec 2007 01:12:15 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:50270 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751136AbXLFGMO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Dec 2007 01:12:14 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id DF9D52EF;
	Thu,  6 Dec 2007 01:12:34 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 2EDE29A6D2;
	Thu,  6 Dec 2007 01:12:31 -0500 (EST)
In-Reply-To: <20071206053059.GF5499@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 6 Dec 2007 00:30:59 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67250>

Jeff King <peff@peff.net> writes:

> [Eric Wong cc'd because of git-svn relevance]
>
> On Wed, Dec 05, 2007 at 06:05:04PM -0800, Junio C Hamano wrote:
>
>> This adds an option to help scripts find out color settings from
>> the configuration file.
>> 
>>     git config --get-colorbool color.diff
>> 
>> inspects color.diff variable, and exits with status 0 (i.e. success) if
>> color is to be used.  It exits with status 1 otherwise.
>
> There is no way to differentiate between "do not use color" and "no
> value found". This makes it impossible to use this to implement the
> required "try color.diff, fallback to diff.color" behavior.
>
> We could simply make it
>
>   git config --get-colorbool diff
>
> which would check both (and when diff.color support is finally dropped,
> just remove it from there).

I thought about this a bit and thought that it would probably be a good
workaround to teach "--get-colorbool that diff.color is a deprecated
synonym to color.diff, like this.

-- >8 --
config --get-colorbool: diff.color is a deprecated synonym to color.diff

The applications can ask for color.diff but the configuration of old
timer users can still instruct it to use color with diff.color this
way.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-config.c |   18 ++++++++++++++++--
 1 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/builtin-config.c b/builtin-config.c
index d10b03f..e4a12e3 100644
--- a/builtin-config.c
+++ b/builtin-config.c
@@ -210,11 +210,17 @@ static int get_color(int argc, const char **argv)
 
 static int stdout_is_tty;
 static int get_colorbool_found;
+static int get_diff_color_found;
 static int git_get_colorbool_config(const char *var, const char *value)
 {
-	if (!strcmp(var, get_color_slot))
+	if (!strcmp(var, get_color_slot)) {
 		get_colorbool_found =
 			git_config_colorbool(var, value, stdout_is_tty);
+	}
+	if (!strcmp(var, "diff.color")) {
+		get_diff_color_found =
+			git_config_colorbool(var, value, stdout_is_tty);
+	}
 	return 0;
 }
 
@@ -233,10 +239,18 @@ static int get_colorbool(int argc, const char **argv)
 		stdout_is_tty = isatty(1);
 	else
 		usage(git_config_set_usage);
-	get_colorbool_found = 0;
+	get_colorbool_found = -1;
+	get_diff_color_found = -1;
 	get_color_slot = argv[0];
 	git_config(git_get_colorbool_config);
 
+	if (get_colorbool_found < 0) {
+		if (!strcmp(get_color_slot, "color.diff"))
+			get_colorbool_found = get_diff_color_found;
+		if (get_colorbool_found < 0)
+			get_colorbool_found = 0;
+	}
+
 	if (argc == 1) {
 		return get_colorbool_found ? 0 : 1;
 	} else {
