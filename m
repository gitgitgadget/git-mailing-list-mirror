From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: regression in  92392b4
Date: Wed, 23 Jul 2008 00:34:03 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807230033000.8986@racer>
References: <20080722231745.GD11831@artemis.madism.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1111573832-1216769644=:8986"
Cc: spearce@spearce.org, Git ML <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Wed Jul 23 01:35:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLRO4-0003oj-TW
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 01:35:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758552AbYGVXeG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2008 19:34:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759272AbYGVXeG
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jul 2008 19:34:06 -0400
Received: from mail.gmx.net ([213.165.64.20]:54931 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757779AbYGVXeD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2008 19:34:03 -0400
Received: (qmail invoked by alias); 22 Jul 2008 23:34:02 -0000
Received: from grape.st-and.ac.uk (EHLO grape.st-and.ac.uk) [138.251.155.28]
  by mail.gmx.net (mp016) with SMTP; 23 Jul 2008 01:34:02 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/o/NFt0RDokIY3/okQUQRjP5Cd818jncyCSjMmI2
	N4ENClNPojc63z
X-X-Sender: gene099@racer
In-Reply-To: <20080722231745.GD11831@artemis.madism.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.46
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89566>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1111573832-1216769644=:8986
Content-Type: TEXT/PLAIN; charset=KOI8-R
Content-Transfer-Encoding: 8BIT

Hi,

On Wed, 23 Jul 2008, Pierre Habouzit wrote:

>   Hi, here is a manual painful down-secting (opposed to a bisect ;P) I
> did, since git in next cannot fetch on a regular basis for me. The
> culprit seems to be commit  92392b4:
> 
>     ‚€(1:11)€€<~/dev/scm/git 92392b4...>€€
>     „[artemis] git fetch
>     remote: Counting objects: 461, done.
>     remote: Compressing objects: 100% (141/141), done.
>     remote: Total 263 (delta 227), reused 155 (delta 121)
>     Receiving objects: 100% (263/263), 95.55 KiB, done.
>     fatal: Out of memory, malloc failed
>     fatal: index-pack failed
>     [2]    16674 abort (core dumped)  git fetch
> 
>     ‚€(1:12)€€<~/dev/scm/git 92392b4...>€€
>     „[artemis] git checkout -m HEAD~1; make git-index-pack
>     Previous HEAD position was 92392b4... index-pack: Honor core.deltaBaseCacheLimit when resolving deltas
>     HEAD is now at 03993e1... index-pack: Track the object_entry that creates each base_data
>     GIT_VERSION = 1.5.6.3.3.g03993
> 	CC index-pack.o
> 	LINK git-index-pack
> 
>     ‚€(1:12)€€<~/dev/scm/git 03993e1...>€€
>     „[artemis] git fetch
>     remote: Counting objects: 461, done.
>     remote: Compressing objects: 100% (141/141), done.
>     remote: Total 263 (delta 227), reused 155 (delta 121)
>     Receiving objects: 100% (263/263), 95.55 KiB, done.
>     Resolving deltas: 100% (227/227), completed with 153 local objects.
>     From git://git.kernel.org/pub/scm/git/git
>        5ba2c22..0868a30  html       -> origin/html
>        2857e17..abeeabe  man        -> origin/man
>        93310a4..95f8ebb  master     -> origin/master
>        559998f..e8bf351  next       -> origin/next
> 
> You can see the commit sha's in the prompt. 03993e1 is fine, 92392b4 is
> broken, I've absolutely no clue about what happens.
> 
> All I can say is that at some point in get_data_from_pack, obj[1].idx
> points to something that is *not* a sha so it's probably corrupted.
> (from index-pack.c).

Just a guess:

-- snipsnap --
[PATCH] index-pack: set base_data's data member to NULL after freeing it

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

 index-pack.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/index-pack.c b/index-pack.c
index ac20a46..19c39e5 100644
--- a/index-pack.c
+++ b/index-pack.c
@@ -257,6 +257,7 @@ static void unlink_base_data(struct base_data *c)
 		base_cache = NULL;
 	if (c->data) {
 		free(c->data);
+		c->data = NULL;
 		base_cache_used -= c->size;
 	}
 }
--8323329-1111573832-1216769644=:8986--
