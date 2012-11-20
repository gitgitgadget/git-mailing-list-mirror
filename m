From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 2/4] pathspec: do exact comparison on the leading
 non-wildcard part
Date: Tue, 20 Nov 2012 20:09:50 +0700
Message-ID: <CACsJy8DqTR12sckwMm_Zzv2UbdX6jvvyFm3Fx9-b8a-NVXWL9g@mail.gmail.com>
References: <1353229989-13075-1-git-send-email-pclouds@gmail.com>
 <1353229989-13075-3-git-send-email-pclouds@gmail.com> <7vzk2duw3m.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 20 14:10:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tanb3-0007y6-ST
	for gcvg-git-2@plane.gmane.org; Tue, 20 Nov 2012 14:10:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753130Ab2KTNKW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Nov 2012 08:10:22 -0500
Received: from mail-ob0-f174.google.com ([209.85.214.174]:57775 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752710Ab2KTNKW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Nov 2012 08:10:22 -0500
Received: by mail-ob0-f174.google.com with SMTP id wc20so5880079obb.19
        for <git@vger.kernel.org>; Tue, 20 Nov 2012 05:10:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=WUsAyGNqPoYwywgyqLtTH2rAWzdGsZMGkkoEDOBGmX4=;
        b=z1cWJiilTx1StRrYg44JM/sCXXqqq9jdQD1S920SNgKqJ7sxyi0IX1//UJbULGE1ZT
         zet6N/2jTvdWwFtqd98yaUiYcISCdxDXBgpE1pJ2zKsz3NVJ32tzEjBa7FABmvLa8ous
         AI1F3BCzb2PRLlbzJ8LETumhpfuqXvWixj/oelwU47jmW542OTK7Izmv73MHfFbrDKCz
         opA7z9bhzFp6UFtO/tlFwxoLBsB/vhJNp+uoRwhVUXoaYyCJjdkYInmUgg9MbJVvT9pa
         uJW3Hn1MmfL5eT/N4X+NoUFI+LVueZaEbQL7umy31jEsg+n0zKvTHeFcEA6pOfbHbn0+
         qQVg==
Received: by 10.182.38.101 with SMTP id f5mr13382521obk.80.1353417021351; Tue,
 20 Nov 2012 05:10:21 -0800 (PST)
Received: by 10.182.14.201 with HTTP; Tue, 20 Nov 2012 05:09:50 -0800 (PST)
In-Reply-To: <7vzk2duw3m.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210099>

On Tue, Nov 20, 2012 at 3:54 AM, Junio C Hamano <gitster@pobox.com> wrote:
> How would we protect this optimization from future breakages?
>
> Once we start using FNM_PERIOD, this becomes unsafe, as the simple
> part in "foo/bar*baz" would be "foo/bar" with remainder "*baz".
>
> The pattern "foo/bar*baz" should match "foo/bar.baz" with FNM_PERIOD
> set.  But with this optimization, fnmatch is fed pattern="*baz",
> string=".baz" and they would not match.

The first question is how FNM_PERIOD comes in the first place without
breaking the current syntax. I guess we just turn off the optimization
if FNM_PERIOD is used.

My secret "plan" is to convert all fnmatch() calls to git_fnmatch()
then replace fnmatch() with wildmatch() and move these optimization
down to wildmatch(). I think we can handle FNM_PERIOD case better down
there because string is still "foo/bar.baz".
-- 
Duy
