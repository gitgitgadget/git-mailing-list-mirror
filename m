From: Jan Engelhardt <jengelh@medozas.de>
Subject: Re: Git produces Unidiff - Does it really?
Date: Mon, 25 May 2009 11:48:38 +0200 (CEST)
Message-ID: <alpine.LSU.2.00.0905251117340.27529@fbirervta.pbzchgretzou.qr>
References: <alpine.LSU.2.00.0905250105410.22963@fbirervta.pbzchgretzou.qr> <7v4ov9zwtt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 25 11:48:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M8WnW-0007x1-9p
	for gcvg-git-2@gmane.org; Mon, 25 May 2009 11:48:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752781AbZEYJsj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 May 2009 05:48:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752298AbZEYJsi
	(ORCPT <rfc822;git-outgoing>); Mon, 25 May 2009 05:48:38 -0400
Received: from sovereign.computergmbh.de ([85.214.69.204]:41830 "EHLO
	sovereign.computergmbh.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751649AbZEYJsh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 May 2009 05:48:37 -0400
Received: by sovereign.computergmbh.de (Postfix, from userid 25121)
	id 3F006D0CD67; Mon, 25 May 2009 11:48:38 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by sovereign.computergmbh.de (Postfix) with ESMTP id 3CA1443C8D14;
	Mon, 25 May 2009 11:48:38 +0200 (CEST)
In-Reply-To: <7v4ov9zwtt.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LSU 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119911>


On Monday 2009-05-25 05:27, Junio C Hamano wrote:
>Jan Engelhardt writes:
>
>> Any insights?
>
>[...]
>For example, "rcsdiff -u" shows something like:
>
>    diff -u -r1.1 -r1.2
>    --- Make        1995/01/08 20:50:24     1.1
>    +++ Make        2001/10/04 07:14:29     1.2
>    @@ -1,7 +1,11 @@
>     #!/bin/sh
>    -...
>It has cruft after the timestamp, and the timestamp itself is not even in
>the format POSIX expects to see (see
> http://www.opengroup.org/onlinepubs/9699919799/utilities/diff.html#tag_20_34_10_07
>if you really care).
>
>Is it in violation of POSIX unified context format?  Of course yes.  Is it
>then not in unified context format at all?
>
>For all practical purposes, if you (either you human or your tool) know
>how to read unified context format, you can process what we (or RCS)
>produce.
>I used RCS as an example because it has been maintained by the same person
>who maintains "GNU diff" and was one of the main player who pushed
>"unified context" format to the updated POSIX.
>

Here is a random patch; not that I am fond of it, but it
speaks in code at least.
Tear it apar! :)


parent 9619ff14159ab3401636b9883a715b0f20b051df (v1.6.3.1-152-g9619ff1)
commit 9d73395d1c08d2fc4e1b740c2d37d8daed7cb3e6
Author: Jan Engelhardt <jengelh@medozas.de>
Date:   Mon May 25 11:40:34 2009 +0200

diff: produce TSVN-acceptable diff

Once TortoiseSVNMerge sees a \t after the filename in a --- line,
it accepts a patch. (Not that t
So let's produce patches with said \t, and a $ so the \t does not
get chopped off by incompetent tools or overlooked otherwise.
---
 diff.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/diff.c b/diff.c
index f06876b..55cb974 100644
--- a/diff.c
+++ b/diff.c
@@ -324,7 +324,7 @@ static void emit_rewrite_diff(const char *name_a,
 	lc_a = count_lines(data_one, size_one);
 	lc_b = count_lines(data_two, size_two);
 	fprintf(o->file,
-		"%s--- %s%s%s\n%s+++ %s%s%s\n%s@@ -",
+		"%s--- %s%s%s\t$\n%s+++ %s%s%s\n%s@@ -",
 		metainfo, a_name.buf, name_a_tab, reset,
 		metainfo, b_name.buf, name_b_tab, reset, fraginfo);
 	print_line_count(o->file, lc_a);
@@ -637,7 +637,7 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
 		name_a_tab = strchr(ecbdata->label_path[0], ' ') ? "\t" : "";
 		name_b_tab = strchr(ecbdata->label_path[1], ' ') ? "\t" : "";
 
-		fprintf(ecbdata->file, "%s--- %s%s%s\n",
+		fprintf(ecbdata->file, "%s--- %s%s%s\t$\n",
 			meta, ecbdata->label_path[0], reset, name_a_tab);
 		fprintf(ecbdata->file, "%s+++ %s%s%s\n",
 			meta, ecbdata->label_path[1], reset, name_b_tab);
-- 
# Created with git-export-patch
