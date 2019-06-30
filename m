Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E71EA1F461
	for <e@80x24.org>; Sun, 30 Jun 2019 06:34:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbfF3GeN (ORCPT <rfc822;e@80x24.org>);
        Sun, 30 Jun 2019 02:34:13 -0400
Received: from cloud.peff.net ([104.130.231.41]:55202 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725976AbfF3GeN (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Jun 2019 02:34:13 -0400
Received: (qmail 22585 invoked by uid 109); 30 Jun 2019 06:34:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 30 Jun 2019 06:34:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28814 invoked by uid 111); 30 Jun 2019 06:35:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sun, 30 Jun 2019 02:35:04 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 30 Jun 2019 02:34:11 -0400
Date:   Sun, 30 Jun 2019 02:34:11 -0400
From:   Jeff King <peff@peff.net>
To:     Elijah Newren <newren@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH 0/6] easy bulk commit creation in tests
Message-ID: <20190630063410.GA31264@sigill.intra.peff.net>
References: <49d98293-9f0b-44e9-cb07-d6b7ac791eb6@gmail.com>
 <14689d27-eecd-2e0a-715d-796b20d573e5@gmail.com>
 <20190628064103.GA19777@sigill.intra.peff.net>
 <20190628093751.GA3569@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1906281452251.44@tvgsbejvaqbjf.bet>
 <20190629003057.GB3094@sigill.intra.peff.net>
 <CABPp-BEyq-9sj_9wxLdh66BJqqjQ80a8sCpXd_cMCArAHnM7kA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BEyq-9sj_9wxLdh66BJqqjQ80a8sCpXd_cMCArAHnM7kA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 29, 2019 at 10:38:43AM -0600, Elijah Newren wrote:

> >   - add a feature to fast-import to say "build on top of ref X", instead
> >     of using to use rev-parse to manually generates a "reset" line
> >     (maybe this is even possible already; I searched for it, but not
> >     very hard).
> 
> It already exists; quoting the fast-import documentation:
> 
> "The special case of restarting an incremental import from the
> current branch value should be written as:
> 
>             from refs/heads/branch^0

Thank you! I looked over the documentation several times for this, but I
was looking for an individual command similar to "reset".

Unfortunately, I'm not sure we can use this to save ourselves a process.
What I really want to say is "if it does not exist, start from scratch
and otherwise build on the existing branch".

I couldn't figure out a way to do that without first finding out myself
if the branch exists (incurring a process) and then modifying my
fast-import stream appropriately.

So I don't think it actually shaves off our processes, but as I argued
elsewhere, I think it's probably not that important anyway. I do think
the end result is a bit simpler to read, too, as the while-loop now
generates the input in its entirety (I didn't reindent it yet in the
diff below):

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 9fd0fa2a89..4233f408e8 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -305,14 +305,11 @@ test_commit_bulk () {
 	done
 	total=$1
 
-	{
-		# A "reset ... from" instructs fastimport to build on an
-		# existing branch tip rather than trying to overwrite.
-		if tip=$(git -C "$indir" rev-parse --verify "$ref" 2>/dev/null)
-		then
-			echo "reset $ref"
-			echo "from $tip"
-		fi
+	add_from=
+	if git rev-parse --verify "$ref" >/dev/null 2>&1
+	then
+		add_from=t
+	fi
 
 		while test "$total" -gt 0
 		do
@@ -329,16 +326,16 @@ test_commit_bulk () {
 			echo "data <<EOF"
 			printf "$message\n" $n
 			echo "EOF"
+			test -n "$add_from" && echo "from $ref^0"
 			printf "M 644 inline $filename\n" $n
 			echo "data <<EOF"
 			printf "$contents\n" $n
 			echo "EOF"
 			echo
+			add_from=
 			n=$((n + 1))
 			total=$((total - 1))
-		done
-
-	} >"$tmpfile"
+		done >"$tmpfile"
 
 	git -C "$indir" \
 	    -c fastimport.unpacklimit=0 \

Actually, thinking about it more, avoiding the $() probably does save us
a subshell fork, too.

> > The third one is a little less elegant to me, because there are a lot of
> > questions about how to checkout (e.g., with "-f", what happens to
> > deleted files, etc).
> 
> There's a question with deleted files?  Why wouldn't you just delete
> them from the index and working tree?  The more interesting questions
> to me in this case is what to do if the index or working tree were
> dirty before the import started; that seems like a mess, though maybe
> it's just a case where you abort before even importing.  On a similar
> note, though, there could have been an untracked file that is in the
> way of a now-to-be-tracked file that you might not want to lose.

Sorry, by deleted I meant files that were already deleted in the working
tree or index, not ones our fast-import stream deleted. I.e,. the same
dirty case you're asking about. But modifications have the same problem,
too (I was thinking we'd just overwrite them as if the user had done
"cat >dirty-file" as part of their fast-import, but that only applies to
files they actually touched).

So "dirty" is definitely the right way to think about it.

-Peff
