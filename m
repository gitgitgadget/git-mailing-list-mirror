From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: [PATCH QGit RFC] Fix "Save patch..." on a commit range
Date: Tue, 16 Jun 2009 01:44:01 +0200
Message-ID: <200906160144.02320.markus.heidelberg@web.de>
References: <1244849357-31166-1-git-send-email-markus.heidelberg@web.de> <e5bfff550906151425p2dacdcdasbae09af4ce34813d@mail.gmail.com> <e5bfff550906151445m2f38c3fw964e01251d9568b9@mail.gmail.com>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 16 01:44:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MGLqY-00020B-Mq
	for gcvg-git-2@gmane.org; Tue, 16 Jun 2009 01:44:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751501AbZFOXoE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jun 2009 19:44:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751372AbZFOXoC
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Jun 2009 19:44:02 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:51618 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751179AbZFOXoB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jun 2009 19:44:01 -0400
Received: from smtp08.web.de (fmsmtp08.dlan.cinetic.de [172.20.5.216])
	by fmmailgate02.web.de (Postfix) with ESMTP id A6D861038B16A;
	Tue, 16 Jun 2009 01:44:00 +0200 (CEST)
Received: from [89.59.70.41] (helo=.)
	by smtp08.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1MGLqK-0005OC-00; Tue, 16 Jun 2009 01:44:00 +0200
User-Agent: KMail/1.9.9
In-Reply-To: <e5bfff550906151445m2f38c3fw964e01251d9568b9@mail.gmail.com>
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX19fwHgVMbyDTwFdAdrCuBR8SrZPs4dSUIR/4QSO
	FKn3/s0Rb2f5MpUEtC7iA3X6Buvt+U/M6AZHOmZGTOyPT5TC00
	aqnoJ0i8viKtzHWUaTrw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121639>

Marco Costalba, 15.06.2009:
> So you could check, in ListView::getSelectedItems() how the rows are returned.

I added this snippet:

-->8--

diff --git a/src/listview.cpp b/src/listview.cpp
index b2f4915..5bd1ee6 100644
--- a/src/listview.cpp
+++ b/src/listview.cpp
@@ -171,10 +171,12 @@ void ListView::showIdValues() {
 	viewport()->update();
 }
 
+#include <QtDebug>
 void ListView::getSelectedItems(QStringList& selectedItems) {
 
 	selectedItems.clear();
 	QModelIndexList ml = selectionModel()->selectedRows();
+	qDebug() << ml;
 	FOREACH (QModelIndexList, it, ml)
 		selectedItems.append(sha((*it).row()));
 }

--8<--

and got the following for the 4 commits around v1.6.3 in git.git when
enabled "All branches" (output prettified, was one line):

(QModelIndex(2554,0,0x0,FileHistory(0xa06bfe8) )  ,
 QModelIndex(2553,0,0x0,FileHistory(0xa06bfe8) )  ,
 QModelIndex(2552,0,0x0,FileHistory(0xa06bfe8) )  ,
 QModelIndex(2551,0,0x0,FileHistory(0xa06bfe8) )  )

Here it is ordered from oldest to newest. The newest commit (HEAD or
working tree) has '0'.

The same with "All branches" unchecked, just a bit smaller values:

(QModelIndex(404,0,0x0,FileHistory(0xa06bfe8) )  ,
 QModelIndex(403,0,0x0,FileHistory(0xa06bfe8) )  ,
 QModelIndex(402,0,0x0,FileHistory(0xa06bfe8) )  ,
 QModelIndex(401,0,0x0,FileHistory(0xa06bfe8) )  )

But try with selecting many commits, for example v1.6.3..origin/master
(fewer are sufficient). The order has a pattern, but it's not sorted at
all.

Or selecting only two commits v1.6.3 and origin/master prints this for
me, ordered from newest to oldest this time:

(QModelIndex(16,0,0x0,FileHistory(0xa06bfe8) )  ,
 QModelIndex(401,0,0x0,FileHistory(0xa06bfe8) )  )
