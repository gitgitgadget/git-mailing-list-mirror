From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] string-list.h: Add a value to string_list initializer lists
Date: Mon, 02 Jun 2014 13:00:23 -0700
Message-ID: <xmqqlhtf3wvc.fsf@gitster.dls.corp.google.com>
References: <1401699504-29826-1-git-send-email-tanayabh@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 02 22:00:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WrYPP-0006dv-BW
	for gcvg-git-2@plane.gmane.org; Mon, 02 Jun 2014 22:00:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752372AbaFBUAf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jun 2014 16:00:35 -0400
Received: from smtp.pobox.com ([208.72.237.35]:54416 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752040AbaFBUAe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jun 2014 16:00:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id CD3C51D857;
	Mon,  2 Jun 2014 16:00:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TJB6kP7q2rNmaikSHImqcv9gz24=; b=QQX3SB
	GfB3W/g2RTUaiAJfn526bmJX7VBxky2mp959scLOQaqcJK1cSkUM53LwLbzENecF
	+ukmSOJ1Lenrw8+eIZjK3RQB5rXnYctc9TCTEltvYXR3XpGjdU20x2Yqhd4GuafL
	iyHd8qoR3XR93T+SMLscShOWORwG1jpcnulvk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IHBq9rHFXHhfhRC/Dyy98TZ8uLZOqOUB
	1/5l7DqVkYi9/kEVZ94iDgYyBkd1TfMyY4Q4/YbJMnDBXxe33KbmiQ+yyrqQKFcx
	PRDjaBu83gSldxNnxt7SoAIZ/Ds55ckw9YQPOYd3v6NCWUD7E0HFQhkQtj+fdN7D
	ocKEKR6NKQ4=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C19991D856;
	Mon,  2 Jun 2014 16:00:33 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 314B91D851;
	Mon,  2 Jun 2014 16:00:30 -0400 (EDT)
In-Reply-To: <1401699504-29826-1-git-send-email-tanayabh@gmail.com> (Tanay
	Abhra's message of "Mon, 2 Jun 2014 01:58:24 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 8C5A0C3E-EA90-11E3-9955-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250589>

Tanay Abhra <tanayabh@gmail.com> writes:

> Add a NULL value in the end of STRING_LIST_INIT_NODUP and
> STRING_LIST_DUP to initialize `compare_strings_fn`.

Hmph.  That is "what change is proposed", which we can read from the
patch text itself below.  We would want to see "why is this change a
good thing" to justify it.

As you mentioned later "In C, ...", there is nothing wrong in what
we have (and we can not quite read what exactly you tried to do with
uninitialized memory with these macros), so we need an excuse other
than correctness to justify this change.  Perhaps like this?

	STRING_LIST_INIT_{NODUP,DUP} initializers list values only
	for earlier structure members, relying on the usual
	convention in C that the omitted members are initailized to
	0, i.e. the former is expanded to the latter:

	    struct string_list l = STRING_LIST_INIT_DUP;
            struct string_list l = { NULL, 0, 0, 1 };

	and the last member that is not mentioned (i.e. 'cmp') is
	initialized to NULL.

	While there is nothing wrong in this construct, spelling out
	all the values where the macros are defined will serve also
	as a documentation, so let's do so.

> Signed-off-by: Tanay Abhra <tanayabh@gmail.com>
> ---
> When I used a malloced string_list to play around with string-list API and
> used the default init_list, it caused a seg fault. After an hour of debugging
> I saw that comapre_strings_fn should be initialized to NULL. In C, even an
> incomplete initialzer initializes every value to NULl or 0, so in normal
> usage in the codebase this problem never occurs. Still it is better to be
> thorough.
>
>  string-list.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/string-list.h b/string-list.h
> index de6769c..87ee419 100644
> --- a/string-list.h
> +++ b/string-list.h
> @@ -15,8 +15,8 @@ struct string_list {
>  	compare_strings_fn cmp; /* NULL uses strcmp() */
>  };
>  
> -#define STRING_LIST_INIT_NODUP { NULL, 0, 0, 0 }
> -#define STRING_LIST_INIT_DUP   { NULL, 0, 0, 1 }
> +#define STRING_LIST_INIT_NODUP { NULL, 0, 0, 0, NULL }
> +#define STRING_LIST_INIT_DUP   { NULL, 0, 0, 1, NULL }
>  
>  void print_string_list(const struct string_list *p, const char *text);
>  void string_list_clear(struct string_list *list, int free_util);
