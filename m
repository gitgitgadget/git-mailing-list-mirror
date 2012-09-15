From: Luke Diamand <luke@diamand.org>
Subject: Re: [PATCHv2 04/12] git p4: move conflict prompt into run, add [q]uit
 input
Date: Sat, 15 Sep 2012 22:56:05 +0100
Message-ID: <5054F975.6090608@diamand.org>
References: <1347221773-12773-1-git-send-email-pw@padd.com> <1347221773-12773-5-git-send-email-pw@padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Sat Sep 15 23:56:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TD0La-0005LF-4W
	for gcvg-git-2@plane.gmane.org; Sat, 15 Sep 2012 23:56:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753396Ab2IOV4J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Sep 2012 17:56:09 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:57864 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752207Ab2IOV4I (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Sep 2012 17:56:08 -0400
Received: by wibhi8 with SMTP id hi8so1121125wib.1
        for <git@vger.kernel.org>; Sat, 15 Sep 2012 14:56:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=IZnHmwXQ97rkQyclLQGSkAp18LqO9m7ddhYrrTOVTyA=;
        b=AciStCKsuY8Vae9FOCM7myJcOEO9BC+FppN11SRl79WlJFoFNOiOJ6ju1qnkwiNxm9
         uGAH0o6RFPfDhgglZX0dJmJC0yX1j+XPbTobb40fjdSTnlDReLs/F3tsrWivnSP/WLGm
         qbyh0kzqdy05fC4y87MiMAeL9DWaDirz36hGfgTQnvIeWWLdIy9TZfPYNbgYuBb6Bp/e
         5Du+dmG8vZlUhGxWJlBpPvXKV4dk2w3jM2rtYGuLan5u8+ysXy/u9jeaaz//BtnADhSR
         3OQlkPy3fUP6W8xiyJlfdqcAU9Ybdzfi2HMM40FyFP9gu3NSdTwzix127rbWMXJ8Mygf
         UoCw==
Received: by 10.180.93.8 with SMTP id cq8mr6647053wib.16.1347746166926;
        Sat, 15 Sep 2012 14:56:06 -0700 (PDT)
Received: from [86.6.26.120] (cpc21-cmbg14-2-0-cust119.5-4.cable.virginmedia.com. [86.6.26.120])
        by mx.google.com with ESMTPS id cu1sm7736083wib.6.2012.09.15.14.56.05
        (version=SSLv3 cipher=OTHER);
        Sat, 15 Sep 2012 14:56:06 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.4) Gecko/20120510 Icedove/10.0.4
In-Reply-To: <1347221773-12773-5-git-send-email-pw@padd.com>
X-Gm-Message-State: ALoCoQnnSkSvqb71ob1c3K9RCsi0GL79YluNppoT5brvNPbSvroiN9jj2DREAKRvQfK7LbuXBBxW
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205586>


I'll need to supply a followup patch to ensure that a config option can 
override the prompt.

Ack.

