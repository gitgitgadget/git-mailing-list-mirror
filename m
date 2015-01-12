From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] cat-file: remove definition of already defined variables
Date: Mon, 12 Jan 2015 13:27:17 -0800
Message-ID: <xmqqd26j7kqy.fsf@gitster.dls.corp.google.com>
References: <1420913603-794-1-git-send-email-kuleshovmail@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Alexander Kuleshov <kuleshovmail@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 12 22:27:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YAmWD-0003n5-Tc
	for gcvg-git-2@plane.gmane.org; Mon, 12 Jan 2015 22:27:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751678AbbALV1V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jan 2015 16:27:21 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:50322 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751964AbbALV1U (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jan 2015 16:27:20 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id F3FC62FC5F;
	Mon, 12 Jan 2015 16:27:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8wvVoyGXG31cscu1+nKfES38zEA=; b=vMPNyr
	o+OS+TE3SBLOMVXFuxwbx6WIdUsXSgDYmOQimwGPN+Ez5IkLIaf+nA5F1YAubBUL
	qst/7wsFnKK8c+cCx7nXz/yPBhx4Pr3lQZYIW88yq11YGaSrAfAm50qR1+necSyO
	iqn59gS7wa/QX+YAunkwO1K1AJFxCC+Ddztf0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=W0E4do3Fl8fG4TB92Ep1LjIGB2C31Eha
	HiOrYAUvSTTJEVG/3nl40+a+cD/1A5vXwomnYdn62ntGl8KWSWkch9zrpBSTndz6
	HeQ9o96zwzY4J99wwSWHbVVKx9PwNhdTJw1WBNFuFMrleCdx82jOyUicetw0HVmE
	nlhuG6k+6Pw=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E9F3E2FC5E;
	Mon, 12 Jan 2015 16:27:19 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 612562FC5A;
	Mon, 12 Jan 2015 16:27:19 -0500 (EST)
In-Reply-To: <1420913603-794-1-git-send-email-kuleshovmail@gmail.com>
	(Alexander Kuleshov's message of "Sun, 11 Jan 2015 00:13:23 +0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C9CDB6EE-9AA1-11E4-B8B3-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262296>

Alexander Kuleshov <kuleshovmail@gmail.com> writes:

> 'enum object_type type' and 'unsigned long size' are already defined
> at the top of cat_one_file routine

True.  That description applies to two completely different
situations, though, and does not help judging if the change is
correct.

Scenario #1:

	unsigned long size;

        size = something;
        if (...) {
        	unsigned long size = something else;
	}
	use(size);

Scenario #2:

	unsigned long size;

        size = something;
        if (...) {
        	unsigned long size = something else;
	}
	size = yet another something else;
	use(size);

In either case, the variable definition in the inner block hides the
variable that happens to share the same name, but in Scenario #1,
the hiding is deliberate and reusing the variable from outside would
break the later use of the variable.

In the code in question, the outer variable's value before the block
is not used after the block, so it is safe to remove the inner
definition and reuse the variable from the outer block.

"already defined at the top" does not help the readers to tell that
we are dealing with the Scenario #2 here.

Thanks, will apply after trying to come up with a better way to
phrase this.

> Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
> ---
>  builtin/cat-file.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/builtin/cat-file.c b/builtin/cat-file.c
> index 750b5a2..31b133b 100644
> --- a/builtin/cat-file.c
> +++ b/builtin/cat-file.c
> @@ -75,8 +75,6 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name)
>  		if (type_from_string(exp_type) == OBJ_BLOB) {
>  			unsigned char blob_sha1[20];
>  			if (sha1_object_info(sha1, NULL) == OBJ_TAG) {
> -				enum object_type type;
> -				unsigned long size;
>  				char *buffer = read_sha1_file(sha1, &type, &size);
>  				const char *target;
>  				if (!skip_prefix(buffer, "object ", &target) ||
