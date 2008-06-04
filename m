From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [WIP/RFC PATCH 1/2] Introduce GIT_INDEX_PREFIX
Date: Wed, 04 Jun 2008 11:00:41 -0700
Message-ID: <7vabi1xepi.fsf@gitster.siamese.dyndns.org>
References: <20080604162825.GB23975@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 04 20:02:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3xJA-0004iq-3W
	for gcvg-git-2@gmane.org; Wed, 04 Jun 2008 20:02:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755795AbYFDSA6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Jun 2008 14:00:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754378AbYFDSA6
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jun 2008 14:00:58 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:59830 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755372AbYFDSA5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Jun 2008 14:00:57 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id A2DA65DF5;
	Wed,  4 Jun 2008 14:00:54 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 39C835DF4; Wed,  4 Jun 2008 14:00:50 -0400 (EDT)
In-Reply-To: <20080604162825.GB23975@laptop> (=?utf-8?B?Tmd1eeG7hW4gVGg=?=
 =?utf-8?B?w6FpIE5n4buNYw==?= Duy's message of "Wed, 4 Jun 2008 23:28:25
 +0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 2D236DEE-3260-11DD-9DC3-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83801>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:

> GIT_INDEX_PREFIX is used to limit write access to a specific director=
y.
> Only "important" information is protected by index prefix (those will
> be used to create tree objects)
>
> When GIT_INDEX_PREFIX is set, any attempt to modify the index (refres=
h
> it is okay though) will bail out. read-tree and merge, however, can
> write to full index. For merge, no conflict is allowed outside index
> prefix.

This is kind of hard to judge as part of "narrow checkout" series, beca=
use
it is not clear how this will actually _help_ narrow checkout.

In other words, as a standalone "protect parts outside a single
subdirectory" it can be reviewed and judged, but it is unclear how it
would help narrow checkout if you excempted only a _single_ subdirector=
y.
E.g. you might want to limit yourself to arch/x86 _and_ include/asm-x86=
=2E

I sympathize that this series will be hard to get right as the places _=
you
identify_ in the code as "touching index entries" are the only places t=
hat
you _could_ write test scripts for --- if you missed one codepath it wo=
uld
be easy for you to forget writing the test for that codepath.

Having said that...

> @@ -71,6 +73,9 @@ static void setup_git_env(void)
>  	git_graft_file =3D getenv(GRAFT_ENVIRONMENT);
>  	if (!git_graft_file)
>  		git_graft_file =3D xstrdup(git_path("info/grafts"));
> +	index_prefix =3D getenv(INDEX_PREFIX_ENVIRONMENT);
> +	if (index_prefix && (!*index_prefix || index_prefix[strlen(index_pr=
efix)-1] !=3D '/'))
> +		die("GIT_INDEX_PREFIX must end with a slash");

Not nice (aka "why 'must'?").

> diff --git a/read-cache.c b/read-cache.c
> index ac9a8e7..4f8d44b 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -23,6 +23,11 @@
> =20
>  struct index_state the_index;
> =20
> +static int outside_index_prefix(const struct index_state *istate, co=
nst char *ce_name)
> +{
> +	return istate =3D=3D &the_index && get_index_prefix() && prefixcmp(=
ce_name, get_index_prefix());
> +}

The first check above needs to be justified.

If you say "outside of this path are off-limits", why do you allow a
temporary index that is used during a partial commit and other
index_states excempt from that rule?

> @@ -793,21 +804,35 @@ static int check_file_directory_conflict(struct=
 index_state *istate,
>  	return retval + has_dir_name(istate, ce, pos, ok_to_replace);
>  }
> =20
> +static int ce_compare(const struct cache_entry *ce1, const struct ca=
che_entry *ce2)
> +{
> +	return ce1->ce_mode =3D=3D ce2->ce_mode &&
> +		((ce1->ce_flags ^ ce2->ce_flags) & ~(CE_HASHED | CE_UPDATE)) =3D=3D=
 0 &&
> +		!memcmp(ce1->sha1, ce2->sha1, 20) &&
> +		!strcmp(ce1->name, ce2->name);
> +}

This needs a bit of commenting to explain why HASHED and UPDATE are
specifically ignored, so that people who later add their own bit to the
flag can easily tell if their new bit should also be ignored.

> +	cache1 =3D the_index.cache;
> +	cache2 =3D index->cache;
> +	start =3D 0;
> +	end1 =3D the_index.cache_nr ? the_index.cache_nr - 1 : 0;
> +	end2 =3D index->cache_nr ? index->cache_nr - 1 : 0;
> +	while (start < end1 && start < end2 &&
> +		ce_compare(cache1[start], cache2[start]))
> +		start ++;
> +
> +	while (end1 > start && end2 > start &&
> +		ce_compare(cache1[end1], cache2[end2])) {
> +		end1 --;
> +		end2 --;
> +	}

Style.  Drop excess SP before post-increment and -decrement.

> +	/*
> +	 * everything in start..end1 and start..end2 must
> +	 * be prefixed by get_index_prefix()
> +	 */
> +	if (start < end1 &&
> +		(prefixcmp(cache1[start]->name, index_prefix) ||
> +		prefixcmp(cache1[end1]->name, index_prefix)))
> +		return 1;

It is conventional to return negative or 0 for a function that checks "=
is
this kosher".  Returning 0/1 risks getting misunderstood that this retu=
rns
ok for 1 and bad for 0.
