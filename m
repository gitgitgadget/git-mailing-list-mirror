From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Rewrite fsck.c:fsck_commit() replace memcmp() with starts_with()
Date: Fri, 21 Mar 2014 11:43:44 -0700
Message-ID: <xmqqmwgjtmsf.fsf@gitster.dls.corp.google.com>
References: <1395419838-25527-1-git-send-email-cengoguzhanunlu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: sunshine@sunshineco.com, git@vger.kernel.org
To: blacksimit <cengoguzhanunlu@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 21 19:43:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WR4Q4-0000HF-Ns
	for gcvg-git-2@plane.gmane.org; Fri, 21 Mar 2014 19:43:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751085AbaCUSns (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2014 14:43:48 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46811 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751077AbaCUSns (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2014 14:43:48 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6A44F77863;
	Fri, 21 Mar 2014 14:43:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=90o1hG9mWXpZte6r8GPp0rjVdAc=; b=Ib316y
	8uABGsOpWg1wRAj7pgC4aweW/l/O/t2wWNJY5TP+rTpiSBTYQ/ymCoOuGmj3FpHE
	LpVNlxglCBaB/tVYW85ms29PzXrEh2OeMxeSBuWe+/n7LQhOuN223osa4U0QWO5D
	oXRVTY6swVfgpiEBo91X6yEqkLBvCqFlLe55E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lswkClnS9NMse2Pv5Z3aLFPGBkZoeINA
	OeQO0aN5DgjF5d+Lgci28KgoJYi2sMJsfFKhon4rs5J65dsF0plUYDIo2vbBZUax
	VUOY6pkW44+oppf+OR1CfpZ5XrFLlsC0rsZl5heYc6+kPH2Y02VTBnH0hsn5kMFT
	51Zhc65lhR4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 54BB977862;
	Fri, 21 Mar 2014 14:43:47 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AC1BD77861;
	Fri, 21 Mar 2014 14:43:46 -0400 (EDT)
In-Reply-To: <1395419838-25527-1-git-send-email-cengoguzhanunlu@gmail.com>
	(blacksimit's message of "Fri, 21 Mar 2014 18:37:18 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: BC4C0ABA-B128-11E3-B127-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244721>

blacksimit <cengoguzhanunlu@gmail.com> writes:

> From: Oguzhan Unlu <cengoguzhanunlu@gmail.com>
>
> My solution to make lines containing buffer += a_number; clearer to anyone is following; I defined a new int, magic_num, then assigned lengths of used strings to magic_num and then changed assignment lines through using magic_num so that where the number which is added to buffer is known although I eliminated 3rd parameter of memcmp() when using starts_with().   
Eric told you in $gmane/244637:

> Wrap messages to 65-70 characters.

I do not think replacing 5 (or 7) with a variable makes anything
clearer; in fact, by forcing people to check what the last value
assigned to the variable every time they see "+magic_num", the
resulting code is much harder to read, I would think.

Among the various submissions, I found this one one of the cleaner
solutions:

    http://thread.gmane.org/gmane.comp.version-control.git/244019/focus=244020

and it has been queued as 2d820a61 (fsck.c:fsck_commit(): use
skip_prefix() to verify and skip constant, 2014-03-13) on 'pu'.

> Signed-off-by: Oguzhan Unlu <cengoguzhanunlu@gmail.com>
> ---
>  I didn't use skip_prefix() in this microproject and I plan to apply for GSOC 2014. I expect your feedbacks!
>  fsck.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
>
> diff --git a/fsck.c b/fsck.c
> index d43be98..4e5ca30 100644
> --- a/fsck.c
> +++ b/fsck.c
> @@ -289,14 +289,17 @@ static int fsck_commit(struct commit *commit, fsck_error error_func)
>  	struct commit_graft *graft;
>  	int parents = 0;
>  	int err;
> -
> +    int magic_num;
> +    
> +    magic_num = strlen("tree "); /* magic_num is 5 */
>  	if (!starts_with(buffer, "tree "))
>  		return error_func(&commit->object, FSCK_ERROR, "invalid format - expected 'tree' line");
> -	if (get_sha1_hex(buffer+5, tree_sha1) || buffer[45] != '\n')
> +	if (get_sha1_hex(buffer+magic_num, tree_sha1) || buffer[45] != '\n')
>  		return error_func(&commit->object, FSCK_ERROR, "invalid 'tree' line format - bad sha1");
>  	buffer += 46;
> +    magic_num = strlen("parent "); /* magic_num is 7 */
>  	while (starts_with(buffer, "parent ")) {
> -		if (get_sha1_hex(buffer+7, sha1) || buffer[47] != '\n')
> +		if (get_sha1_hex(buffer+magic_num, sha1) || buffer[47] != '\n')
>  			return error_func(&commit->object, FSCK_ERROR, "invalid 'parent' line format - bad sha1");
>  		buffer += 48;
>  		parents++;
> @@ -322,15 +325,17 @@ static int fsck_commit(struct commit *commit, fsck_error error_func)
>  		if (p || parents)
>  			return error_func(&commit->object, FSCK_ERROR, "parent objects missing");
>  	}
> +    magic_num = strlen("author "); /* magic_num is 7 */
>  	if (!starts_with(buffer, "author "))
>  		return error_func(&commit->object, FSCK_ERROR, "invalid format - expected 'author' line");
> -	buffer += 7;
> +	buffer += magic_num;
>  	err = fsck_ident(&buffer, &commit->object, error_func);
>  	if (err)
>  		return err;
> +    magic_num = strlen("committer"); /* magic_num is 7 */
>  	if (!starts_with(buffer, "committer "))
>  		return error_func(&commit->object, FSCK_ERROR, "invalid format - expected 'committer' line");
> -	buffer += strlen("committer ");
> +	buffer += magic_num;
>  	err = fsck_ident(&buffer, &commit->object, error_func);
>  	if (err)
>  		return err;
