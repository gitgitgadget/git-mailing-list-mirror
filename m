Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E336B1F454
	for <e@80x24.org>; Wed,  6 Nov 2019 21:42:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbfKFVmD (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Nov 2019 16:42:03 -0500
Received: from cloud.peff.net ([104.130.231.41]:41024 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726779AbfKFVmC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Nov 2019 16:42:02 -0500
Received: (qmail 25315 invoked by uid 109); 6 Nov 2019 21:42:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 06 Nov 2019 21:42:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27448 invoked by uid 111); 6 Nov 2019 21:45:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 06 Nov 2019 16:45:22 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 6 Nov 2019 16:42:01 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: [BUG] "fatal: bad object .alternate" during fetch with alternates
Message-ID: <20191106214201.GB8521@sigill.intra.peff.net>
References: <nycvar.QRO.7.76.6.1911041053190.46@tvgsbejvaqbjf.bet>
 <20191106205907.GA4122@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191106205907.GA4122@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 06, 2019 at 03:59:07PM -0500, Jeff King wrote:

> > So I see two problems with this error message:
> > 
> > - It is not helpful. It should not say `.alternate`, it should mention
> >   the ref itself, and ideally even the path of the alternate.
> 
> It doesn't know the refname. The data transfer between the alternate and
> the borrowing repo was tightened to just pass over object names. We
> could probably pass the alternate path, though.

The patch to do that is pretty simple (there's a little collateral
damage from having to update the callback signature). I've included it
at the end of this message.

But I feel a little iffy stuffing arbitrary strings into what's usually
a refname (or a syntactically invalid pseudo-refname like ".alternate").

E.g., here's the output of t5618 with this patch:

  expecting success of 5618.6 'log --source shows .alternate marker': 
  	git log --oneline --source --remotes=origin >expect.orig &&
  	sed "s/origin.* /.alternate /" <expect.orig >expect &&
  	git log --oneline --source --alternate-refs >actual &&
  	test_cmp expect actual
  
  --- expect	2019-11-06 21:37:06.435427982 +0000
  +++ actual	2019-11-06 21:37:06.439427949 +0000
  @@ -1,3 +1,3 @@
  -e9067a7	.alternate two
  -eae7140	.alternate one
  -00f38a4	.alternate base
  +e9067a7	.alternate from /home/peff/compile/git/t/trash directory.t5618-alternate-refs/.git two
  +eae7140	.alternate from /home/peff/compile/git/t/trash directory.t5618-alternate-refs/.git one
  +00f38a4	.alternate from /home/peff/compile/git/t/trash directory.t5618-alternate-refs/.git base
  not ok 6 - log --source shows .alternate marker


I wonder if a better approach would be to improve the "bad object"
message. It prints the "name", but never even mentions the bogus oid it
found! So with this much simpler change:

  diff --git a/revision.c b/revision.c
  index 309cd31488..4e55a9248c 100644
  --- a/revision.c
  +++ b/revision.c
  @@ -380,7 +380,7 @@ static struct object *get_reference(struct rev_info *revs, const char *name,
                          return object;
                  if (revs->exclude_promisor_objects && is_promisor_object(oid))
                          return NULL;
  -               die("bad object %s", name);
  +               die(_("bad object %s (from %s)"), oid_to_hex(oid), name);
          }
          object->flags |= flags;
          return object;

You'd get something like:

  fatal: bad object: 1234abcd... (from refs/heads/master)

or

  fatal: bad object: 1234abcd... (from .alternate)

which seems strictly better in the first case, and passably less
confusing in the second.

-Peff

---
Here's the "name objects after their alternate path" patch:

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 411e0b4d99..300249b44a 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -280,7 +280,8 @@ static int show_ref_cb(const char *path_full, const struct object_id *oid,
 	return 0;
 }
 
-static void show_one_alternate_ref(const struct object_id *oid,
+static void show_one_alternate_ref(const char *altpath,
+				   const struct object_id *oid,
 				   void *data)
 {
 	struct oidset *seen = data;
diff --git a/fetch-pack.c b/fetch-pack.c
index 0130b44112..553741341b 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -75,7 +75,8 @@ struct alternate_object_cache {
 	size_t nr, alloc;
 };
 
-static void cache_one_alternate(const struct object_id *oid,
+static void cache_one_alternate(const char *altpath,
+				const struct object_id *oid,
 				void *vcache)
 {
 	struct alternate_object_cache *cache = vcache;
diff --git a/object-store.h b/object-store.h
index 7f7b3cdd80..0066a14f66 100644
--- a/object-store.h
+++ b/object-store.h
@@ -33,7 +33,7 @@ void prepare_alt_odb(struct repository *r);
 char *compute_alternate_path(const char *path, struct strbuf *err);
 typedef int alt_odb_fn(struct object_directory *, void *);
 int foreach_alt_odb(alt_odb_fn, void*);
-typedef void alternate_ref_fn(const struct object_id *oid, void *);
+typedef void alternate_ref_fn(const char *altpath, const struct object_id *oid, void *);
 void for_each_alternate_ref(alternate_ref_fn, void *);
 
 /*
diff --git a/revision.c b/revision.c
index 0e39b2b8a5..077a47f2e6 100644
--- a/revision.c
+++ b/revision.c
@@ -1560,27 +1560,34 @@ void add_index_objects_to_pending(struct rev_info *revs, unsigned int flags)
 struct add_alternate_refs_data {
 	struct rev_info *revs;
 	unsigned int flags;
+	struct strbuf *name;
 };
 
-static void add_one_alternate_ref(const struct object_id *oid,
+static void add_one_alternate_ref(const char *altpath,
+				  const struct object_id *oid,
 				  void *vdata)
 {
-	const char *name = ".alternate";
 	struct add_alternate_refs_data *data = vdata;
 	struct object *obj;
 
-	obj = get_reference(data->revs, name, oid, data->flags);
-	add_rev_cmdline(data->revs, obj, name, REV_CMD_REV, data->flags);
-	add_pending_object(data->revs, obj, name);
+	strbuf_reset(data->name);
+	strbuf_addf(data->name, ".alternate from %s", altpath);
+
+	obj = get_reference(data->revs, data->name->buf, oid, data->flags);
+	add_rev_cmdline(data->revs, obj, data->name->buf, REV_CMD_REV, data->flags);
+	add_pending_object(data->revs, obj, data->name->buf);
 }
 
 static void add_alternate_refs_to_pending(struct rev_info *revs,
 					  unsigned int flags)
 {
+	struct strbuf name = STRBUF_INIT;
 	struct add_alternate_refs_data data;
 	data.revs = revs;
 	data.flags = flags;
+	data.name = &name;
 	for_each_alternate_ref(add_one_alternate_ref, &data);
+	strbuf_release(&name);
 }
 
 static int add_parents_only(struct rev_info *revs, const char *arg_, int flags,
diff --git a/sha1-file.c b/sha1-file.c
index 188de57634..e1709fdf30 100644
--- a/sha1-file.c
+++ b/sha1-file.c
@@ -793,7 +793,7 @@ static void read_alternate_refs(const char *path,
 			break;
 		}
 
-		cb(&oid, data);
+		cb(path, &oid, data);
 	}
 
 	fclose(fh);
