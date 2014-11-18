From: David Turner <dturner@twopensource.com>
Subject: Re: [RFC] On watchman support
Date: Tue, 18 Nov 2014 13:12:40 -0500
Organization: Twitter
Message-ID: <1416334360.27401.10.camel@leckie>
References: <20141111124901.GA6011@lanh> <1416270336.13653.23.camel@leckie>
	 <CACsJy8BfxP7KF1XF29BOgC6XhO8iAy-ycEoLkDG5rn6TYH_DrA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>, gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Nov 18 19:12:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XqnGq-0003fY-2L
	for gcvg-git-2@plane.gmane.org; Tue, 18 Nov 2014 19:12:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754226AbaKRSMw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Nov 2014 13:12:52 -0500
Received: from mail-qg0-f44.google.com ([209.85.192.44]:64748 "EHLO
	mail-qg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753669AbaKRSMv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Nov 2014 13:12:51 -0500
Received: by mail-qg0-f44.google.com with SMTP id z60so2978894qgd.3
        for <git@vger.kernel.org>; Tue, 18 Nov 2014 10:12:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=VHjrazTvfHWHG2Q8TRWsxqCRxvsdBg3A0dCLXNw3e5k=;
        b=jTugn0iJP+GB6gTKlBAzSw0iVgBxMYJ0AZg+0NS+/FIjmr7m1UskwsqJXIRaACttEx
         aWQiYu27nNsWApy/fTIsysnEO++HYEtTXeFcj2t6yQ/TAkaEZb5LDTFot/1+7cVxtUcz
         TCvWwADQgEEhrURml3Zzt8TIBmEcyRWeoWvaScdwkJPZk8/VNAK95DRIpiaC7oS11qlo
         5c4rZ0PoKTypj0yK9OX4VQ+k7u3J4T2L56qrPOA8M2GIgx4suMtuMma+IT9I5K9W7iTq
         hhjHKfrootXDHF5dFjEBL7lquqsxoWgAa43Ub6PjK2+ICO7ePI7U/qwBXL9ekrriHSRN
         RkXg==
X-Gm-Message-State: ALoCoQlzuIPop3d0w20iwF1vL7UL5g0iCv/3V1pnBLj75gM1xY1sIueAJgdWwXiDkeSOQlQ9VeES
X-Received: by 10.229.181.201 with SMTP id bz9mr44949687qcb.1.1416334362899;
        Tue, 18 Nov 2014 10:12:42 -0800 (PST)
Received: from [172.17.131.24] (ip-66-9-26-66.autorev.intellispace.net. [66.9.26.66])
        by mx.google.com with ESMTPSA id w32sm25107326qgw.38.2014.11.18.10.12.41
        for <multiple recipients>
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Nov 2014 10:12:42 -0800 (PST)
In-Reply-To: <CACsJy8BfxP7KF1XF29BOgC6XhO8iAy-ycEoLkDG5rn6TYH_DrA@mail.gmail.com>
X-Mailer: Evolution 3.10.4-0ubuntu2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 2014-11-18 at 17:48 +0700, Duy Nguyen wrote:
> > My patches are not the world's most beautiful, but they do work.  I
> > think some improvement might be possible by keeping info about tracked
> > files in the index, and only storing the tree of ignored and untracked
> > files separately.  But I have not thought this through fully.  In any
> > case, making use of shared memory for the fs_cache (as some of your
> > other patches do for the index) would definitely save time.
> 
> By the way, what happened to your sse optimization in refs.c? I see
> it's reverted but I didn't follow closely to know why. 

I don't know why either -- it works just fine.  There was a bug, but I
fixed it.  Junio?

> Or will you go
> with cityhash now.. I ask because you have another sse optimization
> for hashmap on your watchman branch and that could reduce init time
> for name-hash. Name-hash is used often on case-insensitive fs (less
> often on case-sensitive fs).

Cityhash would be better, because it has actual engineering effort put
into it; what I did on my branch is a hack that happens to work
decently.  As the comment notes, I did not spend much effort on tuning
my implementation.  Also, Cityhash doesn't require SSE, so it's more
portable.

> I did a simple test and your optimization could init name-hash (on
> webkit) in 35ms, while unmodified hashmap took 88ms. Loading index on
> this machine took 360ms for reference (probably down too 100ms with
> index-helper running, when that 88ms starts to become significant).

OK, that sounds like a big win.  
