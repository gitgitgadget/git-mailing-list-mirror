From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: git-format-patch possible regressions
Date: Sat, 27 May 2006 11:12:56 +0200
Message-ID: <e5bfff550605270212n267661rd0463a301cbe1b95@mail.gmail.com>
References: <e5bfff550605251223g2cf8cfb9vfa18d016b369188d@mail.gmail.com>
	 <7vhd3dubd9.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.63.0605252338530.31700@wbgn013.biozentrum.uni-wuerzburg.de>
	 <Pine.LNX.4.63.0605260014340.13003@wbgn013.biozentrum.uni-wuerzburg.de>
	 <7vy7wpr97n.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.63.0605260125420.16816@wbgn013.biozentrum.uni-wuerzburg.de>
	 <e5bfff550605252309h2c4b74bcp50b095e09e6c133f@mail.gmail.com>
	 <7v4pzdqpit.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 27 11:13:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fjuqy-0007OO-O3
	for gcvg-git@gmane.org; Sat, 27 May 2006 11:13:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751450AbWE0JM6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 27 May 2006 05:12:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751451AbWE0JM6
	(ORCPT <rfc822;git-outgoing>); Sat, 27 May 2006 05:12:58 -0400
Received: from wr-out-0506.google.com ([64.233.184.239]:27605 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751450AbWE0JM5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 27 May 2006 05:12:57 -0400
Received: by wr-out-0506.google.com with SMTP id i21so208070wra
        for <git@vger.kernel.org>; Sat, 27 May 2006 02:12:57 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CCj34y7wAOFRDcVlNX9trNk8+GUchOdK//K2Qw45umu+rTYnwGIAhO4KpTzBzY+h6EfL/bW6Vvmg5ahAIKzgbeYaz+YP9mIPboKK46K/rSG6giZawAyu1RKRJ5ub6adETzP/43XAUOjrVrlagjleQD+11VhNlTKQTZiHkePL0H0=
Received: by 10.65.180.2 with SMTP id h2mr102262qbp;
        Sat, 27 May 2006 02:12:56 -0700 (PDT)
Received: by 10.65.163.7 with HTTP; Sat, 27 May 2006 02:12:56 -0700 (PDT)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7v4pzdqpit.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20840>

On 5/26/06, Junio C Hamano <junkio@cox.net> wrote:
>
> What Johannes and I were discussing was the other number -- the
> total in the series.  IOW, y in "[PATCH x/y]".  OTOH, the number
> used for disambiguation you care about is x, which is made
> adjustable with --start-number patch.
>

New --start-number patch says:

"Since the "a..b c..d" syntax is interpreted as "b ^a d ^c" as other
range-ish commands, if you want to format a..b and then c..d and end
up with files consecutively numbered, the second run needs to be able
to tell the command what number to start from.

This does not imply --numbered (which gives [PATCH n/m] to the subject)."

Actually it seems that --numbered is needed anyway.

$ git-format-patch HEAD^..HEAD
0000-git-format-patch-start-number-n.txt
$ git-format-patch --start-number=7 HEAD^..HEAD
0000-git-format-patch-start-number-n.txt
$ git-format-patch --numbered --start-number=7 HEAD^..HEAD
0007-git-format-patch-start-number-n.txt

But with numbered also the patch subject is changed with added [PATCH n/m] that
is not needed.

Also mutually exclusive check is not performed
git-format-patch -n -k HEAD^..HEAD
0001-git-format-patch-start-number-n.txt

This patch should fix all.

Subject: [PATCH] Let git-format-patch --start-number option to work
also without --numbered

While there also fix the check for mutually exclusive -n and -k option

Signed-off-by: Marco Costalba <mcostalba@gmail.com>
---
 builtin-log.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin-log.c b/builtin-log.c
index 71f4ff9..c35733f 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -148,7 +148,7 @@ int cmd_format_patch(int argc, const cha
 	int nr = 0, total, i, j;
 	int use_stdout = 0;
 	int numbered = 0;
-	int start_number = -1;
+	int start_number = 0;
 	int keep_subject = 0;

 	init_revisions(&rev);
@@ -201,9 +201,9 @@ int cmd_format_patch(int argc, const cha
 	}
 	argc = j;

-	if (numbered && start_number < 0)
+	if (numbered && start_number == 0)
 		start_number = 1;
-	if (numbered && keep_subject < 0)
+	if (numbered && keep_subject)
 		die ("-n and -k are mutually exclusive.");

 	argc = setup_revisions(argc, argv, &rev, "HEAD");
@@ -233,7 +233,7 @@ int cmd_format_patch(int argc, const cha
 	while (0 <= --nr) {
 		int shown;
 		commit = list[nr];
-		rev.nr = rev.total - nr;
+		rev.nr = start_number + total - nr - 1;
 		if (!use_stdout)
 			reopen_stdout(commit, rev.nr, keep_subject);
 		shown = log_tree_commit(&rev, commit);
-- 
1.3.3.gfa0f-dirty
