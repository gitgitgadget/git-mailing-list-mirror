From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Improving merge messages for 1.7.10 and making "pull" easier
Date: Fri, 24 Feb 2012 10:59:00 +0100
Message-ID: <CACBZZX5UVq9k7jvSy3m+yMVj7_JbfLp8ugFWf2gGFdMz_8GPEA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Thomas Rast <trast@student.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Feb 24 10:59:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S0rvz-0006B1-Kf
	for gcvg-git-2@plane.gmane.org; Fri, 24 Feb 2012 10:59:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756694Ab2BXJ7W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Feb 2012 04:59:22 -0500
Received: from mail-wi0-f174.google.com ([209.85.212.174]:45846 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756690Ab2BXJ7V (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Feb 2012 04:59:21 -0500
Received: by wicr5 with SMTP id r5so94232wic.19
        for <git@vger.kernel.org>; Fri, 24 Feb 2012 01:59:20 -0800 (PST)
Received-SPF: pass (google.com: domain of avarab@gmail.com designates 10.180.93.194 as permitted sender) client-ip=10.180.93.194;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of avarab@gmail.com designates 10.180.93.194 as permitted sender) smtp.mail=avarab@gmail.com; dkim=pass header.i=avarab@gmail.com
Received: from mr.google.com ([10.180.93.194])
        by 10.180.93.194 with SMTP id cw2mr3400564wib.0.1330077560393 (num_hops = 1);
        Fri, 24 Feb 2012 01:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:cc:content-type;
        bh=iWCkGuthablMhtgL0gsI/3ioODX/L52d65xJcBzkXe8=;
        b=u4eQT+chPIp6iktKDcflrlkfXqzRe5piDA3WlRCnqa3oP1GMKDIGPdumzJ1mRhK4Yj
         y33Q7H5GNfhv+9i0zVoKb85/p9uhDLjmg4718HfJ71YKcoStABTunEDcrJtBy8n51XSR
         /swGHc0y+qlP1RLjL9YqSfpoTnXEGnTXHdZg4=
Received: by 10.180.93.194 with SMTP id cw2mr2727845wib.0.1330077560222; Fri,
 24 Feb 2012 01:59:20 -0800 (PST)
Received: by 10.223.69.133 with HTTP; Fri, 24 Feb 2012 01:59:00 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191424>

With 1.7.10 we'll get merge edit messages by default (which I like)
but I wonder if we could better clarify this to users when they see a
merge message pop up.

Firstly (and as a more general thing) I think we should add a mention
of "git merge --abort" to the message, just saving an empty file is
not sufficient to fully clear the merge state:

    diff --git a/builtin/merge.c b/builtin/merge.c
    index d3e1e8d..9169c74 100644
    --- a/builtin/merge.c
    +++ b/builtin/merge.c
    @@ -889,8 +889,8 @@ static const char merge_editor_comment[] =
     N_("Please enter a commit message to explain why this merge is
necessary,\n"
        "especially if it merges an updated upstream into a topic branch.\n"
        "\n"
    -   "Lines starting with '#' will be ignored, and an empty message aborts\n"
    -   "the commit.\n");
    +   "Lines starting with '#' will be ignored, and an empty message
followed\n"
    +   "by 'git merge --abort' the merge.\n");

     static void prepare_to_commit(void)
     {

Additionally, perhaps it would be a good idea to:

 * Detect if the user didn't run this explicitly but implicitly from a
   "git pull". We could pass some env var along or another option
   (e.g. --internal-from-porcelain=pull) and add this:

       You've merged implicitly via a "git pull", if you're just
       updating some local work in progress to keep up with upstream
       you may want to use "git pull --rebase" instead (or set the
       pull.rebase configuration variable) to rebase instead of merge.

 * Explicitly check if we're merging an updated upstream into the
   work-in-progress topic, then mentioning some succinct version of
   Junio's #1 point at
   http://git-blame.blogspot.com/2012/02/anticipating-git-1710.html

I work with a lot of inexperienced git users and a lot of them are
going to be very confused by this change. I still think it's a good
change to make, but we could do a lot more to mitigate the inevitable
confusion.

One thing that would help these users in particular would be to have
some easy to use replacement for their frequent use of "git
pull".

They don't often commit their work (because of git inexperience) so
rebasing will error out because the tree is unclean. I tried to hack
support for unclean trees into git-rebase(1) the other day but it was
difficult because at various points in the process it'll do a "git
reset --hard".

Maybe having an option to "git pull" that would make it do:

    git stash save --include-untracked -- "Automatically created stash
by \"git pull\" at $(date)"
    git pull --rebase
    git stash pop

Would make things easier. It could be called "git pull --rebase
--stash".
