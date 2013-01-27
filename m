From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/2] fetch-pack: avoid repeatedly re-scanning pack
 directory
Date: Sun, 27 Jan 2013 02:27:53 -0800
Message-ID: <20130127102753.GB4228@elie.Belkin>
References: <20130126224011.GA20675@sigill.intra.peff.net>
 <20130126224043.GB20849@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Jan 27 11:28:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzPTL-0000Y4-QC
	for gcvg-git-2@plane.gmane.org; Sun, 27 Jan 2013 11:28:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756392Ab3A0K2A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jan 2013 05:28:00 -0500
Received: from mail-pb0-f45.google.com ([209.85.160.45]:54587 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756362Ab3A0K16 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jan 2013 05:27:58 -0500
Received: by mail-pb0-f45.google.com with SMTP id rq13so953855pbb.32
        for <git@vger.kernel.org>; Sun, 27 Jan 2013 02:27:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=Uyx3sJl8vDqCFVun+harlLJMOMCA4juGChnRfsoDtv4=;
        b=sG4kbmnyVPyVYIy6ZtbRpnSrx+I815iFXDc8SL5cQaGlTewMP+ynd+D1Se+5CWMn3m
         CqvS+F49eP2HGew8IMLEgrW+baDqJ992TbRs6mCiL5TovVhn0aLrb+RfjN9yFJ+XinHW
         4QnKA9m8nFpNQPpvsuEwvMuaqN4DeJBL+sWc06QdbR8ggUa8ofFomGQOxgjEBRNomhtZ
         5UPI/lHXsYtNEekwFsOOgvHgLKoYwYrbV/f14DtRt8Xyh3Tgg0mw/Jko7KJJxCfT8RHH
         zDjoE+gCtmXUjtvkta1a+AZYJ5PidKHRBnrJ/9WgYB9S2Z//HhFHliwmTTFgtg5o7rxb
         rMKg==
X-Received: by 10.66.83.6 with SMTP id m6mr27384408pay.52.1359282478363;
        Sun, 27 Jan 2013 02:27:58 -0800 (PST)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id qo10sm4160878pbc.58.2013.01.27.02.27.55
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 27 Jan 2013 02:27:57 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20130126224043.GB20849@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214690>

Hi,

Jeff King wrote:

> When we look up a sha1 object for reading, we first check
> packfiles, and then loose objects. If we still haven't found
> it, we re-scan the list of packfiles in `objects/pack`. This
> final step ensures that we can co-exist with a simultaneous
> repack process which creates a new pack and then prunes the
> old object.

I like the context above and what follows it, but I think you forgot
to mention what the patch actually does. :)

I guess it is:

	However, in the first scan over refs in fetch-pack.c::everything_local,
	this double-check of packfiles is not necessary since we are only
	trying to get a rough estimate of the last time we fetched from this
	remote repository in order to find good candidate common commits ---
	a missed object would only result in a slightly slower fetch.

	Avoid that slow second scan in the common case by guarding the object
	lookup with has_sha1_file().

Sounds like it would not affect most fetches except by making them
a lot faster in the many-refs case, so for what it's worth I like it.

I had not read this codepath before.  I'm left with a few questions:

 * Why is 49bb805e ("Do not ask for objects known to be complete",
   2005-10-19) trying to do?  Are we hurting that in any way?

   For the sake of an example, suppose in my stalled project I
   maintain 20 topic branches against an unmoving mainline I do not
   advertise and you regularly fetch from me.  The cutoff is the
   *newest* commit date of any of my topic branches you already have.
   By declaring you have that topic branch you avoid a complicated
   negotiation to discover that we both have the mainline.  Is that
   the goal?

 * Is has_sha1_file() generally succeptible to the race against repack
   you mentioned?  How is that normally dealt with?

 * Can a slow operation get confused if an object is incorporated into
   a pack and then expelled again by two repacks in sequence?

Thanks,
Jonathan
