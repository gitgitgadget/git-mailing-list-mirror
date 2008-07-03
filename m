From: "Adam Brewster" <adambrewster@gmail.com>
Subject: Re: [PATCH/v2] git-basis, a script to manage bases for git-bundle
Date: Thu, 3 Jul 2008 19:38:21 -0400
Message-ID: <c376da900807031638l219229bcy983ed994b37512c9@mail.gmail.com>
References: <1214272713-7808-1-git-send-email-adambrewster@gmail.com>
	 <c376da900807011836i76363d74n7f1b87d66ba34cd6@mail.gmail.com>
	 <20080702032155.GA13581@sigill.intra.peff.net>
	 <200807021144.46423.jnareb@gmail.com>
	 <20080703195915.GA18532@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Mark Levedahl" <mdl123@verizon.net>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Jakub Narebski" <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 04 01:39:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEYOZ-0008Lz-3R
	for gcvg-git-2@gmane.org; Fri, 04 Jul 2008 01:39:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756749AbYGCXi0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jul 2008 19:38:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756650AbYGCXi0
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Jul 2008 19:38:26 -0400
Received: from yw-out-2324.google.com ([74.125.46.30]:47228 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753360AbYGCXiZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jul 2008 19:38:25 -0400
Received: by yw-out-2324.google.com with SMTP id 9so446320ywe.1
        for <git@vger.kernel.org>; Thu, 03 Jul 2008 16:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=RNFwSTZjeAaYG8qGwXCHUHucPo+VW70WIMD+ihKiZHg=;
        b=COnfIIgnqp70bbqnl7YhOJG/bvdjPds7wx8poNHK0ovpzAUC35iyIFLzn3e97R+JeJ
         KEWnXB2vow/LuBbffgSNRCIvkE/ZL7z8tJSAx7/yWAsfSF3oyzEPoT/e7MzJkkDRnQEs
         xD2adt9GpD81Hf7NqttCBo8hBwLgPafUlEjZE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=JBLVbKCwpLAWhhpuIQBv5kP2QsJ1eS27lg9vfz+snD/bb+4ydA/hZv5mlbpL1zyNhI
         NER/If/H6ReUHJP4FZqsZRHU8Gr/J+kcXLLSbAobP7wwRa1umQzuc/Mxj6A9aJ1edXjO
         9x3mSBo15+wMpJwOSf0xBkRt650vpjeNTzhyI=
Received: by 10.150.206.21 with SMTP id d21mr1047569ybg.227.1215128301982;
        Thu, 03 Jul 2008 16:38:21 -0700 (PDT)
Received: by 10.150.205.18 with HTTP; Thu, 3 Jul 2008 16:38:21 -0700 (PDT)
In-Reply-To: <20080703195915.GA18532@sigill.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87336>

>
> Yes, certainly it is more flexible to have them split. I find Adam's
> argument the most compelling, though. Think about moving commits as a
> multi-step protocol:
>
>  1. Local -> Remote: Here are some new commits, basis..current
>  2. Remote -> Local: OK, I am now at current.
>  3. Local: update basis to current
>
> git-push has the luxury of asking for "basis" each time, so we know it
> is correct. But with bundles, we can't do that. And failing to update
> "basis" means we will send some extra commits next time. But updating
> "basis" when we shouldn't means that the next bundle will be broken.
>
> So I think even if people _do_ want to update "basis" when they create
> the bundle (because it is more convenient, and they are willing to
> accept the possibility of losing sync), it is trivial to create that
> workflow on top of the separate components. But I can see why somebody
> might prefer the separate components, and it is hard to create them if
> the feature is lumped into "git-bundle" (meaning in such a way that you
> cannot perform the steps separately; obviously git-bundle --basis would
> be equivalent).
>
> But I am not a bundle user, so that is just my outsider perspective.
>
> -Peff
>

How does everybody feel about the following:

- Leave git-basis as a small perl script.

- Add a -b/--basis option in git-bundle that calls git-basis.  Any
objects mentioned in the output would be excluded from the bundle.
Multiple --basis options will call git-basis once with several
arguments to generate the intersection of specified bases.

- (maybe) Add an option "--update-bases" to automatically call
git-basis --update after the bundle is created successfully.

- Change the syntax a bit so git-basis --show does what git-basis
alone does now (because the user will no longer need to interact with
that command).

There's still plenty of potential for improvements, like a --gc mode
to clean up basis files, a --rewind option to undo an incorrect
--update, or improvements in the way it calculates intersections, but
I think that with these changes the system is as simple as possible
while maximizing flexibility, utility, and usability.

Adam
