From: Michael G Schwern <schwern@pobox.com>
Subject: Re: git-svn SVN 1.7 fix, take 2
Date: Tue, 24 Jul 2012 22:36:55 -0700
Message-ID: <500F85F7.8050304@pobox.com>
References: <500F17A3.60307@pobox.com> <20120724220207.GA15969@burratino>
 <500F26BF.7090501@pobox.com> <20120724233128.GD16333@burratino>
 <7va9yoenb2.fsf@alter.siamese.dyndns.org> <500F4530.7030207@pobox.com>
 <20120725045327.GD3055@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	"Robin H. Johnson" <robbat2@gentoo.org>,
	Eric Wong <normalperson@yhbt.net>,
	Ben Walton <bwalton@artsci.utoronto.ca>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 25 07:37:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StuIE-000221-6Y
	for gcvg-git-2@plane.gmane.org; Wed, 25 Jul 2012 07:37:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751371Ab2GYFg7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jul 2012 01:36:59 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54409 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751133Ab2GYFg6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jul 2012 01:36:58 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C365C4A49;
	Wed, 25 Jul 2012 01:36:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=message-id
	:date:from:mime-version:to:cc:subject:references:in-reply-to
	:content-type:content-transfer-encoding; s=sasl; bh=8QIl1Xihxqib
	Ir6S80mRxSUr2a0=; b=O1cIzH1zZwcoPVGVpq8RVuA0Id4KN4Pk9MnrsOAyjlb+
	mETItBPSqeAZD+ncL9xwHV6HV1CQXe0NNDQmzvfA39uP2ZMTuDGMGXEsn+2Nlaji
	KGkFjBR2ibt216Xyw7LbJcPUXC1CghSJ0Wyyb/qduPaQqC58F58X673hxtDUzvg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=message-id:date
	:from:mime-version:to:cc:subject:references:in-reply-to
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Of5Pnw
	GeTXyPqvootuUxP5AdrXD4MFGQE4ovk/hJSAKpSXJSjL4hQyDjtc/uXn3N8F5JQY
	8hjpBRLtT2S/E7PwcUE3jx36s99SE861PE3NyEdocx3tSMB6DWOr9RxMRNq2IAMb
	EKgzm9yD6noCKrJSZwN6WXqKvdgW39RXZrsP0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AF2BC4A47;
	Wed, 25 Jul 2012 01:36:57 -0400 (EDT)
Received: from windhund.local (unknown [71.236.173.173]) (using TLSv1 with
 cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested)
 by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C61F14A3F; Wed, 25 Jul
 2012 01:36:56 -0400 (EDT)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:14.0)
 Gecko/20120713 Thunderbird/14.0
In-Reply-To: <20120725045327.GD3055@burratino>
X-Enigmail-Version: 1.4.3
X-Pobox-Relay-ID: BFD2515C-D61A-11E1-ACB1-01B42E706CDE-02258300!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202121>

On 2012.7.24 9:53 PM, Jonathan Nieder wrote:
> Michael G Schwern wrote:
> 
>> No, now it's just canonicalizing as early as possible.  Preferably within the
>> object accessor rather than at the point of use.  So in the code below,
>> $full_url is already escaped/canonicalized.
> 
> Let's start with this.
> 
> Is svn_path_canonicalize() idempotent?  What does it do when it
> encounters a percent-sign?

Nothing, because paths are not URI escaped. :)

You probably meant svn_uri_canonicalize().  And no, it does not double escape,
so its safe to escape as early as possible.

   use SVN::Core;

   my $uri = "http://www.example.com/ foo";

    print SVN::_Core::svn_uri_canonicalize(
        SVN::_Core::svn_uri_canonicalize($uri)
    );

That produces "http://www.example.com/%20foo".

The API docs don't say it specifically, but if it were otherwise it would be
impossible to use.  You'd have to check first if anything were escaped before
canonicalizing.  And a user couldn't pass in an escaped URL without risking it
being double escaped.

http://subversion.apache.org/docs/api/latest/svn__dirent__uri_8h.html#a8bae33a2fbf86857869f7b0e39a553e7


-- 
'All anyone gets in a mirror is themselves,' she said. 'But what you
gets in a good gumbo is everything.'
    -- "Witches Abroad" by Terry Prachett
