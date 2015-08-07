From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Question: .idx without .pack causes performance issues?
Date: Fri, 07 Aug 2015 15:27:59 -0700
Message-ID: <xmqqwpx6wx74.fsf@gitster.dls.corp.google.com>
References: <CAEtYS8QWCg5_DtrJw-e+c50vcG0OpciR6LWon-3GgyngGn+0pQ@mail.gmail.com>
	<xmqq4mkxwd77.fsf@gitster.dls.corp.google.com>
	<xmqqzj2puxu2.fsf@gitster.dls.corp.google.com>
	<xmqqtwsxtey8.fsf@gitster.dls.corp.google.com>
	<CAEtYS8QEuEA6d13FH_0_ZbT9YbJ_UdvhkSBYq1xyGCAuznh-GQ@mail.gmail.com>
	<CAEtYS8SNksc0m5rn_tRk8bGLBeq_8QcBLHyHo=cOfZ+aE6n0gA@mail.gmail.com>
	<xmqqk2tb6dxc.fsf@gitster.dls.corp.google.com>
	<CAEtYS8SGnFFHM5BFzAo+Z2BzUGbp47AibA3v6qm_uEboRmfaNQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
To: Doug Kelly <dougk.ff7@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 08 00:28:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZNq7W-0003uQ-Jv
	for gcvg-git-2@plane.gmane.org; Sat, 08 Aug 2015 00:28:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946317AbbHGW2E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Aug 2015 18:28:04 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:33944 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946286AbbHGW2C (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Aug 2015 18:28:02 -0400
Received: by pawu10 with SMTP id u10so97413994paw.1
        for <git@vger.kernel.org>; Fri, 07 Aug 2015 15:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=0Fu0+/J5bpG/BJykRbyqNYlmwBBeBN0ydX0ZsysdeWM=;
        b=e7SFbtrgkjqSUVyhYRZ98QvQn0vqVi6Tp8E8Ww1nONxTUdxe3HhY7UzxhLv5r32nlL
         rx34NgJ4Bpk8fSAmV7/UN9tte/VAt2pUBV5QbC0smgtGW9+c+DX5p6ftPAEQQW8mesa4
         dFvpAeW/ziT2j/XfOl7iBT9wi0WNZYgXXQTODodsDq6sBVYl4Lt+yZ02vHIzJUA6LAt/
         qtTmZ4NEqvSSG8T0UC0uV86oJyMMmnULnzvr+kC48G4jhXjmHoRL9ueAtLtGKQJ5o0Ir
         WqY4XhYoqGLctXwFgUi47xY3VN9lybiSwL686dVMXF3x17bMJDD/ZujCXU7q/WB7L1ZW
         opoA==
X-Received: by 10.69.17.202 with SMTP id gg10mr19101762pbd.15.1438986481205;
        Fri, 07 Aug 2015 15:28:01 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:6597:23b2:a33a:2b5b])
        by smtp.gmail.com with ESMTPSA id w17sm11242930pbt.17.2015.08.07.15.28.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 07 Aug 2015 15:28:00 -0700 (PDT)
Illegal-Object: Syntax error in Cc: address found on vger.kernel.org:
	Cc:	unlisted-recipients:; (no To-header on input)Git List <git@vger.kernel.org>
								     ^-missing end of address
