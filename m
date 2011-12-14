From: Michael Schubert <mschub@elegosoft.com>
Subject: Re: [bug?] checkout -m doesn't work without a base version
Date: Wed, 14 Dec 2011 11:19:22 +0100
Message-ID: <4EE8782A.9040507@elegosoft.com>
References: <4EDBF4D5.6030908@pcharlan.com> <7vbormn8vk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Pete Harlan <pgit@pcharlan.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 14 11:20:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ralx6-0008R0-4t
	for gcvg-git-2@lo.gmane.org; Wed, 14 Dec 2011 11:20:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756207Ab1LNKUk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Dec 2011 05:20:40 -0500
Received: from mx0.elegosoft.com ([78.47.87.163]:37291 "EHLO mx0.elegosoft.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752793Ab1LNKUj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Dec 2011 05:20:39 -0500
Received: from localhost (localhost [127.0.0.1])
	by mx0.elegosoft.com (Postfix) with ESMTP id 3E54DDE870;
	Wed, 14 Dec 2011 11:20:38 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at mx0.elegosoft.com
Received: from mx0.elegosoft.com ([127.0.0.1])
	by localhost (mx0.elegosoft.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TVQkW7GV48jA; Wed, 14 Dec 2011 11:20:30 +0100 (CET)
Received: from [10.10.10.197] (i59F7870A.versanet.de [89.247.135.10])
	by mx0.elegosoft.com (Postfix) with ESMTPSA id 230F5DE859;
	Wed, 14 Dec 2011 11:20:30 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:8.0) Gecko/20111108 Thunderbird/8.0
In-Reply-To: <7vbormn8vk.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187107>

On 12/05/2011 07:58 PM, Junio C Hamano wrote:
> @@ -150,18 +155,27 @@ static int checkout_merged(int pos, struct chec=
kout *state)
>  	int status;
>  	unsigned char sha1[20];
>  	mmbuffer_t result_buf;
> +	unsigned char threeway[3][20];
> +	unsigned mode;
> +
> +	memset(threeway, 0, sizeof(threeway));
> +	while (pos < active_nr) {
> +		int stage;
> +		stage =3D ce_stage(ce);
> +		if (!stage || strcmp(path, ce->name))
> +			break;
> +		hashcpy(threeway[stage - 1], ce->sha1);
> +		if (stage =3D=3D 2)
> +			mode =3D create_ce_mode(ce->ce_mode);
> +		pos++;
> +		ce =3D active_cache[pos];
> +	}
> +	if (is_null_sha1(threeway[1]) || is_null_sha1(threeway[2]))
> +		return error(_("path '%s' does not have necessary versions"), path=
);
> =20
> -	if (ce_stage(ce) !=3D 1 ||
> -	    active_nr <=3D pos + 2 ||
> -	    strcmp(active_cache[pos+1]->name, path) ||
> -	    ce_stage(active_cache[pos+1]) !=3D 2 ||
> -	    strcmp(active_cache[pos+2]->name, path) ||
> -	    ce_stage(active_cache[pos+2]) !=3D 3)
> -		return error(_("path '%s' does not have all 3 versions"), path);
> -
> -	read_mmblob(&ancestor, active_cache[pos]->sha1);
> -	read_mmblob(&ours, active_cache[pos+1]->sha1);
> -	read_mmblob(&theirs, active_cache[pos+2]->sha1);
> +	read_mmblob(&ancestor, threeway[0]);
> +	read_mmblob(&ours, threeway[1]);
> +	read_mmblob(&theirs, threeway[2]);
> =20
>  	/*
>  	 * NEEDSWORK: re-create conflicts from merges with
> @@ -192,9 +206,7 @@ static int checkout_merged(int pos, struct checko=
ut *state)
>  	if (write_sha1_file(result_buf.ptr, result_buf.size,
>  			    blob_type, sha1))
>  		die(_("Unable to add merge result for '%s'"), path);
> -	ce =3D make_cache_entry(create_ce_mode(active_cache[pos+1]->ce_mode=
),
> -			      sha1,
> -			      path, 2, 0);
> +	ce =3D make_cache_entry(mode, sha1, path, 2, 0);
>  	if (!ce)
>  		die(_("make_cache_entry failed for path '%s'"), path);
>  	status =3D checkout_entry(ce, state, NULL);

gcc 4.6.2:

builtin/checkout.c: In function =91cmd_checkout=92:
builtin/checkout.c:210:5: warning: =91mode=92 may be used uninitialized=
 in this function [-Wuninitialized]
builtin/checkout.c:160:11: note: =91mode=92 was declared here
