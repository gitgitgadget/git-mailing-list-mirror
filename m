From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v2] fast-import: Stream very large blobs directly to pack
Date: Fri, 29 Jan 2010 10:29:25 -0800 (PST)
Message-ID: <m3aavwbwaz.fsf@localhost.localdomain>
References: <20100129012350.GD20488@spearce.org>
	<7vockdjx6w.fsf@alter.siamese.dyndns.org>
	<20100129152254.GC21821@spearce.org>
	<20100129163838.GD21821@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
	Nicolas Pitre <nico@fluxnic.net>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Jan 29 19:29:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Navb8-0001vW-L4
	for gcvg-git-2@lo.gmane.org; Fri, 29 Jan 2010 19:29:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753249Ab0A2S3c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jan 2010 13:29:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752962Ab0A2S3c
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jan 2010 13:29:32 -0500
Received: from fg-out-1718.google.com ([72.14.220.159]:55397 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752161Ab0A2S3b (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jan 2010 13:29:31 -0500
Received: by fg-out-1718.google.com with SMTP id l26so926202fgb.1
        for <git@vger.kernel.org>; Fri, 29 Jan 2010 10:29:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=snN4KYCWHqav6bU2mSe0B7pGuMRlMv/BBJz/PDFCXek=;
        b=RGAOZWjsyL5CrJFA3R3StrL68OunIbifrlB2S6FhKz0VQ88UcV4n4RmU7yBtq9S5SV
         m6kJmThT1dmldyw2ckOdP/wZ6JX+g1Vhj6bP7VV3Y3q9RA30xmPxDOfy4IfMp0/NI4G3
         jj5wAm9miKqP4X+9apYsO3MbubTupdmHulQjs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=NN5FcF9jr6BFIb0SPj+0sdH7Jc/3lkmBi9U4ZPntwKlHGXhLdjNzGlUAo4s6jWzo5b
         xqume3pg0XtSmcwLK1wZA8F1oEpc33ckw+Le5dVKwMrSMCqAe+M59LeHBn5FiwrI6LVO
         1dmAX64ixh2em3UNwBlz7mUTu6qvfYKIhNbm4=
Received: by 10.86.6.30 with SMTP id 30mr2258750fgf.62.1264789769494;
        Fri, 29 Jan 2010 10:29:29 -0800 (PST)
Received: from localhost.localdomain (abvm98.neoplus.adsl.tpnet.pl [83.8.210.98])
        by mx.google.com with ESMTPS id l12sm7448082fgb.25.2010.01.29.10.29.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 29 Jan 2010 10:29:25 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o0TISdKo015613;
	Fri, 29 Jan 2010 19:28:49 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o0TIS7Zv015519;
	Fri, 29 Jan 2010 19:28:07 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20100129163838.GD21821@spearce.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138333>

"Shawn O. Pearce" <spearce@spearce.org> writes:

>  Documentation/git-fast-import.txt |    6 ++
>  fast-import.c                     |  172 +++++++++++++++++++++++++++++++++----
>  t/t5705-clone-2gb.sh              |    2 +-
>  t/t9300-fast-import.sh            |   46 ++++++++++
>  4 files changed, 208 insertions(+), 18 deletions(-)

> +--big-file-threshold=<n>::
> +	Maximum size of a blob that fast-import will attempt to
> +	create a delta for, expressed in MiB.  The default is 512.
> +	Some importers may wish to lower this on systems with
> +	constrained memory.
> +

Shouldn't there be config variable corresponding to this command line
option, so that it can be set once for [constrained] system?

-- 
Jakub Narebski
Poland
ShadeHawk on #git
