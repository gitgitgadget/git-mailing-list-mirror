From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] objects to be pruned immediately don't have to be loosened
Date: Mon, 15 Dec 2008 12:38:02 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0812151105100.30035@xanadu.home>
References: <808wqhzjl9.fsf@tiny.isode.net>
 <237967ef0812150538n671c22b8gaf7a7b5dcaf68433@mail.gmail.com>
 <20081215140834.GA3684@atjola.homenet> <20081215155610.GA11502@mit.edu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_ulwPNNYWRvZmlVXv2XHHQA)"
Cc: =?ISO-8859-15?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>,
	Mikael Magnusson <mikachu@gmail.com>,
	Bruce Stephens <bruce.stephens@isode.com>, git@vger.kernel.org
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Mon Dec 15 18:40:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCHPs-000287-4K
	for gcvg-git-2@gmane.org; Mon, 15 Dec 2008 18:39:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755219AbYLORiM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Dec 2008 12:38:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755156AbYLORiL
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Dec 2008 12:38:11 -0500
Received: from relais.videotron.ca ([24.201.245.36]:64462 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755081AbYLORiK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Dec 2008 12:38:10 -0500
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KBX00AJHIBEZ7A0@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 15 Dec 2008 12:38:02 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <20081215155610.GA11502@mit.edu>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Content-id: <alpine.LFD.2.00.0812151230560.30035@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103189>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_ulwPNNYWRvZmlVXv2XHHQA)
Content-id: <alpine.LFD.2.00.0812151230561.30035@xanadu.home>
Content-type: TEXT/PLAIN; CHARSET=ISO-8859-15
Content-transfer-encoding: 8BIT


When there is no grace period before pruning unreferenced objects, it is 
pointless to push those objects in their loose form just to delete them 
right away.

Also be more explicit about the possibility of using "now" in the 
gc.pruneexpire config variable (needed for the above behavior to 
happen).

Signed-off-by: Nicolas Pitre <nico@cam.org>
---

On Mon, 15 Dec 2008, Theodore Tso wrote:

> On Mon, Dec 15, 2008 at 03:08:34PM +0100, Björn Steinbrink wrote:
> > To clarify that a bit more: git gc keeps unreachable objects unpacked,
> > so that git prune can drop them. And git gc invokes git prune so that
> > only unreachable objects older than 2 weeks are dropped.
> 
> To be even more explicit, "git gc" will **unpack** objects that have
> become unreachable and were currently in packs.  As a result, the
> amount of disk space used by a git repository can actually go **up**
> dramatically after a "git gc" operation, which could be surprising for
> someone who is running close to full on their filesystem, deletes a
> number of branches from a tracking repository, and then does a "git
> gc" may get a very unpleasant surprise.
> 
> A really good repository which shows this is linux-next, since it is
> constantly getting rewound, and old branches are reserved via a tag
> such as next-20081204.  If you update the your local copy of the
> linux-next repository every day, you will accumulate a large number of
> these old branch tags.  If you then delete a whole series of them, and
> run git-gc, the operation will take quite a while, and the number of
> blocks and inodes used will grow significantly.  They will disappear
> after a "git prune", but when I do this housekeeping operation, I've
> often wished for a --yes-I-know-what-I-am-doing-and-it's-unsafe-but-
> just-drop-the-unreachable-objects-cause-this-is-just-a-tracking-repository
> option to "git gc".

What about this?

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 21ea165..ca45e71 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -702,7 +702,9 @@ gc.packrefs::
 
 gc.pruneexpire::
 	When 'git-gc' is run, it will call 'prune --expire 2.weeks.ago'.
-	Override the grace period with this config variable.
+	Override the grace period with this config variable.  The value
+	"now" may be used to disable this  grace period and always prune
+	unreachable objects immediately.
 
 gc.reflogexpire::
 	'git-reflog expire' removes reflog entries older than
diff --git a/builtin-gc.c b/builtin-gc.c
index 781df60..f8eae4a 100644
--- a/builtin-gc.c
+++ b/builtin-gc.c
@@ -188,7 +188,9 @@ static int need_to_gc(void)
 	 * there is no need.
 	 */
 	if (too_many_packs())
-		append_option(argv_repack, "-A", MAX_ADD);
+		append_option(argv_repack,
+			      !strcmp(prune_expire, "now") ? "-a" : "-A",
+			      MAX_ADD);
 	else if (!too_many_loose_objects())
 		return 0;
 
@@ -243,7 +245,9 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 			"run \"git gc\" manually. See "
 			"\"git help gc\" for more information.\n");
 	} else
-		append_option(argv_repack, "-A", MAX_ADD);
+		append_option(argv_repack,
+			      !strcmp(prune_expire, "now") ? "-a" : "-A",
+			      MAX_ADD);
 
 	if (pack_refs && run_command_v_opt(argv_pack_refs, RUN_GIT_CMD))
 		return error(FAILED_RUN, argv_pack_refs[0]);

--Boundary_(ID_ulwPNNYWRvZmlVXv2XHHQA)--
