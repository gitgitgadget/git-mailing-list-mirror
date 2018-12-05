Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 173C4211B3
	for <e@80x24.org>; Wed,  5 Dec 2018 14:54:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727797AbeLEOy0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Dec 2018 09:54:26 -0500
Received: from smtp62.i.mail.ru ([217.69.128.42]:35868 "EHLO smtp62.i.mail.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727025AbeLEOy0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Dec 2018 09:54:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bswap.ru; s=mailru;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=pjQA7emaXgAqYywKcP6doVguKVFZBRHsxbek4RqGX24=;
        b=LU7g9Vtr/NDuCz5RZk3uMMjOyMqYLooL7XWVIRmXiyKzL6WA/E/i3BJBPifj3tgeRRQop4j634Bq5KScr0Bey/+uSRJkse2seAvl3Mr9aAIr0Cum/yWbrtHDqBZsoXFpFzk7zu35KaLozmp2E9v2hqTiwRCN+XY/i94R3ZiU46g=;
Received: by smtp62.i.mail.ru with esmtpa (envelope-from <kostix@bswap.ru>)
        id 1gUYZD-00013Z-Kl; Wed, 05 Dec 2018 17:54:23 +0300
Date:   Wed, 5 Dec 2018 17:54:20 +0300
From:   Konstantin Khomoutov <kostix@bswap.ru>
To:     Konstantin Kharlamov <hi-angel@yandex.ru>
Cc:     git@vger.kernel.org
Subject: Re: Any way to make git-log to enumerate commits?
Message-ID: <20181205145419.vbbaghzzrnceez45@tigra>
References: <5e5c6d1c-6b3e-c94a-17be-a2af518c1607@yandex.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e5c6d1c-6b3e-c94a-17be-a2af518c1607@yandex.ru>
User-Agent: NeoMutt/20170306 (1.8.0)
Authentication-Results: smtp62.i.mail.ru; auth=pass smtp.auth=kostix@bswap.ru smtp.mailfrom=kostix@bswap.ru
X-77F55803: 3FFC80838138E3AB5A78504BD2AC294135F1F2F3833E2C93F8C28D231C312522F963E2CCF65D8DBDA82528EE0BC577CD
X-7FA49CB5: 0D63561A33F958A5A9BD4F39F39F6C2F478BC1721E8F62CDD49D23DA4F9259428941B15DA834481FA18204E546F3947CEDCF5861DED71B2F389733CBF5DBD5E9C8A9BA7A39EFB7666BA297DBC24807EA117882F44604297287769387670735209ECD01F8117BC8BEA471835C12D1D977C4224003CC8364767815B9869FA544D8D32BA5DBAC0009BE9E8FC8737B5C2249A5DF9383870C0FED3AA81AA40904B5D9CF19DD082D7633A0E7DDDDC251EA7DABD81D268191BDAD3D78DA827A17800CE767C209D01CC1E34BCD04E86FAF290E2D40A5AABA2AD3711975ECD9A6C639B01B78DA827A17800CE7093088C0DBAB4EA32C6770A8BB2BE74C75ECD9A6C639B01B4E70A05D1297E1BBC6867C52282FAC85D9B7C4F32B44FF57C2F2A386D11C4599BD9CCCA9EDD067B1EDA766A37F9254B7
X-Mailru-Sender: 3EA917A0E6524472E50B252446CEFEA451A23A74E00BBC5F85536879A24D29FB91CE35F2FE2EB445FD27B1545737DED76F53C80213D1719CB3360D9C94DE366A1CC4A9B39F20364B73395D515EC5B64AAE208404248635DF
X-Mras: OK
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 05, 2018 at 05:22:14PM +0300, Konstantin Kharlamov wrote:

> It would be great if git-log has a formatting option to insert an
> index of the current commit since HEAD.
> 
> It would allow after quitting the git-log to immediately fire up "git
> rebase -i HEAD~index" instead of "git rebase -i
> go-copy-paste-this-long-number-id".

This may have little sense in a general case as the history maintained
by Git is a graph, not a single line. Hence your prospective approach
would only work for cases like `git log` called with the
"--first-parent" command-line option.

Still, for a simple approach you may code it right away yourself.
Say, let's create an alias:

  $ git config alias.foo '!git log "$@" --pretty=oneline --source | {
      n=0;
      while read sha ref rest; do
        printf "%s\t%s~%s\t%s\n" "$sha" "$ref" $n "$rest"
		n=$((n+1))
	  done
    }'

Now calling `git foo --abbrev=commit` would output something like

9be8e297d        HEAD~7       Frobincated fizzle

where "7" is what you're looking for.

A more roubst solution may need to use the `git rev-list` command.

