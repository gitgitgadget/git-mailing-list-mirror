From: Michael G Schwern <schwern@pobox.com>
Subject: Re: [PATCH 1/4] Extract some utilities from git-svn to allow
 extracting Git::SVN.
Date: Wed, 25 Jul 2012 15:39:46 -0700
Message-ID: <501075B2.8090205@pobox.com>
References: <1343196066-81319-1-git-send-email-schwern@pobox.com>
 <1343196066-81319-2-git-send-email-schwern@pobox.com>
 <20120725212418.GA17494@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com, robbat2@gentoo.org,
	bwalton@artsci.utoronto.ca, Jonathan Nieder <jrnieder@gmail.com>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Thu Jul 26 00:39:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SuAFF-0003pK-7J
	for gcvg-git-2@plane.gmane.org; Thu, 26 Jul 2012 00:39:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751180Ab2GYWju (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jul 2012 18:39:50 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48562 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750911Ab2GYWjt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jul 2012 18:39:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5445886B8;
	Wed, 25 Jul 2012 18:39:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=message-id
	:date:from:mime-version:to:cc:subject:references:in-reply-to
	:content-type:content-transfer-encoding; s=sasl; bh=boW0t2EDzEit
	SsCdReA5h3io59k=; b=KvsAK/Wv8u7EverWl0XqsmhuDr/8rbNx/0b0yc/96a7s
	GLceNMci9vsisxaJX3BZppMVtw2qK7cMtAaYRX/rx/JRhuklo7krnPLZWf6VenqG
	GGlc/MAWkrx0vmLfXrcJUnO7ZZFWBOxNqd/TOn+I1pvKrvSpBf9pQqMZAHo2Gd4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=message-id:date
	:from:mime-version:to:cc:subject:references:in-reply-to
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=xaMs2E
	JPmp7rhZJOXkz3DTUmLt9QNgtPs7KLqvh8eS9Rt52+yJjqi7pMyBB+t9bIFeh6b0
	tIGLajhA0XJpGK49eoi4aKoOQ25HESy1SLideFGylJ6LxhMGMp5UCSxy8hgvhW+D
	vkzpHsBLdlW7lqyt25+wDsQa61bKdua38bXog=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 423C886B7;
	Wed, 25 Jul 2012 18:39:48 -0400 (EDT)
Received: from windhund.local (unknown [71.236.173.173]) (using TLSv1 with
 cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested)
 by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 561AB86B6; Wed, 25 Jul
 2012 18:39:47 -0400 (EDT)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:14.0)
 Gecko/20120713 Thunderbird/14.0
In-Reply-To: <20120725212418.GA17494@dcvr.yhbt.net>
X-Enigmail-Version: 1.4.3
X-Pobox-Relay-ID: A3852D0A-D6A9-11E1-B12E-01B42E706CDE-02258300!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202212>

On 2012.7.25 2:24 PM, Eric Wong wrote:
> Please keep Jonathan Cc:-ed, he's been very helpful with this series
> (and very helpful in general :)

I will try.


>> +use Test::More 'no_plan';
> 
> Didn't we agree to use done_testing()?   Perhaps (as you suggested) with
> a private copy of Test::More?  It's probably easier to start using
> done_testing() earlier rather than later.

Yes, we agreed done_testing is the way forward.  Given how much work I've had
to do to get even basic patches in I decided to ditch anything extra.  That
includes adding a t/lib and I didn't want to make it silently depend on an
upgraded Test::More either.

There's not much difference if we do it later.  Switching to done_testing is
trivial.  I'd like to get the big class extractions in so code stops shifting
around, and worry about the minutia of test plans later.  If it happens before
I get to it, great!

PS  Those t/Git-SVN/ tests are not tied into the normal testing process.  I
felt writing the tests now was important and they could be integrated into the
test suite later.


>> +BEGIN {
>> +    # Override exit at BEGIN time before Git::SVN::Utils is loaded
>> +    # so it will see our local exit later.
>> +    *CORE::GLOBAL::exit = sub(;$) {
>> +        return @_ ? CORE::exit($_[0]) : CORE::exit();
>> +    };
>> +}
> 
> For new code related to git-svn, please match the existing indentation
> style (tabs) prevalent in git-svn.  Most of the Perl found in git also
> uses tabs for indentation.

About that.  I followed kernel style in existing code, but felt that new code
would do better to follow Perl style.  The existing Perl code mixes tabs and
spaces, so I felt it wasn't a strongly held style.  You'll get more Perl
programmers to work on the Perl code by following Perl style in the Perl code
rather than kernel style.

Alternatively, how about allowing emacs/vim configuration comments?  The
Kernel coding style doesn't allow them, how do you folks feel?  Then people
don't have to guess the style and reconfigure their editor, their editor will
do it for them.

The important thing is to have one less special thing a new-to-your-project
Perl programmer has to do.


-- 
ROCKS FALL! EVERYONE DIES!
	http://www.somethingpositive.net/sp05032002.shtml
