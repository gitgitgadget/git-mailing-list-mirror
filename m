From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [PATCH v3 0/3] add push --current and remote.*.pushHeadOnly
Date: Tue, 21 Jul 2009 00:09:07 +0200
Message-ID: <4A64EB03.4050104@gnu.org>
References: <1248091094-31485-1-git-send-email-bonzini@gnu.org> <7vskgrum2v.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Finn Arne Gangstad <finnag@pvv.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 21 00:09:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MT12z-00049k-JU
	for gcvg-git-2@gmane.org; Tue, 21 Jul 2009 00:09:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753673AbZGTWJS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jul 2009 18:09:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753525AbZGTWJR
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Jul 2009 18:09:17 -0400
Received: from mail-bw0-f228.google.com ([209.85.218.228]:41196 "EHLO
	mail-bw0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753299AbZGTWJR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jul 2009 18:09:17 -0400
Received: by bwz28 with SMTP id 28so2259861bwz.37
        for <git@vger.kernel.org>; Mon, 20 Jul 2009 15:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=hU5wlD//bu07TJH/bbYhrcI9oDmqdMn8SLWr9kew0Pk=;
        b=mi0Xiq2Mi0OPhAYkEqKeLiFVphPukwV7oRbznSGxxMLZHOkkTAaT8nL+CPGEmLm5NE
         YjwRFgLA4sgdrJuc2L3L63Va5NoCtEmbIoaFvC+nOZbLAJUC6l/5bo6HHlu1wAJPAI5b
         LsvKFbv9OLg7Bv4PiBBqgfMRl/IIINls6qAIk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=TcuOUcobhFja0YSc7A1TSXo4JGfoVSQueVWNqocAxhPfmVhDqHdCCBtHlDcwPJiK7G
         2UV/8p+8+a9+BUkP1NCyRua8RA4miOZY4j/VHWxOElUzeXzdfu+QH7q/Al1/2DJdJZVj
         shOZWHZMDK6KT6OaPOVJxE9hoeYKkCJxAM0V0=
Received: by 10.204.120.201 with SMTP id e9mr4726968bkr.187.1248127754992;
        Mon, 20 Jul 2009 15:09:14 -0700 (PDT)
Received: from yakj.usersys.redhat.com ([85.93.118.17])
        by mx.google.com with ESMTPS id 35sm8674852fkt.50.2009.07.20.15.09.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 20 Jul 2009 15:09:09 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b3pre) Gecko/20090513 Fedora/3.0-2.3.beta2.fc11 Lightning/1.0pre Thunderbird/3.0b2
In-Reply-To: <7vskgrum2v.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123640>

> Having to read this three times made me irritated enough to comment on
> this part of the cover letter.

Sorry (you weren't CCed on v1, though, were you?).

For me, the inherent problem of push.default is that it is a global 
setting.  As you say below, different remotes may have different 
characteristics and this can happen within the same repository.

One example is an integrator (push.default=matching) that also develops 
a few topic branches and wants to publish his tree so that people can 
peek at them --- at the same time, he wants to be free to rebase there. 
  He can then use --mirror to set up the latter remote.

Now, instead, we have a person working in a set up like the one Finn 
described.  He is a subsystem integrator, so he publishes some stable 
branches (push.default=matching again).  For development, however, he 
has to branch off the repositories published by other subsystem 
integrators; for these he wants push.default=tracking semantics.  He 
then has to define push.default=tracking and configure the other remote 
manually.  Unlike the first user, this one needs to make a global 
decision and adjust the git configuration whenever this global decision 
does not fit.

In addition, if he wants to disable pushing to some repository, he 
cannot use push.default=nothing anymore.  The problem is that "the 
exception [the setting of push.default that was desired for one 
repository] became the rule [the global per-repository push.default 
setting]", and this happened because there is no way to realize 
push.default=tracking with the usual set of git tools, namely refspecs 
and checkout -t.

While trying to understand the problem, I tried to see what it would 
take to implement push.default using the existing git tools, and what 
extra features would be needed.  The resulting design had three new 
features (per-remote tracking, autosetuppush and pushHeadOnly), and 
everything else built on top of those (the --push patch series I posted 
today).  I actually liked the design, and decided it was worth pursuing 
it instead of just turning push.default into a per-remote configuration.

It is way bigger than the push.default patches; on the other hand the 
three new features may be otherwise desirable, and it also includes some 
nice cleanups.  However, because of this I placed too much attention to 
the separate features and failed to show the big picture and what was 
missing in the 1.6.3 implementation.

(Now, back to your comments).

> [...] If on the other hand your workflow is to fork topics from the remote
> integration branch(es) (e.g. topicA and fixB both forked from master taken
> from the remote), both topics will be set to push back to the same master
> branch on the remote side if you use branch.autosetuppush.  In such a
> workflow, you work on these two topics, and when one of them is done, you
> want to push that one out, without having to push the other one that is
> not yet ready (beside, that one won't fast-forward).
> A "tracking" push that pushes all branches is actively a wrong thing to do
> in such a workflow.

Agreed.

autosetuppush is in fact not meant to be used by the usre, at least the 
casual user who restricts himself to the "git remote" porcelain and 
prefers not to deal into .git/config whenever possible.  The idea is 
that the user can use --push=tracking to express his workflow, and this 
will set up pushHeadOnly and autosetuppush together.  The combination of 
the two options is safe, and provides the behavior that best suites the 
user's workflow.

(Writing this final paragraph is what made me realize me that I was 
wrong in not showing the big picture in the beginning.  Giving hints 
through the cover letters was not enough).

 > In short, it is not necessarily bad that "push all matching" is much
 > easier to set up and use than "push all tracking", and I think it is
 > nothing to be annoyed about.

The problem is, when "the exception becomes the rule", is it still true 
that "push all matching" is easier to set up?

Paolo
