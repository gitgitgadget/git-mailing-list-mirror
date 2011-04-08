From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/4] add -u: get rid of "treewideupdate" configuration
Date: Fri, 08 Apr 2011 15:22:20 -0700
Message-ID: <7vmxk01izn.fsf@alter.siamese.dyndns.org>
References: <1302138996-10006-1-git-send-email-gitster@pobox.com>
 <1302138996-10006-3-git-send-email-gitster@pobox.com>
 <20110408175149.GA3917@sigill.intra.peff.net>
 <7vaag04k8m.fsf@alter.siamese.dyndns.org>
 <20110408202404.GA16540@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Apr 09 00:22:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q8K4b-0001su-8a
	for gcvg-git-2@lo.gmane.org; Sat, 09 Apr 2011 00:22:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752107Ab1DHWWb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Apr 2011 18:22:31 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:61139 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750936Ab1DHWWa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Apr 2011 18:22:30 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0C41D5D28;
	Fri,  8 Apr 2011 18:24:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=Nvu/KihvRUl6/toO2HgFeHwqsGg=; b=Y0lJ0XaxJF0eyza/aH0D
	15TC6cK2XBxsPya5yfOUjaTzBB6QfRg1Kg2ziukOErpl39qcdfur3ma1tSQ3F1+b
	69fN2J82+sfsDlgdD+rSAAUK7K0YPzXpMXdjP4WbVnH8PHZJ0iavNWXcTLY39zfD
	X2qIF7d2YYKs7DOXWfn2NKo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=Ip87KVAxgM4K77/ry5f0EjvDNjIhxVXTsR6P5V7HO3CFyu
	5oFa1hStnuEu6KHJAMebr3X1JxvO4yMCf82tI+Cgrb98rvRO9ULTBDHniwCYyntj
	dlgsi3409xCgPcfCcyFv4jou8LlEX+8/0ETwG7pSGfkCFFL9mhY/LmjPqj45Y=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id DC6305D27;
	Fri,  8 Apr 2011 18:24:20 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id C79235D26; Fri,  8 Apr 2011
 18:24:17 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F321FDC0-622E-11E0-A81D-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171166>

Jeff King <peff@peff.net> writes:

> But we don't live in that world. We are making a transition, and so it
> may be worth it to help:
>
>   1. People who want the new behavior _now_ without extra typing.
>
>   2. Placate people who say "...but I liked the old behavior better".
>
> I am in group (1). I don't know if people in group (2) need placating or
> not, but I have grown to assume there will always be people to complain
> about a change. :)

Ok, first things first.  Any new feature we add we would need to keep
forever.  I would rather not to see us having to maintain the default
behaviour configuration variable forever into the future for these
commands (not just add-u, but also grep, ls-files, ...).

Now, having said that, we could vastly simplify things.

I think the real cause of this confusion is because we have been dead-set
assuming that we _have_ to change the default.  The logic goes like this:

 - We will change the default, but we do not want to harm existing users;
   therefore

 - We need to introduce the variable to keep the old default not to harm
   existing users, but it would add to the uncertainty of the default when
   you do not know which version of git you are using. You now have to
   also worry about unknown configurations, so we need to train people to
   explicitly say '.' or ':/'; therefore

 - We need to issue warnings to train the user, but we do not want to show
   warnings to users who already learned the change is coming; therefore

 - We do need the configuration variable, and everybody needs to set it to
   squelch the warning. Otherwise "add -u" without any pathspec is too
   noisy to be usable.

But I am not happy with the last step of the above deduction for two
reasons.

The configuration will only help people who have total control of the
version of git they have on their boxes.  They can say "Ok, I know what I
want, and I know which default the version of git I installed on this box,
so I set the variable and can forget about it forever, and keep typing
'git add -u' without any pathspec."

But that would not work for people who need to work on multiple boxes,
some of the boxes still running late 1.7.X while others running 1.8.0 or
later, and the version of git they will be running is under sysadmin's
control (your "a site that runs unknown version" example).  These people
need to train their fingers to be explicit when working in a subdirectory
and running the command without a pathspec during the transition period
anyway.  It is a _good_ thing not to have any way to squelch the warning
without being explicit in that sense, _if_ we are going to change the
default.

Another reason, which is worse, is that it would make it _harder_ to help
migrating scripts, if the presense of the configuration variable squelched
the warning.  "Warn when run without pathspec from a subdirectory" would
issue the warning every time until the invocation is changed to an
explicit one, and your script that runs 'add -u' without pathspec will
keep emitting the message until all such invocations are fixed.

So let's step back a bit.

How about we'd just add ':/' to make it equally easy to switch between
"local only" vs "tree-wide" in 1.7.6 release, and be done with it.  We
don't change the default for any of the commands at all.

No need to issue warnings because there won't be any backward imcompatible
change.  The users fingers do not need any re-training.  There is no need
to rewrite scripts, either.

One good attribute of the combination of short-and-sweet ':/' and existing
short-and-sweet '.' is that they make the default immaterial.

Since more than a year ago, I've been saying that the ideal is to make the
default not matter:

  http://thread.gmane.org/gmane.comp.version-control.git/133570/focus=133683

If the default does not matter, why change it?  It just causes us more
headaches for dubious gain, no?

IIRC, I think the two reasons why we started discussing of "add -u" and
friends were that (1) some commands default to whole-tree while others
limit to $cwd --- inconsistency is bad; and (2) when the user wants to do
a full tree "add -u", there is no way other than counting the current
depth and typing "../" that many times.

But when we looked at the current set of commands that limit them to the $cwd,
we found that "add -u" was the only one that may make sense to switch the
default, meaning that the "consistency" was not something we would even
want to shoot for.  For example, we want our "git grep -e pattern" to
mimic "grep -r -e pattern .".

And the second reason is going away, thanks to Michael and Duy's ':/'.
