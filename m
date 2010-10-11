From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] fast-import: Allow filemodify to set the root
Date: Mon, 11 Oct 2010 01:34:29 -0500
Message-ID: <20101011063429.GA32034@burratino>
References: <AANLkTinsnMRyoeGzCn1Rkk7tc+zwVa5j3AGqVZCdDGDv@mail.gmail.com>
 <1286681415-1831-1-git-send-email-david.barr@cordelta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Gabriel Filion <lelutin@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>
To: David Barr <david.barr@cordelta.com>
X-From: git-owner@vger.kernel.org Mon Oct 11 08:37:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P5C1C-0002xw-OB
	for gcvg-git-2@lo.gmane.org; Mon, 11 Oct 2010 08:37:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752522Ab0JKGht (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Oct 2010 02:37:49 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:62405 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752409Ab0JKGhs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Oct 2010 02:37:48 -0400
Received: by gxk9 with SMTP id 9so874884gxk.19
        for <git@vger.kernel.org>; Sun, 10 Oct 2010 23:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=T1/3cFA6jwqWc7YMoAHfZkPhKbNUTvhsceXoTO2b09k=;
        b=gYxXAQUMmebEOyAblRK6dciOC5CbPcv3/EWd65EBqQe+EFBB5a3vHXKwEANJ3ytkL6
         r+bpAMfqiHuPGKrMoCg9XfuHo1L4tuI7CS59Mw7AhpOF1OIOJMUPKYqG9GZoG/4PuZ/5
         4Du+BE8q276pXb3aeIXFGh1ABWQvHPy1I+0x8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=qYDomig0/WYAGk0DTUq/kNCVYm9572prz7UKQavbZoUS95ljS2nCj3ifQC45mWCfxE
         K3kenwNnSZOk3LgA0tWNmp8/WO+Y7HmOxtoJDAfj+RKhej/FsZUsZ7xO5wyFZyAso9rv
         J8yre+GJpNmJza9EWJMrGd0O7Wghi9s56+XcM=
Received: by 10.101.176.2 with SMTP id d2mr2464170anp.109.1286779067394;
        Sun, 10 Oct 2010 23:37:47 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id u3sm8207342ani.39.2010.10.10.23.37.44
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 10 Oct 2010 23:37:45 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1286681415-1831-1-git-send-email-david.barr@cordelta.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158749>

David Barr wrote:

> --- a/Documentation/git-fast-import.txt
> +++ b/Documentation/git-fast-import.txt
> @@ -524,6 +524,9 @@ start with double quote (`"`).
>  If an `LF` or double quote must be encoded into `<path>` shell-style
>  quoting should be used, e.g. `"path/with\n and \" in it"`.
>  
> +Additionally, in `040000` mode, `<path>` may also be an empty string
> +(`""`) to specify the root of the tree.
> +

Ideally this would be not so much "Additionally" as "For example".
Maybe just:

	An empty path ("") refers to the toplevel directory of
	the tracked tree.

> --- a/fast-import.c
> +++ b/fast-import.c
> @@ -1454,6 +1454,15 @@ static int tree_content_set(
>  		n = slash1 - p;
>  	else
>  		n = strlen(p);
> +	if (!slash1 && !n) {
> +		if (!S_ISDIR(mode))
> +			die("Root cannot be a non-directory");
> +		hashcpy(root->versions[1].sha1, sha1);
> +		if (root->tree)
> +			release_tree_content_recursive(root->tree);
> +		root->tree = subtree;
> +		return 1;
> +	}
>  	if (!n)
>  		die("Empty path component found in input");

Background for the curious: tree_content_set() is a recursive function
to modify a tree-in-the-making by changing the entry at path p to
refer to some specified content with a given mode.  The recursion
works as one might expect:

	tree_content_set(root, "foo/bar/baz", ...) ->
	 tree_content_set(root:foo, "bar/baz", ...) ->
	  et c

The "if (!n)" check introduced in v1.5.1.3~11^2~1 (Don't allow empty
pathnames in fast-import, 2007-04-28) ensures fast-import doesn't
end up creating a subdirectory corresponding to an empty path
component in a pathname like "foo//bar/baz".

With this patch, an empty path component is allowed again, but only
as the last path component.  It is used to modify directories.  So,
for example,

	tree_content_set(root, "foo/bar/", sha1, S_IFDIR)

becomes an almost-synonym for

	tree_content_set(root, "foo/bar", sha1, S_IFDIR)

and

	tree_content_set(root, "foo/bar/", sha1, S_IFREG | 0644)

is rejected.

Why do I say almost-synonym?  Because as Ram pointed out, you are not
invalidating the parent tree hash, because there may not even _be_ a
parent tree.

In other words, with this patch, I worry that a

	M 040000 ...sha1... "foo/bar/"

line would be sometimes ignored and sometimes not.  Confusing.

Would it make sense to just handle the empty-path case in the callers
(file_change_m(), file_change_cr()) to avoid this?
