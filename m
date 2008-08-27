From: robert_no.spam_m@yahoo.fr
Subject: [egit PATCH] avoiding output in the error log
Date: Wed, 27 Aug 2008 09:34:33 +0000 (GMT)
Message-ID: <218798.11648.bm@omp221.mail.ukl.yahoo.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 27 11:36:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYHRF-0002S6-0d
	for gcvg-git-2@gmane.org; Wed, 27 Aug 2008 11:35:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753843AbYH0Jef (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2008 05:34:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753769AbYH0Jef
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Aug 2008 05:34:35 -0400
Received: from n40.bullet.mail.ukl.yahoo.com ([87.248.110.173]:36510 "HELO
	n40.bullet.mail.ukl.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753784AbYH0Jee (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Aug 2008 05:34:34 -0400
Received: from [217.12.4.215] by n40.bullet.mail.ukl.yahoo.com with NNFMP; 27 Aug 2008 09:34:33 -0000
Received: from [87.248.110.116] by t2.bullet.ukl.yahoo.com with NNFMP; 27 Aug 2008 09:34:33 -0000
Received: from [127.0.0.1] by omp221.mail.ukl.yahoo.com with NNFMP; 27 Aug 2008 09:34:33 -0000
X-Yahoo-Newman-Id: 218798.11648.bm@omp221.mail.ukl.yahoo.com
Received: (qmail 40434 invoked from network); 27 Aug 2008 09:34:33 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.fr;
  h=Received:X-YMail-OSG:X-Yahoo-Newman-Property:Subject:From:To;
  b=W15lWt/kjqvCy7T2llfnjpWc9jLb8TNP3OUXf5Ld30S9HZGkUcbhjifLS00TxzdEdtn/rcwVBzB98t9JwYLmQjYqLWkyxe0Ncp+AfA67TyiUUtAUXY2dq1fNRg0LmFVwgCkTBqYjG+0mt56wA7v1+C2L22TuZOkO9vaxz5nIFms=  ;
Received: from unknown (robert_no.spam_m@yahoo.fr@83.156.243.168 with login)
  by smtp147.mail.ukl.yahoo.com with SMTP; 27 Aug 2008 09:34:32 -0000
X-YMail-OSG: yJ29iR0VM1km8YBQDjQqPpNPXg1xyev.xnb68EjRPWiO_KxBqkSghww74.zCYxQ6vLhQMICsA6SWGBdQ_fdCx8TNQypdvaeMc2GyTKiPlrl01B8Nk8ufN0cUCiZ444I-
X-Yahoo-Newman-Property: ymail-3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93881>

Hi,this is a patch for egit. The purpose of the patch
is to avoid a lot of output in the error log.

>From 6f7be5d1a41d356a9b558ac81722e959095ff04d Mon Sep 17 00:00:00 2001
From: robert <robert_no.spam_m@yahoo.fr>
Date: Mon, 25 Aug 2008 20:42:39 +0200
Subject: [PATCH] Checks added to avoid a lot of entries in the log

* IResource.exists() must be checked before calling setProperty on it.
* getActiveDecorator() was returning null in some case.
---
 .../internal/decorators/GitResourceDecorator.java  |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/GitResourceDecorator.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/GitResourceDecorator.java
index 5857eaf..7c10ec6 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/GitResourceDecorator.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/GitResourceDecorator.java
@@ -143,7 +143,9 @@ if (resources.size() > 0)
 					try {
 						m.accept(new IResourceVisitor() {
 							public boolean visit(IResource resource) throws CoreException {
-								getActiveDecorator().clearDecorationState(resource);
+								GitResourceDecorator decorator = getActiveDecorator();
+								if (decorator != null)
+									decorator.clearDecorationState(resource);
 								return true;
 							}
 						},
@@ -197,8 +199,10 @@ synchronized (resources) {
 	} // End ResCL
 
 	void clearDecorationState(IResource r) throws CoreException {
-		r.setSessionProperty(GITFOLDERDIRTYSTATEPROPERTY, null);
-		fireLabelProviderChanged(new LabelProviderChangedEvent(this, r));
+		if (r.exists()) {
+			r.setSessionProperty(GITFOLDERDIRTYSTATEPROPERTY, null);
+			fireLabelProviderChanged(new LabelProviderChangedEvent(this, r));
+		}
 	}
 
 	static ResCL myrescl = new ResCL();
-- 
1.6.0
