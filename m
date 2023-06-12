Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E26AC7EE2E
	for <git@archiver.kernel.org>; Mon, 12 Jun 2023 04:05:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232253AbjFLEFY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jun 2023 00:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232207AbjFLEFV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jun 2023 00:05:21 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A4D513D
        for <git@vger.kernel.org>; Sun, 11 Jun 2023 21:05:20 -0700 (PDT)
Received: (qmail 24828 invoked by uid 109); 12 Jun 2023 04:05:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 12 Jun 2023 04:05:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11858 invoked by uid 111); 12 Jun 2023 04:05:23 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 12 Jun 2023 00:05:23 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 12 Jun 2023 00:05:18 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UnViw6lu?= Justo <rjusto@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [PATCH 10/11] config: fix a leak in
 git_config_copy_or_rename_section_in_file
Message-ID: <20230612040518.GJ306352@coredump.intra.peff.net>
References: <9eb931e7-dd18-8ce8-4d4a-cf3d85066189@gmail.com>
 <3ee93720-dce0-8f90-68bf-0242e5731a36@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3ee93720-dce0-8f90-68bf-0242e5731a36@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 11, 2023 at 08:50:45PM +0200, Rubén Justo wrote:

> diff --git a/config.c b/config.c
> index 39a7d7422c..207e4394a3 100644
> --- a/config.c
> +++ b/config.c
> @@ -3833,6 +3833,7 @@ static int git_config_copy_or_rename_section_in_file(const char *config_filename
>  						output[0] = '\t';
>  					}
>  				} else {
> +					strbuf_release(&copystr);
>  					copystr = store_create_section(new_name, &store);
>  				}
>  			}

Wow, I did a double-take on this code. It is uncommon in our codebase to
assign a struct by value in a function return like this, and doubly
weird to assign a strbuf (since the whole point of strbuf is to use the
opaque functions to make sure we aren't overwriting existing allocations
or aliasing pointers).

I think your fix here is the correct thing if we aren't going to clean
up the code further.

The more usual thing for our codebase would be refactoring like:

diff --git a/config.c b/config.c
index b79baf83e3..f5a7cced7c 100644
--- a/config.c
+++ b/config.c
@@ -3140,37 +3140,36 @@ static int write_error(const char *filename)
 	return 4;
 }
 
-static struct strbuf store_create_section(const char *key,
-					  const struct config_store_data *store)
+static void store_create_section(const char *key,
+				 const struct config_store_data *store,
+				 struct strbuf *sb)
 {
 	const char *dot;
 	size_t i;
-	struct strbuf sb = STRBUF_INIT;
 
 	dot = memchr(key, '.', store->baselen);
 	if (dot) {
-		strbuf_addf(&sb, "[%.*s \"", (int)(dot - key), key);
+		strbuf_addf(sb, "[%.*s \"", (int)(dot - key), key);
 		for (i = dot - key + 1; i < store->baselen; i++) {
 			if (key[i] == '"' || key[i] == '\\')
-				strbuf_addch(&sb, '\\');
-			strbuf_addch(&sb, key[i]);
+				strbuf_addch(sb, '\\');
+			strbuf_addch(sb, key[i]);
 		}
-		strbuf_addstr(&sb, "\"]\n");
+		strbuf_addstr(sb, "\"]\n");
 	} else {
-		strbuf_addch(&sb, '[');
-		strbuf_add(&sb, key, store->baselen);
-		strbuf_addstr(&sb, "]\n");
+		strbuf_addch(sb, '[');
+		strbuf_add(sb, key, store->baselen);
+		strbuf_addstr(sb, "]\n");
 	}
-
-	return sb;
 }
 
 static ssize_t write_section(int fd, const char *key,
 			     const struct config_store_data *store)
 {
-	struct strbuf sb = store_create_section(key, store);
+	struct strbuf sb = STRBUF_INIT;
 	ssize_t ret;
 
+	store_create_section(key, store, &sb);
 	ret = write_in_full(fd, sb.buf, sb.len);
 	strbuf_release(&sb);
 
@@ -3833,7 +3832,9 @@ static int git_config_copy_or_rename_section_in_file(const char *config_filename
 						output[0] = '\t';
 					}
 				} else {
-					copystr = store_create_section(new_name, &store);
+					strbuf_reset(&copystr);
+					store_create_section(new_name, &store,
+							     &copystr);
 				}
 			}
 			remove = 0;
