From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [BUG] git bisect start fails when stale bisect data is left behind
Date: Tue, 6 Sep 2011 09:48:34 +0200
Message-ID: <CAP8UFD1h059dOyjszcP-qFauyho78c0RHBMQsGOPFgzZtp+7vg@mail.gmail.com>
References: <CAC6WLetwT9UvBY_=Nf38hhkyU1mhmdWHWqscf3ebba1WRGS1LQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Joel Kaasinen <joel@zenrobotics.com>
X-From: git-owner@vger.kernel.org Tue Sep 06 09:48:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R0qOe-0000Tk-49
	for gcvg-git-2@lo.gmane.org; Tue, 06 Sep 2011 09:48:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753294Ab1IFHsf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Sep 2011 03:48:35 -0400
Received: from mail-yi0-f46.google.com ([209.85.218.46]:35612 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752825Ab1IFHse (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Sep 2011 03:48:34 -0400
Received: by yie30 with SMTP id 30so3808311yie.19
        for <git@vger.kernel.org>; Tue, 06 Sep 2011 00:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=5wI1McRisU766LqGVG7EivSmWsSQFBN7/JvSTIEGxUU=;
        b=DC8mwDAP6FsShIU7ih1I4ihxX0ds6vFZ8oATl64tl1Qu96CUpM1IDp5zOeH7sUMQb1
         b/CZyBBepHiyAS9wBjRh+/KrsVBAmGa3RSgHJ2aLghBmdHD9oZoEX4nxe6yEO5V13P0j
         hpkuPYqUpmJkV2DW9QphWxTBJInyEV3fSVXpo=
Received: by 10.236.145.132 with SMTP id p4mr22180715yhj.41.1315295314081;
 Tue, 06 Sep 2011 00:48:34 -0700 (PDT)
Received: by 10.147.33.10 with HTTP; Tue, 6 Sep 2011 00:48:34 -0700 (PDT)
In-Reply-To: <CAC6WLetwT9UvBY_=Nf38hhkyU1mhmdWHWqscf3ebba1WRGS1LQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180777>

Hi,

On Mon, Sep 5, 2011 at 1:15 PM, Joel Kaasinen <joel@zenrobotics.com> wrote:
> Hi,
>
> Just bumped into a weird bug: bisect refused to start. It seems some
> previous bisect had left around state that referred to a
> now-nonexistent branch.
>
> How to reproduce:
> $ echo foo > .git/BISECT_START
> $ git bisect start HEAD HEAD^
>
> Fails with "fatal: invalid reference:" on git 1.7.6.

Yeah, it looks like a very old behavior.
I'd suggest a simple improvement in the error message like this:

diff --git a/git-bisect.sh b/git-bisect.sh
index c21e33c..bd7155b 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -67,7 +67,8 @@ bisect_start() {
        then
                # Reset to the rev from where we started.
                start_head=$(cat "$GIT_DIR/BISECT_START")
-               git checkout "$start_head" -- || exit
+               git checkout "$start_head" -- ||
+               die "Could not checkout previous start point
'$start_head'. Try 'git bisect reset <branch>' first."
        else
                # Get rev from where we start.
                case "$head" in

If there is no objection I will provide a proper patch.

Thanks,
Christian.
