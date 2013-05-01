From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/5] git-svn: fix bottleneck in stash_placeholder_list()
Date: Wed, 01 May 2013 14:53:54 -0700
Message-ID: <7v1u9q5pu5.fsf@alter.siamese.dyndns.org>
References: <1438528085.20130501090926@gmail.com>
	<1409591910.20130501123153@gmail.com>
	<7vhaim8w48.fsf@alter.siamese.dyndns.org>
	<455264907.20130501235104@gmail.com>
	<20130501213031.GA13056@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ilya Basin <basinilya@gmail.com>,
	Git mailing list <git@vger.kernel.org>,
	Ray Chen <rchen@cs.umd.edu>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Wed May 01 23:54:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXeyS-00036x-Ax
	for gcvg-git-2@plane.gmane.org; Wed, 01 May 2013 23:54:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757881Ab3EAVyA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 May 2013 17:54:00 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36100 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757782Ab3EAVx6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 May 2013 17:53:58 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A32BB1BDE0;
	Wed,  1 May 2013 21:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5kGstMCj4LoSNd+z6sNrI3V3WjE=; b=s7yDJL
	do8hJbbLbWFV39Ee6ZVrJY/Et1t2nvvmac9Np9hvdRIfJmsJBFGsZJJ1yNWmZTEs
	MA7rzMsTjMruiBGJZwf7/deV8bY5IOquG2squRyhoOpASiY1LkVh52o3n+O60QgH
	Ek/lu7zY3LA8B/SOXJ4w49gA1ha+Yn8CFvaNA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ky0Htmtlcxhd4LRAmc2pbOnSHDU7yODM
	H/8DU7xAFPFdBq1z/aGU2d6WXaJdw8fdDYutV7HbSE5AsYySeOI32PHMkRodoF3M
	Ew1+u7GbiE43ZQVwH3jj75hSBcLpVNflUtJP9h6u8QlyoxLzTGnOXNfnKhTUX04p
	zfUrMD8CJiI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9A0241BDDF;
	Wed,  1 May 2013 21:53:57 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BB42E1BDDC;
	Wed,  1 May 2013 21:53:55 +0000 (UTC)
In-Reply-To: <20130501213031.GA13056@dcvr.yhbt.net> (Eric Wong's message of
	"Wed, 1 May 2013 21:30:31 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9EC95034-B2A9-11E2-A1D9-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223149>

Eric Wong <normalperson@yhbt.net> writes:

> Ilya Basin <basinilya@gmail.com> wrote:
>> JCH> comment line "# added by git-svn only to keep the directory" and
>> JCH> consider a directory that has nothing but .gitignore that consists
>> JCH> of only that exact comment line an "added placeholder" directory to
>> JCH> work it around.
>> Sounds good, but it's not I who decided to use the config file.
>
> Ugh, I didn't review Ray's original commit closely enough to notice
> this :x
>
> Perhaps we should migrate users to use YAML storage for this, instead
> (we already use YAML for Git::SVN::Memoize::YAML).

But does it solve the impedance mismatch between "per tree"
information and "per project" information?  Unless you key the
information not just with path but also with revision or tree object
name, use of YAML vs config would not make a difference in the
semantics, I am afraid.

I am reading the placeholder-added flag as: "This .gitignore file
does not exist in the Subversion original; it is there only so that
we can keep the otherwise empty diretory in the checkout, and it
should not be pushed back to the Subversion side".  Am I mistaken?

That however is not a property of the directory containing it (or
the path to that .gitignore file) that is valid throughout the
history of the project.  It is a property of a specific tree object
(or you could say it is a property of the revision).  When at some
point in the history the upstream project adds .gitignore there
because many people use git-svn to contribute to their project, it
stops to be "should not be pushed back".

So it seems to me that the information this "placeholder added"
thing wants to express belongs to the tree object (and .gitignore
file itself is a natural place to have that information).

> Fwiw, I've never been a fan of placeholders only accepted it since it's
> off-by-default but it worked well enough for Ray.
>
> My personal philosophy has always been: git svn users should leave
> no trace or indication they're using a non-standard SVN client.
