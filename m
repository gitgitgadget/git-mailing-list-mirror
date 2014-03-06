From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] upload-pack: send shallow info over stdin to pack-objects
Date: Thu, 06 Mar 2014 10:37:24 -0800
Message-ID: <xmqqfvmvyxzv.fsf@gitster.dls.corp.google.com>
References: <1393936205-15953-1-git-send-email-pclouds@gmail.com>
	<1394095783-24402-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 06 19:37:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLdAk-0006DD-9U
	for gcvg-git-2@plane.gmane.org; Thu, 06 Mar 2014 19:37:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752392AbaCFSha convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 Mar 2014 13:37:30 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43822 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751951AbaCFSh2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Mar 2014 13:37:28 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3770870753;
	Thu,  6 Mar 2014 13:37:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=2la7LLeioPY0
	VYHC/zYq4u3lKIY=; b=hVNPj3HxEYdC2d6OQ/CUPo8BoNH7TZEeh+L8uBuBnauL
	pAfOeNFy3EHzgd0oaoikxJER9Cf+HjMuchjkyeh+/p6M0NjkLOv/U6klwyrtsn/7
	qiyHrErNon7rwuTgpq6u/DpXScMgLlndvXuNAvEh1hnreevoUBSZtCULGrNZN4k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=WblBcY
	yCv4SCpk+CmrunfHqYJeUCEJFBXOvWAVT9PSlMgl2D/2KO6Gx+JBMjevIWHyzaYe
	nXpPg69j/PpkCEhDHar4qcIoNHWT00FraeeFstAP9Zwe+qtkHZAq1dYKL1qwyEB2
	b975w9L2B7K/TTokQ3BNaz+WILHhdhVcAhpeo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1FB7070752;
	Thu,  6 Mar 2014 13:37:28 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9C5017074D;
	Thu,  6 Mar 2014 13:37:26 -0500 (EST)
In-Reply-To: <1394095783-24402-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Thu, 6 Mar
 2014 15:49:43 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 5D909066-A55E-11E3-A9AB-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243530>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> From: Duy Nguyen <pclouds@gmail.com>
>
> Before cdab485 (upload-pack: delegate rev walking in shallow fetch to
> pack-objects - 2013-08-16) upload-pack does not write to the source
> repository. cdab485 starts to write $GIT_DIR/shallow_XXXXXX if it's a
> shallow fetch, so the source repo must be writable.
>
> git:// servers do not need write access to repos and usually don't
> have it, which means cdab485 breaks shallow clone over git://
>
> Instead of using a temporary file as the media for shallow points, we
> can send them over stdin to pack-objects as well. Prepend shallow
> SHA-1 with --shallow so pack-objects knows what is
> what.
>
> read_object_list_from_stdin() does not accept --shallow lines because
> upload-pack never uses that code. When upload-pack does, then it can
> learn about --shallow lines.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  OK new approach, stop creating shallow_XXXXXX in upload-pack.

Thanks.

I like what I see in this patch, but I wonder if we can essentially
revert that "temporary shallow file" patch and replace it with the
same (or a similar) mechanism uniformly?

On the receive-pack side, the comment at the bottom of
preprare_shallow_update() makes it clear that, if we wanted to use
hooks, we cannot avoid having the proposed new shallow-file in a
temporary file, which is unfortunate.  Do we have a similar issue on
hooks on the upload-pack side?


>  builtin/pack-objects.c   |  7 +++++++
>  shallow.c                |  2 ++
>  t/t5537-fetch-shallow.sh | 13 +++++++++++++
>  upload-pack.c            | 21 ++++++++++++---------
>  4 files changed, 34 insertions(+), 9 deletions(-)

Nothing for Documentation/ anywhere?

> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index c733379..79e848e 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -2467,6 +2467,13 @@ static void get_object_list(int ac, const char=
 **av)
