From: Sam Vilain <sam@vilain.net>
Subject: Re: [RFC] [PATCH 0/5] Implement 'prior' commit object links (and
Date: Tue, 02 May 2006 12:21:42 +1200
Message-ID: <4456A616.6070402@vilain.net>
References: <20060429165151.2570.qmail@science.horizon.com>	<e30b48$ovk$1@sea.gmane.org> <7viros1585.fsf@assigned-by-dhcp.cox.net>	<e30k0n$ij5$1@sea.gmane.org> <e32kkf$amc$1@sea.gmane.org>	<7vfyjuwt0v.fsf@assigned-by-dhcp.cox.net>	<7v8xpmva9x.fsf@assigned-by-dhcp.cox.net>	<4455638A.3070802@vilain.net> <7vlktms02x.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 02 02:22:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FaieR-0006IK-7e
	for gcvg-git@gmane.org; Tue, 02 May 2006 02:22:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751270AbWEBAV7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 1 May 2006 20:21:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751275AbWEBAV7
	(ORCPT <rfc822;git-outgoing>); Mon, 1 May 2006 20:21:59 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:19080 "EHLO
	watts.utsl.gen.nz") by vger.kernel.org with ESMTP id S1751270AbWEBAV6
	(ORCPT <rfc822;git@vger.kernel.org>); Mon, 1 May 2006 20:21:58 -0400
Received: by watts.utsl.gen.nz (Postfix, from userid 65534)
	id 51E8A5A61; Tue,  2 May 2006 12:21:55 +1200 (NZST)
Received: from [127.0.0.1] (longdrop.watts.utsl.gen.nz [192.168.255.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by watts.utsl.gen.nz (Postfix) with ESMTP id 896FD55A5;
	Tue,  2 May 2006 12:21:43 +1200 (NZST)
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vlktms02x.fsf@assigned-by-dhcp.cox.net>
X-Enigmail-Version: 0.92.1.0
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on 
	mail.watts.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=5.0 tests=ALL_TRUSTED autolearn=failed 
	version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19395>

Junio C Hamano wrote:

>>Aha, now I see reason in the madness. So, the "prior" head is not stored
>>in the trees, and tracking the progress of actual head transitions is
>>loosely defined / a research topic. But demonstrably derivable. That
>>works for me.
>>    
>>
>I do not think there is any madness involved here, but I should
>  
>

Sorry, it was a figure of speech. It's more like, what appeared to be
madness no longer looks so.

>point out that the above example happens to work only because
>Linus and David are two different people.  If Linus did the
>David's work in a separate repository, or even in the same
>repository but on a separate branch, people following the Linus
>tip might still want to know about the fast-forward, but that is
>something you cannot truly tell by the digging like what I did
>in the previous message.
>
>That is why I earlier said this:
>
>    *1* IOW, we _are_ losing some information by not recording the
>    fact that fast-forward was done while doing so.  
>
>    That record should _not_ be in the commit chain.  At the
>    mechanical level, recording that in the commit chain means two
>    criss-crossing branches never converge at the commit chain
>    level, which is already bad.
>  
>

Here I'm a little bit confused still. Surely criss-crossing branches
already don't converge unless the commits are in the same order.

Oh, I see. Even if they *are* in the same order, the commit IDs would
end up different due to these extra headers.

>  At the philosophical level, the
>    commit chain is a mesh of many possible "global" histories, and
>    the record that somebody (a particular branch in a particular
>    repository) was at what point in the mesh at given time does not
>    belong there.
>
>    But from the repository-owner's point of view, that _might_ be a
>    useful information to keep.  I am just saying this preemptively
>    so that if somebody wants to record it, that should not be
>    recorded in the commit object.
>  
>

That makes sense.

>On the other hand, a "note" field that records on which branch
>of which repository each commit was made (you need to give each
>repository-branch an UUID) when you do create a new commit would
>be a sensible thing to have if somebody cares deeply enough.  It
>is an information that is global in nature, and with that, you
>could do the digging like I did without relying on the committer
>identity, but instead using the branch identity.
>  
>

That sounds reasonable. The UUID doesn't need to replicate, either, just
tag the commits that were made against it.

This extra information falls into the informational, "forensic" history
tracing category. ie, we don't know now whether we'll need it, but we'll
store it anyway just to be sure to not make later operations impossible.

I think the large remaining question is around what conventions apply to
the use of the "note" field. We have perhaps the first example of a well
formed piece of "forensic" information that belongs in the commit chain
and could possibly be added by plumbing. I can't think of any more of
those, but the rename/copy tracking case is a bit different. In this
case, it doesn't belong in the plumbing, yet you want a reasonable
convention for storing this information to apply. Also the other cases
outlined in the original post might do well to have a common convention
so that the information is more portable between porcelain.

Sam.
