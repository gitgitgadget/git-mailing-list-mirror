Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 785E31F461
	for <e@80x24.org>; Tue, 27 Aug 2019 22:31:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726232AbfH0Wbl (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Aug 2019 18:31:41 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:62621 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbfH0Wbl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Aug 2019 18:31:41 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id F210E80FEC;
        Tue, 27 Aug 2019 18:31:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=qHD9flif5wsjQiVxyx1aDzzvVio=; b=x71uya
        auWPCOc3j+7hR/GJFgkvtEvQrzJN7dmL7x5yPcJV14jZ9/4cIDK+w/YUZi1deyiA
        E5EX3GR5jcHwWx9h0bAM4TZsaL3Of/r+fncEYDiWjaa0eXEAsrGQqhHhJs4hx4Mt
        yVwJ4MQ4uVW1Ay8amVh8O+RJHA76CrB3PAoMA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=qqVtwQzTo2Iufd9cQaF96DhTFOYW3iW8
        PSoUis4LWwyUgyCIi6OfR6zjIGmpjifEb399dnu1QAPDlP3k1u24uLzX1s+LnulR
        ZVzaBNRf2Z5oVfmP/Z9jfgGnNfV4AtWQ1eI0Y1CbjFH41O7d7cLspKFaGCAtTWDs
        6m+gcfX5gKY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E9B8E80FEB;
        Tue, 27 Aug 2019 18:31:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 2114F80FEA;
        Tue, 27 Aug 2019 18:31:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Andrey Mazo <ahippo@yandex.ru>
Cc:     "Philip.McGraw" <Philip.McGraw@bentley.com>,
        Luke Diamand <luke@diamand.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Andrey Mazo <ahippo@yandex.com>, git@vger.kernel.org,
        gitgitgadget@gmail.com
Subject: Re: [PATCH v2 1/1] git-p4: auto-delete named temporary file
References: <pull.303.v2.git.gitgitgadget@gmail.com>
        <7e59b5cec2f267820feeeeb63a20814fe67d61e3.1566876175.git.ahippo@yandex.com>
Date:   Tue, 27 Aug 2019 15:31:33 -0700
In-Reply-To: <7e59b5cec2f267820feeeeb63a20814fe67d61e3.1566876175.git.ahippo@yandex.com>
        (Andrey Mazo's message of "Tue, 27 Aug 2019 06:43:58 +0300")
Message-ID: <xmqq1rx62qbe.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6DE4488C-C91A-11E9-8747-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Andrey Mazo <ahippo@yandex.ru> writes:

> From: "Philip.McGraw" <Philip.McGraw@bentley.com>
>
> Avoid double-open exceptions on Windows platform when
> calculating for lfs compressed size threshold
> (git-p4.largeFileCompressedThreshold) comparisons.
>
> Take new approach using the NamedTemporaryFile()
> file-like object as input to the ZipFile() which
> auto-deletes after implicit close leaving with scope.
>
> Original code had double-open exception on Windows
> platform because file still open from NamedTemporaryFile()
> using generated filename instead of object.
>
> Thanks to Andrey for patiently suggesting several
> iterations on this change for avoiding exceptions!
>
> Also print error details after resulting IOError to make
> debugging cause of exception less mysterious when it has
> nothing to do with "git version recent enough."
>
> Signed-off-by: Philip.McGraw <Philip.McGraw@bentley.com>
> Reviewed-by: Andrey Mazo <ahippo@yandex.com>
> ---

Luke, does this look good?

I know Mazo is the only other contributor who has multiple commits
to git-p4.py in the past 2 years, to make Reviewed-by carry some
weight ;-) but as we have so small number of people touching this
script anyway, I'd rather see what the main contributor in the past
2 years thinks.

Thanks.

>  git-p4.py | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
>
> diff --git a/git-p4.py b/git-p4.py
> index c71a6832e2..33bdb14fd1 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -1158,17 +1158,15 @@ def exceedsLargeFileThreshold(self, relPath, contents):
>          if gitConfigInt('git-p4.largeFileCompressedThreshold'):
>              contentsSize = sum(len(d) for d in contents)
>              if contentsSize <= gitConfigInt('git-p4.largeFileCompressedThreshold'):
>                  return False
>              contentTempFile = self.generateTempFile(contents)
> -            compressedContentFile = tempfile.NamedTemporaryFile(prefix='git-p4-large-file', delete=False)
> -            zf = zipfile.ZipFile(compressedContentFile.name, mode='w')
> -            zf.write(contentTempFile, compress_type=zipfile.ZIP_DEFLATED)
> -            zf.close()
> -            compressedContentsSize = zf.infolist()[0].compress_size
> +            compressedContentFile = tempfile.NamedTemporaryFile(prefix='git-p4-large-file', delete=True)
> +            with zipfile.ZipFile(compressedContentFile, mode='w') as zf:
> +                zf.write(contentTempFile, compress_type=zipfile.ZIP_DEFLATED)
> +                compressedContentsSize = zf.infolist()[0].compress_size
>              os.remove(contentTempFile)
> -            os.remove(compressedContentFile.name)
>              if compressedContentsSize > gitConfigInt('git-p4.largeFileCompressedThreshold'):
>                  return True
>          return False
>  
>      def addLargeFile(self, relPath):
> @@ -3512,12 +3510,13 @@ def importHeadRevision(self, revision):
>          details["time"] = res["time"]
>  
>          self.updateOptionDict(details)
>          try:
>              self.commit(details, self.extractFilesFromCommit(details), self.branch)
> -        except IOError:
> +        except IOError as err:
>              print("IO error with git fast-import. Is your git version recent enough?")
> +            print("IO error details: {}".format(err))
>              print(self.gitError.read())
>  
>      def openStreams(self):
>          self.importProcess = subprocess.Popen(["git", "fast-import"],
>                                                stdin=subprocess.PIPE,
>
> base-commit: 1feeaaf26bff51996f9f96c6dc41ca0f95ab5fc4
> Pull-Request: https://github.com/gitgitgadget/git/pull/303