>  				write_bitmap_index =3D 0;
>  				continue;
>  			}
> +			if (starts_with(line, "--shallow ")) {
> +				unsigned char sha1[20];
> +				if (get_sha1_hex(line + 10, sha1))
> +					die("not an SHA-1 '%s'", line + 10);
> +				register_shallow(sha1);
> +				continue;
> +			}
>  			die("not a rev '%s'", line);
>  		}
>  		if (handle_revision_arg(line, &revs, flags, REVARG_CANNOT_BE_FILEN=
AME))
> diff --git a/shallow.c b/shallow.c
> index bbc98b5..41ff4a0 100644
> --- a/shallow.c
> +++ b/shallow.c
> @@ -33,6 +33,8 @@ int register_shallow(const unsigned char *sha1)
>  	graft->nr_parent =3D -1;
>  	if (commit && commit->object.parsed)
>  		commit->parents =3D NULL;
> +	if (is_shallow =3D=3D -1)
> +		is_shallow =3D 1;
>  	return register_commit_graft(graft, 0);
>  }
> =20
> diff --git a/t/t5537-fetch-shallow.sh b/t/t5537-fetch-shallow.sh
> index 3ae9092..a980574 100755
> --- a/t/t5537-fetch-shallow.sh
> +++ b/t/t5537-fetch-shallow.sh
> @@ -173,4 +173,17 @@ EOF
>  	)
>  '
> =20
> +test_expect_success POSIXPERM,SANITY 'shallow fetch from a read-only=
 repo' '
> +	cp -R .git read-only.git &&
> +	find read-only.git -print | xargs chmod -w &&
> +	test_when_finished "find read-only.git -type d -print | xargs chmod=
 +w" &&
> +	git clone --no-local --depth=3D2 read-only.git from-read-only &&
> +	git --git-dir=3Dfrom-read-only/.git log --format=3D%s >actual &&
> +	cat >expect <<EOF &&
> +add-1-back
> +4
> +EOF
> +	test_cmp expect actual
> +'
> +
>  test_done
> diff --git a/upload-pack.c b/upload-pack.c
> index 0c44f6b..a5c50e4 100644
> --- a/upload-pack.c
> +++ b/upload-pack.c
> @@ -70,6 +70,14 @@ static ssize_t send_client_data(int fd, const char=
 *data, ssize_t sz)
>  	return sz;
>  }
> =20
> +static int write_one_shallow(const struct commit_graft *graft, void =
*cb_data)
> +{
> +	FILE *fp =3D cb_data;
> +	if (graft->nr_parent =3D=3D -1)
> +		fprintf(fp, "--shallow %s\n", sha1_to_hex(graft->sha1));
> +	return 0;
> +}
> +
>  static void create_pack_file(void)
>  {
>  	struct child_process pack_objects;
> @@ -81,12 +89,10 @@ static void create_pack_file(void)
>  	const char *argv[12];
>  	int i, arg =3D 0;
>  	FILE *pipe_fd;
> -	char *shallow_file =3D NULL;
> =20
>  	if (shallow_nr) {
> -		shallow_file =3D setup_temporary_shallow(NULL);
>  		argv[arg++] =3D "--shallow-file";
> -		argv[arg++] =3D shallow_file;
> +		argv[arg++] =3D "";
>  	}
>  	argv[arg++] =3D "pack-objects";
>  	argv[arg++] =3D "--revs";
> @@ -114,6 +120,9 @@ static void create_pack_file(void)
> =20
>  	pipe_fd =3D xfdopen(pack_objects.in, "w");
> =20
> +	if (shallow_nr)
> +		for_each_commit_graft(write_one_shallow, pipe_fd);
> +
>  	for (i =3D 0; i < want_obj.nr; i++)
>  		fprintf(pipe_fd, "%s\n",
>  			sha1_to_hex(want_obj.objects[i].item->sha1));
> @@ -242,12 +251,6 @@ static void create_pack_file(void)
>  		error("git upload-pack: git-pack-objects died with error.");
>  		goto fail;
>  	}
> -	if (shallow_file) {
> -		if (*shallow_file)
> -			unlink(shallow_file);
> -		free(shallow_file);
> -	}
> -
>  	/* flush the data */
>  	if (0 <=3D buffered) {
>  		data[0] =3D buffered;
