From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 6/8] git-remote-testpy: hash bytes explicitly
Date: Thu, 17 Jan 2013 12:36:33 -0800
Message-ID: <7vtxqftulq.fsf@alter.siamese.dyndns.org>
References: <cover.1358448207.git.john@keeping.me.uk>
 <66c42ff65eddde494f40d0a582e89a081b4ab8e8.1358448207.git.john@keeping.me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	Pete Wyckoff <pw@padd.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Thu Jan 17 21:36:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvwCn-00016a-FJ
	for gcvg-git-2@plane.gmane.org; Thu, 17 Jan 2013 21:36:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756678Ab3AQUgh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jan 2013 15:36:37 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47054 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756546Ab3AQUgg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jan 2013 15:36:36 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BDE6AC389;
	Thu, 17 Jan 2013 15:36:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cwcbOPtBeoqyoj/qNo/YZyncP0w=; b=n8MsKY
	/q5CNGCbwjxPNvWezHIGQndMq5vFv9n9s/OWfqFnEerLpjs3oT3Bj/tMXHcuta3Z
	FqZxEkVPaL/qNQuGALxLNHx0LdvSS7wXoF0Dl5AbF9/2zZh3Grt6j9mPp1FJk8Ep
	1uEjIDsgseHTeCYTQ4fqQxwM9dW4IKPFpxRDw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=V2M+uNgxroP5McnPuiOE3OEOkmJIaVNA
	uwYTKAO2QjMWw840+6C/OduvrUldg8bXwxhQiiD6SMKpY6pLkwS970Rg1PvpJ7OR
	4YHRvDaO/D5eNKUzMVQA5T9OSZfppRfHCw2bQeVvRyEhmI2fNHMqJR9WnhYveeV2
	O1R1YC1BtwQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AF4E1C388;
	Thu, 17 Jan 2013 15:36:35 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 10C7CC385; Thu, 17 Jan 2013
 15:36:34 -0500 (EST)
In-Reply-To: <66c42ff65eddde494f40d0a582e89a081b4ab8e8.1358448207.git.john@keeping.me.uk>
 (John Keeping's message of "Thu, 17 Jan 2013 18:53:59 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 95C0F804-60E5-11E2-8F0B-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213875>

John Keeping <john@keeping.me.uk> writes:

> Under Python 3 'hasher.update(...)' must take a byte string and not a
> unicode string.  Explicitly encode the argument to this method as UTF-8
> so that this code works under Python 3.
>
> This moves the required Python version forward to 2.0.
>
> Signed-off-by: John Keeping <john@keeping.me.uk>
> ---

Hmph.  So what happens when the path is _not_ encoded in UTF-8?

Is the repo.hash (and local.hash that gets a copy of it) something
that needs to stay the same across multiple invocations of this
remote helper, and between the currently shipped Git and the version
of Git after applying this patch?  If that is not the case, and if
this is used only to get a randomly-looking 40-byte hexadecimal
string, then a lossy attempt to .encode('utf-8') and falling back to
replace or ignore bytes in the original that couldn't be interpreted
as part of a UTF-8 string would be OK, but doesn't .encode('utf-8')
throw an exception if not told to 'ignore' or something?

>  git-remote-testpy.py | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/git-remote-testpy.py b/git-remote-testpy.py
> index d94a66a..f8dc196 100644
> --- a/git-remote-testpy.py
> +++ b/git-remote-testpy.py
> @@ -31,9 +31,9 @@ from git_remote_helpers.git.exporter import GitExporter
>  from git_remote_helpers.git.importer import GitImporter
>  from git_remote_helpers.git.non_local import NonLocalGit
>  
> -if sys.hexversion < 0x01050200:
> -    # os.makedirs() is the limiter
> -    sys.stderr.write("git-remote-testgit: requires Python 1.5.2 or later.\n")
> +if sys.hexversion < 0x02000000:
> +    # string.encode() is the limiter
> +    sys.stderr.write("git-remote-testgit: requires Python 2.0 or later.\n")
>      sys.exit(1)
>  
>  def get_repo(alias, url):
> @@ -45,7 +45,7 @@ def get_repo(alias, url):
>      repo.get_head()
>  
>      hasher = _digest()
> -    hasher.update(repo.path)
> +    hasher.update(repo.path.encode('utf-8'))
>      repo.hash = hasher.hexdigest()
>  
>      repo.get_base_path = lambda base: os.path.join(
