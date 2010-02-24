From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: Handling non-git config files
Date: Thu, 25 Feb 2010 08:37:53 +1100
Message-ID: <2cfc40321002241337q6b437803m82d05fb272cca6b2@mail.gmail.com>
References: <8440EA2C12E50645A68C4AA9887166513FC19C@SERVER.webdezign.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Feb 24 22:38:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NkOvh-00041N-76
	for gcvg-git-2@lo.gmane.org; Wed, 24 Feb 2010 22:38:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758192Ab0BXVhz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2010 16:37:55 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:60145 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758182Ab0BXVhy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2010 16:37:54 -0500
Received: by pwj8 with SMTP id 8so5148913pwj.19
        for <git@vger.kernel.org>; Wed, 24 Feb 2010 13:37:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type;
        bh=4X2r6P6+GiUS9xKValpLX0Hx4Ar73itiB3PjxoB9cF0=;
        b=gPaSe41aY1HhqukrTBfh2bJuulvfGDDMvwxHqS3FkKl3/oIClMMhTuXj1phlGqEEEs
         9NgD7gwngI/BJuzg6FGsDH8leF1j8E6OCXIYrFfPJPPV5Lx/TuRSFARTXehDKLc6ASPj
         aFu4+IV0OTfw+T2jxpEu2prqhL1xoNIEDm2dg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        b=PNPncfgOFAFDnJH00+/QpyJm8HWXZcak8O2g+iqpKtloClPzj92z0tbdiyh4ThfpwR
         QdJMfg68xZhBbD5on+78rJA99QUDYA2Ov6lWTF/n6YlW0LC+Udv2rPTfA5OvM0NGvVAD
         NnKwxxagH94j9iIdzNz4+bOQa4o/L5+H/AXV8=
Received: by 10.115.133.25 with SMTP id k25mr205924wan.134.1267047473720; Wed, 
	24 Feb 2010 13:37:53 -0800 (PST)
In-Reply-To: <8440EA2C12E50645A68C4AA9887166513FC19C@SERVER.webdezign.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140990>

[ Richard sent his own copy ]

I have used git in a deployment scenario and found it to be very useful.

The way I dealt with this problem was to treat the variants as a build
problem. During the build, I create a version of the deployment
artifacts that reflect a generic, uncustomized server. This gets
checked into a branch. To build the an environment specific variant, I
checkout the build result for the uncustomized server on a new branch,
customize it and commit that to the tip of the environment specfic
branch. The process continues down the hierarchy, so I take the
environment specific variant, customize it for particular servers and
commit that to a new branch. Each branch is represented in git as a
merge of the current build with the results of the previous build for
the previous for the same branch. [ Thereby allowing FF merges during
deployment ]

The end result is that I have a git repo with one branch for the
abstract server, one for each environment (all uncustomized or
partially customized) and one full customized branch for each physical
server. The whole repo can then be pushed to all environments (but not
checkout there). Deployment is then simply a question of pulling (or
checking out) the right tag of the right branch on each server at the
right time (e.g. after testing, during change windows etc).

Pulling has the advantage of preserving adhoc configuration changes in
deployed environments that have not been folded back into the build
process, though at some risk of merge conflicts &/or inconsistency. My
approach in the case of merge conflicts was to report the problem,
save the current state (in the git history) and resolve in favour of
the build product. Alternative strategies might be to abort the
deployment until the conflict is resolved, etc.

(I also used a separate aggregation technique to aggregate several
distinct repo into a single hub repo so that as to minimise the number
of git operations required to sync two nodes in the deployment
topology.)

Using git in this way was great - deployment of an incremental release
was super quick because the repos could be pre-deployed and transfers
typically only included files that had changed for the release - gone
are the big tar balls being transferred that contain mostly unchanged
stuff.
