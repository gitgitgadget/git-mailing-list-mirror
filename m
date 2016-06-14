From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2] blame: improve diagnosis for "--reverse NEW"
Date: Tue, 14 Jun 2016 10:46:06 -0700
Message-ID: <xmqqporjackh.fsf@gitster.mtv.corp.google.com>
References: <xmqqtwgvadru.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 14 19:46:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCsPn-0002ze-12
	for gcvg-git-2@plane.gmane.org; Tue, 14 Jun 2016 19:46:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752028AbcFNRqL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jun 2016 13:46:11 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55101 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751395AbcFNRqJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jun 2016 13:46:09 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8CAA324C5C;
	Tue, 14 Jun 2016 13:46:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Ppity6JToOxWVYANdzPYice+EdY=; b=c3DR+E
	SQcBkGMhvxSuIpSMzkjjAfQDWhYRM6zv886kIKYoiozgjVg6KVBnYYD8yq7fx3xK
	Ywo2NLT2RjZwq0KfIXTHdbBGv8bG74L9kPFOBAaJshPZP9plzr7oosrtjI07HWJ1
	7MZV4rsIifxfbyOGSI91HWMX8n4/vM10j0Cu4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XSDtg2sBvA86HdJilH4//PCQw20sgaBr
	svuyUZ4XeuadKkLcIx0g/dvMIrh6cNdbgWrUEf1RZ4I3z3EdT0+2OUMPfuzP+17p
	xGLFm9NOlGA17jcLuf5QNJGSC04GHhk5A5+SV62n8jC6pysVihtZBbhLRwENViTC
	YrwGrT8zao4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 85CF824C5B;
	Tue, 14 Jun 2016 13:46:08 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 11D5D24C5A;
	Tue, 14 Jun 2016 13:46:08 -0400 (EDT)
In-Reply-To: <xmqqtwgvadru.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Tue, 14 Jun 2016 10:20:05 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: DFDE8C2A-3257-11E6-AF14-89D312518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297311>

"git blame --reverse OLD..NEW -- PATH" tells us to start from the
contents in PATH at OLD and observe how each line is changed while
the history developers up to NEW, and report for each line the
latest commit up to which the line survives in the original form.

If you say "git blame --reverse NEW -- PATH" by mistake, we complain
about the missing OLD, but we phrased it as "No commit to dig down
to?"  In this case, however, we are digging up from OLD, so say so.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * There was another instance of "dig down to" in the same function.

 Documentation/git-blame.txt | 2 +-
 builtin/blame.c             | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-blame.txt b/Documentation/git-blame.txt
index ba54175..16323eb 100644
--- a/Documentation/git-blame.txt
+++ b/Documentation/git-blame.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 [verse]
 'git blame' [-c] [-b] [-l] [--root] [-t] [-f] [-n] [-s] [-e] [-p] [-w] [--incremental]
 	    [-L <range>] [-S <revs-file>] [-M] [-C] [-C] [-C] [--since=<date>]
-	    [--progress] [--abbrev=<n>] [<rev> | --contents <file> | --reverse <rev>]
+	    [--progress] [--abbrev=<n>] [<rev> | --contents <file> | --reverse <rev>..<rev>]
 	    [--] <file>
 
 DESCRIPTION
diff --git a/builtin/blame.c b/builtin/blame.c
index 21f42b0..a027b8a 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -2466,14 +2466,14 @@ static char *prepare_initial(struct scoreboard *sb)
 		if (obj->type != OBJ_COMMIT)
 			die("Non commit %s?", revs->pending.objects[i].name);
 		if (sb->final)
-			die("More than one commit to dig down to %s and %s?",
+			die("More than one commit to dig up from, %s and %s?",
 			    revs->pending.objects[i].name,
 			    final_commit_name);
 		sb->final = (struct commit *) obj;
 		final_commit_name = revs->pending.objects[i].name;
 	}
 	if (!final_commit_name)
-		die("No commit to dig down to?");
+		die("No commit to dig up from?");
 	return xstrdup(final_commit_name);
 }
 
-- 
2.9.0-290-g8794d48
