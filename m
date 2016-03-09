From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] dir.c: fix dir re-inclusion rules with "NODIR" and "MUSTBEDIR"
Date: Wed, 09 Mar 2016 09:55:41 -0800
Message-ID: <xmqqoaanilia.fsf@gitster.mtv.corp.google.com>
References: <xmqqy49siin2.fsf@gitster.mtv.corp.google.com>
	<1457521693-26141-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Kevin Daudt <me@ikke.info>,
	Charles Strahan <charles@cstrahan.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 09 18:55:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adiKr-0001bX-84
	for gcvg-git-2@plane.gmane.org; Wed, 09 Mar 2016 18:55:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933491AbcCIRzq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Mar 2016 12:55:46 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:52446 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753423AbcCIRzo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Mar 2016 12:55:44 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 342C54A909;
	Wed,  9 Mar 2016 12:55:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=4amv3fWNMw1y
	S4pAHcf0zuh7LDs=; b=V3Un9NYWp+hKRu2sDNRvcOCeU5nXXak1t6ZM7C13gY9n
	TdHwoxBRGBpeYmZuiRaqKwTUY00IzoIKgIuIkEEy7CB6vuAhNHbW7cQbLeLdhaAK
	PgAugvE5Wckzq5wDwsdnhGFNj9oxxfeZLDMNh+0vOv4UkTx9GVfkGjcjSBV//To=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=VZ0rAk
	Uqb0zbIorC2lviw6r4lMtICEjBo56ZjfflBH0ixJVdvEF2MsrLSKUuQAw92KPXX/
	6AEgiPUC1kiI0y7tJ1U2RUCem8BzbovzkigIsAKUlRDX4Pe2IPr536GQwG7oJtGs
	LOPpJzm1edB8TuxkUZr/3JtJ6/BI9ckL59Kbw=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2AFF54A908;
	Wed,  9 Mar 2016 12:55:43 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 95A3A4A907;
	Wed,  9 Mar 2016 12:55:42 -0500 (EST)
In-Reply-To: <1457521693-26141-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Wed, 9 Mar
 2016 18:08:13 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 244124D8-E620-11E5-952E-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288538>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Side note, it's probably a bad idea to use basename matching on a
> negative rule (ie. no slashes in the pattern) because what the patter=
n
> says is "re-include _any_ directory named 'dir'", not just the direct=
ory
> "dir" at right below this directory.

I am not sure I agree with this comment.  When we say '.depend/' in
our .gitignore file, we do want to ignore everything in the
directory with that name anywhere in that tree.  Perhaps '!include/'
followed by '*' may be a good way to pick only the header files that
are found in any directory with that name anywhere in the tree in a
similar fashion.  It certainly is a disappointing comment if made by
somebody who wants to make 'dir' and '!dir' behave in a more similar
way, I'd have to say.

> In the MUSTBEDIR case, the patterns look like this
>
>     *          # exclude dir, dir/file1 and dir/file2..
>     !dir/      #  ..except that dir and everything inside is re-inclu=
ded..
>     dir/file2  # ..except (again!) that dir/file2 is excluded
>                # ..which means dir/file1 stays included
>
> Again, we're ok at the toplevel, then we enter "dir" and test
> "dir/file1". The MUSTBEDIR code tests if the _full_ path (ie. "dir/fi=
le1")
> is a directory. We want it to test the "dir" part from "dir/file1"
> instead.

That certainly sounds like a breakage worth fixing.

> In both cases, we want to test if the pattern matches a parent
> directory. match_dir_component() is for this purpose.

I do not follow.  I would understand "In all cases, we want to
behave as if we are testing the _full_ path against the pattern",
though.

IOW, "dir/file1" matches '*' (because 'file1' and '*' matches),
'!dir/' (because the pattern is "everything under dir/ directory),
and nothing else in the pattern list, and the last match
wins---which happens to be negative ignore, hence dir/file1 is not
ignored.

> We do want to be careful not to get back too far. Given the file
> foo/bar/.gitignore, we should only check as far back as foo/bar becau=
se
> this .gitignore file can never match outside that directory, which is
> "toplevel" in the above paragraphs, to begin with.

Yes.  But isn't that what exclude_stack mechanism already gives us?
That is, when you are not looking at a path inside foo/bar/, entries
stored in foo/bar/.gitignore will not participate the determination
of the fate of the path.

I am not sure why you have to say this.  Puzzled...
