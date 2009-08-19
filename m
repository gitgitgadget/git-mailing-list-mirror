From: Adam Simpkins <simpkins@facebook.com>
Subject: Re: [PATCH] graph API: fix bug in graph_is_interesting()
Date: Tue, 18 Aug 2009 19:34:33 -0700
Message-ID: <20090819023433.GP8147@facebook.com>
References: <1250628954.114121983@192.168.1.201> <20090818211812.GL8147@facebook.com> <7vk5103chi.fsf@alter.siamese.dyndns.org> <20090819022918.GO8147@facebook.com>
Reply-To: Adam Simpkins <simpkins@facebook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Santi =?iso-8859-1?Q?B=E9jar?= <santi@agolina.net>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Aug 19 04:34:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mdb0j-0002Jq-Rz
	for gcvg-git-2@lo.gmane.org; Wed, 19 Aug 2009 04:34:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751777AbZHSCeg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 18 Aug 2009 22:34:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751762AbZHSCeg
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Aug 2009 22:34:36 -0400
Received: from mailout-snc1.facebook.com ([69.63.179.25]:45201 "EHLO
	mailout-snc1.facebook.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751726AbZHSCef (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Aug 2009 22:34:35 -0400
Received: from mail.thefacebook.com (intlb01.snat.snc1.facebook.com [10.128.203.17] (may be forged))
	by pp01.snc1.tfbnw.net (8.14.1/8.14.1) with ESMTP id n7J2YTCx019373
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NOT);
	Tue, 18 Aug 2009 19:34:29 -0700
Received: from simpkins (192.168.18.252) by mail.TheFacebook.com
 (192.168.18.105) with Microsoft SMTP Server (TLS) id 8.1.393.1; Tue, 18 Aug
 2009 19:34:34 -0700
Received: from simpkins by simpkins with local (Exim 4.69)	(envelope-from
 <simpkins@facebook.com>)	id 1Mdb0T-0006JW-HX; Tue, 18 Aug 2009 19:34:33 -0700
Mail-Followup-To: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Santi =?iso-8859-1?Q?B=E9jar?= <santi@agolina.net>
Content-Disposition: inline
In-Reply-To: <20090819022918.GO8147@facebook.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Proofpoint-Virus-Version: vendor=fsecure engine=1.12.8161:2.4.5,1.2.40,4.0.166 definitions=2009-08-18_15:2009-08-11,2009-08-18,2009-08-18 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 ipscore=0 phishscore=0 bulkscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx engine=5.0.0-0907200000 definitions=main-0908180219
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126499>

Previously, graph_is_interesting() did not behave quite the same way as
the code in get_revision().  As a result, it would sometimes think
commits were uninteresting, even though get_revision() would return
them.  This resulted in incorrect lines in the graph output.

This change creates a get_commit_action() function, which
graph_is_interesting() and simplify_commit() both now use to determine
if a commit will be shown.  It is identical to the old simplify_commit(=
)
behavior, except that it never calls rewrite_parents().

This problem was reported by Santi B=E9jar.  The following command
would exhibit the problem before, but now works correctly:

  git log --graph --simplify-by-decoration --oneline v1.6.3.3

Previously git graph did not display the output for this command
correctly between f29ac4f and 66996ec, among other places.

Signed-off-by: Adam Simpkins <simpkins@facebook.com>
---
 graph.c    |    5 +++--
 revision.c |   15 ++++++++++++---
 revision.h |    1 +
 3 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/graph.c b/graph.c
index e466770..9087f65 100644
--- a/graph.c
+++ b/graph.c
@@ -286,9 +286,10 @@ static int graph_is_interesting(struct git_graph *=
graph, struct commit *commit)
 	}
=20
 	/*
-	 * Uninteresting and pruned commits won't be printed
+	 * Otherwise, use get_commit_action() to see if this commit is
+	 * interesting
 	 */
-	return (commit->object.flags & (UNINTERESTING | TREESAME)) ? 0 : 1;
+	return get_commit_action(graph->revs, commit) =3D=3D commit_show;
 }
=20
 static struct commit_list *next_interesting_parent(struct git_graph *g=
raph,
diff --git a/revision.c b/revision.c
index 8ffb661..fe7d522 100644
--- a/revision.c
+++ b/revision.c
@@ -1664,7 +1664,7 @@ static inline int want_ancestry(struct rev_info *=
revs)
 	return (revs->rewrite_parents || revs->children.name);
 }
=20
-enum commit_action simplify_commit(struct rev_info *revs, struct commi=
t *commit)
+enum commit_action get_commit_action(struct rev_info *revs, struct com=
mit *commit)
 {
 	if (commit->object.flags & SHOWN)
 		return commit_ignore;
@@ -1692,12 +1692,21 @@ enum commit_action simplify_commit(struct rev_i=
nfo *revs, struct commit *commit)
 			if (!commit->parents || !commit->parents->next)
 				return commit_ignore;
 		}
-		if (want_ancestry(revs) && rewrite_parents(revs, commit) < 0)
-			return commit_error;
 	}
 	return commit_show;
 }
=20
+enum commit_action simplify_commit(struct rev_info *revs, struct commi=
t *commit)
+{
+	enum commit_action action =3D get_commit_action(revs, commit);
+
+	if (action =3D=3D commit_show && revs->prune && revs->dense && want_a=
ncestry(revs)) {
+		if (rewrite_parents(revs, commit) < 0)
+			return commit_error;
+	}
+	return action;
+}
+
 static struct commit *get_revision_1(struct rev_info *revs)
 {
 	if (!revs->commits)
diff --git a/revision.h b/revision.h
index b10984b..9d0dddb 100644
--- a/revision.h
+++ b/revision.h
@@ -168,6 +168,7 @@ enum commit_action {
 	commit_error
 };
=20
+extern enum commit_action get_commit_action(struct rev_info *revs, str=
uct commit *commit);
 extern enum commit_action simplify_commit(struct rev_info *revs, struc=
t commit *commit);
=20
 #endif
--=20
1.6.4.314.g0a482.dirty
