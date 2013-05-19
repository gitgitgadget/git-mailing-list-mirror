From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 02/17] fetch: make own copies of refnames
Date: Sun, 19 May 2013 22:26:57 +0200
Message-ID: <1368995232-11042-3-git-send-email-mhagger@alum.mit.edu>
References: <1368995232-11042-1-git-send-email-mhagger@alum.mit.edu>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun May 19 22:28:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UeADA-0004Io-K8
	for gcvg-git-2@plane.gmane.org; Sun, 19 May 2013 22:28:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754687Ab3ESU2A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 May 2013 16:28:00 -0400
Received: from ALUM-MAILSEC-SCANNER-5.MIT.EDU ([18.7.68.17]:43726 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754541Ab3ESU16 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 May 2013 16:27:58 -0400
X-AuditID: 12074411-b7f286d0000008e8-bf-519935ceb3af
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 5B.D1.02280.EC539915; Sun, 19 May 2013 16:27:58 -0400 (EDT)
Received: from michael.fritz.box (p57A25040.dip0.t-ipconnect.de [87.162.80.64])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r4JKRX5L026019
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 19 May 2013 16:27:57 -0400
X-Mailer: git-send-email 1.8.2.3
In-Reply-To: <1368995232-11042-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGIsWRmVeSWpSXmKPExsUixO6iqHvOdGagwYXdShZdV7qZLBp6rzBb
	zLu7i8ni9or5zBY/WnqYHVg9/r7/wORx6eV3No9nvXsYPS5eUvb4vEkugDWK2yYpsaQsODM9
	T98ugTvj456jbAUTOCsWXO5lbGA8yd7FyMkhIWAi8f/hGShbTOLCvfVsXYxcHEIClxklTr7b
	yAThnGeSOHBrLRtIFZuArsSinmYmEFtEQFbi++GNjCA2s8AERoml/YUgtrCApcSuXTNZuhg5
	OFgEVCWWzE4HCfMKuEgs3XWOGWKZgsTlWWvAbE4BV4kt7btYQWwhoJp//bdZJzDyLmBkWMUo
	l5hTmqubm5iZU5yarFucnJiXl1qka6qXm1mil5pSuokRElKCOxhnnJQ7xCjAwajEw9vwYXqg
	EGtiWXFl7iFGSQ4mJVHedyYzA4X4kvJTKjMSizPii0pzUosPMUpwMCuJ8O4RAsrxpiRWVqUW
	5cOkpDlYlMR5+Zao+wkJpCeWpGanphakFsFkZTg4lCR43UGGChalpqdWpGXmlCCkmTg4QQQX
	yAYeoA2LQAp5iwsSc4sz0yGKTjEqSonzXgRJCIAkMkrz4AbAov8VozjQP8K8R0CqeICJA677
	FdBgJqDBrNemggwuSURISTUwtoYk8mmoX4thFlFa9/b4XG+pv55ml+JT7+hvZYicr9jys9v+
	6ueO6ayPfh07ZtBeXXzM1N9NO5/zR+9cXgOVlYU817cFf5spIs1V9LX36IdnF48Vq6Y0yc+b
	Ljrph8VGH3utjNylh79p7ja78XjSDNvofRtOLhfNnHdoySftp2xL2ZlmvQu5rcRS 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224908>

Do not retain references to refnames passed to the each_ref_fn
callback add_existing(), because their lifetime is not guaranteed.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/fetch.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 4b6b1df..f949115 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -590,7 +590,7 @@ static void find_non_local_tags(struct transport *transport,
 			struct ref **head,
 			struct ref ***tail)
 {
-	struct string_list existing_refs = STRING_LIST_INIT_NODUP;
+	struct string_list existing_refs = STRING_LIST_INIT_DUP;
 	struct string_list remote_refs = STRING_LIST_INIT_NODUP;
 	const struct ref *ref;
 	struct string_list_item *item = NULL;
@@ -693,7 +693,7 @@ static int truncate_fetch_head(void)
 static int do_fetch(struct transport *transport,
 		    struct refspec *refs, int ref_count)
 {
-	struct string_list existing_refs = STRING_LIST_INIT_NODUP;
+	struct string_list existing_refs = STRING_LIST_INIT_DUP;
 	struct string_list_item *peer_item = NULL;
 	struct ref *ref_map;
 	struct ref *rm;
-- 
1.8.2.3
