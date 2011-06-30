From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] branch: honor core.abbrev
Date: Thu, 30 Jun 2011 13:10:20 -0500
Message-ID: <20110630181020.GA1128@elie>
References: <1309449762-10476-1-git-send-email-namhyung@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Namhyung Kim <namhyung@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 30 20:10:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QcLhD-0008QZ-IM
	for gcvg-git-2@lo.gmane.org; Thu, 30 Jun 2011 20:10:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753524Ab1F3SKa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Jun 2011 14:10:30 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:43131 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752976Ab1F3SKa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jun 2011 14:10:30 -0400
Received: by vxb39 with SMTP id 39so1804445vxb.19
        for <git@vger.kernel.org>; Thu, 30 Jun 2011 11:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=EgWV090ivkgoGNXzg0MOLH/Bq8tBrveg0XZlxDX9MNk=;
        b=rXAwuKe3wM8whQ7Pwjp92hyhdOAQj4hChAt+NfbMalAXvvwRKZ7KVveDYq1wJSwIgR
         3t/yLCTxe4gveZd4XTfXLMaN4uo01AVTaD2gB+J3BapSQw5YlN5IvD2xV/d4FnXys1bU
         tDmXmjtoPi19YZGQXwFhdb50T8EajMXjFWtbk=
Received: by 10.52.73.196 with SMTP id n4mr3454449vdv.39.1309457429246;
        Thu, 30 Jun 2011 11:10:29 -0700 (PDT)
Received: from elie (adsl-68-255-110-41.dsl.chcgil.ameritech.net [68.255.110.41])
        by mx.google.com with ESMTPS id b9sm932226vdk.13.2011.06.30.11.10.27
        (version=SSLv3 cipher=OTHER);
        Thu, 30 Jun 2011 11:10:28 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1309449762-10476-1-git-send-email-namhyung@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176496>

Namhyung Kim wrote:

> --- a/Documentation/git-branch.txt
> +++ b/Documentation/git-branch.txt
> @@ -114,6 +114,7 @@ OPTIONS
>  --abbrev=<length>::
>  	Alter the sha1's minimum display length in the output listing.
>  	The default value is 7.
> +	(and can be overrided by the `core.abbrev` config option).

Nitpicks: this would be clearer without the period after "7" and without
the parentheses around the following phrase.  s/overrided/overridden/.

> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -613,7 +613,7 @@ static int opt_parse_merge_filter(const struct option *opt, const char *arg, int
>  int cmd_branch(int argc, const char **argv, const char *prefix)
>  {
>  	int delete = 0, rename = 0, force_create = 0;
> -	int verbose = 0, abbrev = DEFAULT_ABBREV, detached = 0;
> +	int verbose = 0, abbrev = -1, detached = 0;

Yes.  (One meaningful "c89 -pedantic" warning down, several to go.)

Some squashable tests follow.  Maybe they can be useful.  Thanks for
fixing this.  

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/t3203-branch-output.sh |   29 +++++++++++++++++++++++++++++
 1 files changed, 29 insertions(+), 0 deletions(-)

diff --git i/t/t3203-branch-output.sh w/t/t3203-branch-output.sh
index 6b7c118e..87333b49 100755
--- i/t/t3203-branch-output.sh
+++ w/t/t3203-branch-output.sh
@@ -3,6 +3,17 @@
 test_description='git branch display tests'
 . ./test-lib.sh
 
+minimum_line_length () {
+	awk '
+		BEGIN { minlen = 99 }
+		{
+			if (length($1) < minlen)
+				minlen = length($1)
+		}
+		END { print minlen }
+	'
+}
+
 test_expect_success 'make commits' '
 	echo content >file &&
 	git add file &&
@@ -66,6 +77,24 @@ test_expect_success 'git branch -v shows branch summaries' '
 	test_cmp expect actual
 '
 
+test_expect_success 'git branch -v --abbrev' '
+	echo 10 >expect &&
+	git branch -v --abbrev=10 >tmp &&
+	awk "{print \$(NF - 1)}" <tmp >commitids &&
+	minimum_line_length <commitids >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git branch -v respects [core] abbrev configuration' '
+	git config core.abbrev 9 &&
+	test_when_finished "git config --unset core.abbrev" &&
+	echo 9 >expect &&
+	git branch -v >tmp &&
+	awk "{print \$(NF - 1)}" <tmp >commitids &&
+	minimum_line_length <commitids >actual &&
+	test_cmp expect actual
+'
+
 cat >expect <<'EOF'
 * (no branch)
   branch-one
