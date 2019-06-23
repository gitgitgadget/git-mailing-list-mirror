Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 45E611F4B6
	for <e@80x24.org>; Sun, 23 Jun 2019 18:08:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbfFWSI0 (ORCPT <rfc822;e@80x24.org>);
        Sun, 23 Jun 2019 14:08:26 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:34474 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726417AbfFWSI0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Jun 2019 14:08:26 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id BBDC71F461;
        Sun, 23 Jun 2019 18:08:25 +0000 (UTC)
Date:   Sun, 23 Jun 2019 18:08:25 +0000
From:   Eric Wong <e@80x24.org>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Janos Farkas <chexum@gmail.com>, git@vger.kernel.org
Subject: Re: 2.22.0 repack -a duplicating pack contents
Message-ID: <20190623180825.3ospajjgat3clwiu@dcvr>
References: <CAEXt3sqno7RAtuwQ_OpD3aLkEORLaf6aNeNKGQL0BKezD+wWTw@mail.gmail.com>
 <875zow8i85.fsf@evledraar.gmail.com>
 <20190623180226.GA1100@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190623180226.GA1100@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> wrote:
> On Sun, Jun 23, 2019 at 04:54:50PM +0200, Ævar Arnfjörð Bjarmason wrote:
> 
> > I haven't looked at this for more than a couple of minutes (and don't
> > have more time now), but this is almost certainly due to 36eba0323d
> > ("repack: enable bitmaps by default on bare repos", 2019-03-14). Can you
> > confirm when you re-run with repack.writeBitmaps=false in the config?
> > 
> > I.e. something in the "yes I want bitmaps" code implies "*.keep"
> > semantics changing from "keep" to "replace", which is obvious in
> > retrospect, since we can only have one *.bitmap per-repo.
> 
> Yeah, the .keep behavior with bitmaps is intended, though it means a
> funny implication for the bitmap-by-default strategy.
> 
> Basically, you never want to have .keep files if you have bitmaps turned
> on, and so the default for "respect .keeps" is based on whether bitmaps
> are in use. See ee34a2bead (repack: add `repack.packKeptObjects` config
> var, 2014-03-03).
> 
> I'm not sure of the right solution. For maximal backwards-compatibility,
> the default for bitmaps could become "if not bare and if there are no
> .keep files". But that would mean bitmaps sometimes not getting
> generated because of the problems that ee34a2bead was trying to solve.
> 
> That's probably OK, though; you can always flip the bitmap config to
> "true" yourself if you _must_ have bitmaps.

What about something like this?  Needs tests but I need to leave, now.

diff --git a/builtin/repack.c b/builtin/repack.c
index caca113927..1d99fb449b 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -89,6 +89,25 @@ static void remove_pack_on_signal(int signo)
 	raise(signo);
 }
 
+static int has_pack_keep_file(void)
+{
+	DIR *dir;
+	struct dirent *e;
+	int found = 0;
+
+	if (!(dir = opendir(packdir)))
+		return found;
+
+	while ((e = readdir(dir)) != NULL) {
+		if (ends_with(e->d_name, ".keep")) {
+			found = 1;
+			break;
+		}
+	}
+	closedir(dir);
+	return found;
+}
+
 /*
  * Adds all packs hex strings to the fname list, which do not
  * have a corresponding .keep file. These packs are not to
@@ -343,16 +362,20 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	    (unpack_unreachable || (pack_everything & LOOSEN_UNREACHABLE)))
 		die(_("--keep-unreachable and -A are incompatible"));
 
-	if (write_bitmaps < 0)
+	packdir = mkpathdup("%s/pack", get_object_directory());
+
+	if (write_bitmaps < 0) {
 		write_bitmaps = (pack_everything & ALL_INTO_ONE) &&
-				 is_bare_repository();
+				 is_bare_repository() &&
+				 keep_pack_list.nr == 0 &&
+				 !has_pack_keep_file();
+	}
 	if (pack_kept_objects < 0)
 		pack_kept_objects = write_bitmaps;
 
 	if (write_bitmaps && !(pack_everything & ALL_INTO_ONE))
 		die(_(incremental_bitmap_conflict_error));
 
-	packdir = mkpathdup("%s/pack", get_object_directory());
 	packtmp = mkpathdup("%s/.tmp-%d-pack", packdir, (int)getpid());
 
 	sigchain_push_common(remove_pack_on_signal);
