From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 3/3] cat-file: add --follow-symlinks to --batch
Date: Mon, 11 May 2015 13:21:16 -0700
Message-ID: <xmqqd2263lxf.fsf@gitster.dls.corp.google.com>
References: <1431366989-7405-1-git-send-email-dturner@twopensource.com>
	<1431366989-7405-4-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, David Turner <dturner@twitter.com>
To: dturner@twopensource.com
X-From: git-owner@vger.kernel.org Mon May 11 22:21:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YruCa-00040g-Up
	for gcvg-git-2@plane.gmane.org; Mon, 11 May 2015 22:21:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751290AbbEKUVV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 May 2015 16:21:21 -0400
Received: from mail-ig0-f174.google.com ([209.85.213.174]:36471 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751530AbbEKUVT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 May 2015 16:21:19 -0400
Received: by igbpi8 with SMTP id pi8so81602130igb.1
        for <git@vger.kernel.org>; Mon, 11 May 2015 13:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=CRaK/8da/Q9CdTKawL5+ee6nNwn+UCJNbX0y331xn6c=;
        b=Qz6J8i27cAWNOnv6W57URQxfCqEy3B5aisHmIcaki2TylNXo2oDcVRyM7u+QBf38Ly
         YnupAeRaQF+TZuVm3kO7/KqlFm+TKAPmGw8i7SKhG9qc5tzw1nMTq6sGHgdCXmC34Bpc
         8cWJPLnWfcjgf2res08nTD+dkBUB/MiuB123JizlpJMBOXNorPvrul5zgXaqac1A/fW9
         MCWoMns98zyO07t4QdS00d2rvUXaOhm3AtJ3Qd7wH0vV1qjJ9SsXRQQrWsbD/sSwL1gi
         8lI/vCO/pTi6LHnMGvAjmc9vlj9C93oORNn5YQg+W4cIQAFwvUP7PaNoYq599uXeSrbg
         qWNA==
X-Received: by 10.107.47.21 with SMTP id j21mr15403936ioo.17.1431375678758;
        Mon, 11 May 2015 13:21:18 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:e888:82ed:a88f:f5e4])
        by mx.google.com with ESMTPSA id v14sm586892igd.12.2015.05.11.13.21.17
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 11 May 2015 13:21:18 -0700 (PDT)
In-Reply-To: <1431366989-7405-4-git-send-email-dturner@twopensource.com>
	(dturner@twopensource.com's message of "Mon, 11 May 2015 13:56:29
	-0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268822>

dturner@twopensource.com writes:

> +--follow-symlinks::
> +	Follow symlinks inside the repository.  Instead of providing
> +	output about the link itself, provide output about the linked-to
> +	object.  This option requires --batch or --batch-check.  In the
> +	event of a symlink loop (or more than 40 symlinks in a symlink
> +	resolution chain), the file will be treated as missing.  If a
> +	symlink points outside the repository (e.g. a link to /foo or a
> +	root-level link to ../foo), the portion of the link which is
> +	outside the repository will be printed.  Follow-symlinks will
> +	be silently turned off if <object> specifies an object in the
> +	index rather than one in the object database.

One thing that I found is missing from the above and other places in
the documents updated by this patch, when I pretend that I am an
end-user who never saw the discussion for the problem definition and
design of the solution on the list, is what "symlink" this refers
to and how I am expected to use this feature.

Such an end-user in me without inside knowledge naively expects that
the command invocation would be like this:

	$ git cat-file --batch-check --follow-symlinks <<\EOF
	e156455ea49124c140a67623f22a393db62d5d98
	55aeb4d32091e0e6062759958c30d316f77a570e
        e50885caa1043665dfe2d995e0a2f7a7a7bb51ca
	EOF

where the last one is output from "git rev-parse v2.0.0:RelNotes"
(the second one is v2.0.0^{tree}).

As somebody who is familiar with how the implementation works, I
_know_ that such an expectation is wrong.  At least the command
would need a hint that lets it realize that the blob sits inside a
tree with mode bits that says it is a symlink, e.g.

	$ git cat-file --batch-check --follow-symlinks <<\EOF
	55aeb4d32091e0e6062759958c30d316f77a570e:RelNotes
	EOF

But that requirement is not hinted in the documentation, so there is
no way for a new user to discover how useful this feature is and how
to use it.

The above description mentions "points outside the repository", but
that also may need some clarification to such an end-user in me
without inside knowledge.

For example, if I had a tree T that records a subtree T:sub, in
which a symbolic link sub/link that points at "../target", i.e. with
this setup (8fb753 is T):

    $ git rev-parse 8fb7535cc62fd9a0a804f21389667f9505299fb4:sub
    13056eb35d037f4af8be37e6a1ba983235bd7613
    $ git ls-tree 13056eb35d037f4af8be37e6a1ba983235bd7613 link
    120000 blob 78bc33729bacb569b76aaef40fec807af2ec1274    link
    $ git cat-file blob 78bc33729ba
    ../target
    $ git ls-tree 8fb7535cc62 target
    100644 blob e69de29bb2d1d6434b8b29ae775ad8c2e48c5391    target

These behave differently

    $ git cat-file --batch-check --follow-symlinks <<\EOF
    8fb7535cc62f:sub/link
    13056eb35d03:link
    EOF

and that is correct for obvious reasons, but is the reason obvious
enough to an end-user in me without inside knowledge?  The symlink
points inside the repository, but it is outside the starting object
of the extended SHA-1 expression that was used to name the object.

So in short, the description above should mention that this feature
is about asking for the object with extended SHA-1 expression that
begins with a tree-ish, colon and a path to in the tree.  And it
needs to rephrase "outside the repository" with something like
"outside the tree-ish on the left hand side of the colon in the
extended SHA-1 expression" or something.

Others better at phrasing may be able to offer a better wording than
my clumsy attempt above, though ;-)

> +If --follow-symlinks is used, and a symlink in the repository points
> +outside the repository, then `cat-file` will ignore any custom format
> +and print:
> +
> +------------
> +symlink SP <size> LF <symlink> LF
> +------------

A symlink contain LF, obviously, and we should use some quoting
convention.  Perhaps quote_c_style() on a string that needs it is
sufficient---most sane people do not put LF or literally '\' 'n' or
'"' in their symbolic links, so the ugly output is not visible for
them, and it is far better to be able to say "If you have funny
characters in your symlinks, they will be quoted" than "If you have
funny characters in your symlinks, you are SOL".

Thanks.
