Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 505A71F442
	for <e@80x24.org>; Wed,  8 Nov 2017 07:53:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751261AbdKHHxj (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Nov 2017 02:53:39 -0500
Received: from cloud.peff.net ([104.130.231.41]:49942 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750983AbdKHHxi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Nov 2017 02:53:38 -0500
Received: (qmail 4936 invoked by uid 109); 8 Nov 2017 07:53:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 08 Nov 2017 07:53:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12202 invoked by uid 111); 8 Nov 2017 07:53:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 08 Nov 2017 02:53:49 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 08 Nov 2017 02:53:36 -0500
Date:   Wed, 8 Nov 2017 02:53:36 -0500
From:   Jeff King <peff@peff.net>
To:     Joey Hess <id@joeyh.name>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: use of PWD
Message-ID: <20171108075336.is4awgyw53dohf7y@sigill.intra.peff.net>
References: <20171107192239.6hinu235hfpwqpv6@kitenet.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171107192239.6hinu235hfpwqpv6@kitenet.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 07, 2017 at 03:22:39PM -0400, Joey Hess wrote:

> In strbuf_add_absolute_path, git uses PWD if set when making relative
> paths absolute, otherwise it falls back to getcwd(3). Using PWD may not
> be a good idea. Here's one case where it confuses git badly:
> 
> joey@darkstar:/>sudo ln -s /media/hd/repo hd
> joey@darkstar:/>cd /hd/repo
> joey@darkstar:/hd/repo>git --git-dir=../../../home/joey/tmp/repo/.git cat-file -t HEAD
> fatal: unable to normalize object directory: /hd/repo/../../../home/joey/tmp/repo/.git/objects
> joey@darkstar:/hd/repo>ls -d ../../../home/joey/tmp/repo/.git
> ../../../home/joey/tmp/repo/.git/
> 
> In that situation where cd has followed a symlink to a different
> depth, there seems to be no way to give git a relative path that works.
> Other numbers of ../ also don't work.

I wondered if:

  git --git-dir=../../home/joey/tmp/repo.git

would work. But interestingly we _do_ resolve the relative git-dir using
the physical path, so that fails with "not a git repository". IOW,
there's no relative path that could possibly work.

Also interestingly, your case "worked" until my 670c359da3
(link_alt_odb_entry: handle normalize_path errors, 2016-10-03). But
that's only because we quietly generated a broken nonsense path, which
turned out not to matter because there are no alternates to link.

So totally orthogonal to your bug, I wonder if we ought to be doing:

diff --git a/sha1_file.c b/sha1_file.c
index 057262d46e..0b76233aa7 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -530,11 +530,11 @@ void prepare_alt_odb(void)
 	if (alt_odb_tail)
 		return;
 
-	alt = getenv(ALTERNATE_DB_ENVIRONMENT);
-	if (!alt) alt = "";
-
 	alt_odb_tail = &alt_odb_list;
-	link_alt_odb_entries(alt, strlen(alt), PATH_SEP, NULL, 0);
+
+	alt = getenv(ALTERNATE_DB_ENVIRONMENT);
+	if (alt)
+		link_alt_odb_entries(alt, strlen(alt), PATH_SEP, NULL, 0);
 
 	read_info_alternates(get_object_directory(), 0);
 }

to avoid hitting link_alt_odb_entries() at all when there are no
entries.

Anyway, back on topic.

> So why does git use PWD at all? Some shell code used pwd earlier
> (leading to similar bugs like the one fixed in v1.5.1.5), but in
> the C code, it was first introduced in commit
> 1b9a9467f8b9a8da2fe58d10ae16779492aa7737, which speaks of the "user's
> view of the current directory", which is what PWD is. The use of PWD in
> that commit may be ok.
> 
> Then in commit 10c4c881c4d2cb0ece0508e7142e189e68445257, 
> the limited use of PWD broadened a lot, seemingly without
> intending to look at the "user's view of the current directory"
> anymore, due to reusing the code from the earlier commit.

I had trouble finding anything definite in the list archive. I suspect
it was mostly about trying to make things look "nice" to the user in
messages, etc. But as you noticed, while it works some of the time, it
definitely doesn't always.

Interestingly, ripping it out and just using getcwd() causes t1305 to
fail. The test does:

  ln -s foo bar
  cd bar
  git config includeIf.gitdir:bar/.key value

and expects that condition to trigger.

That's somewhat convenient, but it's also slightly crazy that the config
might or might not trigger for the same repo depending on how you
happened to "cd" there.

This was added by 0624c63ce6 (config: match both symlink & realpath
versions in IncludeIf.gitdir:*, 2017-05-16) which makes it clear that
this behavior is very intentional.

Ideally we would instead be canonicalizing both the cwd and the
directory mentioned in the config file, and then comparing those
results.  But I suspect that may be tricky since what's in the config is
actually a globbing pattern. I guess you'd have to expand the glob and
then `real_path` the results.

Or we can leave the minor weirdness (which AFAIK nobody is complaining
about), and just let that matching code use its own custom
$PWD-respecting implementation. And change strbuf_add_absolute_path() to
do the more robust physical-path matching.

-Peff
