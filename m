From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH v3 6/8] git-remote-testpy: hash bytes explicitly
Date: Sun, 27 Jan 2013 14:21:54 +0000
Message-ID: <20130127142154.GO7498@serenity.lan>
References: <cover.1358686905.git.john@keeping.me.uk>
 <611a44568bdc969bcfa3d7d870560855e00baf1e.1358686905.git.john@keeping.me.uk>
 <20130126175158.GK7498@serenity.lan>
 <7vwquzzkiw.fsf@alter.siamese.dyndns.org>
 <5104B0B5.1030501@alum.mit.edu>
 <7vy5ffxkfb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 27 15:22:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzT7r-0001Is-Jm
	for gcvg-git-2@plane.gmane.org; Sun, 27 Jan 2013 15:22:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755366Ab3A0OWF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jan 2013 09:22:05 -0500
Received: from coyote.aluminati.org ([72.9.247.114]:54106 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754965Ab3A0OWE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jan 2013 09:22:04 -0500
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id AD4816064CD;
	Sun, 27 Jan 2013 14:22:03 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -11
X-Spam-Level: 
X-Spam-Status: No, score=-11 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10] autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xSumbuO6gioc; Sun, 27 Jan 2013 14:22:03 +0000 (GMT)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by coyote.aluminati.org (Postfix) with ESMTP id 59E326064CB;
	Sun, 27 Jan 2013 14:22:03 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id 4BE5E161E564;
	Sun, 27 Jan 2013 14:22:03 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BviKXKZactyM; Sun, 27 Jan 2013 14:22:03 +0000 (GMT)
Received: from serenity.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id 36FBB161E341;
	Sun, 27 Jan 2013 14:21:56 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <7vy5ffxkfb.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214701>

On Sat, Jan 26, 2013 at 09:30:00PM -0800, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
> > This will still fail under Python 2.x if repo.path is a byte string that
> > contains non-ASCII characters.  And it will fail under Python 3.1 and
> > later if repo.path contains characters using the surrogateescape
> > encoding option [1],...
> > Here you don't really need byte-for-byte correctness; it would be enough
> > to get *some* byte string that is unique for a given input ...
> 
> Yeek.
> 
> As we do not care about the actual value at all, how about doing
> something like this instead?
> 
> +    hasher.update(".".join([str(ord(c)) for c in repo.path]))

This doesn't solve the original problem since we're still ending up with
a Unicode string.  If we wanted something like this it would need to be:

    hasher.update(b'.'.join([b'%X' % ord(c) for c in repo.path]))

which limits us to Python 2.6 and later and seems to me to be less clear
than introducing an "encode_filepath" helper function using Michael's
suggestion.


John
