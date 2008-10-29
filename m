From: Jeff King <peff@peff.net>
Subject: a few git notes numbers
Date: Wed, 29 Oct 2008 17:40:04 -0400
Message-ID: <20081029214003.GA19458@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Oct 29 22:41:37 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvIn9-0007hu-3r
	for gcvg-git-2@gmane.org; Wed, 29 Oct 2008 22:41:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755634AbYJ2VkL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Oct 2008 17:40:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755625AbYJ2VkL
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Oct 2008 17:40:11 -0400
Received: from peff.net ([208.65.91.99]:2044 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755266AbYJ2VkJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Oct 2008 17:40:09 -0400
Received: (qmail 31304 invoked by uid 111); 29 Oct 2008 21:40:07 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (216.239.45.19)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Wed, 29 Oct 2008 17:40:07 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 29 Oct 2008 17:40:04 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99415>

I looked a little bit at how bad tree lookup speed would be for notes.

My test implementation was a notes tree made like this:

 blob=`echo this is a note | git hash-object -w --stdin`
 export GIT_INDEX_FILE=.git/notes
 # attach the note to every commit;
 # note that this uses a less-efficient ascii encoding
 git rev-list HEAD | while read commit; do
   echo -e "100644 blob $blob\t$commit"
 done | git update-index --index-info
 tree=`git write-tree`
 commit=`echo notes | git commit-tree $tree`
 git update-ref refs/notes $tree

Then I added a %N format specifier that looked up the note in the
refs/notes tree for every commit. For a baseline, here is just looking
at the subject of a commit message:

   /usr/bin/time git log --pretty=format:'%s' >/dev/null
   0.57user 0.00system 0:00.58elapsed 100%CPU (0avgtext+0avgdata 0maxresident)k
   0inputs+0outputs (0major+3497minor)pagefaults 0swaps

So it takes about half a second without notes. When I used the regular
init_tree_desc() and tree_entry() walk, that bumped to about 37 seconds
(sorry, I didn't save the /usr/bin/time output). Converting the stupid
ascii filename format to binary brought it down to 27 seconds. So both
obviously crappy due to the linear walk.

Then at somebody (David Reiss?)'s suggestion, I used our hash table
implementation and pre-seeded the table. I kept with the ascii
filenames in the tree, since they are a little easier to create, and
since we only pay the price for conversion when seeding the hash table.
And I got these numbers:

  $ /usr/bin/time git log --pretty=format:'%s: %N' >/dev/null
  0.85user 0.12system 0:00.98elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
  0inputs+0outputs (0major+20914minor)pagefaults 0swaps

So not too bad, though check out those minor page faults. Patch is
below:

---
diff --git a/pretty.c b/pretty.c
index f6ff312..c4930ac 100644
--- a/pretty.c
+++ b/pretty.c
@@ -498,6 +498,67 @@ static void format_decoration(struct strbuf *sb, const struct commit *commit)
 		strbuf_addch(sb, ')');
 }
 
+struct note_entry {
+	unsigned char from[20];
+	unsigned char to[20];
+	struct note_entry *next;
+};
+
+static struct hash_table *notes_tree(void)
+{
+	static int initialized;
+	static struct hash_table table;
+
+	if (!initialized) {
+		unsigned char sha1[20];
+		struct tree *tree;
+		struct tree_desc desc;
+		struct name_entry entry;
+
+		init_hash(&table);
+		if(get_sha1("refs/notes", sha1) == 0)
+			tree = parse_tree_indirect(sha1);
+		init_tree_desc(&desc, tree->buffer, tree->size);
+		while (tree_entry(&desc, &entry)) {
+			struct note_entry *note;
+			unsigned int hash;
+			void **pos;
+
+			note = malloc(sizeof *note);
+			if (get_sha1_hex(entry.path, note->from) < 0) {
+				free(note);
+				continue;
+			}
+			memcpy(note->to, entry.sha1, 20);
+			memcpy(&hash, note->from, sizeof(hash));
+			pos = insert_hash(hash, note, &table);
+			if (pos) {
+				note->next = *pos;
+				*pos = note;
+			}
+		}
+
+		initialized = 1;
+	}
+	return &table;
+}
+
+static char *lookup_note(const unsigned char *sha1, unsigned long *size) {
+	struct hash_table *table = notes_tree();
+	struct note_entry *note;
+	unsigned int hash;
+
+	memcpy(&hash, sha1, sizeof(hash));
+	note = lookup_hash(hash, table);
+	while (note) {
+		if (!memcmp(sha1, note->from, 20)) {
+			enum object_type type;
+			return read_sha1_file(note->to, &type, size);
+		}
+	}
+	return NULL;
+}
+
 static size_t format_commit_item(struct strbuf *sb, const char *placeholder,
                                void *context)
 {
@@ -537,6 +598,17 @@ static size_t format_commit_item(struct strbuf *sb, const char *placeholder,
 			return 3;
 		} else
 			return 0;
+	case 'N':
+		{
+			unsigned long size;
+			char *buf;
+			buf = lookup_note(commit->object.sha1, &size);
+			if (buf) {
+				strbuf_add(sb, buf, size);
+				free(buf);
+			}
+		}
+		return 1;
 	}
 
 	/* these depend on the commit */
