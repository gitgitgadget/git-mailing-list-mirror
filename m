Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1DB4B1F404
	for <e@80x24.org>; Sat, 17 Mar 2018 13:01:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752482AbeCQNBd (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Mar 2018 09:01:33 -0400
Received: from smtp51.i.mail.ru ([94.100.177.111]:59370 "EHLO smtp51.i.mail.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752114AbeCQNBd (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Mar 2018 09:01:33 -0400
X-Greylist: delayed 81090 seconds by postgrey-1.27 at vger.kernel.org; Sat, 17 Mar 2018 09:01:32 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bswap.ru; s=mailru;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=B9j4mPEyduSoYOa+ILfiHary9Q9bni9SmIZuV2OQohU=;
        b=bbWK7LsYDnBKkzXHFOvPp501NvhDPZ4+MpGtbXm4XUtaKpRWexWKH/vEygPWxoO0B73SE+LmoRGDS81iKAWlt7Z51xOBm63JKDhQflTsklMKkkgvkuXHVeRDeczGhwP3KNIfiV7tmV4kDS6oIHwb6QqOmuLgg8Ab7QXjC7uTkFw=;
Received: by smtp51.i.mail.ru with esmtpa (envelope-from <kostix@bswap.ru>)
        id 1exBSk-0004EH-2Z; Sat, 17 Mar 2018 16:01:30 +0300
Date:   Sat, 17 Mar 2018 16:01:28 +0300
From:   Konstantin Khomoutov <kostix@bswap.ru>
To:     Michal Novotny <clime@redhat.com>
Cc:     git@vger.kernel.org
Subject: Re: get commit ID from a tree object ID
Message-ID: <20180317130128.mr2sfsrncykkubwo@tigra>
References: <CANT8FXR3pMgbwVWmwssDYhgv6eMFw4+Uz5xARGwFVVU1cMVmWw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANT8FXR3pMgbwVWmwssDYhgv6eMFw4+Uz5xARGwFVVU1cMVmWw@mail.gmail.com>
User-Agent: NeoMutt/20170306 (1.8.0)
Authentication-Results: smtp51.i.mail.ru; auth=pass smtp.auth=kostix@bswap.ru smtp.mailfrom=kostix@bswap.ru
X-7FA49CB5: 0D63561A33F958A54725F980E20D240F4A2ACDAD2A425DF1AE14F745316A64C3725E5C173C3A84C36DD0439D4B94EFE552AF71BC7C1132E56D8C47C27EEC5E9FB5C8C57E37DE458B4C7702A67D5C3316FA3894348FB808DB48C21F01D89DB561574AF45C6390F7469DAA53EE0834AAEE
X-Mailru-Sender: 3EA917A0E6524472E50B252446CEFEA42636CBAB2BF6EBBCA2AE3C8AB7F5D2911B299102C875D7EEFD27B1545737DED76F53C80213D1719CB3360D9C94DE366A1CC4A9B39F20364B73395D515EC5B64AAE208404248635DF
X-Mras: OK
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 17, 2018 at 01:17:12PM +0100, Michal Novotny wrote:

> let's say I have made an annotated tag on a certain treeish:
> 
> $ git tag -a -m msg tagname HEAD:
> 
> Now, I can try to see the content of the tag:
> 
> $ git tag -v tagname
> object 42a1c36553a50ceae2f75ffc4b1446c6c393eae7
> type tree
> tag tagname
> tagger clime <clime@redhat.com> 1521288727 +0100
> 
> msg
> error: no signature found
> 
> 
> Can I use that object ID 42a1c36553a50ceae2f75ffc4b1446c6c393eae7 to
> get back to a particular commit from which the tag was created? The
> reason is that I would eventually like to checkout that commit.

In general, you can't, and that's because there can be any number of
commits referencing that tree. A typical case is a tree object
representing a subdirectory of your project which changes rarily, if
ever - in this case, each commit which includes the same state of this
subdirectory will refer the same tree object.

Another point to consider is that the commit itself only refers to a
single tree object -- that one which records the state of the top-level
project directory, and it usually refers to other three objects which
may, in turn, refer to others and so on - all the way down.

So actually a generic approach to what you need is a full scan of all
the commits in the repository with recursive traversing of the hierarchy
of trees of each of them (via `git ls-tree`) and looking for the SHA-1
name of the reference tree object.  As you can see, this is not going to
be fast on repos of realistic size.

