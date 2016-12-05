Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F10281FBB0
	for <e@80x24.org>; Mon,  5 Dec 2016 23:37:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752099AbcLEXhS convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Mon, 5 Dec 2016 18:37:18 -0500
Received: from mxo1.dft.dmz.twosigma.com ([208.77.212.183]:35502 "EHLO
        mxo1.dft.dmz.twosigma.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751981AbcLEXhQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Dec 2016 18:37:16 -0500
Received: from localhost (localhost [127.0.0.1])
        by mxo1.dft.dmz.twosigma.com (Postfix) with ESMTP id E7F81100043;
        Mon,  5 Dec 2016 23:37:14 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at twosigma.com
Received: from mxo1.dft.dmz.twosigma.com ([127.0.0.1])
        by localhost (mxo1.dft.dmz.twosigma.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id WRP0Mx0FPsUH; Mon,  5 Dec 2016 23:37:14 +0000 (GMT)
Received: from exmbdft7.ad.twosigma.com (msx.twosigma.com [172.22.2.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxo1.dft.dmz.twosigma.com (Postfix) with ESMTPS id D64F980035;
        Mon,  5 Dec 2016 23:37:14 +0000 (GMT)
Received: from exmbdft7.ad.twosigma.com (172.22.2.43) by
 exmbdft7.ad.twosigma.com (172.22.2.43) with Microsoft SMTP Server (TLS) id
 15.0.1156.6; Mon, 5 Dec 2016 23:37:14 +0000
Received: from exmbdft7.ad.twosigma.com ([fe80::552e:5f62:35e9:7955]) by
 exmbdft7.ad.twosigma.com ([fe80::552e:5f62:35e9:7955%25]) with mapi id
 15.00.1156.000; Mon, 5 Dec 2016 23:37:14 +0000
From:   David Turner <David.Turner@twosigma.com>
To:     'Stefan Beller' <sbeller@google.com>,
        "bmwill@google.com" <bmwill@google.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "sandals@crustytoothpaste.net" <sandals@crustytoothpaste.net>,
        "hvoigt@hvoigt.net" <hvoigt@hvoigt.net>,
        "gitster@pobox.com" <gitster@pobox.com>
Subject: RE: [RFC PATCHv2 09/17] update submodules: add scheduling to update
 submodules
Thread-Topic: [RFC PATCHv2 09/17] update submodules: add scheduling to update
 submodules
Thread-Index: AQHSTPx9X0XqxOxWvkGE8tJox6gtJKD5/IKg
Date:   Mon, 5 Dec 2016 23:37:14 +0000
Message-ID: <f19844d15ab4424b8c056cd13837d233@exmbdft7.ad.twosigma.com>
References: <20161203003022.29797-1-sbeller@google.com>
 <20161203003022.29797-10-sbeller@google.com>
In-Reply-To: <20161203003022.29797-10-sbeller@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [172.20.60.10]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch confuses me -- see below.

> -----Original Message-----
> From: Stefan Beller [mailto:sbeller@google.com]
> Sent: Friday, December 02, 2016 7:30 PM
> To: bmwill@google.com; David Turner
> Cc: git@vger.kernel.org; sandals@crustytoothpaste.net; hvoigt@hvoigt.net;
> gitster@pobox.com; Stefan Beller
> Subject: [RFC PATCHv2 09/17] update submodules: add scheduling to update
> submodules
[snip] 
> +static int update_submodule(const char *path, const struct object_id
> *oid,
> +			    int force, int is_new)
> +{
> +	const char *git_dir;
> +	struct child_process cp = CHILD_PROCESS_INIT;
> +	const struct submodule *sub = submodule_from_path(null_sha1, path);
> +
> +	if (!sub || !sub->name)
> +		return -1;
> +
> +	git_dir = resolve_gitdir(git_common_path("modules/%s", sub->name));
> +
> +	if (!git_dir)
> +		return -1;
> +
> +	if (is_new)
> +		connect_work_tree_and_git_dir(path, git_dir);
> +
> +	/* update index via `read-tree --reset sha1` */
> +	argv_array_pushl(&cp.args, "read-tree",
> +				   force ? "--reset" : "-m",
> +				   "-u", sha1_to_hex(oid->hash), NULL);
> +	prepare_submodule_repo_env(&cp.env_array);
> +	cp.git_cmd = 1;
> +	cp.no_stdin = 1;
> +	cp.dir = path;
> +	if (run_command(&cp)) {
> +		warning(_("reading the index in submodule '%s' failed"),
> path);

The error is not (usually) in "reading the index" -- it's "updating the index" (or the working tree)

> +		child_process_clear(&cp);
> +		return -1;
> +	}
> +
> +	/* write index to working dir */
> +	child_process_clear(&cp);
> +	child_process_init(&cp);
> +	argv_array_pushl(&cp.args, "checkout-index", "-a", NULL);

I'm confused -- doesn't read-tree -u already do this?  And if not, shouldn't we back out the result of the read-tree, to leave the submodule as it was?

> +	cp.git_cmd = 1;
> +	cp.no_stdin = 1;
> +	cp.dir = path;
> +	if (force)
> +		argv_array_push(&cp.args, "-f");
> +
> +	if (run_command(&cp)) {
> +		warning(_("populating the working directory in submodule '%s'
> failed"), path);
> +		child_process_clear(&cp);
> +		return -1;
> +	}
> +
> +	/* get the HEAD right */
> +	child_process_clear(&cp);
> +	child_process_init(&cp);
> +	argv_array_pushl(&cp.args, "checkout", "--recurse-submodules",
> NULL);


Why are we running checkout on the submodule when we've already done most of the checkout? The only thing left is to set HEAD and recurse, right?  I must be missing something.

