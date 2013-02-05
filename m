From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v3 0/8] Hiding refs
Date: Tue, 5 Feb 2013 00:33:27 -0800
Message-ID: <20130205083327.GA4931@elie.Belkin>
References: <1359571542-19852-1-git-send-email-gitster@pobox.com>
 <5110BD18.3080608@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>, Shawn Pearce <spearce@spearce.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Feb 05 09:34:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2dyZ-0004pU-Jv
	for gcvg-git-2@plane.gmane.org; Tue, 05 Feb 2013 09:33:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754318Ab3BEIdh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2013 03:33:37 -0500
Received: from mail-da0-f52.google.com ([209.85.210.52]:58499 "EHLO
	mail-da0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753969Ab3BEIdg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2013 03:33:36 -0500
Received: by mail-da0-f52.google.com with SMTP id f10so3003194dak.25
        for <git@vger.kernel.org>; Tue, 05 Feb 2013 00:33:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=XSP6akHG0Pn/CkgmJz1HhDISEOPIDYko4LWTGKc6XdI=;
        b=pM2zvG0jpZt9Qal/aFG6Ca+V50n+evFDk3wEYOxXCm9drnHYCt3s5mjM3iftjnXyD0
         rDsfzdFvAMH8zd0V9YDkzoTn9WG7J9wRpfmAzqq8pYADVmiDBBGsNDJDRZp28BT5xiFI
         Rn1S71tAo+PqOR7NvUa6A8iGNirHWzsgQhPPMIJIj3LjFuGxOnSoR1QoUnJvqJDtT/mj
         c9BqkxJR6Rc5kSl6Av+RR6snxAiFa7x6wi+5/B+3xD3F5ySaxwFqgjm1HB+swPwBcGul
         HcVWQD+2+IDNd/1Zts3TDpxe0yrMxxd3XIgJ99udJbTPbVxdO5Biel10NjO4aYg0VfRv
         aaoQ==
X-Received: by 10.66.84.232 with SMTP id c8mr62262380paz.8.1360053215855;
        Tue, 05 Feb 2013 00:33:35 -0800 (PST)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id m3sm27623617pav.4.2013.02.05.00.33.33
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 05 Feb 2013 00:33:34 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <5110BD18.3080608@alum.mit.edu>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215466>

Hi Michael,

Michael Haggerty wrote:

> I would again like to express my discomfort about this feature, which is
> already listed as "will merge to next".  Frankly, I have the feeling
> that this feature is being steamrolled in before a community consensus
> has been reached and indeed before many valid points raised by other
> members of the community have even been addressed.  For example:

In $dayjob I work with Gerrit, so I think I can start to answer some
of these questions.

> * I didn't see a response to Peff's convincing arguments that this
> should be a client-side feature rather than a server-side feature [1].

The client can't control the size of the ref advertisement.  That is
the main motivation if I understood correctly.

> * I didn't see an answer to Duy's question [2] about what is different
> between the proposed feature and gitnamespaces.

Namespaces are more complicated and don't sit well in existing setups
involving git repositories whose refs are not namespaced.

> * I didn't see a response to my worries that this feature could be
> abused [3].

Can you elaborate?  Do you mean that through social engineering an
attacker would convince the server admin to store secrets using a
hidden ref and enable the upload-archive service?

That does sound like a reasonable concern.  Perhaps the documentation
should be updated along these lines

	transfer.hiderefs::
		String(s) `upload-pack` and `receive-pack` use to decide
		which refs to omit from their initial advertisement.  Use
		more than one transfer.hiderefs configuration variables to
		specify multiple prefix strings. A ref that are under the
		hierarchies listed on the value of this variable is excluded,
		and is hidden from `git ls-remote`, `git fetch`, `git push :`,
		etc.  An attempt to update or delete a hidden ref by `git push`
		is rejected, and an attempt to fetch a hidden ref by `git fetch`
		will fail.
	+
	This setting does not currently affect the `upload-archive` service.

until someone interested implements the same for upload-archive.

> I also think that the feature is poorly designed.  For example:

That's another reasonable concern.  It's very hard to get a design
correct right away, which is presumably part of the motivation of
getting this into the hands of interested users who can give feedback
on it.  What would potentially be worth blocking even that is concerns
about the wire protocol, since it is hard to take back mistakes there.

> * Why should a repository have exactly one setting for what refs should
> be hidden?  Wouldn't it make more sense to allow multiple "views" to be
> defined?:

How do I request a different view of the repository at
/path/to/repo.git over the network?  How can we make the common case
of only one view easy to achieve?  Isn't the multiple-views case
exactly what gitnamespaces is for?

[...]
> * Is it enough to support only reference exclusion (as opposed to
> exclusion and inclusion rules)?

The motivating example is turning off advertisement of the
refs/changes hierarchy.  If and when more complicated cases come up,
that would presumably be the time to support more complicated
configuration.

[...]
> * Why should this feature only be available remotely?

It is about transport.  Ref namespaces have their own set of use cases
and are a distinct feature.

Hoping that clarifies,
Jonathan
