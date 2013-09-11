From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH 1/2] reset: handle submodule with trailing slash
Date: Wed, 11 Sep 2013 18:27:05 +0100
Message-ID: <20130911172705.GV2582@serenity.lan>
References: <cover.1378840318.git.john@keeping.me.uk>
 <c7e026f44f9ccbf5736b72e728a360b31887a50f.1378840318.git.john@keeping.me.uk>
 <52300838.5040703@kdbg.org>
 <20130911082042.GR2582@serenity.lan>
 <CACsJy8BgEM3eEDo8wOgkqYTL1fkh9azZNqbogxBubp9g5KRNbQ@mail.gmail.com>
 <xmqqwqmnthfh.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Duy Nguyen <pclouds@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
	Git Mailing List <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 11 19:27:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJoCH-0001DS-NG
	for gcvg-git-2@plane.gmane.org; Wed, 11 Sep 2013 19:27:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755757Ab3IKR1R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Sep 2013 13:27:17 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:56330 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754015Ab3IKR1R (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Sep 2013 13:27:17 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id A23E5CDA5E2;
	Wed, 11 Sep 2013 18:27:16 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -2.9
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9] autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hIS+BL6AlHsc; Wed, 11 Sep 2013 18:27:15 +0100 (BST)
Received: from serenity.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 3025ECDA566;
	Wed, 11 Sep 2013 18:27:07 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <xmqqwqmnthfh.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234584>

On Wed, Sep 11, 2013 at 10:08:18AM -0700, Junio C Hamano wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
> 
> > reset --soft does not go through these code paths (i.e. it does not
> > need index at all). If we fail to load index index in "reset --soft" I
> > think it's ok to die(). Corrupt index is fatal anyway.
> 
> Do I smell a breakage here?  Isn't "reset --soft HEAD" (or some
> known good commit) a way to recover from a corrupt index?
> 
> If that is the case, I do not think it is OK at all.  What do we
> suggest as an alternative?  "rm .git/index && read-tree"?

Duy's suggestion below is necessary to avoid this then I think - we'll
die if the user has a corrupt index and gives a path with a trailing
slash, but without that path we won't try to load the index.

> > But "reset
> > --soft" now has to pay the cost to load index, which could be slow
> > when the index is big. Assuming nobody does "reset --soft" that often
> > I think this is OK.
> >
> > Alternatively we could load index lazily in _CHEAP code only when we
> > see trailing slashes, then replace these read_cache() with
> > read_cache_unless_its_already_loaded_earlier() or something.
