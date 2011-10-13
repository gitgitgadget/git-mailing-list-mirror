From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/9] completion: optimize refs completion
Date: Wed, 12 Oct 2011 17:50:38 -0700
Message-ID: <7v7h497m01.fsf@alter.siamese.dyndns.org>
References: <1318085683-29830-1-git-send-email-szeder@ira.uka.de>
 <1318085683-29830-3-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Thu Oct 13 02:50:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RE9VX-0003Rx-IB
	for gcvg-git-2@lo.gmane.org; Thu, 13 Oct 2011 02:50:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751965Ab1JMAum convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 12 Oct 2011 20:50:42 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58175 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751301Ab1JMAuk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 12 Oct 2011 20:50:40 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 406996C17;
	Wed, 12 Oct 2011 20:50:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=ntjnpGKZWowA
	suxlTOslAC6ejuE=; b=RTOVJzzUCgFImmrTWDToBkqm6+06gCl02C9iKwaHe9aL
	zslUyXmWeVP4aIkx2RE3uU/sCGyBMErdYILznagJAGObCuB900uuEYVJnhS5V0O1
	szLJR1At26hAlvjjHG0Hit/TFcfOnU3qrvirMdvbowUPX4iVahkw7SLilUyKw04=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Oj7llb
	o3uXqUZ7bcWXTm55NGtS/016GuYtdGulQC9VIqOD14Algoa2eQQopoafS8vfg1hc
	n8vt6uFIkbmMvOHDPyOALMFKGbaOdi6f1c3om4owPjsWlCQU1db0LLFXhAa62e8l
	dCt10zXxw0L9FSXy2xr1Q1NL5kvqRa2z08I9I=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3549B6C16;
	Wed, 12 Oct 2011 20:50:40 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AA6196C15; Wed, 12 Oct 2011
 20:50:39 -0400 (EDT)
In-Reply-To: <1318085683-29830-3-git-send-email-szeder@ira.uka.de> ("SZEDER
 =?utf-8?Q?G=C3=A1bor=22's?= message of "Sat, 8 Oct 2011 16:54:36 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5F01149C-F535-11E0-8D5E-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183432>

SZEDER G=C3=A1bor <szeder@ira.uka.de> writes:

> After a unique command or option is completed, in most cases it is a
> good thing to add a trailing a space, but sometimes it doesn't makes

s/makes/make/;

> __gitcomp() therefore iterates over all possible completion words it
> got as argument, and checks each word whether a trailing space is
> necessary or not.  This is ok for commands, options, etc., i.e. when
> the number of words is relatively small, but can be noticeably slow
> for large number of refs.  However, while options might or might not
> need that trailing space, refs are always handled uniformly and alway=
s
> get that trailing space (or a trailing '.' for 'git config
> branch.<head>.').
> ...
> So, add a specialized variant of __gitcomp() that only deals with
> possible completion words separated by a newline and uniformly append=
s
> the trailing space to all words using 'compgen -S' (or any other
> suffix, if specified), so no iteration over all words is done.

s/is done./is needed./;

I think I followed your logic (very well written ;-), but feel somewhat
dirty, as you are conflating the "These things are separated with newli=
nes"
with "These things do not need inspection --- they all need suffix", wh=
ich
has one obvious drawback --- you may find other class of words that alw=
ays
want a SP after each of them but the source that generates such a class=
 of
words may not separate the list elements with a newline.

Because a ref cannot have $IFS whitespace in its name anyway, I think y=
ou
can rename __gitcomp_nl to a name that conveys more clearly what it doe=
s
(i.e. "complete and always append suffix"), drop the IFS fiddling from =
the
function, and get the same optimization, no?
