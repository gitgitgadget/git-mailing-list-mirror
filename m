From: Junio C Hamano <gitster@pobox.com>
Subject: Re* git remote --mirror bug?
Date: Sun, 16 Mar 2008 03:21:30 -0700
Message-ID: <7v1w6bj7f9.fsf_-_@gitster.siamese.dyndns.org>
References: <1205499956.7589.4.camel@gentoo-jocke.transmode.se>
 <1205604534.7589.20.camel@gentoo-jocke.transmode.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: joakim.tjernlund@transmode.se
X-From: git-owner@vger.kernel.org Sun Mar 16 11:22:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jaq0q-0006nC-1D
	for gcvg-git-2@gmane.org; Sun, 16 Mar 2008 11:22:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751077AbYCPKVl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Mar 2008 06:21:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750928AbYCPKVl
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Mar 2008 06:21:41 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:59453 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750758AbYCPKVk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Mar 2008 06:21:40 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id A3DC5271B;
	Sun, 16 Mar 2008 06:21:37 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 798302718; Sun, 16 Mar 2008 06:21:32 -0400 (EDT)
In-Reply-To: <1205604534.7589.20.camel@gentoo-jocke.transmode.se> (Joakim
 Tjernlund's message of "Sat, 15 Mar 2008 19:08:53 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77359>

Joakim Tjernlund <joakim.tjernlund@transmode.se> writes:

>> git remote show os2kernel 
>> * remote os2kernel
>>   URL: /usr/local/src/os2kernel
>> Warning: unrecognized mapping in remotes.os2kernel.fetch: +refs/*:refs/*

This is very unfortunate.  What's more unfortunate is that, adding insult
to injury, "git remote" reimplemented in C gives even worse nonsense:

    $ git remote show git.git
    fatal: * refusing to create funny ref 'refs/stash' locally

This is with my test repository sitting next to my primary git.git
repository with config entries like this:

    [remote "git.git"]
        url = ../git.git/
        fetch = refs/*:refs/*

The thing is that we obviously are _not_ attempting to create anything
when we say "git remote show".

Now, it happens that "stash" is purely a local matter, and propagating it
with fetch (even with mirroring) may not make much sense.  Even if the
mirroring is for backup purposes, its value is dubious (if you are backing
up because you are afraid of disk failure, you should back up properly
with disk back-up tools).

So in that sense, it could be argued that it is Ok not to propagate
refs/stash and that was partly the reason why we create the "stash" ref
directly underneath refs/ namespace.  Everything else that is propagatable
has at least two level refnames, e.g. heads/master, tags/v1.5.0, and the
plumbing layer has a way to enforce this, and "git remote" uses it.

But that is not an excuse to fail "git fetch" (which is the underlying
mechanism "git remote" uses).

I think this patch may work the issue around for recent enough git, but
I have to say that this is an interim fix.  With this, now you get a less
nonsense output, but it still is nonsense nevertheless:

    $ git remote show git.git
    * remote git.git
      URL: ../git.git/
      New remote branch (next fetch will store in remotes/git.git)
        refs/stash
      Tracked remote branches
        ar/sgid-bsd cb/mergetool cc/help cr/reset-parseopt db/diff...

Notice that it talks about storing refs/stash in remotes/git.git?

It won't, and it shouldn't, as we told it to mirror refs/stash to
refs/stash.

As a side note, I think remote, when doing "show" that does _not_ update
the local side of tracking refs, should tweak the error behaviour that it
can trigger when it calls get_fetch_map().  The callee may have originally
been written for "fetch" and had a hardcoded "we are fetching and storing,
so our behaviour when seeing a funny ref is to error out with "refusing to
create" message and that is fine" mentality.  Calling such a function when
it is not actually fetching, without modifying the callee's assumption to
suit the error behaviour for its needs, is sloppy and needs to be fixed.

The scripted version if git-parse-remote, which is being phased out (it
still is used somewhat by git-pull and git-clone) has similar logic to
parse fetch refspec mapping, but it does not understand the mirroring
layout (refs/*:refs/*) as you saw, so it fails way before it triggers
these issues.  What the C reimplementation does (or at least tries to do)
is an improvement in that sense, but because it is relatively a new
feature, bugs in there are to be expected.

We are going into 1.5.5-rc feature freeze tonight, and squashing these
bugs now are of the highest priority.  Please keep the bug reports and
fixes flowing.

Thanks.

---

 builtin-check-ref-format.c |    2 +-
 git-parse-remote.sh        |    9 +++++++--
 remote.c                   |   16 +++++++++++++---
 3 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/builtin-check-ref-format.c b/builtin-check-ref-format.c
index fe04be7..e2b4eef 100644
--- a/builtin-check-ref-format.c
+++ b/builtin-check-ref-format.c
@@ -10,5 +10,5 @@ int cmd_check_ref_format(int argc, const char **argv, const char *prefix)
 {
 	if (argc != 2)
 		usage("git-check-ref-format refname");
-	return !!check_ref_format(argv[1]);
+	return (-check_ref_format(argv[1]));
 }
diff --git a/git-parse-remote.sh b/git-parse-remote.sh
index 695a409..19d00e7 100755
--- a/git-parse-remote.sh
+++ b/git-parse-remote.sh
@@ -156,8 +156,13 @@ canon_refs_list_for_fetch () {
 
 		if local_ref_name=$(expr "z$local" : 'zrefs/\(.*\)')
 		then
-		   git check-ref-format "$local_ref_name" ||
-		   die "* refusing to create funny ref '$local_ref_name' locally"
+		   git check-ref-format "$local_ref_name"
+		   case "$?" in
+		   0 | 2) ;;
+		   *)
+			die "* refusing to create funny ref '$local_ref_name' locally"
+			;;
+		   esac
 		fi
 		echo "${dot_prefix}${force}${remote}:${local}"
 	done
diff --git a/remote.c b/remote.c
index f3f7375..6a95b1e 100644
--- a/remote.c
+++ b/remote.c
@@ -1007,9 +1007,19 @@ int get_fetch_map(const struct ref *remote_refs,
 	}
 
 	for (rm = ref_map; rm; rm = rm->next) {
-		if (rm->peer_ref && check_ref_format(rm->peer_ref->name + 5))
-			die("* refusing to create funny ref '%s' locally",
-			    rm->peer_ref->name);
+		if (rm->peer_ref) {
+			switch (check_ref_format(rm->peer_ref->name + 5)) {
+			default:
+				die("* refusing to create funny ref '%s' locally",
+				    rm->peer_ref->name);
+				break;
+			case CHECK_REF_FORMAT_ONELEVEL:
+				/* allow "refs/stash" to be propagated */
+				break;
+			case CHECK_REF_FORMAT_OK:
+				break;
+			}
+		}
 	}
 
 	if (ref_map)
