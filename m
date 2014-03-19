From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/3][GSOC] fsck: replace if-statements to logical expressions
Date: Wed, 19 Mar 2014 11:29:02 -0700
Message-ID: <xmqqha6u3uvl.fsf@gitster.dls.corp.google.com>
References: <1395228230-10189-1-git-send-email-sh19910711@gmail.com>
	<1395228230-10189-3-git-send-email-sh19910711@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
To: Hiroyuki Sano <sh19910711@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 19 19:29:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQLEp-0003et-Hp
	for gcvg-git-2@plane.gmane.org; Wed, 19 Mar 2014 19:29:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753242AbaCSS3J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2014 14:29:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41776 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753187AbaCSS3G (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2014 14:29:06 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D233274106;
	Wed, 19 Mar 2014 14:29:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/UDaSrdrgXEWRVorQTGTmqVMVUY=; b=PhVR1g
	J9+xRHhjcSpk9JC8AFoTz2NjwCLhdDOYMaLHkyhUYFpqHuWhIEhjUUtHf6BkaJWd
	F+CdNCGiEt/SNRjwr96s8eV1Ddu2qVVKbGskT/3PISOILu4yeqg7ZnhmitEZqRbK
	rm9wvhj8QCA4JvM89tgFK4i5XqsEwLq+9QZg8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=yH5xVrCqw/y29HtSJhL2UeeUPMRyzSk9
	gcIVjG9z6MrMN9HD6zaJwAXmPD/5ReDMQHjXXmF3IdZ6L0MIzO421BKZRdf88RzT
	ou8dGD+7ikxgb5p6WF3udbVq53YsjrjoGwpHnTNKDyc7DdVtWuqpDAz5/Fpw7nC/
	CFU6YcHN41o=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BD19974105;
	Wed, 19 Mar 2014 14:29:05 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1520974103;
	Wed, 19 Mar 2014 14:29:05 -0400 (EDT)
In-Reply-To: <1395228230-10189-3-git-send-email-sh19910711@gmail.com>
	(Hiroyuki Sano's message of "Wed, 19 Mar 2014 20:23:50 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 59FC4AB8-AF94-11E3-A465-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244473>

Hiroyuki Sano <sh19910711@gmail.com> writes:

> There were two different ways to check flag values, one way is
> using if-statement, and the other way is using logical expression.
>
> To make sensible, replace if-statements to logical expressions in
> fsck_tree().

The change described by these two paragraphs makes sense to me, but
the "to make sensible" phrasing made me hiccup while reading it.

	fsck_tree() uses two different ways to set flag values, many
	with a simple if () condition that guards an assignment, and
	one with an bitwise-or assignment operator.

	Unify them to the latter, as it is shorter and easier to
	read when the condition is short and to the point, which all
	of them are.

or something?

> When checking "has_dot" and "has_dotdot", use is_dot_or_dotdot()
> instead of strcmp() to avoid hard coding.

I am not sure how this change is an improvement.  Besides being
seemingly inefficient by checking name[1] twice (which is not a huge
objection, as a sensible compiler would notice and optimize), the
caller that checks name[1] already hardcodes its knowledge on what
is_dot_or_dotdot() does, e.g. when it returns true, name[0] is never
NUL, and name[1] is NUL only when it saw a dot and not a dotdot, so
the "to avoid hard coding" does not really justify this change.

I further wonder if

	...
	if (!name[0]) {
		has_empty_name = 1;
	} else if (name[0] == '.') {
        	has_dot |= !name[1];
                has_dotdot |= name[1] == '.' && !name[2];
		has_dotgit |= !strcmp(name + 1, "git");
	}
	...

may be an improvement (this is not a suggestion--when I say I
wonder, I usually do not know the answer).  It defeats the "unify
the two styles" theme of this change, so...

> The is_dot_or_dotdot() is used to check if the string is
> either "." or "..".
> Include the "dir.h" header file to use is_dot_or_dotdot().
>
> Signed-off-by: Hiroyuki Sano <sh19910711@gmail.com>
> ---
>  fsck.c | 19 +++++++------------
>  1 file changed, 7 insertions(+), 12 deletions(-)
>
> diff --git a/fsck.c b/fsck.c
> index b3022ad..08f613d 100644
> --- a/fsck.c
> +++ b/fsck.c
> @@ -6,6 +6,7 @@
>  #include "commit.h"
>  #include "tag.h"
>  #include "fsck.h"
> +#include "dir.h"
>  
>  static int fsck_walk_tree(struct tree *tree, fsck_walk_func walk, void *data)
>  {
> @@ -165,18 +166,12 @@ static int fsck_tree(struct tree *item, int strict, fsck_error error_func)
>  
>  		sha1 = tree_entry_extract(&desc, &name, &mode);
>  
> -		if (is_null_sha1(sha1))
> -			has_null_sha1 = 1;
> -		if (strchr(name, '/'))
> -			has_full_path = 1;
> -		if (!*name)
> -			has_empty_name = 1;
> -		if (!strcmp(name, "."))
> -			has_dot = 1;
> -		if (!strcmp(name, ".."))
> -			has_dotdot = 1;
> -		if (!strcmp(name, ".git"))
> -			has_dotgit = 1;
> +		has_null_sha1 |= is_null_sha1(sha1);
> +		has_full_path |= !!strchr(name, '/');
> +		has_empty_name |= !*name;
> +		has_dot |= is_dot_or_dotdot(name) && !name[1];
> +		has_dotdot |= is_dot_or_dotdot(name) && name[1];
> +		has_dotgit |= !strcmp(name, ".git");
>  		has_zero_pad |= *(char *)desc.buffer == '0';
>  		update_tree_entry(&desc);
