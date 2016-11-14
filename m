Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F66E1F858
	for <e@80x24.org>; Mon, 14 Nov 2016 18:31:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935947AbcKNSbF (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Nov 2016 13:31:05 -0500
Received: from homie.mail.dreamhost.com ([208.97.132.208]:36538 "EHLO
        homiemail-a61.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S936239AbcKNSa5 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 14 Nov 2016 13:30:57 -0500
Received: from homiemail-a61.g.dreamhost.com (localhost [127.0.0.1])
        by homiemail-a61.g.dreamhost.com (Postfix) with ESMTP id 2BE1B57807B;
        Mon, 14 Nov 2016 10:30:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=mattmccutchen.net; h=
        in-reply-to:references:from:date:subject:to:cc
        :content-transfer-encoding:message-id:mime-version; s=
        mattmccutchen.net; bh=DyDAZICHpaXwb53ULwnpIF2gloI=; b=kXZRxJPrDL
        IK6ciOelZHJyk50GRvwt76aduAC3OthOkbtFX4x55vFeGecAHnrnpUPjeIiNPiLW
        S5QIp3ErSxbhaNXqQJ9RnIM8dXWoKm4/rZODwsfXJIIDJ3Lo8gJKMZQdR8SnEeRj
        j0DzwPJZ5O46GG4xYeiFpIZdQuCRay5HU=
Received: from main (30-10-119.wireless.csail.mit.edu [128.30.10.119])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: matt@mattmccutchen.net)
        by homiemail-a61.g.dreamhost.com (Postfix) with ESMTPSA id AE965578077;
        Mon, 14 Nov 2016 10:30:56 -0800 (PST)
In-Reply-To: <1479148088.2406.27.camel@mattmccutchen.net>
References: <1479148088.2406.27.camel@mattmccutchen.net>
From:   Matt McCutchen <matt@mattmccutchen.net>
Date:   Mon, 14 Nov 2016 13:20:24 -0500
Subject: [PATCH] doc: mention transfer data leaks in more places
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Content-Transfer-Encoding: 7bit
Message-ID: <1479148255.2406.30.camel@mattmccutchen.net>
Mime-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The "SECURITY" section of the gitnamespaces(7) man page described two
ways for a client to steal data from a server that wasn't intended to be
shared. Similar attacks can be performed by a server on a client, so
adapt the section to cover both directions and add it to the
git-fetch(1), git-pull(1), and git-push(1) man pages. Also add
references to this section from the documentation of server
configuration options that attempt to control data leakage but may not
be fully effective.

Signed-off-by: Matt McCutchen <matt@mattmccutchen.net>
---
 Documentation/config.txt              | 17 ++++++++++++++---
 Documentation/git-fetch.txt           |  2 ++
 Documentation/git-pull.txt            |  2 ++
 Documentation/git-push.txt            |  2 ++
 Documentation/gitnamespaces.txt       | 20 +-------------------
 Documentation/transfer-data-leaks.txt | 30 ++++++++++++++++++++++++++++++
 6 files changed, 51 insertions(+), 22 deletions(-)
 create mode 100644 Documentation/transfer-data-leaks.txt

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 21fdddf..fc2cf83 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2898,6 +2898,11 @@ is omitted from the advertisements but `refs/heads/master` and
 `refs/namespaces/bar/refs/heads/master` are still advertised as so-called
 "have" lines. In order to match refs before stripping, add a `^` in front of
 the ref name. If you combine `!` and `^`, `!` must be specified first.
++
+Even if you hide refs, a client may still be able to steal the target
+objects via the techniques described in the "SECURITY" section of the
+linkgit:gitnamespaces[7] man page; it's best to keep private data in a
+separate repository.
 
 transfer.unpackLimit::
 	When `fetch.unpackLimit` or `receive.unpackLimit` are
@@ -2907,7 +2912,7 @@ transfer.unpackLimit::
 uploadarchive.allowUnreachable::
 	If true, allow clients to use `git archive --remote` to request
 	any tree, whether reachable from the ref tips or not. See the
-	discussion in the `SECURITY` section of
+	discussion in the "SECURITY" section of
 	linkgit:git-upload-archive[1] for more details. Defaults to
 	`false`.
 
@@ -2921,13 +2926,19 @@ uploadpack.allowTipSHA1InWant::
 	When `uploadpack.hideRefs` is in effect, allow `upload-pack`
 	to accept a fetch request that asks for an object at the tip
 	of a hidden ref (by default, such a request is rejected).
-	see also `uploadpack.hideRefs`.
+	See also `uploadpack.hideRefs`.  Even if this is false, a client
+	may be able to steal objects via the techniques described in the
+	"SECURITY" section of the linkgit:gitnamespaces[7] man page; it's
+	best to keep private data in a separate repository.
 
 uploadpack.allowReachableSHA1InWant::
 	Allow `upload-pack` to accept a fetch request that asks for an
 	object that is reachable from any ref tip. However, note that
 	calculating object reachability is computationally expensive.
-	Defaults to `false`.
+	Defaults to `false`.  Even if this is false, a client may be able
+	to steal objects via the techniques described in the "SECURITY"
+	section of the linkgit:gitnamespaces[7] man page; it's best to
+	keep private data in a separate repository.
 
 uploadpack.keepAlive::
 	When `upload-pack` has started `pack-objects`, there may be a
diff --git a/Documentation/git-fetch.txt b/Documentation/git-fetch.txt
index 9e42169..b153aef 100644
--- a/Documentation/git-fetch.txt
+++ b/Documentation/git-fetch.txt
@@ -192,6 +192,8 @@ The first command fetches the `maint` branch from the repository at
 objects will eventually be removed by git's built-in housekeeping (see
 linkgit:git-gc[1]).
 
