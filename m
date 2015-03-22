From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2/GSoC/RFC] fetch: git fetch --deepen
Date: Mon, 23 Mar 2015 06:23:28 +0700
Message-ID: <CACsJy8A6ffMvySRUhfx8VCvTe2z+s7R-F6z+S+dex_xQ4kORKg@mail.gmail.com>
References: <1426251846-1604-1-git-send-email-dongcan.jiang@gmail.com> <39ef84113d77ee6fa371ac2f23bbb0ef321323ba.1427031746.git.dongcan.jiang@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Dongcan Jiang <dongcan.jiang@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 23 00:24:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZpE0-00074M-4I
	for gcvg-git-2@plane.gmane.org; Mon, 23 Mar 2015 00:24:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752600AbbCVXYD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Mar 2015 19:24:03 -0400
Received: from mail-ig0-f172.google.com ([209.85.213.172]:35635 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752586AbbCVXX7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Mar 2015 19:23:59 -0400
Received: by igcau2 with SMTP id au2so28570229igc.0
        for <git@vger.kernel.org>; Sun, 22 Mar 2015 16:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=7BAziBt/E054ZTlhrvW2aWhJFLAF+OloIKnhH0SkiTE=;
        b=G4cagGe01YZlG/5qVOT1oqqQ9R0Dgqc/BSoOEF+v209869Xwm+j5j9d5L6z8odmkic
         yzAd/bPn0B3UupKhfz+habYL84/2Ej+AsVD6gE1f1vp9CipRQ386FGOgadia2q+rHCov
         KV9SoOSivfdfP7pZszyvA9Y7p6kUo8LSS4fKAtQBvN8tu5/CtZp+kwl8LfROWxVHhHfF
         +KAABrwgDLCUfRzdYVbFu0x7MWltnmTfJKVzTAkSe11wyXorMt8+grZXodvEKz6h1Abc
         kCGg4C4ERgyZqS2yW0i08n33+uSFBB6sSSf5dZGZh5dULlgZADTqLOoYmajf57/nU1AT
         n6BQ==
X-Received: by 10.43.36.82 with SMTP id sz18mr16625839icb.65.1427066638505;
 Sun, 22 Mar 2015 16:23:58 -0700 (PDT)
Received: by 10.107.131.33 with HTTP; Sun, 22 Mar 2015 16:23:28 -0700 (PDT)
In-Reply-To: <39ef84113d77ee6fa371ac2f23bbb0ef321323ba.1427031746.git.dongcan.jiang@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266104>

On Sun, Mar 22, 2015 at 10:24 PM, Dongcan Jiang <dongcan.jiang@gmail.com> wrote:
> This patch is just for discusstion. An option --deepen is added to
> 'git fetch'. When it comes to '--deepen', git should fetch N more
> commits ahead the local shallow commit, where N is indicated by
> '--depth=N'. [1]
>
> e.g.
>
>>  (upstream)
>>   ---o---o---o---A---B
>>
>>  (you)
>>                  A---B
>
> After excuting "git fetch --depth=1 --deepen", (you) get one more
> tip and it becomes
>
>>  (you)
>>              o---A---B
>
> '--deepen' is designed to be a boolean option in this patch, which
> is a little different from [1]. It's designed in this way, because
> it can reuse '--depth' in the program, and just costs one more bit
> in some data structure, such as fetch_pack_args,
> git_transport_options.
>
> Of course, as a patch for discussion, it remains a long way to go
> before being complete.
>
>         1) Documents should be completed.
>         2) More test cases, expecially corner cases, should be added.
>         3) No need to get remote refs when it comes to '--deepen' option.
>         4) Validity on options combination should be checked.
>         5) smart-http protocol remains to be supported. [2]

Quick notes before $DAYJOB starts. Cool pictures, perhaps they could
be part of the commit message too.

Personally i still don't think not moving the refs is worth the effort
(and it's a waste if we have to send then drop objects for these
updated refs, but I didn't check carefully). So if you we don't needs
ref updates, we probably don't need to send "want" lines and sort of
simplify processing at upload-pack side.

And it makes me realise, we're loosing security a bit here. We
normally don't send anything that's not reachable from the visible ref
set. But we now would accept any shallow sha-1 and send some objects
regardless if these sha-1 are connected to any refs. We may need some
more checking in place to avoid this. See check_non_sha1_tip() for a
way to do it. Pack bitmaps may help as well, but I think that's behind
the scene (i.e. behind rev-list and we already can take advantage of
it).
-- 
Duy
