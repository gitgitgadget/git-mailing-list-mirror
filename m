From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v10 0/4] cat-file: add support for "-allow-unknown-type"
Date: Sun, 03 May 2015 17:14:06 -0700
Message-ID: <xmqqvbg9td0x.fsf@gitster.dls.corp.google.com>
References: <55463094.9040204@gmail.com>
	<xmqqzj5ltd6c.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>
To: karthik nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 04 02:14:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yp41X-00070w-6N
	for gcvg-git-2@plane.gmane.org; Mon, 04 May 2015 02:14:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751567AbbEDAOL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 May 2015 20:14:11 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:53862 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751384AbbEDAOI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 May 2015 20:14:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id F32324F239;
	Sun,  3 May 2015 20:14:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+Y4cjoyE56bJxT1e6DTUr2DlUCc=; b=cB7lxV
	LYDlxl1Ga+dweXE5zPToTyV55qo/IS/9zc0CJXsSTf20wEfO9dLs4XG6vWzJ+FB4
	lUOni4AWEWkDt1eOG3UuvO6+SlbqWWwl1VttKwbfKXuUKNSADoHhpJZtXpmhIQH6
	V/z7OkyxRWUjFjstsMc7dhI2lJYh+nQ4dPVRQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WxyqGHBmPb22gBLYkIPBkwv5wm6eVNdK
	d2s97jyw1K9wvS2mW2BhuCucPojiueZpELkxQ0XICUc1Z4lrmkYnksL/oC8uGWGu
	9GMk+0qSY9kpCfwK3ktjVmD1GRgdq16OfJ73kQT26hpf1SDrJ4D56VxJtS+Bul4X
	MBJJPGXfpK4=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EB1BD4F238;
	Sun,  3 May 2015 20:14:07 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 72CD24F237;
	Sun,  3 May 2015 20:14:07 -0400 (EDT)
In-Reply-To: <xmqqzj5ltd6c.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Sun, 03 May 2015 17:10:51 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 7AEF9166-F1F2-11E4-BA06-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268302>

Junio C Hamano <gitster@pobox.com> writes:

> Hmmmm... you do not seem to pass your own test.
>
> expecting success: 
>         echo $bogus_type >expect &&
>         git cat-file -t --allow-unknown-type $bogus_sha1 >actual &&
>         test_cmp expect actual
>
> --- expect      2015-05-04 00:09:24.327335512 +0000
> +++ actual      2015-05-04 00:09:24.335335473 +0000
> @@ -1 +1 @@
> -abcdefghijklmnopqrstuvwxyz1234679
> +abcdefghijklmnopqrstuvwxyz123467abcdefghijklmnopqrstuvwxyz1234679
> not ok 86 - Type of broken object is correct when type is large

Perhaps it would have a better chance of being correct with this
squashed in.

-- >8 --
[PATCH] fixup! sha1_file: support reading from a loose object of unknown type

---
 sha1_file.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index f65bf90..e010e7c 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1568,7 +1568,6 @@ static int unpack_sha1_header_to_strbuf(git_zstream *stream, unsigned char *map,
 					unsigned long mapsize, void *buffer,
 					unsigned long bufsiz, struct strbuf *header)
 {
-	unsigned char *cp;
 	int status;
 
 	status = unpack_sha1_header(stream, map, mapsize, buffer, bufsiz);
@@ -1579,7 +1578,6 @@ static int unpack_sha1_header_to_strbuf(git_zstream *stream, unsigned char *map,
 	if (memchr(buffer, '\0', stream->next_out - (unsigned char *)buffer))
 		return 0;
 
-	strbuf_add(header, buffer, stream->next_out - (unsigned char *)buffer);
 	do {
 		status = git_inflate(stream, 0);
 		strbuf_add(header, buffer, stream->next_out - (unsigned char *)buffer);
-- 
2.4.0-282-g4432dd4
