From: Will Palmer <wmpalmer@gmail.com>
Subject: [RFD] Expanded Pretty Format Placeholders Proposal
Date: Fri, 11 Mar 2011 00:47:21 +0000
Message-ID: <1299804441.6220.1.camel@walleee>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 11 01:47:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PxqVz-0008Q7-M6
	for gcvg-git-2@lo.gmane.org; Fri, 11 Mar 2011 01:47:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754740Ab1CKAr3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Mar 2011 19:47:29 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:33277 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754669Ab1CKAr2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Mar 2011 19:47:28 -0500
Received: by wwa36 with SMTP id 36so2626505wwa.1
        for <git@vger.kernel.org>; Thu, 10 Mar 2011 16:47:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:subject:from:to:content-type:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=Cm0xrfCKYwUEaG6E7mB13j3fXbFM69Xw+k0kEz0LPvA=;
        b=EiMjTGZ67Xn/NSSYuYqZF9vS3K0fo0EyWGNOQ1f4yWtwZlL1o8l/X8+lnp9tjZ6oek
         sDAxlA48bERZ5a+OVwIWErHZIBlQMJ1Uxc3RWRaPn/u7BfsJCVWjp93WOi2N+S2OvX8/
         iEcsFDgWCVq9Zz/2LfW5iemWwBp66qHzhorIY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:content-type:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=IdzgVvLoefinl2LBbxABqH9KsAPbnQRv5qTDHRqxZF3h3SDmbyY5Zar+x8QBdzcvYF
         diu2vZCdCtTwU2taigO1yiK0NWC7OfYDtIPRu3ezvOc/Ck6qp/neVfpetNzVz6DTvEG7
         OKQkV8ccB+Uy38UekcJqXryJMG1XcKMORScag=
Received: by 10.227.110.147 with SMTP id n19mr2704268wbp.51.1299804446880;
        Thu, 10 Mar 2011 16:47:26 -0800 (PST)
Received: from [192.168.0.2] (5acc3aad.bb.sky.com [90.204.58.173])
        by mx.google.com with ESMTPS id y29sm2911627wbd.4.2011.03.10.16.47.23
        (version=SSLv3 cipher=OTHER);
        Thu, 10 Mar 2011 16:47:24 -0800 (PST)
X-Mailer: Evolution 2.28.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168874>

I have been working off and on (mostly off) for a while now on an
expanded "pretty" format which would allow for, among other things,
conditional formats and "long" placeholders.

Recent threads on the mailing list seem to be leaning towards "long"
placeholders happening sooner, rather than later, so I think it might be
a good time to discuss how they might work, if only so that I can make
sure that what might be desired of an expanded format doesn't conflict
with my goals regarding conditional formats / etc.

The justifications for allowing "long" placeholders are simple:
	1) We have a lot of "short" placeholders already, and the
	   mnemonics are going to keep getting more awkward the more
	   of them we have
	2) Long-forms leave room for options and other fun
	3) Terse is fun to write, verbose is fun to read.

To start with, the basic idea for expanded placeholders is to allow, in
addition to the current short-forms, such as %h, %ad, etc, "git log" and
friends would also support "long forms", such as %(hash), %(authordate),
etc. Ideally, the "long" forms would be compatible with / perhaps even
(eventually) share code with, the placeholders used by for-each-ref.

There are several requirements which I know of:
	- Long placeholders cannot invalidate any existing placeholders 
	- Long placeholders must have a method for accepting "parameters"
	- Nothing should ever be "illegal". ie: any placeholder which does
	  not make sense to us should be interpreted literally, rather
	  than causing a fatal error.

And, for my own part, there are several requirements which my itch has:
	- Long placeholders must be able to accept multiple parameters
	- Long placeholders must be able to accept a variable number of
	  parameters
	- It must be possible to include an entire "sub-format" as a
	  parameter of a long placeholder

Our current placeholder rules are very simple. If I recall correctly,
for example, the only escape character is "%". It would be good to keep
this simplicity. The parser internals, however, are most likely due for
a change, to allow for a "parse once, process many" approach to make up
for the long-formats being somewhat slower to parse by nature. Hopefully
this would give us a slight speed boost in the trivial cases as well,
though this is not actually a goal of any work I am doing.

Discussion so far, and the way for-each-ref does things, suggests the
following specification for long formats:
	%(placeholdername:optional-parameter)

Meanwhile, the existing %w(  ) format gives us a precedent for multiple
parameters: separate them with commas:
	%(placeholdername:optional-parameter,optional-parameter)

Currently, for-each-ref is strict about whitespace. For example:
	%(objectname:short) is valid
	%(objectname: short) is not

While log's %w(  ) is less-strict:
	%w(0,4,4) is valid
	%w(0, 4, 4 ) is too
	%w(0,
		4, 4) is too

I prefer support for whitespace: there's not really a good reason not to
allow it, as far as I know, and it gives people more freedom to make
things readable how they see fit.

As for the names of long placeholders, for-each-ref seems to have the
opinion of:
	- only alphabetic characters (ie: no dashes, etc, between words)
	- only lowercase characters (eg: no camelCase)
	- strict about both (ie: must be typed exactly, no caSeMixing)

all of these restrictions sound sane, but may be limiting if declared a
convention to follow. I assume a sane extension would be:
	- alphanumeric characters and dashes allowed

For my own purposes (conditional formats), I'd like to see the ability
to embed an entire sub-format within a placeholder. Clearly this would
complicate the parser quite a bit (we wouldn't be able to just look for
a closing ")", for example), but I think the flexibility makes it work
it. To achieve this in terms of a specification to shoot for, we can
simply say that any embedded "%(" must be terminated by its own ")" to
be valid. eg:
	%(foo-condition: %(format: %H, aka %h), %H )

This does conflict with the idea of whitespace being non-important,
and unfortunately I don't have a good idea for that one yet. There are
four options, as I see it:
	A) make whitespace always-important. I don't like this at all
	B) Add quotation marks and backslashes as additional escape
	   characters, allowing for " Sally said \"foo\" ". This seems
	   like a nasty thing to do to an otherwise simple format
	C) add %(preserve-whitespace: whitespace is important here )
	   This may add weirdness to the parse that makes it hard to
	   follow, and we'd need to come up with rules about
	   "inheritance" of whitespace preservation.
	D) Require people to type %20 if they want a space at the
	   beginning/end of a parameter. This idea feels ugly too, but
	   maybe not as ugly as the alternatives.

For what it's worth, the current WIP code I've got uses option B.

As a final note: "Conditional formats" feel a lot like ternary operators
in C. Because of that, I feel like saying that conditional formats like:
	%(opt-color: %Cred%h%Creset, %h)
Look better to me as:
	%(opt-color ? %Cred%h%Creset : %h)

But thinking in terms of consistency / simplicity of "what escapes now?"
I think the more-uniform %(placeholdername:parameter,parameter) is
probably the one to go for.

Those are my thoughts on the matter, or at least those I have at the
moment. I'll leave this to the list to discuss for now, and hope that it
doesn't get bikeshedded to death.

-- Will
