From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] add post-fetch hook
Date: Sun, 25 Dec 2011 08:24:52 -0800 (PST)
Message-ID: <m3liq0fwkz.fsf@localhost.localdomain>
References: <20111224234212.GA21533@gnu.kitenet.net>
	<7v4nwpbaxq.fsf@alter.siamese.dyndns.org>
	<20111225035059.GA29852@gnu.kitenet.net>
	<7vsjk99exw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Joey Hess <joey@kitenet.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Dec 25 17:25:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Reqt4-00046h-4a
	for gcvg-git-2@lo.gmane.org; Sun, 25 Dec 2011 17:25:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753205Ab1LYQYz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Dec 2011 11:24:55 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:61803 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752990Ab1LYQYy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Dec 2011 11:24:54 -0500
Received: by eekc4 with SMTP id c4so10620433eek.19
        for <git@vger.kernel.org>; Sun, 25 Dec 2011 08:24:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=tcpm5Ds/ttnmbZOWbbcSx2nHtGcttNZZwtgDVd2iOfQ=;
        b=tz49q2cU+EnUo6XeSX7knAP4ndY4qpLuaiCxAHglrsM0xbta1RclBb77W1rsOHj8vW
         8CMg8GvLV1xe+N09j0MZKQ/fL4aJ1GPfxzSb/YvVhqjRLNOtxpNoWxkHjgqCbUdp5as6
         ZnpRlqVfKTh1aVC48YhgcPs/NiJq4QGBErlRM=
Received: by 10.213.10.195 with SMTP id q3mr4458568ebq.46.1324830292871;
        Sun, 25 Dec 2011 08:24:52 -0800 (PST)
Received: from localhost.localdomain (aehn107.neoplus.adsl.tpnet.pl. [79.186.195.107])
        by mx.google.com with ESMTPS id y12sm78220262eeb.11.2011.12.25.08.24.51
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 25 Dec 2011 08:24:52 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id pBPGOkZi001420;
	Sun, 25 Dec 2011 17:24:46 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id pBPGOjS9001417;
	Sun, 25 Dec 2011 17:24:45 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <7vsjk99exw.fsf@alter.siamese.dyndns.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187681>

Junio C Hamano <gitster@pobox.com> writes:

> [...] if we were to allow the hook to lie what commits were fetched and store
> something different from what we fetched in the remote tracking refs, I
> think the correct place to do so would be in store_updated_refs(),
> immediately before we call check_everything_connected().
> 
>  - Feed the contents of the ref_map to the hook. For each entry, the hook
>    would get (at least):
>    . the object name;
>    . the refname at the remote;
>    . the refname at the local (which could be empty when we are not
>      copying it to any of our local ref); and
>    . if the entry is to be used for merge.
> 
>  - The hook must read _everything_ from its standard input, and then
>    return the
>    re-written result in the same format as its input. The hook could
>    . update the object name (i.e. re-point the remote tracking ref);
>    . update the local refname (i.e. use different remote tracking ref);
>    . change "merge" flag between true/false; and/or
>    . add or remove entries

This is a very nice idea, IMHO, both because it makes it simple to
implement no-op (example) hook by just using "cat", and beause it
makes possible to stack such hooks (e.g. one from git-annex with the
one from pristine-tar etc.).

One thing that needs to be specified is what should happen if the hook
changes "the refname at the remote" part...
 
>  - You read from the hook and replace the ref_map list that is fed to
>    check_everything_connected(). This ref_map list is what is used in the
>    next for() loop that calls update_local_ref() to update the remote
>    tracking ref, records the entry in FETCH_HEAD, and produces the report.
> 
> This way, the hook cannot screw up, as what it tells us will consistently
> be written by us to where it should go.

-- 
Jakub Narebski
