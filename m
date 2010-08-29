From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: remote-helpers: http-push protocol
Date: Sat, 28 Aug 2010 23:57:31 -0500
Message-ID: <AANLkTim=HKiQ-25QEAPPRcH6wwLLAsDdoRqTsanM67SK@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Aug 29 06:58:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OpZy3-0001tM-9v
	for gcvg-git-2@lo.gmane.org; Sun, 29 Aug 2010 06:58:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751005Ab0H2E5x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Aug 2010 00:57:53 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:58412 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750726Ab0H2E5w (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Aug 2010 00:57:52 -0400
Received: by gyd8 with SMTP id 8so1624205gyd.19
        for <git@vger.kernel.org>; Sat, 28 Aug 2010 21:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:from:date
         :message-id:subject:to:cc:content-type;
        bh=BlPbj2+RNARTXR5adrxybGdXrKPU2zkb03q3wr5Rb08=;
        b=SdX9sPAN4nXQlAlf1IGi/iG9aFY2WXUoibYLLtCwrLfepcR+h7hH1d197+eW75slrA
         Xc/VWkh1UwxVf1Pxqb1JHdiEolwve1lRSy/Q19Xh96I633sqp6Z/FM5TIqhMqUDwkPv1
         47rS8kqN4eJMe4Ak9n8RVYf1ujfQUzgewafkg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:cc:content-type;
        b=SOONDmpyTEat+EzGTEeKsqfWcFpckuM/gpfJ45LaLdoka3d4pej1f2Z/BfVRCtek9s
         gFKvD5kkgs14of2tA0ia7zsCGb4A+tm61BwHU5xFHbP8k/YiP2XCXvsSe8uMWZjecPpT
         jRxD9X+4nFmidOU+1KRmsHgMOVXHFYCDRrgmM=
Received: by 10.150.52.11 with SMTP id z11mr3607709ybz.149.1283057871211; Sat,
 28 Aug 2010 21:57:51 -0700 (PDT)
Received: by 10.151.49.17 with HTTP; Sat, 28 Aug 2010 21:57:31 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154682>

Heya,

I'm trying to figure out how the current http push protocol is
implemented. What I've been able to deduce on my own:

When fetching from the remote, the helper is called with 'list', after
which it will give back a list of refs, 'remote' style. That is, the
remote master branch will be listed as '<remote sha>
refs/heads/master'.
When pushing to the remote, the helper is called with 'list for-push',
it will again list all refs in the same manner (omitting 'HEAD' if the
smart protocol is used).

What happens next is the part that confuses me, a certain set of refs
is pushed, by calling the helper with 'push <refspec>'. I am unclear
how this set of refs is chosen, I see that only refs that have a
peer_ref are sent, unless mirror is also set (I don't think I
understand the significance)? After the push, the helper write a set
of 'ok/error' messages, sometimes for refs that were not asked to be
pushed in the first place, errors for those are ignored though (the
error parsing code ignores an error if the ref was not scheduled to be
pushed).

Can you clarify the behavior I described? How can I best hook into the
'refs that need to be pushed selection' in the 'export' command [0]?

[0] The export command currently tries to export all refs it gets from
push_refs, which seems to be everything that the helper got from the
'list' command. The only reason this has worked so far it seems is
that all branches listed by 'list' were present as local branches.

-- 
Cheers,

Sverre Rabbelier
