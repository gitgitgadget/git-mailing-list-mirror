Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2FE551F453
	for <e@80x24.org>; Fri, 18 Jan 2019 01:41:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbfARBlO (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Jan 2019 20:41:14 -0500
Received: from avasout04.plus.net ([212.159.14.19]:57021 "EHLO
        avasout04.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbfARBlN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jan 2019 20:41:13 -0500
Received: from [10.0.2.15] ([146.198.133.33])
        by smtp with ESMTPA
        id kJ9igIUN1AOoykJ9jg96tN; Fri, 18 Jan 2019 01:41:12 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=Rdm+9Wlv c=1 sm=1 tr=0
 a=VCDsReDbrwk4B7AcQzWGLw==:117 a=VCDsReDbrwk4B7AcQzWGLw==:17
 a=IkcTkHD0fZMA:10 a=G_CDLfixEHop0cp0fw4A:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH/RFC] fsck: complain when .gitignore and .gitattributes are
 symlinks
To:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <20190114230902.GG162110@google.com>
 <20190117170005.GA27667@sigill.intra.peff.net>
 <xmqq1s5bniuf.fsf@gitster-ct.c.googlers.com>
 <20190117212448.GA13100@sigill.intra.peff.net>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <a0aef5a7-eb69-8dd8-abb7-4db6d1de4a26@ramsayjones.plus.com>
Date:   Fri, 18 Jan 2019 01:41:08 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190117212448.GA13100@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfMudNJWUiTiF818Y4eSnoWN3ofvNO+QHV61MlPn+vYqnEOLaFRseWJHVxY1ybHsx+LBsZXL/xPQNOPBPPRBGaVPATsER6RJnuEpLsB39V2vJQBlwTTxD
 disYGZmH5SrMUGvVT35OtxPy9b8pv5QtJP3yML0JHdEjZlO4DeE9V1Ua
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 17/01/2019 21:24, Jeff King wrote:
> On Thu, Jan 17, 2019 at 12:13:12PM -0800, Junio C Hamano wrote:
> 
>>> @@ -966,7 +968,9 @@ int verify_path(const char *path, unsigned mode)
>>>  				if (is_hfs_dotgit(path))
>>>  					return 0;
>>>  				if (S_ISLNK(mode)) {
>>> -					if (is_hfs_dotgitmodules(path))
>>> +					if (is_hfs_dotgitmodules(path) ||
>>> +					    is_hfs_dotgitignore(path) ||
>>> +					    is_hfs_dotgitattributes(path))
>>>  						return 0;
>>>  				}
>>>  			}
>>> @@ -974,7 +978,9 @@ int verify_path(const char *path, unsigned mode)
>>>  				if (is_ntfs_dotgit(path))
>>>  					return 0;
>>>  				if (S_ISLNK(mode)) {
>>> -					if (is_ntfs_dotgitmodules(path))
>>> +					if (is_ntfs_dotgitmodules(path) ||
>>> +					    is_ntfs_dotgitignore(path) ||
>>> +					    is_ntfs_dotgitattributes(path))
>>>  						return 0;
>>
>> Curious that we already have these helpers, nobody seems to call
>> them in the current codebase, and we haven't seen the "these are
>> unused" linter message on the list for a while ;-).
> 
> Heh. Yeah, I was surprised by that, too. They were added by e7cb0b4455
> (is_ntfs_dotgit: match other .git files, 2018-05-11). The original
> version of my series had the hunks quoted above, and then we backed off
> on handling them as part of the emergency fix, but I never re-rolled the
> preparatory patch to get rid of them.
> 
> I think they got overlooked because they're not file-local statics, and
> it's much harder to say "this is never called by any function in another
> translation unit". You probably have to do analysis on the complete
> binaries using "nm" or similar. I think maybe Ramsay does that from time
> to time, but I don't offhand know the correct incantation.

I don't do this "from time to time", but *every* build on all
platforms! :-D

As I have mentioned before, I run the script on 'master', 'next'
and 'pu', but I don't look at the results for 'master', I simply
look at the diffs master->next and next->pu.

I put the output of 'static-check.pl' in the sc, nsc and psc files
(guess which files are for which branches!). For example, tonight
I find:

    $ wc -l sc nsc psc
      90 sc
      90 nsc
     100 psc
     280 total
    $ diff sc nsc
    $ diff nsc psc
    29a30,32
    > config.o	- repo_config_set
    > config.o	- repo_config_set_gently
    > config.o	- repo_config_set_worktree_gently
    32a36
    > fuzz-commit-graph.o	- LLVMFuzzerTestOneInput
    37a42,43
    > hex.o	- hash_to_hex
    > hex.o	- hash_to_hex_algop_r
    74a81,83
    > sha1-file.o	- hash_algo_by_id
    > sha1-file.o	- hash_algo_by_name
    > sha1-file.o	- repo_has_sha1_file_with_flags
    80a90
    > strbuf.o	- strbuf_vinsertf
    $ 

BTW, if my memory serves (and it may not), the symbols you
refer to came directly into 'master' (via 'maint') as a
result of security updates - so I would never have seen
them in 'pu' or 'next'. They are, indeed, currently noted
in the 'master' branch:

    $ grep is_ntfs_ sc
    path.o	- is_ntfs_dotgitattributes
    path.o	- is_ntfs_dotgitignore
    $ grep is_hfs_ sc
    utf8.o	- is_hfs_dotgitattributes
    utf8.o	- is_hfs_dotgitignore
    $ 
    
ATB,
Ramsay Jones