+include::transfer-data-leaks.txt[]
+
 BUGS
 ----
 Using --recurse-submodules can only fetch new commits in already checked
diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index d033b25..4470e4b 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -237,6 +237,8 @@ If you tried a pull which resulted in complex conflicts and
 would want to start over, you can recover with 'git reset'.
 
 
+include::transfer-data-leaks.txt[]
+
 BUGS
 ----
 Using --recurse-submodules can only fetch new commits in already checked
diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 47b77e6..8eefabd 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -559,6 +559,8 @@ Commits A and B would no longer belong to a branch with a symbolic name,
 and so would be unreachable.  As such, these commits would be removed by
 a `git gc` command on the origin repository.
 
+include::transfer-data-leaks.txt[]
+
 GIT
 ---
 Part of the linkgit:git[1] suite
diff --git a/Documentation/gitnamespaces.txt b/Documentation/gitnamespaces.txt
index 7685e36..b614969 100644
--- a/Documentation/gitnamespaces.txt
+++ b/Documentation/gitnamespaces.txt
@@ -61,22 +61,4 @@ For a simple local test, you can use linkgit:git-remote-ext[1]:
 git clone ext::'git --namespace=foo %s /tmp/prefixed.git'
 ----------
 
-SECURITY
---------
-
-Anyone with access to any namespace within a repository can potentially
-access objects from any other namespace stored in the same repository.
-You can't directly say "give me object ABCD" if you don't have a ref to
-it, but you can do some other sneaky things like:
-
-. Claiming to push ABCD, at which point the server will optimize out the
-  need for you to actually send it. Now you have a ref to ABCD and can
-  fetch it (claiming not to have it, of course).
-
-. Requesting other refs, claiming that you have ABCD, at which point the
-  server may generate deltas against ABCD.
-
-None of this causes a problem if you only host public repositories, or
-if everyone who may read one namespace may also read everything in every
-other namespace (for instance, if everyone in an organization has read
-permission to every repository).
+include::transfer-data-leaks.txt[]
diff --git a/Documentation/transfer-data-leaks.txt b/Documentation/transfer-data-leaks.txt
new file mode 100644
index 0000000..914bacc
--- /dev/null
+++ b/Documentation/transfer-data-leaks.txt
@@ -0,0 +1,30 @@
+SECURITY
+--------
+The fetch and push protocols are not designed to prevent one side from
+stealing data from the other repository that was not intended to be
+shared. If you have private data that you need to protect from a malicious
+peer, your best option is to store it in another repository. This applies
+to both clients and servers. In particular, namespaces on a server are not
+effective for read access control; you should only grant read access to a
+namespace to clients that you would trust with read access to the entire
+repository.
+
+The known attack vectors are as follows:
+
+. The victim sends "have" lines advertising the IDs of objects it has that
+  are not explicitly intended to be shared but can be used to optimize the
+  transfer if the peer also has them. The attacker chooses an object ID X
+  to steal and sends a ref to X, but isn't required to send the content of
+  X because the victim already has it. Now the victim believes that the
+  attacker has X, and it sends the content of X back to the attacker
+  later. (This attack is most straightforward for a client to perform on a
+  server, by creating a ref to X in the namespace the client has access
+  to and then fetching it. The most likely way for a server to perform it
+  on a client is to "merge" X into a public branch and hope that the user
+  does additional work on this branch and pushes it back to the server
+  without noticing the merge.)
+
+. As in #1, the attacker chooses an object ID X to steal. The victim sends
+  an object Y that the attacker already has, and the attacker falsely
+  claims to have X and not Y, so the victim sends Y as a delta against X.
+  The delta reveals regions of X that are similar to Y to the attacker.
-- 
2.7.4


