From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Question: .idx without .pack causes performance issues?
Date: Tue, 21 Jul 2015 12:15:01 -0700
Message-ID: <xmqqzj2puxu2.fsf@gitster.dls.corp.google.com>
References: <CAEtYS8QWCg5_DtrJw-e+c50vcG0OpciR6LWon-3GgyngGn+0pQ@mail.gmail.com>
	<xmqq4mkxwd77.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>
To: Doug Kelly <dougk.ff7@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 21 21:15:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZHd0V-0004VW-N9
	for gcvg-git-2@plane.gmane.org; Tue, 21 Jul 2015 21:15:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933884AbbGUTPI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jul 2015 15:15:08 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:34340 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933708AbbGUTPE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jul 2015 15:15:04 -0400
Received: by pacan13 with SMTP id an13so126147682pac.1
        for <git@vger.kernel.org>; Tue, 21 Jul 2015 12:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=pK5KIru5XcC/rQnnsYD13Gv3Ti2wIZop88IsqCu7Sis=;
        b=KsM91452CtULIqa6qnogItnRlSzHOtAOPECN1AG0XAjR2ltKrKOmVkTEiLJ4HDbxnx
         XvBAdRay5LnNoSDiaPYqP7kZxleaQle4q3KPbvXUhz/OeRCrasIOu0fIYWrOEL6LCHrB
         +xtDYQyQ1thFxKzGcOUfjDbvy07Uju6DcEGVkYqbsnhb9lTNAZQnuB0/0sHJoON9I5Ka
         c/aHc/PnyGfuPJ2bT910RYf7aAtRAMBlTaRJkcxiC+n6hoyJw03d2xrsKlNSuHVwn7AC
         r3CUvWsMp59+qgAl81GAoiNcoG71xUAK06Se1K69JsDHI2gEh3YFAcPaDXaCD6fJDnr4
         0LdA==
X-Received: by 10.66.116.81 with SMTP id ju17mr76055897pab.35.1437506103832;
        Tue, 21 Jul 2015 12:15:03 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:3977:fdee:723a:a723])
        by smtp.gmail.com with ESMTPSA id ht9sm28937539pdb.0.2015.07.21.12.15.02
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 21 Jul 2015 12:15:03 -0700 (PDT)
In-Reply-To: <xmqq4mkxwd77.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Tue, 21 Jul 2015 11:57:48 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274397>

Junio C Hamano <gitster@pobox.com> writes:

> I however do not think that we mark the in-core structure that
> corresponds to an open ".idx" file in any way when such a failure
> happens.  If we really cared enough, we could do so, saying "we know
> there is .idx file, but do not bother looking at it again, as we
> know the corresponding .pack is missing", and that would speed things
> up a bit, essentially bringing us back to a sane situation without
> any ".idx" without corresponding ".pack".
>
> I do not think it is worth the effort, though.  It would be more
> fruitful to find out how you end up with ".idx exists but not
> corresponding .pack" and if that is some systemic failure, see if
> there is a way to prevent that from happening in the first place.

While I still think that it is more important to prevent such a
situation from occurring in the first place, ignoring .idx that lack
corresponding .pack should be fairly simple, perhaps like this.

Note that if we wanted to do this for real, I think such an ".idx"
file should also be added to the "garbage" list in the loop in which
the second hunk of the following patch appears.

 sha1_file.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/sha1_file.c b/sha1_file.c
index 1cee438..b69298e 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1240,6 +1240,19 @@ static void report_pack_garbage(struct string_list *list)
 	report_helper(list, seen_bits, first, list->nr);
 }
 
+static int packfile_exists(const char *base, size_t base_len)
+{
+	struct strbuf path = STRBUF_INIT;
+	int status;
+
+	strbuf_add(&path, base, base_len);
+	strbuf_addstr(&path, ".pack");
+	status = file_exists(path.buf);
+
+	strbuf_release(&path);
+	return status;
+}
+
 static void prepare_packed_git_one(char *objdir, int local)
 {
 	struct strbuf path = STRBUF_INIT;
@@ -1281,6 +1294,7 @@ static void prepare_packed_git_one(char *objdir, int local)
 					break;
 			}
 			if (p == NULL &&
+			    packfile_exists(path.buf, base_len) &&
 			    /*
 			     * See if it really is a valid .idx file with
 			     * corresponding .pack file that we can map.