In-Reply-To: <CAEtYS8SGnFFHM5BFzAo+Z2BzUGbp47AibA3v6qm_uEboRmfaNQ@mail.gmail.com>
	(Doug Kelly's message of "Fri, 7 Aug 2015 16:36:34 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275496>

Doug Kelly <dougk.ff7@gmail.com> writes:

> So, I think you're right: prune would need to set report_garbage
> appropriately, then call count-objects to clean that up.  If we wanted
> it to *only* care for lone idx files, we would have to string match on
> the message (seems fragile), but perhaps a more observant approach
> would be to add a custom flag to prune to clean *all* garbage in the
> repository, as passed to report_garbage?  Probably wouldn't want to be
> enabled by default, but only on invocation or with careful
> consideration and setting an appropriate config flag.

I was thinking along this line.

Then you would set "report_garbage" to your own function, call
prepare_packed_git(), and in your report-garbagte function, collect
paths with seen_bits set exactly to PACKDIR_FILE_IDX.  By the time
prepare_packed_git() returns, you would have a list of paths only
with .idx but without .pack, which you can prune.

We can later start pruning other garbage, but one step at a time.

-- >8 --
Subject: prepare_packed_git(): refactor garbage reporting in pack directory

The hook to report "garbage" files in $GIT_OBJECT_DIRECTORY/pack/
could be generic but is too specific to count-object's needs.

Move the part to produce human-readable messages to count-objects,
and refine the interface to callback with the "bits" with values
defined in the cache.h header file, so that other callers (e.g.
prune) can later use the same mechanism to enumerate different
kinds of garbage files and do something intelligent about them,
other than reporting in textual messages.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/count-objects.c | 26 ++++++++++++++++++++++++--
 cache.h                 |  7 +++++--
 path.c                  |  2 +-
 sha1_file.c             | 23 ++++++-----------------
 4 files changed, 36 insertions(+), 22 deletions(-)

diff --git a/builtin/count-objects.c b/builtin/count-objects.c
index ad0c799..4c3198e 100644
--- a/builtin/count-objects.c
+++ b/builtin/count-objects.c
@@ -15,9 +15,31 @@ static int verbose;
 static unsigned long loose, packed, packed_loose;
 static off_t loose_size;
 
-static void real_report_garbage(const char *desc, const char *path)
+const char *bits_to_msg(unsigned seen_bits)
+{
+	switch (seen_bits) {
+	case 0:
+		return "no corresponding .idx or .pack";
+	case PACKDIR_FILE_GARBAGE:
+		return "garbage found";
+	case PACKDIR_FILE_PACK:
+		return "no corresponding .idx";
+	case PACKDIR_FILE_IDX:
+		return "no corresponding .pack";
+	case PACKDIR_FILE_PACK|PACKDIR_FILE_IDX:
+	default:
+		return NULL;
+	}
+}
+
+static void real_report_garbage(unsigned seen_bits, const char *path)
 {
 	struct stat st;
+	const char *desc = bits_to_msg(seen_bits);
+
+	if (!desc)
+		return;
+
 	if (!stat(path, &st))
 		size_garbage += st.st_size;
 	warning("%s: %s", desc, path);
@@ -27,7 +49,7 @@ static void real_report_garbage(const char *desc, const char *path)
 static void loose_garbage(const char *path)
 {
 	if (verbose)
-		report_garbage("garbage found", path);
+		report_garbage(PACKDIR_FILE_GARBAGE, path);
 }
 
 static int count_loose(const unsigned char *sha1, const char *path, void *data)
diff --git a/cache.h b/cache.h
index 6bb7119..2d4dedc 100644
--- a/cache.h
+++ b/cache.h
@@ -1212,8 +1212,11 @@ struct pack_entry {
 
 extern struct packed_git *parse_pack_index(unsigned char *sha1, const char *idx_path);
 
-/* A hook for count-objects to report invalid files in pack directory */
-extern void (*report_garbage)(const char *desc, const char *path);
+/* A hook to report invalid files in pack directory */
+#define PACKDIR_FILE_PACK 1
+#define PACKDIR_FILE_IDX 2
+#define PACKDIR_FILE_GARBAGE 4
+extern void (*report_garbage)(unsigned seen_bits, const char *path);
 
 extern void prepare_packed_git(void);
 extern void reprepare_packed_git(void);
diff --git a/path.c b/path.c
index 10f4cbf..75ec236 100644
--- a/path.c
+++ b/path.c
@@ -143,7 +143,7 @@ void report_linked_checkout_garbage(void)
 		strbuf_setlen(&sb, len);
 		strbuf_addstr(&sb, path);
 		if (file_exists(sb.buf))
-			report_garbage("unused in linked checkout", sb.buf);
+			report_garbage(PACKDIR_FILE_GARBAGE, sb.buf);
 	}
 	strbuf_release(&sb);
 }
diff --git a/sha1_file.c b/sha1_file.c
index 1cee438..0c0b652 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1183,27 +1183,16 @@ void install_packed_git(struct packed_git *pack)
 	packed_git = pack;
 }
 
-void (*report_garbage)(const char *desc, const char *path);
+void (*report_garbage)(unsigned seen_bits, const char *path);
 
 static void report_helper(const struct string_list *list,
 			  int seen_bits, int first, int last)
 {
-	const char *msg;
-	switch (seen_bits) {
-	case 0:
-		msg = "no corresponding .idx or .pack";
-		break;
-	case 1:
-		msg = "no corresponding .idx";
-		break;
-	case 2:
-		msg = "no corresponding .pack";
-		break;
-	default:
+	if (seen_bits == (PACKDIR_FILE_PACK|PACKDIR_FILE_IDX))
 		return;
-	}
+
 	for (; first < last; first++)
-		report_garbage(msg, list->items[first].string);
+		report_garbage(seen_bits, list->items[first].string);
 }
 
 static void report_pack_garbage(struct string_list *list)
@@ -1226,7 +1215,7 @@ static void report_pack_garbage(struct string_list *list)
 		if (baselen == -1) {
 			const char *dot = strrchr(path, '.');
 			if (!dot) {
-				report_garbage("garbage found", path);
+				report_garbage(PACKDIR_FILE_GARBAGE, path);
 				continue;
 			}
 			baselen = dot - path + 1;
@@ -1298,7 +1287,7 @@ static void prepare_packed_git_one(char *objdir, int local)
 		    ends_with(de->d_name, ".keep"))
 			string_list_append(&garbage, path.buf);
 		else
-			report_garbage("garbage found", path.buf);
+			report_garbage(PACKDIR_FILE_GARBAGE, path.buf);
 	}
 	closedir(dir);
 	report_pack_garbage(&garbage);
