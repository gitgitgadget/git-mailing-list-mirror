From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-status -- trying to understand all possible states
Date: Tue, 01 Apr 2014 14:37:52 -0700
Message-ID: <xmqq4n2czq6n.fsf@gitster.dls.corp.google.com>
References: <4AF06B83-E928-4FE2-8094-F23CE3BA1EBC@toyland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Toy <michael@toyland.org>
X-From: git-owner@vger.kernel.org Tue Apr 01 23:38:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WV6Nf-0000O3-Bv
	for gcvg-git-2@plane.gmane.org; Tue, 01 Apr 2014 23:38:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751790AbaDAVh6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Apr 2014 17:37:58 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43084 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751655AbaDAVh4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Apr 2014 17:37:56 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 336217792E;
	Tue,  1 Apr 2014 17:37:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vWOp7OljwusXjmVnwdIS3Mfdv04=; b=sEMRWg
	OCCcX2zdvk8wSazMuXZsyw5U8hL1656UqxcYecbhdkTo90PNl0NvriaJXidTYSRW
	nYFUO0NpqwakYcSdtRUj7x5pDb9LTU6ZVCHJvvJv9/pcFg33HbsS1dgX/TYhH2po
	0ABuP5Ll6TYh3naetjLoejEVxRJwgIOUpsSxM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Tkn3bL15ELX2OZ/hG8OsrD5LwUNLOFxG
	L76+gEx55xs5WsdB4IWwB08JZZTehfgTXdfnqd9MkzmhAGcSJDMNqLkc6x+gH3ur
	PFLJWUDo0f3fOCwwZ1A0Zs7pewRofhR78V48MLwfyN1fOouNHAIsCrAKPQedeVb6
	xX8eyA5LEgk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 124657792A;
	Tue,  1 Apr 2014 17:37:55 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3EF8B77925;
	Tue,  1 Apr 2014 17:37:54 -0400 (EDT)
In-Reply-To: <4AF06B83-E928-4FE2-8094-F23CE3BA1EBC@toyland.org> (Michael Toy's
	message of "Tue, 1 Apr 2014 13:07:33 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: E21142D6-B9E5-11E3-8E79-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245661>

Michael Toy <michael@toyland.org> writes:

> Of the 24 possibilities (not counting ignored) in git-status,
> there are 7 that I can't figure out how to generate.

As the post [*1*] that triggered e92e9cd3 (Documentation
improvements for the description of short format., 2010-04-23),
which is where the bulk of the format description comes from, says,
this is "Patches welcome" ;-) Some are just covering possible
permutations and it is not surprising if they would not appear in
practice.

> D           M    deleted from index

I doubt this is possible in practice; once you do not have the entry
in the index, we do not even look at the working tree file, so it
would be unusual to see M in the second column.

> D           D    unmerged, both deleted
> A           U    unmerged, added by us
> U           A    unmerged, added by them

    $ x="100644 $(git hash-object --stdin </dev/null)" &&
      printf "$x 2\tbar\n$x 1\tfoo\n$x 3\tbaz" |
      git update-index --index-info
    $ git status --short -suno
    AU bar
    UA baz
    DD foo
    $ git ls-files -u
    100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 2       bar
    100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 3       baz
    100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 1       foo

When you are using higher-level machinery to merge, "we added, they
left it missing" (i.e. bar that has only stage #2) is automatically
resolved to an addition by the trivial merge machinery.  The "they
added, we left it missing" (i.e. baz with only stage #3) case is
identical.  Also "both of us removed" (i.e. foo that has only stage
#1) is resolved to a deletion by the trivial merge machinery.  Hence
you would not see these three unless you are developing Git using a
low-level plumbing machinery.

[Reference]

*1* http://thread.gmane.org/gmane.comp.version-control.git/144455/focus=144468
