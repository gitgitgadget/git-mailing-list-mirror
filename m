From: Adam Simpkins <simpkins@facebook.com>
Subject: [PATCH] graph API: fix bug in graph_is_interesting()
Date: Tue, 18 Aug 2009 14:18:12 -0700
Message-ID: <20090818211812.GL8147@facebook.com>
References: <1250628954.114121983@192.168.1.201>
Reply-To: Adam Simpkins <simpkins@facebook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Santi =?iso-8859-1?Q?B=E9jar?= <santi@agolina.net>,
	Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Aug 19 00:45:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdXR1-000848-C3
	for gcvg-git-2@lo.gmane.org; Wed, 19 Aug 2009 00:45:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750886AbZHRWp3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 18 Aug 2009 18:45:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750803AbZHRWp3
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Aug 2009 18:45:29 -0400
Received: from mailout-snc1.facebook.com ([69.63.179.25]:53322 "EHLO
	mailout-sf2p.facebook.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750802AbZHRWp2 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Aug 2009 18:45:28 -0400
Received: from mail.thefacebook.com (intlb01.snat.snc1.facebook.com [10.128.203.16] (may be forged))
	by pp02.snc1.tfbnw.net (8.14.1/8.14.1) with ESMTP id n7ILI1aE023853
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NOT);
	Tue, 18 Aug 2009 14:18:01 -0700
Received: from simpkins (192.168.18.252) by mail.TheFacebook.com
 (192.168.18.104) with Microsoft SMTP Server (TLS) id 8.1.393.1; Tue, 18 Aug
 2009 14:18:12 -0700
Received: from simpkins by simpkins with local (Exim 4.69)	(envelope-from
 <simpkins@facebook.com>)	id 1MdW4K-00076m-6S; Tue, 18 Aug 2009 14:18:12 -0700
Mail-Followup-To: Git Mailing List <git@vger.kernel.org>,
	Santi =?iso-8859-1?Q?B=E9jar?= <santi@agolina.net>,
	Junio C Hamano <gitster@pobox.com>
Content-Disposition: inline
In-Reply-To: <1250628954.114121983@192.168.1.201>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Proofpoint-Virus-Version: vendor=fsecure engine=1.12.8161:2.4.5,1.2.40,4.0.166 definitions=2009-08-18_15:2009-08-11,2009-08-18,2009-08-18 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 ipscore=0 phishscore=0 bulkscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx engine=5.0.0-0907200000 definitions=main-0908180160
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126478>

Updated graph_is_interesting() to use simplify_commit() to determine if
a commit is interesting, just like get_revision() does.  Previously, it
would sometimes incorrectly treat an interesting commit as
uninteresting.  This resulted in incorrect lines in the graph output.

This problem was reported by Santi B=E9jar.  The following command
would exhibit the problem before, but now works correctly:

  git log --graph --simplify-by-decoration --oneline v1.6.3.3

Previously git graph did not display the output for this command
correctly between f29ac4f and 66996ec, among other places.

Signed-off-by: Adam Simpkins <simpkins@facebook.com>
---

Note that simplify_commit() may modify the revision list.  Calling it
in graph_is_interesting() can modify the revision list earlier than it
otherwise would be (in get_revision()).  I don't think this should
cause any problems, but figured I'd point it out in case anyone more
familiar with the code thinks otherwise.


 graph.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/graph.c b/graph.c
index e466770..ea21e91 100644
--- a/graph.c
+++ b/graph.c
@@ -286,9 +286,10 @@ static int graph_is_interesting(struct git_graph *=
graph, struct commit *commit)
 	}
=20
 	/*
-	 * Uninteresting and pruned commits won't be printed
+	 * Otherwise, use simplify_commit() to see if this commit is
+	 * interesting
 	 */
-	return (commit->object.flags & (UNINTERESTING | TREESAME)) ? 0 : 1;
+	return simplify_commit(graph->revs, commit) =3D=3D commit_show;
 }
=20
 static struct commit_list *next_interesting_parent(struct git_graph *g=
raph,
--=20
1.6.4.314.ge5db
