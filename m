From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/2] git: continue alias lookup on EACCES errors
Date: Wed, 28 Mar 2012 16:01:45 -0500
Message-ID: <20120328210145.GG8982@burratino>
References: <7vaa30wrjx.fsf@alter.siamese.dyndns.org>
 <20120328174841.GA27876@sigill.intra.peff.net>
 <20120328180404.GA9052@burratino>
 <7v1uocwpap.fsf@alter.siamese.dyndns.org>
 <20120328184014.GA8982@burratino>
 <20120328193909.GB29019@sigill.intra.peff.net>
 <20120328194516.GD8982@burratino>
 <20120328201851.GA29315@sigill.intra.peff.net>
 <20120328204221.GE8982@burratino>
 <20120328205144.GA10174@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	James Pickens <jepicken@gmail.com>,
	Git ML <git@vger.kernel.org>,
	Frans Klaver <fransklaver@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 28 23:01:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SD00C-0007eM-Fa
	for gcvg-git-2@plane.gmane.org; Wed, 28 Mar 2012 23:01:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758651Ab2C1VBv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Mar 2012 17:01:51 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:63476 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758014Ab2C1VBu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Mar 2012 17:01:50 -0400
Received: by iagz16 with SMTP id z16so1984983iag.19
        for <git@vger.kernel.org>; Wed, 28 Mar 2012 14:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=tmryS94cUZLhrZfFeJGVNhp8UWoTE0K7nteaHU6u/Hw=;
        b=YfCV3blUFl05uqj50bJP/AK0jAbnRLCjtRd8lEhGhXILYzH3jND6aBGLy5e0QhIRpO
         XiR5UDQwmZC2f1Tf7pikz46O7RAOTYMQRsIEl5QhmllckGOafcqx8o5tCVq2lIxX5YyI
         K5tteULVR+MCLO+TDwh3nea35B6vBtx27D07IPoPXN4PtEYSjfCxDHr/t501m/gVUWTg
         tJsE388hwO88c8MwqRndptTiXfuXWXT+p2iNJn5K0lnysLDQd9ZXFI9+GIlLEz17PS1H
         XoYp7+ttfi92GZCFXMdpibQTcFG32YBpCBY+Hh1JJqIDz1fuDWPZvlW0UICzd7JttF9V
         WAfw==
Received: by 10.42.179.196 with SMTP id br4mr17455443icb.42.1332968510021;
        Wed, 28 Mar 2012 14:01:50 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id wp4sm15770091igc.3.2012.03.28.14.01.49
        (version=SSLv3 cipher=OTHER);
        Wed, 28 Mar 2012 14:01:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120328205144.GA10174@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194197>

Jeff King wrote:

> That is the cost of using the mkpath convenience function (otherwise,
> the compiler will complain that ".*" expects an int). We can do it
> manually, but in practice, do you really expect your PATH environment
> variable to overflow an int?

I'd think a check like

	if (end - p > INT_MAX)
		die("holy cow your PATH is big");

would be good enough.  Or even

	assert(end - p <= INT_MAX);

if there is some environment limit I forgot about that makes that
always true.

>> 	/*
>> 	 * When a command can't be found because one of the directories
>> 	 * listed in $PATH is unsearchable, execvp reports EACCES, but
>> 	 * careful usability testing (read: analysis of occasional bug
>> 	 * reports) reveals that "No such file or directory" is more
>> 	 * intuitive.
>> 	 */
>> 	if (errno == EACCES && cannot_find_in_PATH(file))
>> 		errno = ENOENT;
>
> I think we can even simplify cannot_find to "!exists_in_PATH" to make
> it even simpler. If it exists and execvp did not execute it, then it
> must be non-executable (or there is a race condition :) ).

Yeah, sounds good.  With Junio's caveat, that makes:

	if (errno == EACCES && !strchr(file, '/'))
		errno = exists_in_PATH(file) ? EACCES : ENOENT;
