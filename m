From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH v2 07/19] make sure partially read index is not changed
Date: Wed, 17 Jul 2013 14:56:52 +0200
Message-ID: <87li55s5t7.fsf@gmail.com>
References: <1373650024-3001-1-git-send-email-t.gummerer@gmail.com> <1373650024-3001-8-git-send-email-t.gummerer@gmail.com> <CACsJy8A61gfWsMecJha-3GoWXFT0bb3zAMJ5YT-a=vs=_3WghQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>,
	Thomas Rast <trast@inf.ethz.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	Robin Rosenberg <robin.rosenberg@dewire.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 17 14:57:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UzRHx-0002YW-M5
	for gcvg-git-2@plane.gmane.org; Wed, 17 Jul 2013 14:57:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754804Ab3GQM45 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jul 2013 08:56:57 -0400
Received: from mail-ea0-f171.google.com ([209.85.215.171]:41289 "EHLO
	mail-ea0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754346Ab3GQM44 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jul 2013 08:56:56 -0400
Received: by mail-ea0-f171.google.com with SMTP id m14so1032022eaj.2
        for <git@vger.kernel.org>; Wed, 17 Jul 2013 05:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:in-reply-to:references:user-agent:date
         :message-id:mime-version:content-type;
        bh=7klFmCeLid+5jv0bcVjj6QR1Xgrrnh7bsa64bMuKygg=;
        b=QHIXOmZGhH+1AOqDT8S38siBncAveAoKK1uA/eJV4T102ByjXujdAI/UTh6zc9up5O
         5NATKTLdb6/R8FCG1eNlaFZ1RYut3zk/VJrdye17UDtoaANPYU8qEKASa/w4lvEl1Dso
         RTKIi3PER5qz6fn9mo+YuVZommDiLFqtImlpWdMKXDUZ/rda5r7CAhitkVHSVYef+Lxc
         NgD5zJ1wGFCW3HTfkWJxO0w94Fo4MyYKq/9dAVrHNkEJZC3o/nFrohh1lPvTq659sud7
         YDp94XQ916/xENog34sxHunzunDjvjkhmidryhEIl1MbnBs3GfBIwc1Yf3yCo4+TqY3N
         iK8Q==
X-Received: by 10.14.183.135 with SMTP id q7mr6162329eem.97.1374065815607;
        Wed, 17 Jul 2013 05:56:55 -0700 (PDT)
Received: from localhost ([2a02:27e8:10:1047:0:dacb:1376:714a])
        by mx.google.com with ESMTPSA id i2sm10685927eeu.4.2013.07.17.05.56.53
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 17 Jul 2013 05:56:54 -0700 (PDT)
In-Reply-To: <CACsJy8A61gfWsMecJha-3GoWXFT0bb3zAMJ5YT-a=vs=_3WghQ@mail.gmail.com>
User-Agent: Notmuch/0.15.2+119~gf0dfda5 (http://notmuchmail.org) Emacs/24.3.1 (x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230620>

Duy Nguyen <pclouds@gmail.com> writes:

> On Sat, Jul 13, 2013 at 12:26 AM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
>> A partially read index file currently cannot be written to disk.  Make
>> sure that never happens, by erroring out when a caller tries to change a
>> partially read index.  The caller is responsible for reading the whole
>> index when it's trying to change it later.
>>
>> Forcing the caller to load the right part of the index file instead of
>> re-reading it when changing it, gives a bit of a performance advantage,
>> by avoiding to read parts of the index twice.
>
> If you want to be strict about this, put similar check in
> fill_stat_cache_info (used by entry.c), cache_tree_invalidate_path and
> convert the code base (maybe except unpack-trees.c, just put a check
> in the beginning of unpack_trees()) to use wrapper function to change
> ce_flags (some still update ce_flags directly, grep them). Some flags
> are in memory only and should be allowed to change in partial index,
> some are to be written on disk and should not be allowed.

I'm not sure anymore we should even be this strict.  A partially read
index will never make it to the disk, because write_index checks if it's
fully read.   I think the check in write_index and read_index_filtered
would be enough.

The only disadvantage would be that it takes a little longer to catch an
error that should never happen in the first place.  If it occurs the
user has bigger problems than the time that not having caught the
error earlier adds to the execution of the command.

I also don't see a clean way to add the check to fill_stat_cache_info or
cache_tree_invalidate_path, because we would need an additional
parameter for the index_state, or at least for index_state->filter_opts,
which doesn't do anything but check if the index is only partially loaded.
