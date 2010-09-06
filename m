From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Several tests: cd inside subshell instead of around
Date: Mon, 6 Sep 2010 14:06:55 -0500
Message-ID: <20100906190655.GG25426@burratino>
References: <4C85357A.8090000@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Mon Sep 06 21:09:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Osh3s-0000RQ-NM
	for gcvg-git-2@lo.gmane.org; Mon, 06 Sep 2010 21:09:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751669Ab0IFTIz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Sep 2010 15:08:55 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:49042 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750999Ab0IFTIx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Sep 2010 15:08:53 -0400
Received: by qwh6 with SMTP id 6so4055317qwh.19
        for <git@vger.kernel.org>; Mon, 06 Sep 2010 12:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=6r0wh5g17KEKHIB29tiS1ucUso3ta7QugoJHn61FH2k=;
        b=IFLortrDURAUfginXnFNXJ7Ff3FxHh5h9qUnK2JTSrImBYJ035kutpYsi4u2Q3glXE
         myVdUf+lR/dbbljupbZk4GwaQiiR8NRRKg+iaq+H41k6Nit+Zqd1VPBgS6w9rIFagQJh
         CM4qCCu2T7AzLHrD+12oHIZzL3hE04ndLxTcY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=i1Aq2hgTzIXn07PAS3f05hXwrVJbtkzKfjofxgvLULeXEPvrnSFxIBCxS6G80bwrdJ
         GD0D2X+CJbspHSuipdgDiXarJEUhNwAfmGGzjFcQBC7Ky+TIxUbBTl9iUDmKwuebXvPC
         O2mAZxFwnkAEjmfeHFkIZh0u+0vvnf1CPN3vY=
Received: by 10.224.11.20 with SMTP id r20mr201461qar.223.1283800132688;
        Mon, 06 Sep 2010 12:08:52 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id t24sm5952082qcs.11.2010.09.06.12.08.51
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 06 Sep 2010 12:08:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4C85357A.8090000@web.de>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155602>

Jens Lehmann wrote:

> Fixed all places where it was a straightforward change from cd'ing into a
> directory and back via "cd .." to a cd inside a subshell.

Thanks, Jens.

> Found these places with "git grep -w "cd \.\.".

I assume that "sed"-ing out all parentheses would make the diff very
small and readable.

Do you think it would be a bad idea if I send a follow-on patch that
changes code like this:

	(cd dir &&
 	git update-index --add two &&
 	case "`git ls-files`" in
 	two) echo pass two ;;
 	*) echo bad two; exit 1 ;;
	esac
	) &&

to this:

	(
		cd dir &&
		git update-index --add two &&
		case "`git ls-files`" in
		two) echo pass two ;;
		*) echo bad two; exit 1 ;;
		esac
	)

It would have the benefit of touching all code in the subshell, so we
could see the effect on "exit" commands and whatnot.
