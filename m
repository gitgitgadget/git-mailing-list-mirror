From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [RFC/PATCH] config: add core.trustmtime
Date: Wed, 25 Nov 2015 10:00:23 +0100
Message-ID: <CACBZZX4YSvfA=BRayk8CC8ipk_nDdvJfznxjyb-upwP9PKRBSA@mail.gmail.com>
References: <1448433323-21037-1-git-send-email-chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 25 10:00:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a1VwU-00012r-0J
	for gcvg-git-2@plane.gmane.org; Wed, 25 Nov 2015 10:00:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932075AbbKYJAo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2015 04:00:44 -0500
Received: from mail-qg0-f49.google.com ([209.85.192.49]:33559 "EHLO
	mail-qg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754366AbbKYJAn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2015 04:00:43 -0500
Received: by qgea14 with SMTP id a14so27895111qge.0
        for <git@vger.kernel.org>; Wed, 25 Nov 2015 01:00:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Y6RoikFLaMD6y9O8KLSY2ns6vXC0lG9mxgIDlHfbjQE=;
        b=dZ1igYaxz2MnWl8SnDeY2kXp7ekgUFoNNlLSnMJ9zooiKELetysErakkf9toj185aU
         2Jp3v2F+6ABBncOIRhn65PZTuFG3MBs42ceXI1gxQiRChhtNxhwGrPl20pwQ3wOP7E9y
         uCpiYzZHpA4CLhsGsbibFAzkMGPwyTwH5xkLcp2qba4GcSBLL16ByIypgD25hxw6CHga
         4L8Hw6CPk6idW+Faabh74svLK5g418VXddzBI53Uyifct3dZd0GuSu+UeDt48yxuG4cr
         qr5eA/k2owaN83mS8ptBnDbCX0mW1WUrEOPLP1eiEXI/NyTNV4vVvo+SHFZedRPeR5YB
         /UWw==
X-Received: by 10.140.20.144 with SMTP id 16mr38551841qgj.45.1448442042764;
 Wed, 25 Nov 2015 01:00:42 -0800 (PST)
Received: by 10.55.33.11 with HTTP; Wed, 25 Nov 2015 01:00:23 -0800 (PST)
In-Reply-To: <1448433323-21037-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281686>

On Wed, Nov 25, 2015 at 7:35 AM, Christian Couder
<christian.couder@gmail.com> wrote:
> At Booking.com we know that mtime works everywhere and we don't
> want the untracked cache to stop working when a kernel is upgraded
> or when the repo is copied to a machine with a different kernel.
> I will add tests later if people are ok with this.

I bit more info: I rolled Git out internally with this patch:
https://github.com/avar/git/commit/c63f7c12c2664631961add7cf3da901b0b6aa2f2

The --untracked-cache feature hardcodes the equivalent of:

    pwd; uname --kernel-name --kernel-release --kernel-version

Into the index. If any of those change it prints out the "cache is
disabled" warning.

This patch will make it stop being so afraid of itself to the point of
disabling itself on minor kernel upgrades :)

A few other issues with this feature I've noticed:

 * There's no way to just enable it globally via the config. Makes it
a bit of a hassle to use it. I wanted to have a config option to
enable it via the config, how about "index.untracked_cache = true" for
the config variable name?

 * Doing "cd /tmp: git --git-dir=/git/somewhere/else/.git update-index
--untracked-cache" doesn't work how I'd expect. It hardcodes "/tmp" as
the directory that "works" into the index, so if you use the working
tree you'll never use the untracked cache. I spotted this because I
carry out a bunch of git maintenance commands with --git-dir instead
of cd-ing to the relevant directories. This works for most other
things in git, is it a bug that it doesn't work here?

 * If you "ctrl+c" git update-index --untracked-cache at an
inopportune time you'll end up with a mtime-test-XXXXXX directory in
your working tree. Perhaps this tempdir should be created in the .git
directory instead?

 * Maybe we should have a --test-untracked-cache option, so you can
run the tests without enabling it.

Aside from the slight hassle of enabling this and keeping it enabled
this feature is great. It's sped up "git status" across the board by
about 40%. Slightly less than that on faster spinning disks, slightly
more than that on slower ones.
