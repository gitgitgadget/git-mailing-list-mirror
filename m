From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git status during interactive rebase
Date: Thu, 21 Jan 2016 14:35:06 -0800
Message-ID: <xmqqtwm6woh1.fsf@gitster.mtv.corp.google.com>
References: <CAGZ79kbUwJ+CN=YoQUP=rm=EhU=fU2ynt_7Q-cd7Dic-bsx+TA@mail.gmail.com>
	<vpqpowvz6g0.fsf@anie.imag.fr>
	<CAGZ79ka7MVuHyTrjuR7BhBAxxJ-PuMCSDnRVWCbeeRSq9rGdWQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Jan 21 23:35:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aMNow-0005ff-OC
	for gcvg-git-2@plane.gmane.org; Thu, 21 Jan 2016 23:35:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751193AbcAUWfL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jan 2016 17:35:11 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:63759 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751091AbcAUWfJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jan 2016 17:35:09 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B352B3D7DF;
	Thu, 21 Jan 2016 17:35:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3ECKRcpq2JpATRiFVBimUjonPmg=; b=XUqy5U
	sc21L6Bhp7dCAH7rJFFhdSqpCrT+OLhRTHiiBGsTRf0Z2y614HzD+Cd40Lw0hELW
	y+S34mvkN+exh5dHLVROZba1u4Lg5vjc50UQandXH5geqFQWso0Wr/5qM6oZeSR3
	h3BXSRTzm0S9MMIC0SbqIXKh2e6nVI+/LOilo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mLEL0bW6dEePi1/mr8te2SSl+EFE386p
	mpVfjPPRtCexRa1YxwszjhspAwUU8C4WsM2pvmC55Lw8HUyN7IOPfkDAmLYkEOV1
	VoQunZucZrkmVcpjQ4t8T3R5zHQQKWaKXdlllmVPztF+Sszj2TQBvW0JltaqWLZ4
	HLjoyAL6qts=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A9BD83D7DE;
	Thu, 21 Jan 2016 17:35:08 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 0D6B73D7DD;
	Thu, 21 Jan 2016 17:35:07 -0500 (EST)
In-Reply-To: <CAGZ79ka7MVuHyTrjuR7BhBAxxJ-PuMCSDnRVWCbeeRSq9rGdWQ@mail.gmail.com>
	(Stefan Beller's message of "Thu, 21 Jan 2016 14:16:40 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 3968F4A0-C08F-11E5-A814-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284538>

Stefan Beller <sbeller@google.com> writes:

>> So the proper fix might be to test for the presence of the "done" file and
>> otherwise tell the user that this rebase has not even started yet.
>
> So what Matthieu said?

Yup, I think that is the right thing to do.

Perhaps something along this line (not tested and done on 'pu', so I
am not committing it to anywhere myself)?

 wt-status.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index ab4f80d..90b2474 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1068,14 +1068,17 @@ static void abbrev_sha1_in_line(struct strbuf *line)
 
 }
 
-static void read_rebase_todolist(const char *fname, struct string_list *lines)
+static int read_rebase_todolist(const char *fname, struct string_list *lines)
 {
 	struct strbuf line = STRBUF_INIT;
 	FILE *f = fopen(git_path("%s", fname), "r");
 
-	if (!f)
+	if (!f) {
+		if (errno == ENOENT)
+			return -1;
 		die_errno("Could not open file %s for reading",
 			  git_path("%s", fname));
+	}
 	while (!strbuf_getline_lf(&line, f)) {
 		if (line.len && line.buf[0] == comment_line_char)
 			continue;
@@ -1085,6 +1088,7 @@ static void read_rebase_todolist(const char *fname, struct string_list *lines)
 		abbrev_sha1_in_line(&line);
 		string_list_append(lines, line.buf);
 	}
+	return 0;
 }
 
 static void show_rebase_information(struct wt_status *s,
@@ -1098,12 +1102,12 @@ static void show_rebase_information(struct wt_status *s,
 		struct string_list have_done = STRING_LIST_INIT_DUP;
 		struct string_list yet_to_do = STRING_LIST_INIT_DUP;
 
-		read_rebase_todolist("rebase-merge/done", &have_done);
-		read_rebase_todolist("rebase-merge/git-rebase-todo", &yet_to_do);
-
-		if (have_done.nr == 0)
+		if ((read_rebase_todolist("rebase-merge/done", &have_done) < 0) ||
+		    (read_rebase_todolist("rebase-merge/git-rebase-todo", &yet_to_do) < 0)) {
+			status_printf_ln(s, color, _("rebase-i not started yet."));
+		} else if (have_done.nr == 0) {
 			status_printf_ln(s, color, _("No commands done."));
-		else {
+		} else {
 			status_printf_ln(s, color,
 				Q_("Last command done (%d command done):",
 					"Last commands done (%d commands done):",
