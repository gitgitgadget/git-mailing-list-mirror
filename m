From: "Geoffrey Irving" <irving@naml.us>
Subject: Re: [PATCH] cherry: cache patch-ids to avoid repeating work
Date: Thu, 10 Jul 2008 07:09:14 -0700
Message-ID: <7f9d599f0807100709u778f0ab1y28776d7efb831b61@mail.gmail.com>
References: <7f9d599f0807082053w4603d0bbgfead9127c33b78b5@mail.gmail.com>
	 <7vfxqjmyg2.fsf@gitster.siamese.dyndns.org>
	 <7f9d599f0807082226oee83bedrf13d254ae12be274@mail.gmail.com>
	 <7vprpnlglh.fsf@gitster.siamese.dyndns.org>
	 <7f9d599f0807092034n438f0976pf44d4c9305871087@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Junio C Hamano" <gitster@pobox.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 10 16:10:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGwqd-0002Y6-96
	for gcvg-git-2@gmane.org; Thu, 10 Jul 2008 16:10:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754616AbYGJOJQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jul 2008 10:09:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754455AbYGJOJQ
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jul 2008 10:09:16 -0400
Received: from rv-out-0506.google.com ([209.85.198.226]:33639 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754157AbYGJOJP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2008 10:09:15 -0400
Received: by rv-out-0506.google.com with SMTP id k40so3999444rvb.1
        for <git@vger.kernel.org>; Thu, 10 Jul 2008 07:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=wKrFW2/aAQxEEOoK6XfxHmj77zTgVZS5JVgtqEDNF0M=;
        b=AMLLYAF7R0uCchEOTxgDtfslQ8JrZ3HMeTq80G/KV4sHq6aimoElPnp7EnZGb9o6qf
         CXybndlPWASsR1o28uYrG8q10xTQNOSDEdL59plaqMIOYtF1Zgzsc5DGeMlayBasK5Bk
         xov/7BL+sREcNJi0g4+tXKL/cHEEZLmM20+FI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=tz/08G2m379cJhmZs9WEvWNDwUJcSpfDUJfAiuX3JlV1fULKPPLpZAvnK67guTPU30
         fX4tLdMXWQABl2EwsWzFd39d/8luj8RLbAhgIu5QBlcaiRrAhElwrucK0VZIHgBOQcKj
         q2xkGFE+Kx1Uqt3n5mlZF/eFRTmdSekPct9Ik=
Received: by 10.140.174.11 with SMTP id w11mr2422101rve.18.1215698954553;
        Thu, 10 Jul 2008 07:09:14 -0700 (PDT)
Received: by 10.141.202.6 with HTTP; Thu, 10 Jul 2008 07:09:14 -0700 (PDT)
In-Reply-To: <7f9d599f0807092034n438f0976pf44d4c9305871087@mail.gmail.com>
Content-Disposition: inline
X-Google-Sender-Auth: cc85007936134576
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87972>

On Wed, Jul 9, 2008 at 8:34 PM, Geoffrey Irving <irving@naml.us> wrote:
> Add cached-sha-map.[ch] implementing a persistent hash map from sha1 to
> sha1.  The map is read with mmap, and completely rewritten if any entries
> change.  It would be good to add incremental update to handle the usual case
> where only a few entries change.
>
> This structure is used by patch-ids.c to cache the mapping from commit to
> patch-id into $GIT_DIR/patch-id-cache.  In the one case I've tested so far,
> this speeds up the second invocation of git-cherry by two orders of
> magnitude.  The caching can be disabled by setting cherry.cachepatchids to
> false.
>
> Original code cannibalized from Johannes Schindelin's notes-index structure.
>
> Signed-off-by: Geoffrey Irving <irving@naml.us>
> ---
>
> Note: there are at least two "holes" in this code.  First, it is impossible
> to verify the validity of the entries (this is impossible to fix).  Second,
> it is possible to write a malicious patch-id-cache file that causes git-cherry
> to go into an infinite loop.  Fixing the loop requires either traversing every
> entry on load (bad) or adding a second loop termination condition to
> find_helper.  Since looping forever is better than returning incorrect
> results, I figured fixing the weaker hole would just result in a false sense
> of security.

Oops: avoiding the infinite loop only requires reading expected O(1)
entries on load, so I can fix that if you like.  It would only be all
of them if it actually did detect the infinite loop.

Geoffrey
