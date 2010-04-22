From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Please default to 'commit -a' when no changes were added
Date: Thu, 22 Apr 2010 10:58:07 -0500
Message-ID: <20100422155806.GC4801@progeny.tock>
References: <20100422151037.2310.2429.reportbug@frosties.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Goswin von Brederlow <goswin-v-b@web.de>, 578764@bugs.debian.org
X-From: git-owner@vger.kernel.org Thu Apr 22 17:58:00 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O4ymt-0005PV-Dk
	for gcvg-git-2@lo.gmane.org; Thu, 22 Apr 2010 17:57:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755874Ab0DVP5x convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 22 Apr 2010 11:57:53 -0400
Received: from mail-pz0-f194.google.com ([209.85.222.194]:54779 "EHLO
	mail-pz0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755322Ab0DVP5w (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Apr 2010 11:57:52 -0400
Received: by pzk32 with SMTP id 32so5539019pzk.21
        for <git@vger.kernel.org>; Thu, 22 Apr 2010 08:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=bpq8DN0pT3LkZgJuCIFETshnT6m9rnTSqNfcSAmjnGE=;
        b=wS2SHCOZYBZN1lmx069hr1pVgrCehg9cWqNm2ykM+lYOln6sayy1mF+lkVgIXsuQzB
         PXZkwazx0Oaxpc3UEARBHBlPxlhp8VRvrjdv9csC7FXQg12pVxxG7HQhp1Gwd3xd+7EX
         cnwWaFfeHzb7cz7ga9BMw34ehh9UI5kouNpTg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=FMr9SRubqP+MSTJmPvzTCKK1GypLudHFj1zY9wLVY5CSTias7wt//hll8cU1ZJT4om
         mshu4vA7uUsTpXSPp21UWFHGOgrfc2GeNpTKgSlJPpKT76FUyILrpIeWUAoug9ID6ALS
         aXJrMCzgFrliSXo5d68qsOa4y4ANPub070WCM=
Received: by 10.140.87.41 with SMTP id k41mr7591110rvb.109.1271951872134;
        Thu, 22 Apr 2010 08:57:52 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 20sm58827iwn.9.2010.04.22.08.57.50
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 22 Apr 2010 08:57:51 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100422151037.2310.2429.reportbug@frosties.localdomain>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145541>

[topic: making =E2=80=98git commit=E2=80=99 more helpful when there are=
 no changes
registered in the index]

Hi Goswin,

Goswin von Brederlow wrote:

> in most (all but git?) RCS a plain 'commit' without any arguments
> commits all changes (to registered files).

Yes, but they are wrong. :)

> no changes added to commit (use "git add" and/or "git commit -a")
[...]
> Imho in most cases where no changes
> were added people do want to commit all modified files. And if not
> then exiting the editor to abort is easy enough.

I absent-mindedly type =E2=80=98git commit=E2=80=99 having forgotten to=
 update the
index with my changes fairly often.  Then I add the appropriate
changes, which is almost never all of them.  I don=E2=80=99t think this=
 is so
unusual.

Starting out, I can see how it would be comforting to people if
=E2=80=98git commit=E2=80=99 would default to -a behavior if they ignor=
e the index.
That is logically a different operation, though, so it would also send
a wrong message and make it harder in the long run to get used to the
interface.

Instead, I think it would be better to focus on making the error
message more helpful.  Right now there is a screen full of status
before the advice, which might make it easy to get scared before
reading it.

Here=E2=80=99s a very rough patch to suppress that screenful.  What do =
you
think?

diff --git a/builtin/commit.c b/builtin/commit.c
index c5ab683..9cb5489 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -396,7 +396,7 @@ static char *prepare_index(int argc, const char **a=
rgv, const char *prefix, int
 }
=20
 static int run_status(FILE *fp, const char *index_file, const char *pr=
efix, int nowarn,
-		      struct wt_status *s)
+		      struct wt_status *s, int simple)
 {
 	unsigned char sha1[20];
=20
@@ -415,6 +415,13 @@ static int run_status(FILE *fp, const char *index_=
file, const char *prefix, int
=20
 	wt_status_collect(s);
=20
+	if (simple) {
+		if (s->commitable)
+			die("internal error: are there changes or not?");
+		wt_status_print_nochanges(s);
+		return 0;
+	}
+
 	switch (status_format) {
 	case STATUS_FORMAT_SHORT:
 		wt_shortstatus_print(s, null_termination);
@@ -670,7 +677,7 @@ static int prepare_to_commit(const char *index_file=
, const char *prefix,
=20
 		saved_color_setting =3D s->use_color;
 		s->use_color =3D 0;
-		commitable =3D run_status(fp, index_file, prefix, 1, s);
+		commitable =3D run_status(fp, index_file, prefix, 1, s, 0);
 		s->use_color =3D saved_color_setting;
 	} else {
 		unsigned char sha1[20];
@@ -692,7 +699,7 @@ static int prepare_to_commit(const char *index_file=
, const char *prefix,
=20
 	if (!commitable && !in_merge && !allow_empty &&
 	    !(amend && is_a_merge(head_sha1))) {
-		run_status(stdout, index_file, prefix, 0, s);
+		run_status(stdout, index_file, prefix, 0, s, 1);
 		return 0;
 	}
=20
@@ -946,7 +953,7 @@ static int dry_run_commit(int argc, const char **ar=
gv, const char *prefix,
 	const char *index_file;
=20
 	index_file =3D prepare_index(argc, argv, prefix, 1);
-	commitable =3D run_status(stdout, index_file, prefix, 0, s);
+	commitable =3D run_status(stdout, index_file, prefix, 0, s, 0);
 	rollback_index_files();
=20
 	return commitable ? 0 : 1;
diff --git a/wt-status.c b/wt-status.c
index 8ca59a2..b50bf71 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -589,6 +589,24 @@ static void wt_status_print_tracking(struct wt_sta=
tus *s)
 	color_fprintf_ln(s->fp, color(WT_STATUS_HEADER, s), "#");
 }
=20
+void wt_status_print_nochanges(struct wt_status *s)
+{
+	if (s->amend)
+		fprintf(s->fp, "# No changes\n");
+	else if (s->nowarn)
+		; /* nothing */
+	else if (s->workdir_dirty)
+		printf("no changes added to commit (use \"git add\" and/or \"git com=
mit -a\")\n");
+	else if (s->untracked.nr)
+		printf("nothing added to commit but untracked files present (use \"g=
it add\" to track)\n");
+	else if (s->is_initial)
+		printf("nothing to commit (create/copy files and use \"git add\" to =
track)\n");
+	else if (!s->show_untracked_files)
+		printf("nothing to commit (use -u to show untracked files)\n");
+	else
+		printf("nothing to commit (working directory clean)\n");
+}
+
 void wt_status_print(struct wt_status *s)
 {
 	const char *branch_color =3D color(WT_STATUS_HEADER, s);
@@ -629,22 +647,8 @@ void wt_status_print(struct wt_status *s)
=20
 	if (s->verbose)
 		wt_status_print_verbose(s);
-	if (!s->commitable) {
-		if (s->amend)
-			fprintf(s->fp, "# No changes\n");
-		else if (s->nowarn)
-			; /* nothing */
-		else if (s->workdir_dirty)
-			printf("no changes added to commit (use \"git add\" and/or \"git co=
mmit -a\")\n");
-		else if (s->untracked.nr)
-			printf("nothing added to commit but untracked files present (use \"=
git add\" to track)\n");
-		else if (s->is_initial)
-			printf("nothing to commit (create/copy files and use \"git add\" to=
 track)\n");
-		else if (!s->show_untracked_files)
-			printf("nothing to commit (use -u to show untracked files)\n");
-		else
-			printf("nothing to commit (working directory clean)\n");
-	}
+	if (!s->commitable)
+		wt_status_print_nochanges(s);
 }
=20
 static void wt_shortstatus_unmerged(int null_termination, struct strin=
g_list_item *it,
diff --git a/wt-status.h b/wt-status.h
index 9120673..f249955 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -59,6 +59,8 @@ void wt_status_prepare(struct wt_status *s);
 void wt_status_print(struct wt_status *s);
 void wt_status_collect(struct wt_status *s);
=20
+void wt_status_print_nochanges(struct wt_status *s);
+
 void wt_shortstatus_print(struct wt_status *s, int null_termination);
 void wt_porcelain_print(struct wt_status *s, int null_termination);
=20
