From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v7] contrib/subtree: fix "subtree split" skipped-merge bug
Date: Thu, 14 Jan 2016 20:06:28 -0500
Message-ID: <CAPig+cS3hCjkb7bc6Z8CMFBU81Mp1Nn=xUUu4ZveVzOWAM5Ybw@mail.gmail.com>
References: <1452806795-26621-1-git-send-email-davidw@realtimegenomics.com>
	<1452818503-21079-1-git-send-email-davidw@realtimegenomics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Dave Ware <davidw@realtimegenomics.com>
X-From: git-owner@vger.kernel.org Fri Jan 15 02:06:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJsqZ-0004hC-2D
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jan 2016 02:06:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754828AbcAOBGa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2016 20:06:30 -0500
Received: from mail-qk0-f193.google.com ([209.85.220.193]:33955 "EHLO
	mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754761AbcAOBG3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2016 20:06:29 -0500
Received: by mail-qk0-f193.google.com with SMTP id y67so3949285qkc.1
        for <git@vger.kernel.org>; Thu, 14 Jan 2016 17:06:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=w/JlpqBTAnvxrOk4izEIw0Q10lZduor62zeKPU5vhB4=;
        b=y09SBA5q+NMpNRPOS1mnsA5S1yiXJW27h9Z2Aco78mJnAcPJ7ubnGRDlwDuGEV84m4
         k/O+1VM1ama/1N9t/Eb7zfJrvLLVZWVj6sjYirm85DcmAjR1c4ZR1B5G52PcAFNJ0YVL
         Uxek3SFnTXpS1jbKxarbDK1WRuvKsEkMGr3HL7hLJwD5fp+1lOIxw6C7i1Eayxc96oTK
         EQDuwou2iA6Ul21CVuHsUU72+REExxX5ZBNwia/4L4Cj+V4rVGcY4/V40PsjlNTzvFpF
         N4ej2ue4yq8iAsBSWjQnuOBHM7P/CINPyCC06kTMmt4m8KCB5hiDUYVEwkDN4YA6YuOz
         OVag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=w/JlpqBTAnvxrOk4izEIw0Q10lZduor62zeKPU5vhB4=;
        b=GxLnmtgvQmIjKjUfWEygtmN41is/+0fWauFoH3F5mTCJFmo7YOMik0q1N9Tv5aNkCP
         550TPg+w6I2oDLZmBd8jYJnnkdeWIlC0Fg1AnV/7SDz9z8yXhRcrNYaif2RQ83Lcrhd1
         2NWjVHkNS6gEOksOiymK6pujsEciRzuUZzEluf6wJhZ+GOqqzzpdpyaS3baXSRqT5iUb
         usO95QM8UwoCuWDCnfbvAMSXd3pTSHHqg9L50pMCWtnJprr5Nnl/ossjhK/kYOXehUre
         j1CwyupYAnFZKSQtl2tJgQLmOUmjKfJriaj5Si5XFy8qeUQBbreWCTWG61SwJkbABsBQ
         VFDw==
X-Gm-Message-State: ALoCoQm8Aw2UdBgzKMjiCC4fYVlJqVzRmjEi3Ml5gVqjLnXveAk6CCp4OqNwzMOAV3ypuSuWFdp78SuaTRNMpkV+AaVoGO8+yA==
X-Received: by 10.55.78.131 with SMTP id c125mr9554277qkb.71.1452819988886;
 Thu, 14 Jan 2016 17:06:28 -0800 (PST)
Received: by 10.233.221.1 with HTTP; Thu, 14 Jan 2016 17:06:28 -0800 (PST)
In-Reply-To: <1452818503-21079-1-git-send-email-davidw@realtimegenomics.com>
X-Google-Sender-Auth: Admwdcp7rmKig37Ut6hRGLHlyDA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284127>

On Thu, Jan 14, 2016 at 7:41 PM, Dave Ware <davidw@realtimegenomics.com> wrote:
> 'git subtree split' can incorrectly skip a merge even when both parents
> act on the subtree, provided the merge results in a tree identical to
> one of the parents. Fix by copying the merge if at least one parent is
> non-identical, and the non-identical parent is not an ancestor of the
> identical parent.
>
> Also, add a test case which checks that a descendant remains a
> descendent on the subtree in this case.
>
> Signed-off-by: Dave Ware <davidw@realtimegenomics.com>
> ---
> diff --git a/contrib/subtree/t/t7900-subtree.sh b/contrib/subtree/t/t7900-subtree.sh
> @@ -1014,4 +1014,64 @@ test_expect_success 'push split to subproj' '
> +# This test covers 2 cases in subtree split copy_or_skip code
> +# 1) Merges where one parent is a superset of the changes of the other
> +#    parent regarding changes to the subtree, in this case the merge
> +#    commit should be copied
> +# 2) Merges where only one parent operate on the subtree, and the merge

s/operate/operates/

> +#    commit should be skipped
> +#
> +next_test
> +test_expect_success 'subtree descendant check' '
> +       subtree_test_create_repo "$subtree_test_count" &&
> +       test_create_commit "$subtree_test_count" folder_subtree/a &&
> +       (
> +               cd "$subtree_test_count" &&
> +               git branch branch

Not worth a re-roll (and probably not worthwhile anyhow since it would
be inconsistent with the rest of the script), but for these really
simple cases, you can use -C and avoid the subshell altogether:

    git -C "$subtree_test_count" branch branch

> +       ) &&
> +       test_create_commit "$subtree_test_count" folder_subtree/0 &&
> +       test_create_commit "$subtree_test_count" folder_subtree/b &&
> +       cherry=$(cd "$subtree_test_count"; git rev-parse HEAD) &&
> +       (
> +               cd "$subtree_test_count" &&
> +               git checkout branch
> +       ) &&
> +       test_create_commit "$subtree_test_count" commit_on_branch &&
> +       (
> +               cd "$subtree_test_count" &&
> +               git cherry-pick $cherry &&
> +               git checkout master &&
> +               git merge -m "merge should be kept on subtree" branch &&
> +               git branch no_subtree_work_branch
> +       ) &&
> +       test_create_commit "$subtree_test_count" folder_subtree/d &&
> +       (
> +               cd "$subtree_test_count" &&
> +               git checkout no_subtree_work_branch
> +       ) &&
> +       test_create_commit "$subtree_test_count" not_a_subtree_change &&
> +       (
> +               cd "$subtree_test_count" &&
> +               git checkout master &&
> +               git merge -m "merge should be skipped on subtree" no_subtree_work_branch &&
> +
> +               git subtree split --prefix folder_subtree/ --branch subtree_tip master &&
> +               git subtree split --prefix folder_subtree/ --branch subtree_branch branch &&
> +               check_equal $(git rev-list --count subtree_tip..subtree_branch) 0
> +       )
> +'
> +
>  test_done
