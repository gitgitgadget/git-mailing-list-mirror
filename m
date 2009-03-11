From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [BUG] - git-read-tree segfaults
Date: Wed, 11 Mar 2009 13:04:15 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903111300330.10279@pacific.mpi-cbg.de>
References: <35476bd20903101234q71bc520fh18828d7170a4a2f5@mail.gmail.com>  <alpine.DEB.1.00.0903102120290.14295@intel-tinevez-2-302> <35476bd20903110059v7d6d8aa0g93af17a940c91919@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-911060519-1236773055=:10279"
Cc: git@vger.kernel.org
To: Jiri Olsa <olsajiri@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 11 13:04:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhNAN-0002yX-GB
	for gcvg-git-2@gmane.org; Wed, 11 Mar 2009 13:04:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755152AbZCKMCi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Mar 2009 08:02:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755135AbZCKMCh
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Mar 2009 08:02:37 -0400
Received: from mail.gmx.net ([213.165.64.20]:41758 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755031AbZCKMCg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Mar 2009 08:02:36 -0400
Received: (qmail invoked by alias); 11 Mar 2009 12:02:33 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp007) with SMTP; 11 Mar 2009 13:02:33 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/0HDdlzIr0WEp8/7LiJ7fqCdD6kKSVPtgROmRDWy
	sl2prfrBvtxhRw
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <35476bd20903110059v7d6d8aa0g93af17a940c91919@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.52
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112915>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-911060519-1236773055=:10279
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

On Wed, 11 Mar 2009, Jiri Olsa wrote:

> On Tue, Mar 10, 2009 at 9:21 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
>
> > On Tue, 10 Mar 2009, Jiri Olsa wrote:
> >
> >> mb=$($GIT merge-base HEAD yyy)
> >> $GIT read-tree $mb HEAD yyy
> >
> > While I agree that it is a bad thing for Git to segfault, I think this 
> > here is a pilot error.  You try to read 3 trees at the same time, but 
> > not perform a merge.  IMHO you want to add -m at least.
> 
> agreed, I've already said I executed it like this by an accident...

Hey, you did the right thing!  And you even provided a script to recreate, 
so that it was really easy to see what is happening.

> it was easy to recreate so I shared... I'm not saying it is a show 
> stopper :)

Well, Git should not crash.  But read-tree is real low-level, so I am 
torn.  OTOH, something like this may be the correct thing to do:

-- snipsnap --
Subject: [PATCH] Make read-tree with multiple trees imply -m

Noticed by Jiri Olsa.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

 builtin-read-tree.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/builtin-read-tree.c b/builtin-read-tree.c
index 8e02738..547ac25 100644
--- a/builtin-read-tree.c
+++ b/builtin-read-tree.c
@@ -221,6 +221,11 @@ int cmd_read_tree(int argc, const char **argv, const char *unused_prefix)
 			opts.head_idx = 1;
 	}
 
+	if (nr_trees > 1 && !o->merge) {
+		warning("Assuming -m with multiple trees");
+		o->merge = 1;
+	}
+
 	for (i = 0; i < nr_trees; i++) {
 		struct tree *tree = trees[i];
 		parse_tree(tree);
--8323328-911060519-1236773055=:10279--
