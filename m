X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [RFC] Submodules in GIT
Date: Fri, 1 Dec 2006 09:02:48 +0000
Message-ID: <200612010902.51264.andyparkins@gmail.com>
References: <20061121223130.GA24909@nan92-1-81-57-214-146.fbx.proxad.net> <200611292000.23778.andyparkins@gmail.com> <20061130170625.GH18810@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 1 Dec 2006 09:03:08 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=G+MHKfXDsa72TgE+CUaMUdQ028+siRZsgGgnTBIxTvQEIc3qpDPHazRuAzDDCYHWEFFJWuhhMcxK8nKwAsEeRjvXPL8GdNJxxntbSw0mubCWr/SdTGnuVq9yn0n1fxTMUIT+DT6ZrrSkS41lJAk7CxhVds7lC41rv//nRrHUExk=
User-Agent: KMail/1.9.5
In-Reply-To: <20061130170625.GH18810@admingilde.org>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32876>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gq4IP-0006qU-D7 for gcvg-git@gmane.org; Fri, 01 Dec
 2006 10:03:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030391AbWLAJC6 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 1 Dec 2006
 04:02:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967564AbWLAJC6
 (ORCPT <rfc822;git-outgoing>); Fri, 1 Dec 2006 04:02:58 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:38265 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S967536AbWLAJC5
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 1 Dec 2006 04:02:57 -0500
Received: by ug-out-1314.google.com with SMTP id 44so2363062uga for
 <git@vger.kernel.org>; Fri, 01 Dec 2006 01:02:55 -0800 (PST)
Received: by 10.67.19.17 with SMTP id w17mr6927139ugi.1164963775541; Fri, 01
 Dec 2006 01:02:55 -0800 (PST)
Received: from dvr.360vision.com ( [194.70.53.227]) by mx.google.com with
 ESMTP id x37sm3592198ugc.2006.12.01.01.02.54; Fri, 01 Dec 2006 01:02:55 -0800
 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On Thursday 2006 November 30 17:06, Martin Waitz wrote:

> You can easily have several topic-branches and merge updates from the
> master branch.
> otherwise you always have to remember which branch holds your current
> contents from the supermodule.

WHAT?  I've got to make merges (that I don't necessarily want) in order to 
commit in the supermodule?  This completely negates any useful functioning of 
branches in the submodule.  I want to be able to make a quick development 
branch in the submodule and NOT merge that code into master and then be able 
to still commit that in the supermodule.

I think you're imagining the binding between the super and sub is very much 
tighter than it should be.  What if I'm working on a development version of 
the supermodule, which includes a stable version of the submodule?  Vice 
versa?

> When viewed from the supermodule, you are storing one branch per
> submodule in your tree.

That prevents me "trying something out" on a topic branch in the submodule.  
Here's a scenario using my suggested "supermodule tracks submodule HEAD" 
method.

 * You're developerA
 * Make a development branch in the supermodule
 * In the submodule, make a whole load of topic branches
 * Make a development branch in the submodule
 * Merge the topic branches into the development branch of the submodule
 * Commit in the supermodule.  This capture
 * Tag that commit "my-tested-arrangement-of-submodule-features"
 * Push that tag to the central repository - tell the world.
 * DeveloperB checks out that tag and tries it.  Great stuff.

Now: here's the secret fact that I didn't tell you that will break 
your "supermodule tracks submodule branch" method.  DeveloperB has decided to 
have this in his remote:
  Pull: refs/heads/master:refs/heads/upstream/master
Oops. The supermodule, which has been told to track the "master" branch in the 
submodule is tracking different things in developerA's repository from 
developerB's repository.  Worse, what if developerB did this:
  Pull: refs/heads/master:refs/heads/development
  Pull: refs/heads/development:refs/heads/master

Branches are completely arbitrary per-repository.  You cannot rely on them 
being consistent between different repositories.  If you store the name of a 
submodule branch in a supermodule - that supermodule is only valid for that 
one special case of your particular version of the submodule.


Andy
-- 
Dr Andy Parkins, M Eng (hons), MIEE
