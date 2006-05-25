From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [RFC][PATCH] Allow transfer of any valid sha1
Date: Thu, 25 May 2006 14:30:58 -0600
Message-ID: <m13bexetj1.fsf@ebiederm.dsl.xmission.com>
References: <m164jvj1x3.fsf@ebiederm.dsl.xmission.com>
	<7vejyjpz9a.fsf@assigned-by-dhcp.cox.net>
	<m13beysnb2.fsf@ebiederm.dsl.xmission.com>
	<7vwtcay5k8.fsf@assigned-by-dhcp.cox.net>
	<m1lksqdook.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.64.0605251024320.5623@g5.osdl.org>
	<7v3beyuffg.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0605251134410.5623@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	"Eric W. Biederman" <ebiederm@xmission.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 25 22:32:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FjMV2-0006iy-5w
	for gcvg-git@gmane.org; Thu, 25 May 2006 22:32:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030378AbWEYUcA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 May 2006 16:32:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030403AbWEYUcA
	(ORCPT <rfc822;git-outgoing>); Thu, 25 May 2006 16:32:00 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:1698 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1030378AbWEYUb7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 May 2006 16:31:59 -0400
Received: from ebiederm.dsl.xmission.com (localhost [127.0.0.1])
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Debian-3) with ESMTP id k4PKUxp2012079;
	Thu, 25 May 2006 14:30:59 -0600
Received: (from eric@localhost)
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Submit) id k4PKUwZW012078;
	Thu, 25 May 2006 14:30:58 -0600
X-Authentication-Warning: ebiederm.dsl.xmission.com: eric set sender to ebiederm@xmission.com using -f
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0605251134410.5623@g5.osdl.org> (Linus
 Torvalds's message of "Thu, 25 May 2006 11:36:16 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20761>

Linus Torvalds <torvalds@osdl.org> writes:

> On Thu, 25 May 2006, Junio C Hamano wrote:
>> 
>> With the limitation of the current tool, we could do:
>> 
>>   git-fetch master.kernel.org:/pub/scm/.../torvalds/linux-2.6.git \
>> 	refs/heads/master:refs/remotes/linus/master
>>   git merge 'whatever merge message' HEAD b307e854
>> 
>> assuming that b307e854 is reachable from your tip.  So it might
>> be just a matter of giving a convenient shorthand to do the
>> above two commands, instead of mucking with upload-pack.
>
> It's not upload-pack that needs mucking with. It's simply "fetch-pack" 
> that currently will refuse to say "want b307e854..", because the only 
> thing it can do is say "want <headref>".
>
> So the patch would literally be to have a way to tell fetch-pack directly 
> what you want, and not have the "only select from remote branches" logic.

So fixing fetch-pack is easy and pretty non-controversial.
The patch below handles that.

The problem is that I then run into the limitations in upload-pack.

(The movement of filter_refs may actually be overkill)

Eric



diff --git a/fetch-pack.c b/fetch-pack.c
index a3bcad0..c767d84 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -260,6 +260,27 @@ static void mark_recent_complete_commits
 	}
 }
 
+static struct ref **get_sha1_heads(struct ref **refs, int nr_heads, char **head)
+{
+	int i;
+	for (i  = 0; i < nr_heads; i++) {
+		struct ref *ref;
+		unsigned char sha1[20];
+		char *s = head[i];
+		int len = strlen(s);
+
+		if (len != 40 || get_sha1_hex(s, sha1))
+			continue;
+
+		ref = xcalloc(1, sizeof(*ref) + len + 1);
+		memcpy(ref->old_sha1, sha1, 20);
+		memcpy(ref->name, s, len + 1);
+		*refs = ref;
+		refs = &ref->next;
+	}
+	return refs;
+}
+
 static void filter_refs(struct ref **refs, int nr_match, char **match)
 {
 	struct ref *prev, *current, *next;
@@ -311,6 +332,8 @@ static int everything_local(struct ref *
 	if (cutoff)
 		mark_recent_complete_commits(cutoff);
 
+	filter_refs(refs, nr_match, match);
+
 	/*
 	 * Mark all complete remote refs as common refs.
 	 * Don't mark them common yet; the server has to be told so first.
@@ -329,8 +352,6 @@ static int everything_local(struct ref *
 		}
 	}
 
-	filter_refs(refs, nr_match, match);
-
 	for (retval = 1, ref = *refs; ref ; ref = ref->next) {
 		const unsigned char *remote = ref->old_sha1;
 		unsigned char local[20];
@@ -373,6 +394,7 @@ static int fetch_pack(int fd[2], int nr_
 		packet_flush(fd[1]);
 		die("no matching remote head");
 	}
+	get_sha1_heads(&ref, nr_match, match);
 	if (everything_local(&ref, nr_match, match)) {
 		packet_flush(fd[1]);
 		goto all_done;
diff --git a/git-parse-remote.sh b/git-parse-remote.sh
index 187f088..2372df8 100755
--- a/git-parse-remote.sh
+++ b/git-parse-remote.sh
@@ -105,6 +105,7 @@ canon_refs_list_for_fetch () {
 		'') remote=HEAD ;;
 		refs/heads/* | refs/tags/* | refs/remotes/*) ;;
 		heads/* | tags/* | remotes/* ) remote="refs/$remote" ;;
+		[0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F]) ;;
 		*) remote="refs/heads/$remote" ;;
 		esac
 		case "$local" in
