Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CF87C433F5
	for <git@archiver.kernel.org>; Thu, 12 May 2022 15:09:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352937AbiELPJI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 May 2022 11:09:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346249AbiELPJH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 May 2022 11:09:07 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECF8A230225
        for <git@vger.kernel.org>; Thu, 12 May 2022 08:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1652368129;
        bh=NgNAKDX6mVyZSdXxLm4p7ZfvZwayBqxtTAt02415VhE=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=SX8vBEClvP+oF7B28Utl3E2CMrLFWZ8/fKOQl867twVYh5mJ/YsdGnHazwPr/0Rua
         Xs59Jj3SWGN5jXUChccdSHroqZhQTe/8T3JPOf2V66DvKruJfQv41IUUuNSZdCDN9S
         PqujdrveUOD8MX50zshBpmn3CKUxux5JCqgvHCrI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.18.242.215] ([213.196.213.50]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M4axg-1nocT92Bao-001k3s; Thu, 12
 May 2022 17:08:49 +0200
Date:   Thu, 12 May 2022 17:08:48 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Torsten B??gershausen <tboegi@web.de>,
        rsbecker@nexbridge.com, Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v6 20/28] fsmonitor: optimize processing of directory
 events
In-Reply-To: <48af0813deccab924d3591b4df025b17bf309260.1650662994.git.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2205121708400.352@tvgsbejvaqbjf.bet>
References: <pull.1143.v5.git.1650487398.gitgitgadget@gmail.com>        <pull.1143.v6.git.1650662994.gitgitgadget@gmail.com> <48af0813deccab924d3591b4df025b17bf309260.1650662994.git.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:t7RhOHIoqSTkUWejvlOLIrAjA8jtQvOqFgHFKnnU5MSHVjnAp2e
 3/lQi7i1zx3M3NUatQUIy0vDfjd6qz61s8KM5ANOjZ3uzxb6quWN4m6dejjNLSz5hiIPQFs
 F3pU++CdUdqXqrB+Tu7D1h72b76C21+vh/q9uLbQvKw5DQrNN88HjS6Mgi3rhI1NiZ5dgm2
 nYC7jruT1P1qa4QhnMOBQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:NTnYnnc05Oc=:gMcgq0l9mcy7jnJXKPhC1d
 nrnLXAXvpvdD9Q6BfubiG6djuMEIb1P+wv62zM55XpMhzlgKboyGqzxuF1G+K9yPlJnXNRlwO
 Psvyt7dMbnahqIWhuusjUUArY80MvbUNlpL3bK9FuEpylATTYXa51PFVB2zZz6DRUQz8nfdsD
 IWCNe2hudE2DG50TGwBALNeOPO7S04E9i7gt1B/6jOi82HzvqHpv10cNe+uvgWwFcFUJaCE67
 vDfRELN4Kpya0/uIITcUecAxAJzxXW723k9F8npYfscR5J98bJnK578SSDXHKz6SRxrDPJqy+
 rc9eSfamHBVK15JFzfDYcAZugf+NYF/a8m9Src46i3RaGlT5hQjssIkCQnxx/2V6715d2Svps
 VlMv0CR9bJMmbk8eMgapC13AEC38+VwlP/rY3yvZDX96z0TpcL3Tv8S7HvPOagrJpoutoVqm/
 8yqM/jsp7aSM9FXP5hjTzJyyjEiOZZevv8oMGDkVS9XAuPNE0K6E3DGT48NwMVIVlpzBAkcVj
 1JkM2DV81eCCWR0Yr9KocaedKZaMvpLQoBIpftENRO6BwGLQtuiISfVKeZs6cmAOguZ+5D8o1
 22iJeMHzlsUe961E2OgkK7AtS/LowiVPBOKsnw/ovIdl1y0RW1ZB7mWe/iU8rXAFme6ypAfWv
 tvsWVjJDE1FK6rRjTqhg8OIOhr4WyUv2Qwmn237MxDhbZ78C7cETAD1VNn5hydxYueRtahtXW
 yq8A9+zNzMrx9lj4Ps/wx6Io4+R4yMwGAXUxiPaCuc0JONHKyPUKRgviz7rnSQl8Ng5nW9Vfr
 DFKVRA+et4g/dy54Kn2b7KgfAuC2ffNZUnpmQ55Cb/zUVSk7FypzWf5XryoeMwMThH2vVYFPh
 bH9YMP5aMyIy2szc04AcIdnMHGqtca+CmVK8cml+R5GspRBtluNzrcazRU3+xzlW3ntjmh9K+
 3hgjwvkFmuBotpsH9aSGYPxStuKbi8LxnmdGnlEpCscJkoDeIaB2Lj9xoFTdlrEJzkJFsbIl/
 FKReLHEia8OUJVrQtFPrAMAps+cu5WILEeNmszpvXP8N+ackj59m0ga+qBddXZQzLQqJZVWO8
 i+kofRR4ICEXlCCzzzB7ce7Ej2o/HvLkFWPEIA9MUnST+EtnoJiqFttrQ==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jeff,

On Fri, 22 Apr 2022, Jeff Hostetler via GitGitGadget wrote:

