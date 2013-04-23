From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 3/7] cat-file: do not die on --textconv without textconv filters
Date: Tue, 23 Apr 2013 08:15:29 -0700
Message-ID: <7v61zdl1m6.fsf@alter.siamese.dyndns.org>
References: <517298D4.3030802@drmicha.warpmail.net>
	<10c691f7003f1f211f265abb177dd2a1b511b7e2.1366718624.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Matthieu.Moy@grenoble-inp.fr,
	jeremy.rosen@openwide.fr, Jeff King <peff@peff.net>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Apr 23 17:15:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUewV-0000mU-Eq
	for gcvg-git-2@plane.gmane.org; Tue, 23 Apr 2013 17:15:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756654Ab3DWPPd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Apr 2013 11:15:33 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36455 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756567Ab3DWPPc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Apr 2013 11:15:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0B97A19366;
	Tue, 23 Apr 2013 15:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=opnsg6oIew42mbHp0KX7+HEmXnc=; b=uWmVwL
	3L8DXxc4u1rRvnc0a2qUTzLZbVKn8/6r6pVtaH5PxpowJDbwxVraTRo7HwtYlVSB
	iRKZnQuSLAxqn9jrhiYBB4Ga82UNH2PGHeMEIEcQRRHTxFaeHUzvTqiWdq8KZRRg
	sQjqBsD2glCc6kx9iRJ2cdF9H+eiMWuS/b9CA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cSPZhaUfPEdMsc3eVvKKBZFMxv8M4bQk
	EVFWLutpLBW3gjoniZV+I9GzsBynqiTPibmkDf3hLv+RgplEv3apHJUab+mdGhs9
	JtXZPgFauaQOm6Tj8x32jMChT3Pbs2d09Csi6+UabwpWtVXkAaZY153Ny4lLb94u
	ym2W/McBBOo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F3E1619365;
	Tue, 23 Apr 2013 15:15:31 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3536919363;
	Tue, 23 Apr 2013 15:15:31 +0000 (UTC)
In-Reply-To: <10c691f7003f1f211f265abb177dd2a1b511b7e2.1366718624.git.git@drmicha.warpmail.net>
	(Michael J. Gruber's message of "Tue, 23 Apr 2013 14:11:55 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A3435182-AC28-11E2-87E0-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222175>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> When a command is supposed to use textconv filters (by default or with
> "--textconv") and none are configured then the blob is output without
> conversion; the only exception to this rule is "cat-file --textconv".
>
> Make it behave like the rest of textconv aware commands.
>
> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
> ---
>  builtin/cat-file.c           | 18 ++++++++----------
>  t/t8007-cat-file-textconv.sh | 20 +++++---------------
>  2 files changed, 13 insertions(+), 25 deletions(-)
>
> diff --git a/builtin/cat-file.c b/builtin/cat-file.c
> index 045cee7..bd62373 100644
> --- a/builtin/cat-file.c
> +++ b/builtin/cat-file.c
> @@ -48,6 +48,14 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name)
>  	case 'e':
>  		return !has_sha1_file(sha1);
>  
> +	case 'c':
> +		if (!obj_context.path[0])
> +			die("git cat-file --textconv %s: <object> must be <sha1:path>",
> +			    obj_name);
> +
> +		if (textconv_object(obj_context.path, obj_context.mode, sha1, 1, &buf, &size))
> +			break;
> +
>  	case 'p':

Yeah, falling back to the 'p' case is a lot more sensible.

>  		type = sha1_object_info(sha1, NULL);
>  		if (type < 0)
> @@ -70,16 +78,6 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name)
>  		/* otherwise just spit out the data */
>  		break;
>  
> -	case 'c':
> -		if (!obj_context.path[0])
> -			die("git cat-file --textconv %s: <object> must be <sha1:path>",
> -			    obj_name);
> -
> -		if (!textconv_object(obj_context.path, obj_context.mode, sha1, 1, &buf, &size))
> -			die("git cat-file --textconv: unable to run textconv on %s",
> -			    obj_name);
> -		break;
> -
>  	case 0:
>  		if (type_from_string(exp_type) == OBJ_BLOB) {
>  			unsigned char blob_sha1[20];
> diff --git a/t/t8007-cat-file-textconv.sh b/t/t8007-cat-file-textconv.sh
> index 78a0085..83c6636 100755
> --- a/t/t8007-cat-file-textconv.sh
> +++ b/t/t8007-cat-file-textconv.sh
> @@ -22,11 +22,11 @@ test_expect_success 'setup ' '
>  '
>  
>  cat >expected <<EOF
> -fatal: git cat-file --textconv: unable to run textconv on :one.bin
> +bin: test version 2
>  EOF
>  
>  test_expect_success 'no filter specified' '
> -	git cat-file --textconv :one.bin 2>result
> +	git cat-file --textconv :one.bin >result &&
>  	test_cmp expected result
>  '
>  
> @@ -36,10 +36,6 @@ test_expect_success 'setup textconv filters' '
>  	git config diff.test.cachetextconv false
>  '
>  
> -cat >expected <<EOF
> -bin: test version 2
> -EOF
> -
>  test_expect_success 'cat-file without --textconv' '
>  	git cat-file blob :one.bin >result &&
>  	test_cmp expected result
> @@ -73,25 +69,19 @@ test_expect_success 'cat-file --textconv on previous commit' '
>  '
>  
>  test_expect_success SYMLINKS 'cat-file without --textconv (symlink)' '
> +	printf "%s" "one.bin" >expected &&
>  	git cat-file blob :symlink.bin >result &&
> -	printf "%s" "one.bin" >expected
>  	test_cmp expected result
>  '
>  
>  
>  test_expect_success SYMLINKS 'cat-file --textconv on index (symlink)' '
> -	! git cat-file --textconv :symlink.bin 2>result &&
> -	cat >expected <<\EOF &&
> -fatal: git cat-file --textconv: unable to run textconv on :symlink.bin
> -EOF
> +	git cat-file --textconv :symlink.bin >result &&
>  	test_cmp expected result
>  '
>  
>  test_expect_success SYMLINKS 'cat-file --textconv on HEAD (symlink)' '
> -	! git cat-file --textconv HEAD:symlink.bin 2>result &&
> -	cat >expected <<EOF &&
> -fatal: git cat-file --textconv: unable to run textconv on HEAD:symlink.bin
> -EOF
> +	git cat-file --textconv HEAD:symlink.bin >result &&
>  	test_cmp expected result
>  '
