From: Matthijs Kooijman <matthijs@stdin.nl>
Subject: Re: Lines missing from git diff-tree -p -c output?
Date: Wed, 15 May 2013 17:46:38 +0200
Message-ID: <20130515154638.GQ25742@login.drsnuggles.stderr.nl>
References: <20130515143508.GO25742@login.drsnuggles.stderr.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 15 17:46:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ucdug-0002sa-HN
	for gcvg-git-2@plane.gmane.org; Wed, 15 May 2013 17:46:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759472Ab3EOPqn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 May 2013 11:46:43 -0400
Received: from drsnuggles.stderr.nl ([94.142.244.14]:33800 "EHLO
	drsnuggles.stderr.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759466Ab3EOPql (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 May 2013 11:46:41 -0400
Received: from login.drsnuggles.stderr.nl ([10.42.0.9] ident=mail)
	by mail.drsnuggles.stderr.nl with smtp (Exim 4.69)
	(envelope-from <matthijs@stdin.nl>)
	id 1UcduZ-00044B-2O
	for git@vger.kernel.org; Wed, 15 May 2013 17:46:39 +0200
Received: (nullmailer pid 15631 invoked by uid 1000);
	Wed, 15 May 2013 15:46:39 -0000
Mail-Followup-To: Matthijs Kooijman <matthijs@stdin.nl>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20130515143508.GO25742@login.drsnuggles.stderr.nl>
X-PGP-Fingerprint: 7F6A 9F44 2820 18E2 18DE  24AA CF49 D0E6 8A2F AFBC
X-PGP-Key: http://www.stderr.nl/static/files/gpg_pubkey.asc
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Spam-Score: -2.6 (--)
X-Spam-Report: Spamchecked on "mail.drsnuggles.stderr.nl"
	pts  rule name              description
	---- ---------------------- -------------------------------------------
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224419>

Hi folks,

> $ git diff-tree -p -c HEAD
> d945a51b6ca22e6e8e550c53980d026f11b05158
> diff --combined file
> index 3404f54,0eab113..e8c8c18
> --- a/file
> +++ b/file
> @@@ -1,7 -1,5 +1,6 @@@
>  +LEFT
>   BASE2
>   BASE3
>   BASE4
> - BASE5
> + BASE5MODIFIED
>   BASE6

I found the spot in the code where this is going wrong, there is an
incorrectly set "no_pre_delete" flag for the context lines before each
hunk. Since a patch says more than a thousand words, here's what I think
will fix this problem:

diff --git a/combine-diff.c b/combine-diff.c
index 77d7872..d36bfcf 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -518,8 +518,11 @@ static int give_context(struct sline *sline, unsigned long cnt, int num_parent)
                unsigned long k;
 
                /* Paint a few lines before the first interesting line. */
-               while (j < i)
-                       sline[j++].flag |= mark | no_pre_delete;
+               while (j < i) {
+                       if (!(sline[j++].flag & mark))
+                               sline[j++].flag |= no_pre_delete;
+                       sline[j++].flag |= mark;
+               }
 
        again:
                /* we know up to i is to be included.  where does the

I'll see if I can write up a testcase and then submit this as a proper
patch, but I wanted to at least send this over now lest someone wastes
time coming to the same conclusion as I did.

Gr.

Matthijs
