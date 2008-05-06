From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] log and rev-list: add --graph option
Date: Mon, 05 May 2008 23:41:58 -0700
Message-ID: <7vtzhcgci1.fsf@gitster.siamese.dyndns.org>
References: <1209897414-10091-1-git-send-email-adam@adamsimpkins.net>
 <1209897414-10091-2-git-send-email-adam@adamsimpkins.net>
 <1209897414-10091-3-git-send-email-adam@adamsimpkins.net>
 <1209897414-10091-4-git-send-email-adam@adamsimpkins.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Adam Simpkins <adam@adamsimpkins.net>
X-From: git-owner@vger.kernel.org Tue May 06 08:43:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JtGtH-0004Ms-79
	for gcvg-git-2@gmane.org; Tue, 06 May 2008 08:43:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752293AbYEFGmM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 May 2008 02:42:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752274AbYEFGmL
	(ORCPT <rfc822;git-outgoing>); Tue, 6 May 2008 02:42:11 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:64333 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751966AbYEFGmK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 May 2008 02:42:10 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 9F2D43D62;
	Tue,  6 May 2008 02:42:09 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id C8B413D60; Tue,  6 May 2008 02:42:05 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 8D28E0C4-1B37-11DD-BFDB-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81339>

Adam Simpkins <adam@adamsimpkins.net> writes:

> diff --git a/builtin-rev-list.c b/builtin-rev-list.c
> index 476a870..f868290 100644
> --- a/builtin-rev-list.c
> +++ b/builtin-rev-list.c
> ...
> @@ -52,12 +53,13 @@ static struct rev_info revs;
>  
>  static int bisect_list;
>  static int show_timestamp;
> -static int hdr_termination;
>  static const char *header_prefix;
>  
>  static void finish_commit(struct commit *commit);
>  static void show_commit(struct commit *commit)
>  {
> +	graph_show_commit(revs.graph);
> +
>  	if (show_timestamp)
>  		printf("%lu ", commit->date);
>  	if (header_prefix)
> @@ -96,9 +98,50 @@ static void show_commit(struct commit *commit)
>  		pretty_print_commit(revs.commit_format, commit,
>  				    &buf, revs.abbrev, NULL, NULL,
>  				    revs.date_mode, 0);
> -		if (buf.len)
> -			printf("%s%c", buf.buf, hdr_termination);
> +		if (revs.graph) {
> ...
> +		} else {
> +			if (buf.len) {
> +				fwrite(buf.buf, sizeof(char), buf.len, stdout);
> +				putchar('\n');

Now hdr_termination can never be NUL, iow you broke "rev-list -v -z"?

I'll squash in a minimum fix, because otherwise this breaks existing
tests.

--

 builtin-rev-list.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin-rev-list.c b/builtin-rev-list.c
index f868290..54d55cc 100644
--- a/builtin-rev-list.c
+++ b/builtin-rev-list.c
@@ -53,6 +53,7 @@ static struct rev_info revs;
 
 static int bisect_list;
 static int show_timestamp;
+static int hdr_termination;
 static const char *header_prefix;
 
 static void finish_commit(struct commit *commit);
@@ -133,10 +134,8 @@ static void show_commit(struct commit *commit)
 					putchar('\n');
 			}
 		} else {
-			if (buf.len) {
-				fwrite(buf.buf, sizeof(char), buf.len, stdout);
-				putchar('\n');
-			}
+			if (buf.len)
+				printf("%s%c", buf.buf, hdr_termination);
 		}
 		strbuf_release(&buf);
 	} else {
@@ -635,6 +634,7 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 	}
 	if (revs.commit_format != CMIT_FMT_UNSPECIFIED) {
 		/* The command line has a --pretty  */
+		hdr_termination = '\n';
 		if (revs.commit_format == CMIT_FMT_ONELINE)
 			header_prefix = "";
 		else
