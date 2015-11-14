From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: Re: [RFC] Clone repositories recursive with depth 1
Date: Sat, 14 Nov 2015 17:25:15 +0100
Message-ID: <20151114162515.GJ1678@paksenarrion.iveqy.com>
References: <DE5B8B46-B185-4258-A1C8-07E46072CD5D@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 14 17:25:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZxdeE-0004XG-N8
	for gcvg-git-2@plane.gmane.org; Sat, 14 Nov 2015 17:25:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751052AbbKNQZU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Nov 2015 11:25:20 -0500
Received: from mail-lb0-f177.google.com ([209.85.217.177]:36293 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750998AbbKNQZT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Nov 2015 11:25:19 -0500
Received: by lbblt2 with SMTP id lt2so69095021lbb.3
        for <git@vger.kernel.org>; Sat, 14 Nov 2015 08:25:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=ZSyy08Indwfmu6wGVjHkJkPhKxid7kRpoyowrX/84iA=;
        b=Ti3AZ5YmVE4a+p7vc7cZU3e+PYGF6E66OcAep+LoYSsdANwNi11MYrP1hhvDdQ32Jo
         TQP3W0AKYovQdSmExiKalUl57UBKJISbe/d6RFJeNiekVSiivpAVrayRMypYtY5ksrR2
         2ta3ZDrF/BUY4Ivub4kABCjfx0AJX6CEbmEN0eI0jEmF2gkd3eJnNHKDU8seCwVwRQLb
         6NFENwXoRmH/BMKB7C00XmMu26QExatWqlCANwB9VarOAqyQ0fRFK7rKL0RT3X1UxPeH
         Iu01WGUXodN2051RA7rX+i2wGGVUfGOW0IlmgFiEIdS65b7TbRNqrz0Iv0ggrT6syPV1
         otAw==
X-Received: by 10.112.168.194 with SMTP id zy2mr13197339lbb.79.1447518317339;
        Sat, 14 Nov 2015 08:25:17 -0800 (PST)
Received: from paksenarrion.paks.iveqy.com (c83-249-17-125.bredband.comhem.se. [83.249.17.125])
        by smtp.gmail.com with ESMTPSA id ey10sm4035326lbc.29.2015.11.14.08.25.15
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 14 Nov 2015 08:25:16 -0800 (PST)
Received: from iveqy by paksenarrion.paks.iveqy.com with local (Exim 4.84)
	(envelope-from <iveqy@paksenarrion.iveqy.com>)
	id 1Zxddb-0005Sf-7D; Sat, 14 Nov 2015 17:25:15 +0100
Content-Disposition: inline
In-Reply-To: <DE5B8B46-B185-4258-A1C8-07E46072CD5D@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281307>

On Wed, Nov 11, 2015 at 03:09:18PM +0100, Lars Schneider wrote:
> Apparently this does not clone the submodules with "--depth 1" (using Git 2.4.9). As a workaround I tried:
> 
> git clone --depth 1 --single-branch <url>
> cd <repo-name>
> git submodule update --init --recursive --depth 1
> 
> However, this does not work either as I get:
> fatal: reference is not a tree: <correct sha1 of the submodule referenced by the main project>
> Unable to checkout <correct sha1 of the submodule referenced by the main project> in submodule path <submodule path>

This looks like a familiar bug to me. I'm not sure if it's a bug or a
known behaviour. When the depth argument was introduced to submodules a
year (or two) ago there was a know bug. I not sure if it's fixed or
not.

The problem is that git is/was unable to fetch a sha1 but only a branch
or a tag. So fetching a submodule will fetch the HEAD of the submodule
with the requested depth. Then git will try to checkout a sha1 of that
submodule, which may or maynot exists.

Say that you fetch master of a submodule of depth 1 and do a checkout of
a commit that exists. When someonen else has pushed to that submodule,
the commit will not longer be reachable from depth 1 and if someone else
tries to clone with depth 1 it will fail with the same error message as
you got.

The solution to this is to allow git to fetch the sha1 the superproject
points to direct when fetching the submodule.

-- 
Fredrik Gustafsson

phone: +46 733-608274
e-mail: iveqy@iveqy.com
website: http://www.iveqy.com