> From: Jeff Hostetler <jeffhost@microsoft.com>
>
> Teach Git to perform binary search over the cache-entries for a director=
y
> notification and then linearly scan forward to find the immediate childr=
en.
>
> Previously, when the FSMonitor reported a modified directory Git would
> perform a linear search on the entire cache-entry array for all
> entries matching that directory prefix and invalidate them.  Since the
> cache-entry array is already sorted, we can use a binary search to
> find the first matching entry and then only linearly walk forward and
> invalidate entries until the prefix changes.
>
> Also, the original code would invalidate anything having the same
> directory prefix.  Since a directory event should only be received for
> items that are immediately within the directory (and not within
> sub-directories of it), only invalidate those entries and not the
> whole subtree.
>
> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
> ---
>  fsmonitor.c | 71 ++++++++++++++++++++++++++++++++++++++++-------------
>  1 file changed, 54 insertions(+), 17 deletions(-)
>
> diff --git a/fsmonitor.c b/fsmonitor.c
> index 292a6742b4f..e1229c289cf 100644
> --- a/fsmonitor.c
> +++ b/fsmonitor.c
> @@ -184,30 +184,68 @@ static int query_fsmonitor_hook(struct repository =
*r,
>  static void fsmonitor_refresh_callback(struct index_state *istate, char=
 *name)
>  {
>  	int i, len =3D strlen(name);
> -	if (name[len - 1] =3D=3D '/') {
> +	int pos =3D index_name_pos(istate, name, len);
> +
> +	trace_printf_key(&trace_fsmonitor,
> +			 "fsmonitor_refresh_callback '%s' (pos %d)",
> +			 name, pos);
>
> +	if (name[len - 1] =3D=3D '/') {
>  		/*
> -		 * TODO We should binary search to find the first path with
> -		 * TODO this directory prefix.  Then linearly update entries
> -		 * TODO while the prefix matches.  Taking care to search without
> -		 * TODO the trailing slash -- because '/' sorts after a few
> -		 * TODO interesting special chars, like '.' and ' '.
> +		 * The daemon can decorate directory events, such as
> +		 * moves or renames, with a trailing slash if the OS
> +		 * FS Event contains sufficient information, such as
> +		 * MacOS.
> +		 *
> +		 * Use this to invalidate the entire cone under that
> +		 * directory.
> +		 *
> +		 * We do not expect an exact match because the index
> +		 * does not normally contain directory entries, so we
> +		 * start at the insertion point and scan.
>  		 */
> +		if (pos < 0)
> +			pos =3D -pos - 1;
>
>  		/* Mark all entries for the folder invalid */
> -		for (i =3D 0; i < istate->cache_nr; i++) {
> -			if (istate->cache[i]->ce_flags & CE_FSMONITOR_VALID &&
> -			    starts_with(istate->cache[i]->name, name))
> -				istate->cache[i]->ce_flags &=3D ~CE_FSMONITOR_VALID;
> +		for (i =3D pos; i < istate->cache_nr; i++) {
> +			if (!starts_with(istate->cache[i]->name, name))
> +				break;
> +			istate->cache[i]->ce_flags &=3D ~CE_FSMONITOR_VALID;
>  		}
> -		/* Need to remove the / from the path for the untracked cache */
> +
> +		/*
> +		 * We need to remove the traling "/" from the path
> +		 * for the untracked cache.
> +		 */
>  		name[len - 1] =3D '\0';
> +	} else if (pos >=3D 0) {
> +		/*
> +		 * We have an exact match for this path and can just
> +		 * invalidate it.
> +		 */
> +		istate->cache[pos]->ce_flags &=3D ~CE_FSMONITOR_VALID;
>  	} else {
> -		int pos =3D index_name_pos(istate, name, strlen(name));
> -
> -		if (pos >=3D 0) {
> -			struct cache_entry *ce =3D istate->cache[pos];
> -			ce->ce_flags &=3D ~CE_FSMONITOR_VALID;
> +		/*
> +		 * The path is not a tracked file -or- it is a
> +		 * directory event on a platform that cannot
> +		 * distinguish between file and directory events in
> +		 * the event handler, such as Windows.
> +		 *
> +		 * Scan as if it is a directory and invalidate the
> +		 * cone under it.  (But remember to ignore items
> +		 * between "name" and "name/", such as "name-" and
> +		 * "name.".
> +		 */
> +		pos =3D -pos - 1;
> +
> +		for (i =3D pos; i < istate->cache_nr; i++) {
> +			if (!starts_with(istate->cache[i]->name, name))
> +				break;
> +			if ((unsigned char)istate->cache[i]->name[len] > '/')

Nice attention to detail casting `istate->cache[i]->name[len]` to
`(unsigned char)` before comparing to '/'!

> +				break;
> +			if (istate->cache[i]->name[len] =3D=3D '/')
> +				istate->cache[i]->ce_flags &=3D ~CE_FSMONITOR_VALID;
>  		}
>  	}
>
> @@ -215,7 +253,6 @@ static void fsmonitor_refresh_callback(struct index_=
state *istate, char *name)
>  	 * Mark the untracked cache dirty even if it wasn't found in the index
>  	 * as it could be a new untracked file.
>  	 */
> -	trace_printf_key(&trace_fsmonitor, "fsmonitor_refresh_callback '%s'", =
name);

Did you mean to remove this statement in this patch? Not a big issue, but
I wonder what the rationale for it is, and since I have an inquisitive
mind, I figured I'd just ask.

Thanks,
Dscho

>  	untracked_cache_invalidate_path(istate, name, 0);
>  }
>
> --
> gitgitgadget
>
>
