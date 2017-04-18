Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C0491FA26
	for <e@80x24.org>; Tue, 18 Apr 2017 01:19:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755551AbdDRBTK (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Apr 2017 21:19:10 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55765 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753742AbdDRBTJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Apr 2017 21:19:09 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CB17274707;
        Mon, 17 Apr 2017 21:19:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=/SX/jXzVqn7B
        NrvudVnB47UGTOM=; b=HoN2g2qiHHc0KjJV9d7floK8IQaym2YCoJV0kIhoRbIr
        fzYKK1Sy3MY06VQyOUkH8GCJDIf0lC/VLXsdQDPmQlBSBA4Tszn/MR4+WV9b3fxi
        rrOaKCbfn61M760skXHIt1grO2SCPjtZWh5UisaTfq5BMg3kljg0Xg1e1ooARYs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=kpCjU+
        +JYQrAxJrryJ2u+UxCHJFXYfs40caW8xuLCzoBveZgbJehBHXtUVlEzg29yDRmcz
        TYelY3XbEM7Yt0gG/y8k3551ElRLRyVxBcLbJ2ShYQcoDhEziL7wqQtHI+TfJuF/
        d9xnKIMlQCeny/qCadeHM8R1iJ8KvqLffz0P4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C3CD774706;
        Mon, 17 Apr 2017 21:19:07 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3907274705;
        Mon, 17 Apr 2017 21:19:07 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     David Turner <dturner@twosigma.com>
Cc:     git@vger.kernel.org, peff@peff.net, l.s.r@web.de,
        jrnieder@gmail.com
Subject: Re: [PATCH v2] xgethostname: handle long hostnames
References: <20170417161748.31231-1-dturner@twosigma.com>
Date:   Mon, 17 Apr 2017 18:19:06 -0700
In-Reply-To: <20170417161748.31231-1-dturner@twosigma.com> (David Turner's
        message of "Mon, 17 Apr 2017 12:17:48 -0400")
Message-ID: <xmqq1ssqikc5.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 04BB4BAE-23D5-11E7-8D78-C260AE2156B6-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

David Turner <dturner@twosigma.com> writes:

> @@ -250,14 +250,14 @@ static const char *lock_repo_for_gc(int force, pi=
d_t* ret_pid)
> ...
>  	if (!force) {
> -		static char locking_host[128];
> +		static char locking_host[HOST_NAME_MAX + 1];
>  		int should_exit;
>  		fp =3D fopen(pidfile_path, "r");
>  		memset(locking_host, 0, sizeof(locking_host));

I compared the result of applying this v2 directly on top of master
and applying Ren=C3=A9's "Use HOST_NAME_MAX"and then applying your v1. =20
This hunk is the only difference.

As this locking_host is used like so in the later part of the code:

 			time(NULL) - st.st_mtime <=3D 12 * 3600 &&
 			fscanf(fp, "%"SCNuMAX" %127c", &pid, locking_host) =3D=3D 2 &&
 			/* be gentle to concurrent "gc" on remote hosts */
 			(strcmp(locking_host, my_host) || !kill(pid, 0) || errno =3D=3D EPERM=
);

I suspect that turning it to HOST_NAME_MAX + 1 without tweaking
the format "%127c" gives us an inconsistent resulting code.

Of course, my_host is sized to HOST_NAME_MAX + 1 and we are
comparing it with locking_host, so perhaps we'd need to take this
version to size locking_host to also HOST_NAME_MAX + 1, and then
scan with %255c (but then shouldn't we scan with %256c instead?  I
am not sure where these +1 comes from).
