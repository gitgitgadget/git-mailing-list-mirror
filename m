From: Olivier Marin <dkr+ml.git@free.fr>
Subject: Re: [PATCH v2 4/4] remote show: list tracked remote branches with
 -n
Date: Wed, 11 Jun 2008 00:54:49 +0200
Message-ID: <484F0639.4060307@free.fr>
References: <1213109413-6842-1-git-send-email-dkr+ml.git@free.fr> <1213109509-7013-1-git-send-email-dkr+ml.git@free.fr> <7vod69cder.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 11 00:55:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6Cka-0001IT-Vx
	for gcvg-git-2@gmane.org; Wed, 11 Jun 2008 00:55:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754398AbYFJWyo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Jun 2008 18:54:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754558AbYFJWyn
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jun 2008 18:54:43 -0400
Received: from smtp2-g19.free.fr ([212.27.42.28]:45097 "EHLO smtp2-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752793AbYFJWyn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2008 18:54:43 -0400
Received: from smtp2-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp2-g19.free.fr (Postfix) with ESMTP id C9ED112B6AF;
	Wed, 11 Jun 2008 00:54:41 +0200 (CEST)
Received: from [10.253.21.40] (hhe95-1-82-225-56-14.fbx.proxad.net [82.225.56.14])
	by smtp2-g19.free.fr (Postfix) with ESMTP id 6159A12B6AD;
	Wed, 11 Jun 2008 00:54:41 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.14 (X11/20080505)
In-Reply-To: <7vod69cder.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84559>

=46rom: Olivier Marin <dkr@freesurf.fr>

Signed-off-by: Olivier Marin <dkr@freesurf.fr>
---

Junio C Hamano a =E9crit :
> Olivier Marin <dkr+ml.git@free.fr> writes:
>=20
>> +static int append_ref_to_tracked_list(const char *refname,
>> +	const unsigned char *sha1, int flags, void *cb_data)
>> +{
>> +	struct ref_states *states =3D cb_data;
>> +	struct strbuf buf;
>> +
>> +	strbuf_init(&buf, 0);
>> +	strbuf_addf(&buf, "%s/", states->remote->name);
>> +	if (strncmp(buf.buf, refname, buf.len)) {
>> +		strbuf_release(&buf);
>> +		return 0;
>> +	}
>=20
> Doesn't this have the same issue Shawn fixed in 7ad2458 (Make "git-re=
mote
> rm" delete refs acccording to fetch specs, 2008-06-01)?

You are right. This version should fix this.

 builtin-remote.c  |   22 ++++++++++++++++++++--
 t/t5505-remote.sh |    2 ++
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/builtin-remote.c b/builtin-remote.c
index 851bdde..d55d320 100644
--- a/builtin-remote.c
+++ b/builtin-remote.c
@@ -444,6 +444,22 @@ static int get_remote_ref_states(const char *name,
 	return 0;
 }
=20
+static int append_ref_to_tracked_list(const char *refname,
+	const unsigned char *sha1, int flags, void *cb_data)
+{
+	struct ref_states *states =3D cb_data;
+	struct refspec refspec;
+
+	memset(&refspec, 0, sizeof(refspec));
+	refspec.dst =3D (char *)refname;
+	if (!remote_find_tracking(states->remote, &refspec)) {
+		path_list_append(skip_prefix(refspec.src, "refs/heads/"),
+			&states->tracked);
+	}
+
+	return 0;
+}
+
 static int show(int argc, const char **argv)
 {
 	int no_query =3D 0, result =3D 0;
@@ -494,10 +510,12 @@ static int show(int argc, const char **argv)
 			strbuf_release(&buf);
 			show_list("  Stale tracking branch%s (use 'git remote "
 				"prune')", &states.stale);
-			show_list("  Tracked remote branch%s",
-				&states.tracked);
 		}
=20
+		if (no_query)
+			for_each_ref(append_ref_to_tracked_list, &states);
+		show_list("  Tracked remote branch%s", &states.tracked);
+
 		if (states.remote->push_refspec_nr) {
 			printf("  Local branch%s pushed with 'git push'\n   ",
 				states.remote->push_refspec_nr > 1 ?
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index c27cfad..fbf0d30 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -143,6 +143,8 @@ cat > test/expect << EOF
   URL: $(pwd)/one/.git
   Remote branch merged with 'git pull' while on branch master
     master
+  Tracked remote branches
+    master side
   Local branches pushed with 'git push'
     master:upstream +refs/tags/lastbackup
 EOF
