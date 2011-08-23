From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-svn: Destroy the cache when we fail to read it
Date: Tue, 23 Aug 2011 10:05:55 -0700
Message-ID: <7vobzgrrbg.fsf@alter.siamese.dyndns.org>
References: <1313979422-21286-1-git-send-email-jgross@mit.edu>
 <20110823081546.GA28091@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jason Gross <jgross@MIT.EDU>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Tue Aug 23 19:06:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QvuQV-00036c-HD
	for gcvg-git-2@lo.gmane.org; Tue, 23 Aug 2011 19:06:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755022Ab1HWRGD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Aug 2011 13:06:03 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51109 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751259Ab1HWRGA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Aug 2011 13:06:00 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C0AF833F6;
	Tue, 23 Aug 2011 13:05:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=O2xfDaz730G9/flB+cJMpWmGo90=; b=B3chUH
	PjFRT/t5uV1SZAlOUcyVTTtthCv3jiW3klId4HweJkyvcoj5pTeXO61xIL37T/Su
	0o5Tw5RZUC4C+cPZS4Rc5mv6PdZH+L1M/bDejPpie6Z88k9sV50PbzPcIGd8AOLb
	LWUBkZwazdSsoTVQ8CLk1D9OOSVXJaZGXzODc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Y3RsQy4HNMTHPwghyXY/nMbE3CIE9CFn
	V3C1NCASdFTK489zr5RTDg24P93SispPGqC5c25NVLet3O6X6nFKEIB4CbZhxOMm
	QGE8vYWJ8UT4huuqtlk16ShDeqJvZEegj6G2jd/4Rfjzs7H32dbYfvlVuMyDrTKU
	Ozut17o9+M8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B79D233F5;
	Tue, 23 Aug 2011 13:05:58 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3B58633F4; Tue, 23 Aug 2011
 13:05:57 -0400 (EDT)
In-Reply-To: <20110823081546.GA28091@dcvr.yhbt.net> (Eric Wong's message of
 "Tue, 23 Aug 2011 08:15:46 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2BB5317A-CDAA-11E0-B5C8-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179950>

Eric Wong <normalperson@yhbt.net> writes:

> Jason Gross <jgross@MIT.EDU> wrote:
>>  		my $cache_path = "$ENV{GIT_DIR}/svn/.caches/";
>
> Can we make the caches sharable by encoding variables like
> $Config{use64bitint} and $Storable::VERSION into $cache_path?
>
> Something like this (untested):
>
> 	use Config;
>
> 	my $cache_path = "$ENV{GIT_DIR}/svn/.caches/";
> 	$cache_path .= "$Config{use64bitint}.$Storable::VERSION/";
>
> We'll blow everybody's cache away once during the git-svn upgrade, but
> in the future people will be able to share the same working tree between
> different versions of perl/Storable/whatnot without needing extra code
> to detect croaks, different build options, and nuking each other's
> caches.

Meaning multiple directories and people share with those with systems with
similar characteristics?  It certainly is better than silently getting
confused or barfing when reading 32LE data on 64BE box, and presumably it
would be easy to implement, but is that the best we can do with memoize?

I am wondering if memoize can be told to use a platform independent
serializer backend that is reasonably efficient.
