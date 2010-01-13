From: "Rudolf Polzer" <divVerent@alientrap.org>
Subject: Re: [PATCH] git push --track
Date: Wed, 13 Jan 2010 16:55:20 +0100
Message-ID: <op.u6haiiiog402ra@nb-04>
References: <op.u6g8jnixg402ra@nb-04> <20100113154310.GA7348@Knoppix>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 13 16:55:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NV5ZP-0007Xj-SB
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jan 2010 16:55:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755290Ab0AMPzj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2010 10:55:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755160Ab0AMPzj
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jan 2010 10:55:39 -0500
Received: from lo.gmane.org ([80.91.229.12]:51762 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752823Ab0AMPzi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2010 10:55:38 -0500
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1NV5ZH-0007Sw-Go
	for git@vger.kernel.org; Wed, 13 Jan 2010 16:55:35 +0100
Received: from nathost.tnd.lab.arcor.de ([145.253.194.40])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 13 Jan 2010 16:55:35 +0100
Received: from divVerent by nathost.tnd.lab.arcor.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 13 Jan 2010 16:55:35 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: nathost.tnd.lab.arcor.de
User-Agent: Opera Mail/10.10 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136834>

On Wed, 13 Jan 2010 16:43:10 +0100, Ilari Liusvaara  
<ilari.liusvaara@elisanet.fi> wrote:

> On Wed, Jan 13, 2010 at 04:12:49PM +0100, Rudolf Polzer wrote:
>> Hi,
>>
>> I'd like a feature to automatically "transform" a non-tracking local
>> branch into a tracking branch on push. A patch to do that is
>> attached.
>
> The patches should be sent inline, together with commit messages
> (unless you are asked to resend as attachment because of whitespace
> mangling). Attached patches are very hard to comment on.
>
>> Are there any chances for this getting added to official git - or an
>> alternate convenient way convert a local to a tracking branch?
>
> This is missing sign-off. It can't be included without it.

Of course, but I assume the sign-off would not be by me, but by some of  
the git developers, and would depend on whether they actually want this  
feature.

> Also couple comments:
>
> - Some lines look way too long (~160 chars, should be max 80 unles
> it would linebreak error message).

Yes, also I got told that I used the wrong braces style... well, fixed  
that.

> - Should the tracking be set up even if only part of ref update suceeded
> (for those that succeeded), not requiring all to succeed?

Good point, but I simply see no clean way to set it up for the succeeded  
refs. Would be a nice idea for improvement of this.

> - Is --track the best name for this?

I am assuming this, because this is what git-checkout and git-branch use  
for the same thing.

As I am absolutely not sure if with Opera I can include the file as is, I  
also provided it on http://nopaste.linux-dev.org/?6248 this time.

Best regards,

Rudolf


 From 123598516c7d4e1f83591e8dae64e2c76dc87c90 Mon Sep 17 00:00:00 2001
From: Rudolf Polzer <divVerent@alientrap.org>
Date: Wed, 13 Jan 2010 16:42:04 +0100
Subject: [PATCH 1/2] Add a feature "git push --track" to automatically  
make the pushed branches tracking

---
  builtin-push.c |   33 +++++++++++++++++++++++++++++++++
  transport.h    |    1 +
  2 files changed, 34 insertions(+), 0 deletions(-)

diff --git a/builtin-push.c b/builtin-push.c
index 28a26e7..e5b66a3 100644
--- a/builtin-push.c
+++ b/builtin-push.c
@@ -7,6 +7,7 @@
  #include "builtin.h"
  #include "remote.h"
  #include "transport.h"
+#include "branch.h"
  #include "parse-options.h"

  static const char * const push_usage[] = {
@@ -115,6 +116,36 @@ static int push_with_options(struct transport  
*transport, int flags)
  		fprintf(stderr, "Pushing to %s\n", transport->url);
  	err = transport_push(transport, refspec_nr, refspec, flags,
  			     &nonfastforward);
+	if (err == 0 && flags & TRANSPORT_PUSH_TRACK) {
+		struct ref *remote_refs =
+			transport->get_refs_list(transport, 1);
+		struct ref *local_refs = get_local_heads();
+		int match_flags = 0;
+		if (flags & TRANSPORT_PUSH_ALL)
+			match_flags |= MATCH_REFS_ALL;
+		if (flags & TRANSPORT_PUSH_MIRROR)
+			match_flags |= MATCH_REFS_MIRROR;
+		if(!(flags & TRANSPORT_PUSH_DRY_RUN))
+		if(!match_refs(local_refs, &remote_refs, refspec_nr, refspec,
+					match_flags)) {
+			struct ref *next = remote_refs;
+			while(next) {
+				if(next->peer_ref && *next->peer_ref->name &&
+						*next->name &&
+						next->peer_ref->new_sha1 &&
+						!is_null_sha1(next->peer_ref->new_sha1))
+				{
+					if (!prefixcmp(next->peer_ref->name,
+								"refs/heads/"))
+						install_branch_config(BRANCH_CONFIG_VERBOSE,
+								next->peer_ref->name + 11,
+								transport->remote->name,
+								next->name);
+				}
+				next = next->next;
+			}
+		}
+	}
  	if (err != 0)
  		error("failed to push some refs to '%s'", transport->url);

@@ -218,6 +249,8 @@ int cmd_push(int argc, const char **argv, const char  
*prefix)
  		OPT_BOOLEAN( 0 , "thin", &thin, "use thin pack"),
  		OPT_STRING( 0 , "receive-pack", &receivepack, "receive-pack", "receive  
pack program"),
  		OPT_STRING( 0 , "exec", &receivepack, "receive-pack", "receive pack  
program"),
+		OPT_BIT('t', "track",  &flags, "set up tracking mode (see git-pull(1))",
+			TRANSPORT_PUSH_TRACK),
  		OPT_END()
  	};

diff --git a/transport.h b/transport.h
index 9e74406..8a9c776 100644
--- a/transport.h
+++ b/transport.h
@@ -74,6 +74,7 @@ struct transport {
  #define TRANSPORT_PUSH_VERBOSE 16
  #define TRANSPORT_PUSH_PORCELAIN 32
  #define TRANSPORT_PUSH_QUIET 64
+#define TRANSPORT_PUSH_TRACK 128

  /* Returns a transport suitable for the url */
  struct transport *transport_get(struct remote *, const char *);
-- 
1.6.3.3


 From bbdd185ac43fb789f35d0177697486457af87fd0 Mon Sep 17 00:00:00 2001
From: Rudolf Polzer <divVerent@alientrap.org>
Date: Wed, 13 Jan 2010 16:47:24 +0100
Subject: [PATCH 2/2] tracking into Docs

---
  Documentation/git-push.txt |    8 ++++++++
  1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index e3eb1e8..ebaa67b 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -82,6 +82,14 @@ nor in any Push line of the corresponding remotes  
file---see below).
  	if the configuration option `remote.<remote>.mirror` is
  	set.

+-t::
+--track::
+	When pushing, set up "upstream" configuration. See
+	"--track" in linkgit:git-branch[1] for details. All
+	refspecs that have a branch as source ref will be turned
+	into tracking branches if they are not already, and in any case
+	adjusted to track the given remote and ref on the remote side.
+
  -n::
  --dry-run::
  	Do everything except actually send the updates.
-- 
1.6.3.3
