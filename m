Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B57461F461
	for <e@80x24.org>; Sun,  8 Sep 2019 21:21:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730609AbfIHVVY (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Sep 2019 17:21:24 -0400
Received: from cloud.peff.net ([104.130.231.41]:43560 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727235AbfIHVVX (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Sep 2019 17:21:23 -0400
Received: (qmail 30958 invoked by uid 109); 8 Sep 2019 21:21:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 08 Sep 2019 21:21:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2958 invoked by uid 111); 8 Sep 2019 21:23:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 08 Sep 2019 17:23:13 -0400
Authentication-Results: peff.net; auth=none
Date:   Sun, 8 Sep 2019 17:21:22 -0400
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: fix build with Asciidoctor 2
Message-ID: <20190908212122.GA8514@sigill.intra.peff.net>
References: <20190906232947.GJ11334@genre.crustytoothpaste.net>
 <20190907170746.273984-1-sandals@crustytoothpaste.net>
 <20190908104833.GE15641@sigill.intra.peff.net>
 <20190908171807.GL11334@genre.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190908171807.GL11334@genre.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 08, 2019 at 05:18:07PM +0000, brian m. carlson wrote:

> >   -        2. hand resolve the conflict in the working directory, and update the
> >   +        2.  hand resolve the conflict in the working directory, and update the
> >               index file to bring it into a state that the patch should have
> >               produced. Then run the command with the --continue option.
> > 
> > I tricked doc-diff into doing a comparison against 1.5.5 without the
> > patch and 2.0.10 with the patch, and the diff is similar.
> 
> I see the same thing in doc-diff, but this issue doesn't appear to
> actually render in the manual pages themselves, even with MANWIDTH=80.
> I'm not sure why, but it doesn't seem to misrender in the actual man
> output.

Hrm. But doc-diff _is_ diffing the output of man, so that implies a bug
in that script. However, if I manually go into tmp-doc-diff/installed
and run "man -l git-am.1", I do see the extra whitespace, which is what
I'd expect. Are you sure you did your manual inspection on the right
thing?

I was also curious about the root cause at the roff level, so I did this
hack:

diff --git a/Documentation/doc-diff b/Documentation/doc-diff
index 88a9b20168..fde3ac7154 100755
--- a/Documentation/doc-diff
+++ b/Documentation/doc-diff
@@ -22,6 +22,7 @@ to-asciidoc		use asciidoc with the 'to'-commit
 to-asciidoctor		use asciidoctor with the 'to'-commit
 asciidoctor		use asciidoctor with both commits
 cut-footer		cut away footer
+raw			diff roff instead of rendered manpages
 "
 SUBDIRECTORY_OK=1
 . "$(git --exec-path)/git-sh-setup"
@@ -32,6 +33,7 @@ clean=
 from_program=
 to_program=
 cut_footer=
+raw=
 while test $# -gt 0
 do
 	case "$1" in
@@ -57,6 +59,8 @@ do
 		to_program=-asciidoc ;;
 	--cut-footer)
 		cut_footer=-cut-footer ;;
+	--raw)
+		raw=t ;;
 	--)
 		shift; break ;;
 	*)
@@ -159,6 +163,11 @@ render_tree () {
 		mv "$tmp/installed/$dname+" "$tmp/installed/$dname"
 	fi &&
 
+	if test -n "$raw"
+	then
+		return 0
+	fi &&
+
 	# As with "installed" above, we skip the render if it's already been
 	# done.  So using make here is primarily just about running in
 	# parallel.
@@ -181,6 +190,13 @@ render_tree () {
 	fi
 }
 
+if test -z "$raw"
+then
+	diffdir=$tmp/rendered
+else
+	diffdir=$tmp/installed
+fi
+
 render_tree $from_oid $from_dir $from_makemanflags &&
 render_tree $to_oid $to_dir $to_makemanflags &&
-git -C $tmp/rendered diff --no-index "$@" $from_dir $to_dir
+git -C $diffdir diff --no-index "$@" $from_dir $to_dir


The results are quite noisy compared to the rendered output (i.e.,
stylistic choices in the roff output that have equivalent outputs). But
it did let me easily find the difference in one of these cases:


  @@ -312,6 +458,7 @@ option\&.
   .sp -1
   .IP "  2." 4.2
   .\}
  +
   hand resolve the conflict in the working directory, and update the index file to bring it into a state that the patch should have produced\&. Then run the command with the
   \fB\-\-continue\fR
   option\&.


But it's not clear from that whether asciidoc's docbook5 backend inserts
an extra newline, or if it's part of the xml translation. Looking at the
actual XML, I see:

  <listitem>
  <simpara>hand resolve the conflict in the working directory, and update
  the index file to bring it into a state that the patch should
  have produced.  Then run the command with the <literal>--continue</literal> option.</simpara>
  </listitem>

which looks OK. I wondered if there should not be a break between
<listitem> and <simpara>, but it's there in the asciidoc version, too.
So I'm inclined to blame xmlto/docbook5 here.

-Peff
