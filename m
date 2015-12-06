From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH 1/2] git-p4: support multiple depot paths in p4 submit
Date: Sun, 6 Dec 2015 12:56:35 +0100
Message-ID: <F328D5D9-754A-41CC-A7B2-993B9315ED33@gmail.com>
References: <20151205112203.GA15745@hocevar.net>
Mime-Version: 1.0 (Mac OS X Mail 9.1 \(3096.5\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Git Users <git@vger.kernel.org>, Luke Diamand <luke@diamand.org>,
	Pete Wyckoff <pw@padd.com>
To: Sam Hocevar <sam@hocevar.net>
X-From: git-owner@vger.kernel.org Sun Dec 06 12:56:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a5Xvp-0005g5-ME
	for gcvg-git-2@plane.gmane.org; Sun, 06 Dec 2015 12:56:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752987AbbLFL4l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Dec 2015 06:56:41 -0500
Received: from mail-wm0-f48.google.com ([74.125.82.48]:35136 "EHLO
	mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752399AbbLFL4k convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 Dec 2015 06:56:40 -0500
Received: by wmuu63 with SMTP id u63so109972142wmu.0
        for <git@vger.kernel.org>; Sun, 06 Dec 2015 03:56:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=87UAzcfoIlc5iKoQGJp1iH3SDJ9wrXbtgtA2iUZrEvY=;
        b=eU/u4cNoCeqxeJ3oITHo0iGkiFgrrPEh7MCLmfr58UG3YTx5HGkDueEeXOzE7fvbQQ
         JNIzoJKkDXjrvQGOyNmDaFHk1YKcgByrxj7vaoyLsHW+jLQethuXP7GxwkOxzUYuDhr7
         dzlcOXCuNGCoa9PPz6+S24Of7mKLpwobZGjuesIpyzxjnj5LNkGvQrywt3NlMSv4F7at
         Hm8gKMK8ZTrxvfFpIOegf3eKmJdL8GQeduuJYZX/QKQSibecNSCW/XOzgtKIeXJ0Iudu
         /IyD28sJ/6/WWo8rgr5tfAZVFGvUbiClZiiKRanCBeRMw4C3c4q/ppn5ue7of1uHLUeK
         dZGQ==
X-Received: by 10.194.2.193 with SMTP id 1mr27843799wjw.26.1449402999374;
        Sun, 06 Dec 2015 03:56:39 -0800 (PST)
Received: from [10.32.248.55] (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id vr10sm20477248wjc.38.2015.12.06.03.56.37
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 06 Dec 2015 03:56:38 -0800 (PST)
In-Reply-To: <20151205112203.GA15745@hocevar.net>
X-Mailer: Apple Mail (2.3096.5)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282048>

Thanks for the patch! Do you see a way to demonstrate the bug in a test case similar to t9821 [1]?

Cheers,
Lars

[1] https://github.com/git/git/blob/master/t/t9821-git-p4-path-variations.sh

> On 05 Dec 2015, at 12:22, Sam Hocevar <sam@hocevar.net> wrote:
> 
> When submitting from a repository that was cloned using a client spec,
> use the full list of paths when ruling out files that are outside the
> view.  This fixes a bug where only files pertaining to the first path
> would be included in the p4 submit.
> 
> Signed-off-by: Sam Hocevar <sam@hocevar.net>
> ---
> git-p4.py | 11 +++++++++--
> 1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/git-p4.py b/git-p4.py
> index a79b6d8..210f100 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -1253,6 +1253,8 @@ class P4Submit(Command, P4UserMap):
>            Remove lines in the Files section that show changes to files
>            outside the depot path we're committing into."""
> 
> +        [upstream, settings] = findUpstreamBranchPoint()
> +
>         template = ""
>         inFilesSection = False
>         for line in p4_read_pipe_lines(['change', '-o']):
> @@ -1265,8 +1267,13 @@ class P4Submit(Command, P4UserMap):
>                     lastTab = path.rfind("\t")
>                     if lastTab != -1:
>                         path = path[:lastTab]
> -                        if not p4PathStartsWith(path, self.depotPath):
> -                            continue
> +                        if settings.has_key('depot-paths'):
> +                            if not [p for p in settings['depot-paths']
> +                                    if p4PathStartsWith(path, p)]:
> +                                continue
> +                        else:
> +                            if not p4PathStartsWith(path, self.depotPath):
> +                                continue
>                 else:
>                     inFilesSection = False
>             else:
> -- 
> 2.6.2
