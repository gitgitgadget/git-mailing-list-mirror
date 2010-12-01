From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Trivial patches (Re: [PATCH] commit: Remove backward goto in
 read_craft_line())
Date: Wed, 1 Dec 2010 15:07:00 -0600
Message-ID: <20101201210700.GC27845@burratino>
References: <1291230959-3894-1-git-send-email-ralf.thielow@googlemail.com>
 <20101201194441.GB27347@burratino>
 <7vaakputxs.fsf@alter.siamese.dyndns.org>
 <20101201203132.GB27845@burratino>
 <AANLkTinLuF74UKaTMNX84FJt+PNoKkkOr3LaXDSCFqdz@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Ralf Thielow <ralf.thielow@googlemail.com>
X-From: git-owner@vger.kernel.org Wed Dec 01 22:07:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNttX-00023I-FD
	for gcvg-git-2@lo.gmane.org; Wed, 01 Dec 2010 22:07:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757226Ab0LAVHL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Dec 2010 16:07:11 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:61920 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757194Ab0LAVHK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Dec 2010 16:07:10 -0500
Received: by bwz15 with SMTP id 15so6535918bwz.19
        for <git@vger.kernel.org>; Wed, 01 Dec 2010 13:07:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=6HziA01ckbjn4nJgMqgxbJmo2i242L+OfKU3UyY2vuw=;
        b=S9JIN4z+0X0I7aelJN8D4UnFaHMwp/wDsBdPM6P4hSwRogEafeIIYSoAixZFYu+DqN
         vPIjNK4fyQpT2zIqbi61uLvHtRWl6eHugwA/qlxGPT4kAa25v2iTehWqVXNtKNzQ17KC
         56m6nEcwCc0qiGhmrIflN+3NtXADOHiXVQIPo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=NkQzBbk4036A6THN0OHp8vTrMQm1p6skw52uNS4NIU1oDocah9WzX9rY5278mclmRi
         abbxgRs4qgHXbz2TwaydCpRbm73DnhF0m7EUbGv+2oeTsfZI52Azl7gWADTpzpAVZ/A3
         aNB9SpwBDbEFohACoUyWbw7Ma8Lg1K0IJiIGA=
Received: by 10.204.120.141 with SMTP id d13mr4945771bkr.140.1291237629163;
        Wed, 01 Dec 2010 13:07:09 -0800 (PST)
Received: from burratino (adsl-68-255-109-73.dsl.chcgil.ameritech.net [68.255.109.73])
        by mx.google.com with ESMTPS id l3sm1068495fan.0.2010.12.01.13.07.07
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 01 Dec 2010 13:07:08 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTinLuF74UKaTMNX84FJt+PNoKkkOr3LaXDSCFqdz@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162613>

Hi Ralf,

Ralf Thielow wrote:

> In fact the "--show-c-function" output is the problem. But I think that
> a change can't be rejected because of another issue.
> The style of placing "goto"-statements, which leave a function to the
> end of that is used in many other projects. And I think
> it's very usefull.

Thinking more about your patch reminds me of something that can be
confusing to new contributors.  Sometimes it is hard for a trivial
patch to be accepted than one which makes a larger change, requires
more time reviewing it, and has more potential for catastrophic
breakage.

Why is that?  Resistance to trivial changes is in my opinion a good
thing and I'd like to emphasize that now, since my feeling about
this patch is borderline.[1]

In this case, the patch is changing code like this:

	do something
	if (error) {
	error_case:
		report error;
		free resources;
		return -1;
	}
	do something else
	if (error)
		goto error_case;
	if (other error)
		goto error_case;
	return result;

into the more usual simulated exception handling:

	do something
	if (error)
		goto error_case;
	do something else
	if (error)
		goto error_case;
	...
	return result;
error_case:
	report error;
	free resources;
	return -1;

The latter is not really much clearer than the former, just less
unusual.  Changing the code means patches are less likely to apply
to both the before and after.  Changing the code requires time to
review it and to explain why this kind of change is okay in this
case but in other cases it wouldn't be.

So it would be much easier to like this if the change fixed a
noticeable problem (in user-visible behavior, maintainability,
or clarity).

Sorry for the mixed message.  Partly I really _wanted_ to like
this because it is in better taste than some of the trivial patches
the git list has received before.  As far as applying this one, I
suppose I would not mind either way.

Anyway, I hope that makes the underlying principles a bit clearer.

Thanks for a useful example.
Jonathan

[1] Linux has a "maintainer of trivial" that takes care of such
patches while minimizing the damage to bystanders.  Traditionally
there were some pretty rigid guidelines for what patches in this
area were accepted, which was probably a good idea.
ftp://ftp.kernel.org/pub/linux/kernel/people/rusty/trivial/template-index.html
