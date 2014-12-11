From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Poor push performance with large number of refs
Date: Thu, 11 Dec 2014 08:41:07 +0700
Message-ID: <CACsJy8DxXdLsdgP7OKmv8bS1WVPSO_goBaNrttAqd0-ASBgbpQ@mail.gmail.com>
References: <20141210003735.GA124293@vauxhall.crustytoothpaste.net>
 <CAJo=hJvKBvQvN=EV4y=ACz5pou9A0tD+txAn_8VR9L3KKtQSiA@mail.gmail.com> <20141210233443.GA130424@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Shawn Pearce <spearce@spearce.org>, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Dec 11 02:41:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XyslE-0006hf-A9
	for gcvg-git-2@plane.gmane.org; Thu, 11 Dec 2014 02:41:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933531AbaLKBlj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Dec 2014 20:41:39 -0500
Received: from mail-ig0-f173.google.com ([209.85.213.173]:55940 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932937AbaLKBlh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Dec 2014 20:41:37 -0500
Received: by mail-ig0-f173.google.com with SMTP id r2so7540670igi.12
        for <git@vger.kernel.org>; Wed, 10 Dec 2014 17:41:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type;
        bh=Mh776ToGb3zbelu0366DWjqsTxxWrvCxBEB4caxklp4=;
        b=jNO251Aql/jeLi3BiRfq39RVd7ulbQE89scUUSjKRmvylz/SZmlIeH3FPwhtVGJUzZ
         +JDrNLRjgK6dLxwhkQ9uJPbnuQ4+q4ox8cG0ovCRCae2X8GT8f4zAgu+EW7VewSn/1OC
         NVAfqvxRa/IqG5vLSU3owpJbYe7d/0BgNbV3aocSQ7BPs7oO2iBy3/nTpOH1h235Oe41
         biUTC91MxTouzO5lFXroCMZAzCTGF8AcAMVBw6OrTvnyT7VBhEJOQRaVZGZSE3Yijym7
         6SIm8NOTWeGfFw6Nd72b4ft59x3GSSngDKyZZIPE/HwJ1spRgfkoVMIuWVZVHrdiwY4z
         kv9g==
X-Received: by 10.50.47.102 with SMTP id c6mr11420620ign.27.1418262097189;
 Wed, 10 Dec 2014 17:41:37 -0800 (PST)
Received: by 10.107.176.3 with HTTP; Wed, 10 Dec 2014 17:41:07 -0800 (PST)
In-Reply-To: <20141210233443.GA130424@vauxhall.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261268>

On Thu, Dec 11, 2014 at 6:34 AM, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> I looked at this more in depth today and I found that the bottleneck is
> --thin.  I tried git send-pack, which does not use --thin by default,
> which led me to further testing.  A particular push went from 24 seconds
> with --thin to 4 seconds without.
>
> I agree that the large number of refs is at least part of the problem,
> because reducing the number of refs has a slight but noticeable impact.
> It's also the factor I can least control.
>
> I have a patch which allows per-remote configuration of whether to use
> thin packs (which I will send shortly), but I'm wondering if we can do
> better, especially since --thin is the default.  It looks like --thin
> forces pack-objects to do its own lookup (essentially a rev-list)
> instead of using the values provided on stdin.

It could be a regression by fbd4a70 (list-objects: mark more commits
as edges in mark_edges_uninteresting - 2013-08-16). That commit makes
--thin a lot more agressive (reading lots of trees). You can try to
revert that commit (or use a git version without that commit) and see
if it improves performance. If so, we probably want to enable that
code for shallow repos only.
-- 
Duy
