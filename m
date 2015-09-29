From: Junio C Hamano <gitster@pobox.com>
Subject: Re: 2.6.0: Comment in rebase instruction has become too rigid
Date: Tue, 29 Sep 2015 11:17:46 -0700
Message-ID: <xmqqk2r99jjp.fsf@gitster.mtv.corp.google.com>
References: <CAEY4ZpN0C96jU4Tgvqt-hWEviR-sapDoyAv88H+opPSr-cs=mg@mail.gmail.com>
	<vpqr3lhb719.fsf@grenoble-inp.fr> <vpqzj0588i2.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Nazri Ramliy <ayiehere@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Sep 29 20:18:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZgzTQ-00048r-5z
	for gcvg-git-2@plane.gmane.org; Tue, 29 Sep 2015 20:17:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935403AbbI2SRx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Sep 2015 14:17:53 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:33312 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935330AbbI2SRu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Sep 2015 14:17:50 -0400
Received: by pacex6 with SMTP id ex6so13090289pac.0
        for <git@vger.kernel.org>; Tue, 29 Sep 2015 11:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=bjrX0PLEY02EQL8HUJcRBDetc29HMCM2BBc2ZAkEn4c=;
        b=J374U58JgaEwyckNM+bPcB0WOupEQbdieD/nYwbvIz0ToPN976U0dhGuGK8J9BvF2d
         e9XUcKXgGJ4uFa8QH3felCXR1vNQPUr8dXIdp96ZHyKXsNAI3YyHUIci1UlB6y7yepgo
         fKuIlZp/KKLs2lpZERZvy7gpoOHtOSwNW2aqzlwMi6mGl4zbaB3xeVdb+hrx0gRbcSZM
         G6N5ClXKTjjMvf/+tNsPNsDpaJzEiwBGXD5VuLyCYb0HK4S7a5bhdvZUehmT3ek4cgMA
         ydC9HeXWS2oBQrPOMolr7i3M5dllPJa0ncHtTua0GChoGvekJVgTi926mvHuYBXI/xnr
         Jq0Q==
X-Received: by 10.68.69.47 with SMTP id b15mr33799065pbu.139.1443550670018;
        Tue, 29 Sep 2015 11:17:50 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:b19c:d31d:b45e:3f4e])
        by smtp.gmail.com with ESMTPSA id of1sm26843637pbc.11.2015.09.29.11.17.47
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 29 Sep 2015 11:17:47 -0700 (PDT)
In-Reply-To: <vpqzj0588i2.fsf@grenoble-inp.fr> (Matthieu Moy's message of
	"Tue, 29 Sep 2015 19:01:41 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278831>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

>> Confirmed: Git 2.1.4 accepts this, 2.6 doesn't:
>>
>> Warning: the command isn't recognized in the following line:
>>  - # pick dbafac11052a0075233bdcf0b71f54d1503aa82d test
>>
>> You can fix this with 'git rebase --edit-todo'.
>> Or you can abort the rebase with 'git rebase --abort'.
>>
>> I didn't bisect, but I guess this was introduced in the series
>> introducing this check on the todolist before starting the bisection.
>
> Indeed:
>
> 804098bb30a5339cccb0be981a3e876245aa0ae5 is the first bad commit

Yup, before that series, expand_todo_ids -> transfom_todo_ids ended
up reading each line with "while read -r command rest" loop and the
we did not honor the usual "# at the beginning line is the comment"
convention, which I think was a bug.  With that commit, a separate
step in check_bad_cmd_and_sha1 uses a similar looking "while read"
loop but forgets to take '#' into account.

I know you alluded to preprocess what is fed to stripspace, but I
wonder if we can remove the misguided call to stripspace in the
first place and do something like the attached instead.

 git-rebase--interactive.sh | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index f01637b..a64f77a 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -886,7 +886,6 @@ check_commit_sha () {
 # from the todolist in stdin
 check_bad_cmd_and_sha () {
 	retval=0
-	git stripspace --strip-comments |
 	(
 		while read -r line
 		do
@@ -896,7 +895,7 @@ check_bad_cmd_and_sha () {
 			sha1=$2
 
 			case $command in
-			''|noop|x|"exec")
+			'#'*|''|noop|x|"exec")
 				# Doesn't expect a SHA-1
 				;;
 			pick|p|drop|d|reword|r|edit|e|squash|s|fixup|f)
