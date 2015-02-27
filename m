From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Deadlock during remote update
Date: Fri, 27 Feb 2015 18:27:28 +0700
Message-ID: <CACsJy8AG9ZdhZj_pAb3sZPntBt+GPLj06dXDAV=w+5HyL6D+0Q@mail.gmail.com>
References: <311995D1237EC0498D6D8FAFA73D6F458F1B67@G9W0762.americas.hpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Jeff King <peff@peff.net>
To: "Heald, Mike" <mike.heald@hp.com>
X-From: git-owner@vger.kernel.org Fri Feb 27 12:28:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YRJ5R-0005yi-PY
	for gcvg-git-2@plane.gmane.org; Fri, 27 Feb 2015 12:28:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751605AbbB0L2A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Feb 2015 06:28:00 -0500
Received: from mail-ie0-f181.google.com ([209.85.223.181]:37100 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750777AbbB0L17 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 Feb 2015 06:27:59 -0500
Received: by iecrl12 with SMTP id rl12so29493360iec.4
        for <git@vger.kernel.org>; Fri, 27 Feb 2015 03:27:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=T4CHMm/E5xI1rLvFsxB3gBuOFw9ck3PgA1XXUO8Zgcc=;
        b=msojQegaa85CDpNmPSr3eiNxH94fnlv7piSGRk1B1YYNWlkPNNa9ne3/bGyZsDceWl
         hQdlS/NKtClX6OuPXVVwBx2Ti52Jg5opFxd3Gg7Owdla499he2mqaiR4pFpiEw9e3pep
         Ov0+NX7NHECj+C1duY3sUfFiXrk0oliZSRX5TouqQFZMHwLHhpSu+XJCpY4p/qb2ydAY
         vphfPOeEb6BBveJRlvatFyO0q1S/KiofKumDwmPW+EDR21FvdS4w/WJPQBTvDnT0oU9I
         iDPPT2n8RLuH91rTEa0/4AjI3/b06CC5ms8NtLisxFs9FkYvQqFO148+AlVxn9iIZTjY
         wDtA==
X-Received: by 10.107.166.146 with SMTP id p140mr17187996ioe.61.1425036478779;
 Fri, 27 Feb 2015 03:27:58 -0800 (PST)
Received: by 10.107.131.155 with HTTP; Fri, 27 Feb 2015 03:27:28 -0800 (PST)
In-Reply-To: <311995D1237EC0498D6D8FAFA73D6F458F1B67@G9W0762.americas.hpqcorp.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264494>

On Fri, Feb 27, 2015 at 6:03 PM, Heald, Mike <mike.heald@hp.com> wrote:
> Hi,
>
> We have a cron job that runs remote update on a number of repositories. Sometimes, the processes deadlock and we have to go -TERM them. Here's a breakdown of what state the processes end up in when the deadlock happens, from one of our production systems yesterday:
>
> 31629 git --git-dir=/var/lib/jeepyb/openstack/nova/.git --work-tree=/var/lib/jeepyb/openstack/nova remote update --prune
>     wait4'ing for 31630
> 31630 git fetch --prune --multiple --all
>     wait4'ing for 31637
> 31637 git fetch --append --prune upstream
>     waiting for read from pipe:[170381707] (fd 25)
> 31638 git-remote-https upstream https://git.openstack.org/openstack/nova
>     has pipe:[170381707] (fd 1), waiting for read from pipe:[170384472]
> 31642 git fetch-pack --stateless-rpc --lock-pack --include-tag --thin --no-progress https://git.openstack.org/openstack/nova/  efs/heads/master
>     has pipe:[170384472] (fd 1), waiting for read from pipe:[170384471] (fd 0) which fd 7 on 31638
>
> 31638 and 31642 are both waiting to read from a pipe that the other has, and isn't writing to.
>
> This is git version 1.7.9.5, OS is ubuntu precise.

There's this commit 2a45520 (remote-curl: always parse incoming refs -
2013-02-20) that fixes a deadlock between remote-http(s) and
fetch-pack. I'm not sure if it's the same problem. Jeff  knows more
about this. The fix is available since v1.8.3
-- 
Duy
