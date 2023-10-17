Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8682E8475
	for <git@vger.kernel.org>; Tue, 17 Oct 2023 17:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="l4eobPxY"
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2309100
	for <git@vger.kernel.org>; Tue, 17 Oct 2023 10:03:03 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 750C0372B3;
	Tue, 17 Oct 2023 13:03:03 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=f/dHodIp+Dh5GK/Lp7oJmoq7qulFoWFdDlQk+K
	qbeTk=; b=l4eobPxYGXBIE2it16UYkDgOTuyu8HMR9/INbbgV8SLZIr/C+gK+Xv
	MHPnOudFDaaEdghEy4nkk84ysk695bS5S06fUB8SO4Vc2M81hkern6mmU/PO/wj0
	l9A733EHCLSRKyyxZW+LnjiQT6xDueOUED9ihZJpMaSzEy2I9Fm1s=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 6C55B372B2;
	Tue, 17 Oct 2023 13:03:03 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 4517C372AF;
	Tue, 17 Oct 2023 13:02:59 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jason Hatton <jhatton@globalfinishing.com>
Cc: Jeff King <peff@peff.net>,  "brian m. carlson"
 <sandals@crustytoothpaste.net>,  "git@vger.kernel.org"
 <git@vger.kernel.org>,  Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2 2/2] Prevent git from rehashing 4GiB files
In-Reply-To: <MW5PR16MB50791EDD3D006EFBE8DBBCB3AFD6A@MW5PR16MB5079.namprd16.prod.outlook.com>
	(Jason Hatton's message of "Tue, 17 Oct 2023 14:49:09 +0000")
References: <20231012160930.330618-1-sandals@crustytoothpaste.net>
	<20231012160930.330618-3-sandals@crustytoothpaste.net>
	<20231017000019.GB551672@coredump.intra.peff.net>
	<MW5PR16MB50791EDD3D006EFBE8DBBCB3AFD6A@MW5PR16MB5079.namprd16.prod.outlook.com>
Date: Tue, 17 Oct 2023 10:02:57 -0700
Message-ID: <xmqqedhtji66.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 06517864-6D0F-11EE-A7FF-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Jason Hatton <jhatton@globalfinishing.com> writes:

> We could probably write the below to do the same thing.
>
> void fill_stat_data(struct stat_data *sd, struct stat *st)
> {
>       sd->sd_ctime.sec = (unsigned int)st->st_ctime;
>       sd->sd_mtime.sec = (unsigned int)st->st_mtime;
>       sd->sd_ctime.nsec = ST_CTIME_NSEC(*st);
>       sd->sd_mtime.nsec = ST_MTIME_NSEC(*st);
>       sd->sd_dev = st->st_dev;
>       sd->sd_ino = st->st_ino;
>       sd->sd_uid = st->st_uid;
>       sd->sd_gid = st->st_gid;
>       sd->sd_size = st->st_size;
> +      if (sd->sd_size == 0 && st->st_size!= 0) {
> +            sd->sd_size = 1;
> +      }
> }

The above is a fairly straight-forward inlining (except that it does
explicit comparisons with zero) of the helper function the version
of patch under discussion added, and uses 1 instead of (1<<31) as an
arbigrary nonzero number that can be used to work around the issue.

So I agree with you that it would do the same thing.  I am not
surprised if it also gets scolded by Coverity the same way, though.
