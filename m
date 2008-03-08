From: Junio C Hamano <junio@pobox.com>
Subject: Re: [PATCH/RFC] Make "git remote rm <remote>" remove file
 refs/remotes/<remote>/HEAD
Date: Fri, 07 Mar 2008 17:46:28 -0800
Message-ID: <7vlk4uyoln.fsf@gitster.siamese.dyndns.org>
References: <200803051338.44938.tlikonen@iki.fi>
 <1204923732-29141-1-git-send-email-tlikonen@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Teemu Likonen <tlikonen@iki.fi>
X-From: git-owner@vger.kernel.org Sat Mar 08 02:47:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXoAB-0004Rd-IG
	for gcvg-git-2@gmane.org; Sat, 08 Mar 2008 02:47:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753995AbYCHBqo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Mar 2008 20:46:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753964AbYCHBqo
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Mar 2008 20:46:44 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:46883 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752148AbYCHBqn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Mar 2008 20:46:43 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 167E71C7A;
	Fri,  7 Mar 2008 20:46:42 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 2335C1C79; Fri,  7 Mar 2008 20:46:37 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76538>

Junio C Hamano <gitster@pobox.com> writes:

> I think "update-ref -d" should remove the ref without dereferencing
> anyway.  How about not doing your patch at all (you would need to manually
> remove the symref in "prune" codepath as well), and instead doing this?
>
> I do not know how this reacts when the tracked HEAD points at a ref that
> lexicographically sorts earlier, say branch "A".

And it turns out it does not react very well.  You would want to do
something like this on top of that one.

-- >8 --
"remote rm": first remove symbolic and then real refs

This teaches a new %(reftype) to for-each-ref that returns "symref",
"packed", or "plain" (we never pack symrefs, so this is the complete
enumeration), and updates "git remote rm" to first remove the symrefs and
then the actual refs.

Signed-off-by: Junio C Hamano <junio@pobox.com>
---

 builtin-for-each-ref.c |   13 +++++++++++++
 git-remote.perl        |   14 ++++++++++++--
 2 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/builtin-for-each-ref.c b/builtin-for-each-ref.c
index 07d9c57..50e9eed 100644
--- a/builtin-for-each-ref.c
+++ b/builtin-for-each-ref.c
@@ -31,6 +31,7 @@ struct ref_sort {
 
 struct refinfo {
 	char *refname;
+	int reftype;
 	unsigned char objectname[20];
 	struct atom_value *value;
 };
@@ -40,6 +41,7 @@ static struct {
 	cmp_type cmp_type;
 } valid_atom[] = {
 	{ "refname" },
+	{ "reftype" },
 	{ "objecttype" },
 	{ "objectsize", FIELD_ULONG },
 	{ "objectname" },
@@ -568,6 +570,16 @@ static void populate_value(struct refinfo *ref)
 			char *s = xmalloc(len + 4);
 			sprintf(s, "%s^{}", ref->refname);
 			v->s = s;
+		} else if (!strcmp(name, "reftype")) {
+			char *s = xmalloc(20);
+			/* We do not pack symrefs */
+			if (ref->reftype & REF_ISSYMREF)
+				strcpy(s, "symref");
+			else if (ref->reftype & REF_ISPACKED)
+				strcpy(s, "packed");
+			else
+				strcpy(s, "plain");
+			v->s = s;
 		}
 	}
 
@@ -658,6 +670,7 @@ static int grab_single_ref(const char *refname, const unsigned char *sha1, int f
 	 */
 	ref = xcalloc(1, sizeof(*ref));
 	ref->refname = xstrdup(refname);
+	ref->reftype = flag;
 	hashcpy(ref->objectname, sha1);
 
 	cnt = cb->grab_cnt;
diff --git a/git-remote.perl b/git-remote.perl
index b30ed73..c57e29d 100755
--- a/git-remote.perl
+++ b/git-remote.perl
@@ -341,9 +341,19 @@ sub rm_remote {
 	};
 
 	my @refs = $git->command('for-each-ref',
-		'--format=%(refname) %(objectname)', "refs/remotes/$name");
+				 '--format=%(refname) %(reftype) %(objectname)',
+				 "refs/remotes/$name");
+	my @nonsym = ();
 	for (@refs) {
-		my ($ref, $object) = split;
+		my ($ref, $type, $object) = split;
+		if ($type !~ /symref/) {
+			push @nonsym, $_;
+		} else {
+			$git->command(qw(update-ref -d), $ref, $object);
+		}
+	}
+	for (@nonsym) {
+		my ($ref, $type, $object) = split;
 		$git->command(qw(update-ref -d), $ref, $object);
 	}
 	return 0;

