From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v3 05/15] ref-filter: introduce parsing functions for each valid atom
Date: Tue,  5 Jan 2016 13:33:04 +0530
Message-ID: <1451980994-26865-6-git-send-email-Karthik.188@gmail.com>
References: <1451980994-26865-1-git-send-email-Karthik.188@gmail.com>
Cc: gitster@pobox.com, sunshine@sunshineco.com,
	Karthik Nayak <Karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 05 09:03:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aGMa5-0007qp-3K
	for gcvg-git-2@plane.gmane.org; Tue, 05 Jan 2016 09:03:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752052AbcAEIC4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jan 2016 03:02:56 -0500
Received: from mail-pa0-f44.google.com ([209.85.220.44]:35909 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751978AbcAEICy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jan 2016 03:02:54 -0500
Received: by mail-pa0-f44.google.com with SMTP id yy13so118730373pab.3
        for <git@vger.kernel.org>; Tue, 05 Jan 2016 00:02:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6Z7ZZzD5pn1FbwzH/BzynVZBl01gdrTSel7Q6fKmS/k=;
        b=d93y4EM93BtSgbVw7Zioi+t64El03P3zpTGMqTLiJvYV8wXygjIKGVyMVcorlYfeA3
         jp7lkMkVBJdyPoOY6fjJoRUOdf1xf8FuXJaPDeyeQaSwhksL0G0lXKvdp5KU0mpRJTZ4
         jNvlM296Pa1Kut/uaebBWehjC9/ZTYQvSIbgj2V6SnwBd8Q3AhTVgQ7jpwDgm5Fi2dR3
         gxszXfKzBUiZ72OWiprz3SUqtuvoDFVBVRDP+ZggM2p273kLqP9bnInxBK/yXyuh56LQ
         Eqox6R34WMLc1VedX0XAxPL+0D0tGcf+bRVvI3AMaH1gnuUOLe/udh5hGh/kwaKuygeE
         D2Ag==
X-Received: by 10.66.253.97 with SMTP id zz1mr89867440pac.106.1451980974356;
        Tue, 05 Jan 2016 00:02:54 -0800 (PST)
Received: from ashley.localdomain ([106.51.242.38])
        by smtp.gmail.com with ESMTPSA id q190sm125814275pfq.59.2016.01.05.00.02.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 05 Jan 2016 00:02:53 -0800 (PST)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.6.4
In-Reply-To: <1451980994-26865-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283355>

Parsing atoms is done in populate_value(), this is repetitive and
hence expensive. Introduce a parsing function which would let us parse
atoms beforehand and store the required details into the 'used_atom'
structure for further usage.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
---
 ref-filter.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/ref-filter.c b/ref-filter.c
index 75ebd03..efa247a 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -36,6 +36,7 @@ static int need_color_reset_at_eol;
 static struct {
 	const char *name;
 	cmp_type cmp_type;
+	void (*parser)(struct used_atom *atom);
 } valid_atom[] = {
 	{ "refname" },
 	{ "objecttype" },
@@ -154,6 +155,8 @@ int parse_ref_filter_atom(const char *atom, const char *ep)
 	REALLOC_ARRAY(used_atom, used_atom_cnt);
 	used_atom[at].name = xmemdupz(atom, ep - atom);
 	used_atom[at].type = valid_atom[i].cmp_type;
+	if (valid_atom[i].parser)
+		valid_atom[i].parser(&used_atom[at]);
 	if (*atom == '*')
 		need_tagged = 1;
 	if (!strcmp(used_atom[at].name, "symref"))
-- 
2.6.4