On 09/09/12 21:16, Pete Wyckoff wrote:
> When applying a commit to the p4 workspace fails, a prompt
> asks what to do next.  This belongs up in run() instead
> of in applyCommit(), where run() can notice, for instance,
> that the prompt is unnecessary because this is the last commit.
>
> Offer two options about how to continue at conflict: [s]kip or
> [q]uit.  Having an explicit "quit" option gives git p4 a chance
> to clean up, show the applied-commit summary, and do tag export.
>
> Signed-off-by: Pete Wyckoff<pw@padd.com>
> ---
>   git-p4.py                     | 41 +++++++++++++++++++++++++++++------------
>   t/t9815-git-p4-submit-fail.sh | 31 +++++++++++++++++++++++++++----
>   2 files changed, 56 insertions(+), 16 deletions(-)
>
> diff --git a/git-p4.py b/git-p4.py
> index e08fea1..479f1fc 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -1198,17 +1198,11 @@ class P4Submit(Command, P4UserMap):
>                       patch_succeeded = True
>
>           if not patch_succeeded:
> -            print "What do you want to do?"
> -            response = "x"
> -            while response != "s":
> -                response = raw_input("[s]kip this patch ")
> -            if response == "s":
> -                print "Skipping! Good luck with the next patches..."
> -                for f in editedFiles:
> -                    p4_revert(f)
> -                for f in filesToAdd:
> -                    os.remove(f)
> -                return False
> +            for f in editedFiles:
> +                p4_revert(f)
> +            for f in filesToAdd:
> +                os.remove(f)
> +            return False
>
>           system(applyPatchCmd)
>
> @@ -1475,11 +1469,34 @@ class P4Submit(Command, P4UserMap):
>           if gitConfig("git-p4.detectCopiesHarder", "--bool") == "true":
>               self.diffOpts += " --find-copies-harder"
>
> +        #
> +        # Apply the commits, one at a time.  On failure, ask if should
> +        # continue to try the rest of the patches, or quit.
> +        #
>           applied = []
> -        for commit in commits:
> +        last = len(commits) - 1
> +        for i, commit in enumerate(commits):
>               ok = self.applyCommit(commit)
>               if ok:
>                   applied.append(commit)
> +            else:
> +                if i<  last:
> +                    quit = False
> +                    while True:
> +                        print "What do you want to do?"
> +                        response = raw_input("[s]kip this commit but apply"
> +                                             " the rest, or [q]uit? ")
> +                        if not response:
> +                            continue
> +                        if response[0] == "s":
> +                            print "Skipping this commit, but applying the rest"
> +                            break
> +                        if response[0] == "q":
> +                            print "Quitting"
> +                            quit = True
> +                            break
> +                    if quit:
> +                        break
>
>           chdir(self.oldWorkingDirectory)
>
> diff --git a/t/t9815-git-p4-submit-fail.sh b/t/t9815-git-p4-submit-fail.sh
> index 5c36714..397b3e8 100755
> --- a/t/t9815-git-p4-submit-fail.sh
> +++ b/t/t9815-git-p4-submit-fail.sh
> @@ -18,7 +18,7 @@ test_expect_success 'init depot' '
>   	)
>   '
>
> -test_expect_success 'conflict on one commit, skip' '
> +test_expect_success 'conflict on one commit' '
>   	test_when_finished cleanup_git&&
>   	git p4 clone --dest="$git" //depot&&
>   	(
> @@ -34,12 +34,12 @@ test_expect_success 'conflict on one commit, skip' '
>   		echo line3>>file1&&
>   		git add file1&&
>   		git commit -m "line3 in file1 will conflict"&&
> -		echo s | test_expect_code 1 git p4 submit>out&&
> +		test_expect_code 1 git p4 submit>out&&
>   		test_i18ngrep "No commits applied" out
>   	)
>   '
>
> -test_expect_success 'conflict on second of two commits, skip' '
> +test_expect_success 'conflict on second of two commits' '
>   	test_when_finished cleanup_git&&
>   	git p4 clone --dest="$git" //depot&&
>   	(
> @@ -57,7 +57,7 @@ test_expect_success 'conflict on second of two commits, skip' '
>   		echo line4>>file1&&
>   		git add file1&&
>   		git commit -m "line4 in file1 will conflict"&&
> -		echo s | test_expect_code 1 git p4 submit>out&&
> +		test_expect_code 1 git p4 submit>out&&
>   		test_i18ngrep "Applied only the commits" out
>   	)
>   '
> @@ -85,6 +85,29 @@ test_expect_success 'conflict on first of two commits, skip' '
>   	)
>   '
>
> +test_expect_success 'conflict on first of two commits, quit' '
> +	test_when_finished cleanup_git&&
> +	git p4 clone --dest="$git" //depot&&
> +	(
> +		cd "$cli"&&
> +		p4 open file1&&
> +		echo line7>>file1&&
> +		p4 submit -d "line7 in file1"
> +	)&&
> +	(
> +		cd "$git"&&
> +		git config git-p4.skipSubmitEdit true&&
> +		# this submit should cause a conflict
> +		echo line8>>file1&&
> +		git add file1&&
> +		git commit -m "line8 in file1 will conflict"&&
> +		# but this commit is okay
> +		test_commit "okay_commit_after_quit"&&
> +		echo q | test_expect_code 1 git p4 submit>out&&
> +		test_i18ngrep "No commits applied" out
> +	)
> +'
> +
>   test_expect_success 'kill p4d' '
>   	kill_p4d
>   '
