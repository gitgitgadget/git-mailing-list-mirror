From: Luke Diamand <luke@diamand.org>
Subject: Re: git-p4.skipSubmitEdit
Date: Mon, 12 Sep 2011 08:34:08 +0100
Message-ID: <4E6DB5F0.7080303@diamand.org>
References: <1315514452.10046.0.camel@uncle-pecos>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: "L. A. Linden Levy" <alevy@mobitv.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 12 09:34:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3123-0003lr-CO
	for gcvg-git-2@lo.gmane.org; Mon, 12 Sep 2011 09:34:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752969Ab1ILHeO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Sep 2011 03:34:14 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:37812 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751824Ab1ILHeN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Sep 2011 03:34:13 -0400
Received: by wyh22 with SMTP id 22so3184296wyh.19
        for <git@vger.kernel.org>; Mon, 12 Sep 2011 00:34:11 -0700 (PDT)
Received: by 10.216.131.39 with SMTP id l39mr1036070wei.39.1315812851891;
        Mon, 12 Sep 2011 00:34:11 -0700 (PDT)
Received: from [86.26.7.206] (cpc1-cmbg14-2-0-cust973.5-4.cable.virginmedia.com [86.26.7.206])
        by mx.google.com with ESMTPS id y28sm15251650wbn.17.2011.09.12.00.34.10
        (version=SSLv3 cipher=OTHER);
        Mon, 12 Sep 2011 00:34:10 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:6.0.2) Gecko/20110902 Thunderbird/6.0.2
In-Reply-To: <1315514452.10046.0.camel@uncle-pecos>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181212>

On 08/09/11 21:40, L. A. Linden Levy wrote:
> Hi All,
>
> I have been using git-p4 for a while and it has allowed me to completely
> change the way I develop and still be able to use perforce which my
> company has for its main VCS. One thing that was driving me nuts was
> that "git p4 submit" cycles through all of my individual commits and
> asks me if I want to change them. The way I develop I often am checking
> in 20 to 50 different small commits each with a descriptive git comment.
> I felt like I was doing double duty by having emacs open on every commit
> into perforce. So I modified git-p4 to have an option to skip the
> editor. This option coupled with git-p4.skipSubmitEditCheck will make
> the submission non-interactive for "git p4 submit".


Sorry - I've not had a chance to look at this before now. But a couple 
of comments:

  - Is there a line wrap problem in the patch? It doesn't seem to want 
to apply for me.

  - needs an update to the documentation in git-p4.txt

  - is there any way to eliminate the slightly ugly 
"if/pass/else/do-stuff" construct?

  - I'd think if you turned off the editor completely then there's no 
point doing the submit-edit-check.

  - You probably need to follow the instructions in 
Documentation/SubmittingPatches so that Junio will pay attention to the 
patch.

Regards!
Luke


>
> Below are the patch and environment results:
>
>
> $ git config -l
> ...
> user.name=Loren A. Linden Levy
> git-p4.skipsubmitedit=true
> git-p4.skipsubmiteditcheck=true
> ...
>
> $ git format-patch origin/master --stdout
>
>  From 16c4344de0047cbaf3381eca590a3e59b0d0a25c Mon Sep 17 00:00:00 2001
> From: "Loren A. Linden Levy"<lindenle@gmail.com>
> Date: Thu, 8 Sep 2011 13:37:22 -0700
> Subject: [PATCH] changed git-p4
>
> ---
>   contrib/fast-import/git-p4 |   15 ++++++++++-----
>   1 files changed, 10 insertions(+), 5 deletions(-)
>
> diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
> index 2f7b270..a438b3e 100755
> --- a/contrib/fast-import/git-p4
> +++ b/contrib/fast-import/git-p4
> @@ -935,18 +935,23 @@ class P4Submit(Command, P4UserMap):
>               tmpFile.write(submitTemplate + separatorLine + diff +
> newdiff)
>               tmpFile.close()
>               mtime = os.stat(fileName).st_mtime
> -            if os.environ.has_key("P4EDITOR"):
> -                editor = os.environ.get("P4EDITOR")
> +            if gitConfig("git-p4.skipSubmitEdit") == "true":
> +                pass
>               else:
> -                editor = read_pipe("git var GIT_EDITOR").strip()
> -            system(editor + " " + fileName)
> -
> +                if os.environ.has_key("P4EDITOR"):
> +                    editor = os.environ.get("P4EDITOR")
> +                else:
> +                    editor = read_pipe("git var GIT_EDITOR").strip()
> +
> +                    system(editor + " " + fileName)
> +
>               if gitConfig("git-p4.skipSubmitEditCheck") == "true":
>                   checkModTime = False
>               else:
>                   checkModTime = True
>
>               response = "y"
> +
>               if checkModTime and (os.stat(fileName).st_mtime<= mtime):
>                   response = "x"
>                   while response != "y" and response != "n":
