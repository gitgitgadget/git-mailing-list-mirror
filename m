From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] sha1_file: do not add own object directory as alternate
Date: Tue, 15 Jul 2014 12:26:00 -0700
Message-ID: <xmqqd2d6v2yf.fsf@gitster.dls.corp.google.com>
References: <53BFB055.206@gmail.com>
	<xmqqy4vz51gb.fsf@gitster.dls.corp.google.com>
	<53C26309.5040401@gmail.com> <53C39CB0.6040909@gmail.com>
	<CACsJy8B-QFu4SU6HHZukAmmjLrgb+L8KsHPn3GgQhcX6-LGXLg@mail.gmail.com>
	<53C3D2AD.9050204@gmail.com> <53C4BFC7.2000507@kdbg.org>
	<53C510A9.4010208@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j6t@kdbg.org>, Duy Nguyen <pclouds@gmail.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ephrim Khong <dr.khong@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 15 21:26:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X78Mg-0007oE-4l
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jul 2014 21:26:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933232AbaGOT0J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jul 2014 15:26:09 -0400
Received: from smtp.pobox.com ([208.72.237.35]:52089 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932850AbaGOT0I (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2014 15:26:08 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5541028179;
	Tue, 15 Jul 2014 15:25:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jKN8vhoufbV+1tJza0w8QGo+upE=; b=S9RmrJ
	Bo8lA0XiqHc9l0srxkMy20N6AaI30aNgm0DOb/9eL4U1qsjNeUoTeFH5RIPQTwB7
	dgg+2e8Z2bdzm4E8R7yxzK3DqsXlRfP2Z5jh8GCpvjq+L8v/Z6VO8rcU7SF5dL0P
	C4TrNLHxq1BCO/XY45nyxHH7E+aRWv3lb7OC8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZhxjLhyiJyPHuceMDU5EGifSpkGbVoLQ
	BwPPek5LA2al3zZjNA+FQ8aTCsaXRqXSMEU5SiFh1oWYuZK2W9ASAjQcib/nGcfy
	3tl+sVg5AcM+lf7+tIF2C1cu5xL5mF2B1fQqgRQGoAVJFotmpj7gs2DVlWyD+7sx
	OjTinApIVow=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4BEA228178;
	Tue, 15 Jul 2014 15:25:50 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 59FB728170;
	Tue, 15 Jul 2014 15:25:44 -0400 (EDT)
In-Reply-To: <53C510A9.4010208@gmail.com> (Ephrim Khong's message of "Tue, 15
	Jul 2014 13:29:45 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: D0DC7310-0C55-11E4-9D4C-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253589>

Ephrim Khong <dr.khong@gmail.com> writes:

> @@ -320,7 +320,7 @@ static int link_alt_odb_entry(const char *entry, const char *relative_base, int
>  			return -1;
>  		}
>  	}
> -	if (!strcmp(ent->base, objdir)) {
> +	if (!strcmp_icase(ent->base, normalized_objdir)) {

Not a problem with your patch, but we should rethink the name of
this function when the code base is more quiet.  It always makes me
wonder if it is something similar to strcasecmp(), but in fact it is
not.  It is meant to be used *only* for pathnames; pathname_cmp() or
something that has "path" in its name would be appropriate, but it
is wrong to call it "str"-anything.

> @@ -344,6 +344,7 @@ static void link_alt_odb_entries(const char *alt, int len, int sep,
>  	struct string_list entries = STRING_LIST_INIT_NODUP;
>  	char *alt_copy;
>  	int i;
> +	struct strbuf objdirbuf = STRBUF_INIT;
>
>  	if (depth > 5) {
>  		error("%s: ignoring alternate object stores, nesting too deep.",
> @@ -351,6 +352,9 @@ static void link_alt_odb_entries(const char *alt, int len, int sep,
>  		return;
>  	}
>
> +	strbuf_addstr(&objdirbuf, absolute_path(get_object_directory()));
> +	normalize_path_copy(objdirbuf.buf, objdirbuf.buf);

This is somewhat a strange usage of a strbuf.

 - it relies on that normalize_path_copy() only shrinks, never
   lengthens, which is not too bad;

 - if the operation ever shrinks, objdirbuf.len becomes
   meaningless.  The allocated length is objdirbuf.alloc, length
   of the string is strlen(objdirbuf.buf).

 - abspath.c::absolute_path() is still restricted to PATH_MAX, so
   you are not gaining much by using strbuf here.

But at least this patch is not making things any worse, so....

> @@ -361,11 +365,12 @@ static void link_alt_odb_entries(const char *alt, int len, int sep,
>  			error("%s: ignoring relative alternate object store %s",
>  					relative_base, entry);
>  		} else {
> -			link_alt_odb_entry(entry, relative_base, depth);
> +			link_alt_odb_entry(entry, relative_base, depth, objdirbuf.buf);
>  		}
>  	}
>  	string_list_clear(&entries, 0);
>  	free(alt_copy);
> +	strbuf_release(&objdirbuf);
>  }
>
>  void read_info_alternates(const char * relative_base, int depth)
> diff --git a/t/t7702-repack-cyclic-alternate.sh b/t/t7702-repack-cyclic-alternate.sh
> new file mode 100755
> index 0000000..8341d46
> --- /dev/null
> +++ b/t/t7702-repack-cyclic-alternate.sh

Do we really have to waste a new test file only for this test?

Don't we have any test that already uses alternate that these two
new test pieces can be added to?

    $ git grep info/alternates t/

seems to show a few existing ones, including 1450 (fsck) and 7700
(repack) that look very relevant (I didn't check what the tests in
them are about, though).
