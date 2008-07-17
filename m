From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [RFC PATCH] index-pack: Issue a warning if deltaBaseCacheLimit is
	too small
Date: Thu, 17 Jul 2008 22:02:51 +0000
Message-ID: <20080717220251.GA3072@spearce.org>
References: <20080717213550.GA2798@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Andreas Ericsson <ae@op5.se>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>,
	Stephan Hennig <mailing_list@arcor.de>
X-From: git-owner@vger.kernel.org Fri Jul 18 00:03:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJbZq-0000qW-0B
	for gcvg-git-2@gmane.org; Fri, 18 Jul 2008 00:03:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754793AbYGQWCx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jul 2008 18:02:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754770AbYGQWCw
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jul 2008 18:02:52 -0400
Received: from george.spearce.org ([209.20.77.23]:43754 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754513AbYGQWCw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2008 18:02:52 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 7D535382A4; Thu, 17 Jul 2008 22:02:51 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20080717213550.GA2798@spearce.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88928>

Its rare that we should exceed deltaBaseCacheLimit while resolving
delta compressed objects.  By default this limit is 16M, and most
chains are under 50 objects in length.  This affords about 327K per
object in the chain, which is quite large by source code standards.

If we have to recreate a prior delta base because we evicted it to
stay within the deltaBaseCacheLimit we can warn the user that their
configured limit is perhaps too low for this repository data set.
If the user keeps seeing the warning they can research it in the
documentation, and consider setting it higher on this repository,
or just globally on their system.

Suggested-by: Stephan Hennig <mailing_list@arcor.de>
Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 index-pack.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/index-pack.c b/index-pack.c
index ac20a46..97533d6 100644
--- a/index-pack.c
+++ b/index-pack.c
@@ -53,6 +53,7 @@ static struct object_entry *objects;
 static struct delta_entry *deltas;
 static struct base_data *base_cache;
 static size_t base_cache_used;
+static int oom_warning;
 static int nr_objects;
 static int nr_deltas;
 static int nr_resolved_deltas;
@@ -481,6 +482,13 @@ static void *get_base_data(struct base_data *c)
 	if (!c->data) {
 		struct object_entry *obj = c->obj;
 
+		if (!oom_warning && verbose) {
+			if (progress)
+				fputc('\n', stderr);
+			warning("One or more delta chains are larger than deltaBaseCache.");
+			oom_warning = 1;
+		}
+
 		if (obj->type == OBJ_REF_DELTA || obj->type == OBJ_OFS_DELTA) {
 			void *base = get_base_data(c->base);
 			void *raw = get_data_from_pack(obj);
-- 
1.5.6.3.569.ga9185
