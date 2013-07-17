From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH v2 10/19] documentation: add documentation of the index-v5 file format
Date: Wed, 17 Jul 2013 10:09:25 +0200
Message-ID: <87txjtsj4a.fsf@gmail.com>
References: <1373650024-3001-1-git-send-email-t.gummerer@gmail.com> <1373650024-3001-11-git-send-email-t.gummerer@gmail.com> <CACsJy8Ckcuk11Vmhyo-2wk6bMtNo17=Q9KXU9B-JAi0j7Cmi+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>,
	Thomas Rast <trast@inf.ethz.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	Robin Rosenberg <robin.rosenberg@dewire.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 17 10:09:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UzMno-0004vW-TR
	for gcvg-git-2@plane.gmane.org; Wed, 17 Jul 2013 10:09:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752010Ab3GQIJc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jul 2013 04:09:32 -0400
Received: from mail-ea0-f175.google.com ([209.85.215.175]:43217 "EHLO
	mail-ea0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751409Ab3GQIJa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jul 2013 04:09:30 -0400
Received: by mail-ea0-f175.google.com with SMTP id z7so852413eaf.20
        for <git@vger.kernel.org>; Wed, 17 Jul 2013 01:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:in-reply-to:references:user-agent:date
         :message-id:mime-version:content-type;
        bh=5IWoPBPdD0OnaANf60YSaM41RbBqSFcbghel4SsN4Lw=;
        b=0hA/FYQzhTQ56fwM5J0NNCFNSNMiCw8WB95kv6dpPdlG58m+B2MAqCmKVc51t3J8k3
         W8tycH5xUBu+e9n/NyUVokE9vSwUXGGJr5D7UkAAH9dszWw+uFBGKJGbR1dQtGk0DZfw
         kk6dT928MCu0P2322dzN8j2noMfUukxAklCUf0hLkXLDVodIth3Kmmg36rf3RjRn02Mq
         ptAVhBoCLDCuiGF1GFpJyfYc2G+JAVJXfOX3WXx1x5Lg51c0AMKidlb4HL0zHIpa+8vK
         NzgEu3Pcj6lUH3vTvgw0cPPaRNMCY0ISqZIBAMs+m6RanfDGlPlzff6ACfGSxl4rpjEJ
         bkVg==
X-Received: by 10.14.246.197 with SMTP id q45mr5320045eer.15.1374048569399;
        Wed, 17 Jul 2013 01:09:29 -0700 (PDT)
Received: from localhost ([2a02:27e8:10:1047:0:dacb:1376:714a])
        by mx.google.com with ESMTPSA id b7sm8690237eef.16.2013.07.17.01.09.27
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 17 Jul 2013 01:09:28 -0700 (PDT)
In-Reply-To: <CACsJy8Ckcuk11Vmhyo-2wk6bMtNo17=Q9KXU9B-JAi0j7Cmi+A@mail.gmail.com>
User-Agent: Notmuch/0.15.2+119~gf0dfda5 (http://notmuchmail.org) Emacs/24.3.1 (x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230607>

Duy Nguyen <pclouds@gmail.com> writes:

> On Sat, Jul 13, 2013 at 12:26 AM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
>> +== Directory offsets (diroffsets)
>> +
>> +  diroffset (32-bits): offset to the directory relative to the beginning
>> +    of the index file. There are ndir + 1 offsets in the diroffset table,
>> +    the last is pointing to the end of the last direntry. With this last
>> +    entry, we are able to replace the strlen of when reading the directory
>
> strlen of what?

Of the dirname.  Will fix in the re-roll, thanks for noticing.

>> +    name, by calculating it from diroffset[n+1]-diroffset[n]-61.  61 is the
>> +    size of the directory data, which follows each each directory + the
>> +    crc sum + the NUL byte.
>> +
>> +  This part is needed for making the directory entries bisectable and
>> +    thus allowing a binary search.
>
> Just thinking out loud. Maybe this section and fileoffsets should be
> made optional extensions. So far I see no use for them. It's nice for
> a program to occasionally look at a single entry, but such programs do
> not exist (yet). For inotify monitor that may want to update a single
> file's stat, it could regenerate the index with {dir,file}offsets
> extensions the first time it attempts to update the index, then it
> could do bsearch.

There is a use already, namely saving the strlen for the filename.
Previously we had the length of the filename in the lower bits of the
flags, but decided to remove it to avoid having extended flags.  That in
addition to the use case in the future warrants keeping them in the
index, I think.
