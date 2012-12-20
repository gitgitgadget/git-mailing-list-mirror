From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 2/3] wildmatch: support "no FNM_PATHNAME" mode
Date: Thu, 20 Dec 2012 08:55:50 +0700
Message-ID: <CACsJy8C9Nhdq_xBAOxtmLcUnrUioAMvWCPk=sBZKOzFY2WR+iA@mail.gmail.com>
References: <1355922488-20976-1-git-send-email-pclouds@gmail.com>
 <1355922488-20976-3-git-send-email-pclouds@gmail.com> <7vlicu9cpk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 20 02:59:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TlVQS-0001ZD-RU
	for gcvg-git-2@plane.gmane.org; Thu, 20 Dec 2012 02:59:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752194Ab2LTB7i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Dec 2012 20:59:38 -0500
Received: from mail-oa0-f42.google.com ([209.85.219.42]:41453 "EHLO
	mail-oa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752555Ab2LTB4V (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Dec 2012 20:56:21 -0500
Received: by mail-oa0-f42.google.com with SMTP id j1so2873460oag.1
        for <git@vger.kernel.org>; Wed, 19 Dec 2012 17:56:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=AkzOzVPnIBQwGzPhlR0lXH4AJx2fZqnVXbEPyYSUDqU=;
        b=P/NLak1Z+GMIrctiFjgyNiKv1x8sJEO3Fc+d9AFQ2Xh8pulSCcgj801He9pdV8crjx
         L2Ep+r3A+n6yd4apAaOBbu9zDqGE3DQP1ZkTWR3cuULv6D//rugGu8PG/TkWa7WCzpsb
         LnOAWYzCJCuwcTJaB/upWVtnDrCGGNscFH+sXv7EpegMkQRljNKrWEwf4ygvcDhCqT8C
         gnC5iJ5HXi30WYR1PSB5bTR2STbroboeWO9aVPH23b33P1MzdCfwipVUSAKkTWLBsNSf
         naa9NGcByA6+pyJUYESQpmD4hRFVG+g+x4TizSmOneJui1wjoPF27Pw2/hK0X2jhJkbG
         Gi5Q==
Received: by 10.182.141.103 with SMTP id rn7mr6705429obb.5.1355968580607; Wed,
 19 Dec 2012 17:56:20 -0800 (PST)
Received: by 10.182.27.168 with HTTP; Wed, 19 Dec 2012 17:55:50 -0800 (PST)
In-Reply-To: <7vlicu9cpk.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211869>

On Thu, Dec 20, 2012 at 12:24 AM, Junio C Hamano <gitster@pobox.com> wrote:
> When that happens, we should want to retain the same "do not bother
> to descend into subdirectories that will never match" optimization
> for a pattern like "Doc*tion/**/*.txt".  Because of FNM_PATHNAME, we
> can tell if a subdirectory is worth descending into by looking at
> the not-so-simple prefix "Doc*tion/"; "Documentation" will match,
> "Doc" will not (because '*' won't match '/').
>
> Which tells me that integrating this _well_ into the rest of the
> system is not just a matter of replacing fnmatch() with wildmatch().

Yeah, we open a door for more opportunities and a lot more headache.

> I also expect that wildmatch() would be much slower than fnmatch()
> especially when doing its "**" magic, but I personally do not think
> it will be a showstopper.

A potential showstopper is the lack of multibyte support. I don't know
if people want that though.

> If the user asks for a more powerful but
> expensive operation, we are saving time for the user by doing a more
> powerful thing (reducing the need to postprocess the results) and
> can afford to spend extra cycles.

In some case we may be able to spend fewer cycles by preprocessing
patterns first.

> As long as simpler patterns fnmatch() groks (namely, '?', '*', and
> '[class]' wildcards only) are not slowed down by replacing it with
> wildmatch(), that is, of course.

I'm concerned about performance vs fnmatch too. I'll probably write a
small program to exercise both and measure it with glibc.
-- 
Duy
