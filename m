From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC] upload-pack deadlock
Date: Mon, 18 Apr 2011 00:34:06 -0500
Message-ID: <20110418053406.GA5256@elie>
References: <20110404053626.GA26529@sigill.intra.peff.net>
 <7v8vvnjnyg.fsf@alter.siamese.dyndns.org>
 <20110406175413.GA8205@sigill.intra.peff.net>
 <20110406213333.GA18481@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Aman Gupta <aman@github.com>, Ryan Tomayko <ryan@github.com>
To: Jeff King <peff@github.com>
X-From: git-owner@vger.kernel.org Mon Apr 18 07:34:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QBh6I-0001Dq-CM
	for gcvg-git-2@lo.gmane.org; Mon, 18 Apr 2011 07:34:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751432Ab1DRFeO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Apr 2011 01:34:14 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:38387 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751324Ab1DRFeM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Apr 2011 01:34:12 -0400
Received: by iyb14 with SMTP id 14so3614187iyb.19
        for <git@vger.kernel.org>; Sun, 17 Apr 2011 22:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=7i9jMFYjDAj2UCmYTa9fpxPqohWCr3WbFn4J4iHitn4=;
        b=W1fTV7oFDyMQIbEHwKcPGlvqh2XYZON6A+5bAva+dM315/RTF9PxtnAOukWCIE1M5P
         AGDw7ppT4WwMH24UTAA7EMeqGmuUjtHTMr2zGQ7u6RJAqpRa6Owp7AoHwvRLlFO5W+JR
         Z+kPoiOHZGX6z1xpxUyyjeebTsmTIz/HKlApM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=s/8EFvk7UymwYg4oH3iRyfd38+Rj1bVerbmN80RJjWp3PRD7TbcyBn9vw2hv42o3/F
         BuJTDQ6pab//9WYMpkFZDhBpgvRbcXjGQ27zVIAfSW9ef5yEILEefCPY+rHrBAV6j1C+
         aG58xG5DM4z04D/j9KQ2n54+H1lYoJ1EcL3R8=
Received: by 10.231.145.212 with SMTP id e20mr3512493ibv.45.1303104851899;
        Sun, 17 Apr 2011 22:34:11 -0700 (PDT)
Received: from elie (adsl-69-209-55-4.dsl.chcgil.ameritech.net [69.209.55.4])
        by mx.google.com with ESMTPS id d9sm2733536ibb.19.2011.04.17.22.34.10
        (version=SSLv3 cipher=OTHER);
        Sun, 17 Apr 2011 22:34:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110406213333.GA18481@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171735>

Jeff King wrote:

> Subject: [PATCH] upload-pack: start pack-objects before async rev-list
>
> In a pthread-enabled version of upload-pack, there's a race condition
> that can cause a deadlock on the fflush(NULL) we call from run-command.
[...]
> To fix this, we swap the start order: we start the
> pack-objects reader first, and then the rev-list writer
> after. Thus the problematic fflush(NULL) happens before we
> even open the new file descriptor (and even if it didn't,
> flushing should no longer block, as the reader at the end of
> the pipe is now active).
>
> Signed-off-by: Jeff King <peff@peff.net>

t5500.12 "fetch same depth in shallow repo" reproducibly hangs[1] on
the HURD without this patch and passes with it.  I had just assumed it
was some weird hurd thing.  Thanks for figuring it out.

Tested-by: Jonathan Nieder <jrnieder@gmail.com>

[1] http://bugs.debian.org/607346
