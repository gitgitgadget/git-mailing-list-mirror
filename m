From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 03/13] introduce credentials API
Date: Tue, 29 Nov 2011 09:34:54 -0800
Message-ID: <7vmxbeu91d.fsf@alter.siamese.dyndns.org>
References: <20111124105801.GA6168@sigill.intra.peff.net>
 <20111124110105.GA8417@sigill.intra.peff.net>
 <7v4nxnvs1w.fsf@alter.siamese.dyndns.org>
 <20111129050425.GA32022@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Nov 29 18:35:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RVRaC-0001DE-ML
	for gcvg-git-2@lo.gmane.org; Tue, 29 Nov 2011 18:35:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754943Ab1K2Re7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Nov 2011 12:34:59 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46932 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753479Ab1K2Re6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Nov 2011 12:34:58 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 38D07584C;
	Tue, 29 Nov 2011 12:34:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9YRhN6KSPUh7mOryj5JPnFAqoc0=; b=K1/aMS
	0T75RjdaFrAOL5zARtrSRmJgndmrsJNdwVtt1eXUqPu7jaR9HqPL2abnqdM0ga8S
	g6l1LGOUqJ0qDeMhr+I2wPBBv7SrG4ryKw+238eEp8oJOq7lmaEUa2WpRhzi7Whl
	HrLKk762xnYWnQ8LqzjRwrxn33Ay6BlzizLMg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jb3mU3Eg3r3888MjOEHd3VdCfWf9Vuan
	vi172ihYUm6XfHOIQC7WImdL0UWf9IVJY596paM7gGtlktj0yNt8lhVyD37QyWA8
	PvsvcIL68lpBw4DCdOA68XNiokwOluW/TXqNiSyftBq5qo4DhgJeuPa+kHNnAdF+
	Vvs148NauXI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 30767584A;
	Tue, 29 Nov 2011 12:34:57 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8D4D65841; Tue, 29 Nov 2011
 12:34:56 -0500 (EST)
In-Reply-To: <20111129050425.GA32022@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 29 Nov 2011 00:04:25 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 74517F9E-1AB0-11E1-B3CC-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186065>

Jeff King <peff@peff.net> writes:

> On Mon, Nov 28, 2011 at 01:46:35PM -0800, Junio C Hamano wrote:
>
>> > diff --git a/Documentation/technical/api-credentials.txt b/Documentation/technical/api-credentials.txt
>> > new file mode 100644
>> > index 0000000..3061077
>> > --- /dev/null
>> > +++ b/Documentation/technical/api-credentials.txt
>> > @@ -0,0 +1,148 @@
>> > + ...
>> > +`credential_fill`::
>> > +
>> > +	Attempt to fill the username and password fields of the passed
>> > +	credential struct, first consulting storage helpers, then asking
>> > +	the user. Guarantees that the username and password fields will
>> > +	be filled afterwards (or die() will be called).
>> > +
>> > +`credential_reject`::
>> > +
>> > +	Inform the credential subsystem that the provided credentials
>> > +	have been rejected. This will notify any storage helpers of the
>> > +	rejection (which allows them to, for example, purge the invalid
>> > +	credentials from storage), and then clear the username and
>> > +	password fields in `struct credential`. It can then be
>> > +	`credential_fill`-ed again.
>> > +
>> > +`credential_approve`::
>> > +
>> > +	Inform the credential subsystem that the provided credentials
>> > +	were successfully used for authentication. This will notify any
>> > +	storage helpers of the approval, so that they can store the
>> > +	result to be used again.
>> 
>> It's a bit hard to read and understand which part of the system calls
>> these and which other part of the system is responsible for implementing
>> them, and how "helper" fits into the picture (perhaps calling some of
>> these interfaces will result in "helper" getting called?).
>
> How about following it with a rough example of how they would be used,
> like:
>
>   /*
>    * Create a credential with some context; we don't yet know the
>    * username or password.
>    */
>   struct credential c = CREDENTIAL_INIT;
>   c.protocol = xstrdup("https");
>   c.host = xstrdup("example.com");
>   c.path = xstrdup("foo.git");
>
>   /*
>    * Fill in the username and password fields by contacting helpers
>    * and/or asking the user. The function will die if it fails.
>    */
>   credential_fill(&c);
>
>   /*
>    * And then finally make our request, reporting back to the credential
>    * system on whether it succeeded or failed.
>    */
>   if (make_http_request(c.host, c.path, c.username, c.password) < 0)
>           credential_reject(&c);
>   else
>           credential_accept(&c);
>
> Does that make it more clear?

Immensely, at least to me. From the perspective of a user of the API, a
call to credential_fill() is to "fill in the credential" in the sense that
"call the function to fill in the credential" but I find it easier to
understand if it were explained to me as "ask the API to fill in the
credential, which may involve helpers to interact with the user--the point
of the API is that the caller does not care how it is done".  Same for the
reject/accept calls---the example makes it clear that they are to tell the
decision to reject/accept made by the application to the credential API,
and it is up to the API layer what it does using that decision (like
removing the cached and now stale password).

The above example is a bit too simplistic and misleading, though. You
would call reject only on authentication failure (do not trash stored and
good password upon network being unreachable temporarily or the server
being overloaded).

> So one possible rule would be:
>
>   1. If it starts with "!", clip off the "!" and hand it to the shell.
>
>   2. Otherwise, if is_absolute_path(), hand it to the shell directly.
>
>   3. Otherwise, prepend "git credential-" and hand it to the shell.
>
> I think that is slightly less confusing than the "first word is alnum"
> thing.

Simpler and easier to explain. Good ;-)

> How do you feel about the "values cannot contain a newline" requirement?

In the context of asking username, password, or passphrase, I think "LF is
the end of the line and you cannot have that byte in your response" is
perfectly reasonable. I've yet to find a way to use LF in a passphrase to
unlock my Gnome keychain ;-).

>> > +int credential_read(struct credential *c, FILE *fp)
>> > +{
>> > ...
>> > +			c->host = xstrdup(value);
>> > +		}
>> > +		else if (!strcmp(key, "path")) {
>> > ...
>> > +		/* ignore other lines; we don't know what they mean, but
>> > +		 * this future-proofs us when later versions of git do
>> > +		 * learn new lines, and the helpers are updated to match */
>> 
>> Two style nits.
>
> I'm supposed to guess? ;P

Sorry, but you guessed right.
