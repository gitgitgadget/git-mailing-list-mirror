From: Johan Herland <johan@herland.net>
Subject: Re: Re* [1.8.0] Provide proper remote ref namespaces
Date: Tue, 15 Feb 2011 16:06:20 +0100
Message-ID: <201102151606.21040.johan@herland.net>
References: <AANLkTi=yFwOAQMHhvLsB1_xmYOE9HHP2YB4H4TQzwwc8@mail.gmail.com> <201102141018.46527.johan@herland.net> <7vfwrqtrsk.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>,
	Jeff King <peff@peff.net>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Nicolas Pitre <nico@fluxnic.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 15 16:09:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PpMXO-0006cb-9L
	for gcvg-git-2@lo.gmane.org; Tue, 15 Feb 2011 16:09:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755083Ab1BOPJy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Feb 2011 10:09:54 -0500
Received: from smtp.opera.com ([213.236.208.81]:33078 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752027Ab1BOPJw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Feb 2011 10:09:52 -0500
Received: from johanh.eng.oslo.osa (pat-tdc.opera.com [213.236.208.22])
	(authenticated bits=0)
	by smtp.opera.com (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id p1FF6LUE013303
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 15 Feb 2011 15:06:21 GMT
User-Agent: KMail/1.9.9
In-Reply-To: <7vfwrqtrsk.fsf_-_@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166855>

On Monday 14 February 2011, Junio C Hamano wrote:
> Johan Herland <johan@herland.net> writes:
> > So if nobody disagree, I would have no problem with dropping the
> > leading "~" from the refspec, thus disabling auto-following
> > (tracking all tags explicitly instead).
>
> I am not sure what you mean by this.  I think we agree that it would
> be Ok if you cannot add "~" in front to cause automatic following
> when tracking tags in separate namespaces using
> "refs/tags/*:refs/remotes/origin/tags/*".
>
> But are you saying:
>
>  (1) There is no other change than that; or
>
>  (2) Even when not using such a refspec i.e. using the traditional
> "tags live in a single global namespace", automatic following feature
> will be disabled;
>
> I would be moderately unhappy if the latter.

No, I'm saying the former.

For the foreseeable future (i.e. long after v1.8.0 is out) we will still 
have to understand and support the traditional "tags are implicitly 
auto-followed" and "tags live in a single global namespace" concepts 
(aka. (a) below). For new-style remotes I propose that all refspecs be 
explicit, and that auto-follow is disabled (aka. (b) below).

But if you try to specify a new-style remote with all tags in a single 
global namespace, you will NOT get tag autofollowing (aka. (c) below)


(a): The current default config, also supported for the foreseeable 
future (tag refspec is implicit, auto-following is enabled):

    [remote "origin"]
        url = ...
        fetch = +refs/heads/*:refs/remotes/origin/*

(b): The proposed default config, using separate per-remote namespaces 
for tags (tag refspec is explicit, auto-following is disabled):

    [remote "origin"]
        url = ...
        fetch = +refs/heads/*:refs/remotes/origin/heads/*
        fetch = +refs/tags/*:refs/remotes/origin/tags/*

(c): A customized version of the proposed config, using a single global 
namespace for tags (tag refspec is explicit, auto-following is 
disabled):

    [remote "origin"]
        url = ...
        fetch = +refs/heads/*:refs/remotes/origin/(heads/)*
        fetch = refs/tags/*:refs/tags/*


(Note that if we cannot reliably detect the difference between old-style 
(implicit) and new-style (explicit) remotes, we will likely have to add 
a boolean flag, e.g. "remote.origin.implicitTagFollowing".)


> > ... However, what I've seen at $dayjob is
> > that more inexperienced users will often push right after
> > committing, and at that time they're still very much in the
> > "working-on-one-branch" state of mind (as opposed to the
> > "administering-multiple-branches" state of mind),...
>
> Then "current" mode is a good setting for them, I would presume.

Arguably in some workflows, 'tracking' may be a more suitable default 
(i.e. safer for newbies) than 'current', but in practice this shouldn't 
matter much (local branch names usually correspond to remote branch 
names). Also, 'tracking' is more complicated when the branch originates 
locally, and must be created on the server ("git push -u origin 
<branch>" vs. "git push"). So I agree that 'current' is the best 
default.


...Johan


Offtopic PS: Given that we're leaning towards using 'tracking' to 
describe the relationship between remote-tracking branches 
(refs/remotes/*) and remote branches, and 'upstream' to describe the 
relationship between a local branch and the remote branch it 
follows/merges (on 'git pull'), wouldn't

  push.default == "upstream"

be more descriptive than

  push.default == "tracking"

?

-- 
Johan Herland, <johan@herland.net>
www.herland.net
