From: Michael G Schwern <schwern@pobox.com>
Subject: Re: git-svn SVN 1.7 fix, take 2
Date: Wed, 25 Jul 2012 02:53:55 -0700
Message-ID: <500FC233.8090709@pobox.com>
References: <500F17A3.60307@pobox.com> <20120724220207.GA15969@burratino>
 <500F26BF.7090501@pobox.com> <20120724233128.GD16333@burratino>
 <7va9yoenb2.fsf@alter.siamese.dyndns.org> <500F4530.7030207@pobox.com>
 <20120725045327.GD3055@burratino> <500F85F7.8050304@pobox.com>
 <7v1uk0e2hy.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	"Robin H. Johnson" <robbat2@gentoo.org>,
	Eric Wong <normalperson@yhbt.net>,
	Ben Walton <bwalton@artsci.utoronto.ca>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 25 11:58:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StyMA-0002e9-Ba
	for gcvg-git-2@plane.gmane.org; Wed, 25 Jul 2012 11:58:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754284Ab2GYJ6I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jul 2012 05:58:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50663 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754145Ab2GYJ6G (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jul 2012 05:58:06 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C6D7A7222;
	Wed, 25 Jul 2012 05:58:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=message-id
	:date:from:mime-version:to:cc:subject:references:in-reply-to
	:content-type:content-transfer-encoding; s=sasl; bh=95kjymgtDX1s
	DRZ58aB8Mp75syM=; b=bYgq4CMimJ04jCtS5h1cHUhSU2CnOtg6qL2xWJo4gkx0
	khuxGvM3qVk35sfeOOZDn6zkpVbPoyP2AUacnDfTti55sG4ij7yMrF4CNq/fFxWZ
	1JPffIjA9O2uQePRFRRg+lLvtckGX74j1ExrWPTwVuJbb1Wy6EGNz1ocSVYnt0o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=message-id:date
	:from:mime-version:to:cc:subject:references:in-reply-to
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=oO65zg
	lJdhyLURYnnLe8rBehy7La8dq0SNTnqX0apbJRihIlDw5G2/cQCkNtYxfBo7bNNX
	o9wq6QhFluNkww7LtTvgIUAQIUDxP9q9zhqothMFJo1PXRhITR4IB/2IkbXQxzzl
	YrliGm4gClal+ykjVQA3urLibWFPgeuNzfqh0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AFDD37221;
	Wed, 25 Jul 2012 05:58:03 -0400 (EDT)
Received: from windhund.local (unknown [71.236.173.173]) (using TLSv1 with
 cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested)
 by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7E6F87215; Wed, 25 Jul
 2012 05:58:02 -0400 (EDT)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:14.0)
 Gecko/20120713 Thunderbird/14.0
In-Reply-To: <7v1uk0e2hy.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.4.3
X-Pobox-Relay-ID: 3950A244-D63F-11E1-B93B-01B42E706CDE-02258300!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202144>

On 2012.7.25 12:14 AM, Junio C Hamano wrote:
>> Nothing, because paths are not URI escaped. :)
>>
>> You probably meant svn_uri_canonicalize().  And no, it does not double escape,
>> so its safe to escape as early as possible.
> 
> Are you saying that the function assumes that a local pathname would
                                                        ^^^^^^^^

URI and path canonicalization are done differently and by different functions.
 svn_uri_canonicalize() vs svn_dirent_canonicalize().  Or maybe you're
referring to the path portion of the URL?  I don't think that makes a
difference for what you're asking, but its important to keep in mind.


> not have '%' in it, returns its input as-is when it sees one, and if
> the caller really needs to express a path with '%' in it, it is the
> responsibility of the caller to escape it?

It appears that if the % is followed by hex it assumes its an escape.
Otherwise it escapes it.  Thus...

   http://www.google.com/per%%nt -> http://www.google.com/per%25%25nt
   http://www.google.com/per%ant -> http://www.google.com/per%25ant
   http://www.google.com/per%cent -> http://www.google.com/per%CEnt

Which makes sense if the idea is to not double escape.


> That makes it even more confusing....

Straight out of the RFC.
http://pretty-rfc.herokuapp.com/RFC3986#when-to-percent-encode

    Implementations must not percent-encode or decode the same string more
    than once, as decoding an already decoded string might lead to
    misinterpreting a percent data octet as the beginning of a percent-
    encoding, or vice versa in the case of percent-encoding an already
    percent-encoded string.

It makes it far simpler to use.  You can't read the mind of the user, but its
a fair guess that they're not really thinking too deeply about how escaping
works.  It makes URI and path canonicalization safer and simpler.  Otherwise
you'd need to keep track of whether a thing was already escaped or not!  Just
begging for loads of bugs.  (If SVN were using URI and path objects they'd
just take care of it and none of this would be a problem in the first place).

This way you have no double escaping concerns.  No need to track if a thing is
already canonicalized.  Do it as often and as early as you like.  Making a
corner case a little harder is a small price to pay for making the common case
much, much easier.

This also appears to be what Firefox does.


>>    my $uri = "http://www.example.com/ foo";
>>
>>     print SVN::_Core::svn_uri_canonicalize(
>>         SVN::_Core::svn_uri_canonicalize($uri)
>>     );
>>
>> That produces "http://www.example.com/%20foo".
> 
> In other words, if your DocumentRoot was /var/www and you have a
> directory /var/www/per%cent you want to expose to the outside world,
> you have to say "http://www.example.com/per%25cent" yourself and the
> "canonicalize" function will be an identity function?

Yes.  It can be made to work better.

There's a number of places in the code which effectively do this:

    my $full_url = $url . '/' . $path;

And I was canonicalizing them like this:

    my $full_url = canonicalize_url($url . '/' . $path);

I'd been pondering whether it would be worthwhile to have a function which
added a path to a base URL and canonicalized.  Now I see that yes, it would be
to deal with this corner case.

    my $full_url = append_path_to_url($url, $path);

That would properly URI encode any % in $path before appending and then
canonicalizing the whole thing as a URI.

I'm pretty sure the code in master doesn't handle this at all.


> I have this vague suspicion that Jonathan was asking about what your
> Git::SVN::Utils::canonicalize_path() sub does, so all of the above
> might be moot, though...

Its just a pass through to the SVN API.


-- 
44. I am not the atheist chaplain.
    -- The 213 Things Skippy Is No Longer Allowed To Do In The U.S. Army
           http://skippyslist.com/list/
