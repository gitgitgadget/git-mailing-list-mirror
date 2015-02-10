From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] fast-import: avoid running end_packfile recursively
Date: Tue, 10 Feb 2015 13:58:29 -0500
Message-ID: <20150210185828.GB20090@peff.net>
References: <20150210010719.GA31823@peff.net>
 <xmqqa90lwqpr.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 10 19:58:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YLG16-0005R0-Si
	for gcvg-git-2@plane.gmane.org; Tue, 10 Feb 2015 19:58:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753699AbbBJS6c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2015 13:58:32 -0500
Received: from cloud.peff.net ([50.56.180.127]:47360 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753407AbbBJS6b (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2015 13:58:31 -0500
Received: (qmail 30911 invoked by uid 102); 10 Feb 2015 18:58:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 10 Feb 2015 12:58:31 -0600
Received: (qmail 8943 invoked by uid 107); 10 Feb 2015 18:58:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 10 Feb 2015 13:58:33 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 10 Feb 2015 13:58:29 -0500
Content-Disposition: inline
In-Reply-To: <xmqqa90lwqpr.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263642>

On Tue, Feb 10, 2015 at 10:45:20AM -0800, Junio C Hamano wrote:

> > Unfortunately, it is not so easy. pack_data is a global, and
> > end_packfile calls into other functions which operate on the
> > global directly. We would have to teach each of these to
> > take an argument, and there is no guarantee that we would
> > catch all of the spots.
> 
> Well, you can rename the global to something else to make sure ;-)
> But I think that the approach with a simple flag is better.

:) True. The problems I had in mind were more:

  1. One of the problems with that is that there are a whole bunch of
     helper functions that use the variable. But only the ones that are
     called as part of end_packfile need this treatment. So either we
     need to touch all of them, or we need to figure out reliably which
     ones are part of this code path.

  2. Unless we get rid of the global completely, we open ourselves up to
     end_packfile calling new functions, bringing the problem back. This
     is probably not a huge concern, though, as this code has basically
     not changed much since its inception.

I did work through it, though, and the result is not _too_ bad. Here it
is for reference, in case you want to change your mind. The remaining
references are only in start_packfile, and in gfi_load_object, both of
which are hopefully unlikely to be called from end_packfile.

---
diff --git a/fast-import.c b/fast-import.c
index d0bd285..e842386 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -883,7 +883,7 @@ static void start_packfile(void)
 	all_packs[pack_id] = p;
 }
 
-static const char *create_index(void)
+static const char *create_index(struct packed_git *pack)
 {
 	const char *tmpfile;
 	struct pack_idx_entry **idx, **c, **last;
@@ -901,18 +901,18 @@ static const char *create_index(void)
 	if (c != last)
 		die("internal consistency error creating the index");
 
-	tmpfile = write_idx_file(NULL, idx, object_count, &pack_idx_opts, pack_data->sha1);
+	tmpfile = write_idx_file(NULL, idx, object_count, &pack_idx_opts, pack->sha1);
 	free(idx);
 	return tmpfile;
 }
 
-static char *keep_pack(const char *curr_index_name)
+static char *keep_pack(struct packed_git *pack, const char *curr_index_name)
 {
 	static char name[PATH_MAX];
 	static const char *keep_msg = "fast-import";
 	int keep_fd;
 
-	keep_fd = odb_pack_keep(name, sizeof(name), pack_data->sha1);
+	keep_fd = odb_pack_keep(name, sizeof(name), pack->sha1);
 	if (keep_fd < 0)
 		die_errno("cannot create keep file");
 	write_or_die(keep_fd, keep_msg, strlen(keep_msg));
@@ -920,12 +920,12 @@ static char *keep_pack(const char *curr_index_name)
 		die_errno("failed to write keep file");
 
 	snprintf(name, sizeof(name), "%s/pack/pack-%s.pack",
-		 get_object_directory(), sha1_to_hex(pack_data->sha1));
-	if (move_temp_to_file(pack_data->pack_name, name))
+		 get_object_directory(), sha1_to_hex(pack->sha1));
+	if (move_temp_to_file(pack->pack_name, name))
 		die("cannot store pack file");
 
 	snprintf(name, sizeof(name), "%s/pack/pack-%s.idx",
-		 get_object_directory(), sha1_to_hex(pack_data->sha1));
+		 get_object_directory(), sha1_to_hex(pack->sha1));
 	if (move_temp_to_file(curr_index_name, name))
 		die("cannot store index file");
 	free((void *)curr_index_name);
@@ -947,8 +947,11 @@ static void unkeep_all_packs(void)
 
 static void end_packfile(void)
 {
+	struct packed_git *old_p = pack_data;
+
 	if (!pack_data)
 		return;
+	pack_data = NULL;
 
 	clear_delta_base_cache();
 	if (object_count) {
@@ -959,13 +962,13 @@ static void end_packfile(void)
 		struct branch *b;
 		struct tag *t;
 
-		close_pack_windows(pack_data);
+		close_pack_windows(old_p);
 		sha1close(pack_file, cur_pack_sha1, 0);
-		fixup_pack_header_footer(pack_data->pack_fd, pack_data->sha1,
-				    pack_data->pack_name, object_count,
+		fixup_pack_header_footer(old_p->pack_fd, old_p->sha1,
+				    old_p->pack_name, object_count,
 				    cur_pack_sha1, pack_size);
-		close(pack_data->pack_fd);
-		idx_name = keep_pack(create_index());
+		close(old_p->pack_fd);
+		idx_name = keep_pack(old_p, create_index(old_p));
 
 		/* Register the packfile with core git's machinery. */
 		new_p = add_packed_git(idx_name, strlen(idx_name), 1);
@@ -994,11 +997,10 @@ static void end_packfile(void)
 		pack_id++;
 	}
 	else {
-		close(pack_data->pack_fd);
-		unlink_or_warn(pack_data->pack_name);
+		close(old_p->pack_fd);
+		unlink_or_warn(old_p->pack_name);
 	}
-	free(pack_data);
-	pack_data = NULL;
+	free(old_p);
 
 	/* We can't carry a delta across packfiles. */
 	strbuf_release(&last_blob.data);
