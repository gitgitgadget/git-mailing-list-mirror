Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 381561F461
	for <e@80x24.org>; Thu, 22 Aug 2019 13:55:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731811AbfHVNzc (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Aug 2019 09:55:32 -0400
Received: from lb2-smtp-cloud8.xs4all.net ([194.109.24.25]:41063 "EHLO
        lb2-smtp-cloud8.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726687AbfHVNzc (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 22 Aug 2019 09:55:32 -0400
Received: from tri.shiar.net ([83.161.198.138])
        by smtp-cloud8.xs4all.net with ESMTP
        id 0nYmiiD1jDqPe0nYni1iBp; Thu, 22 Aug 2019 15:55:29 +0200
Received: by tri.shiar.net (Postfix, from userid 1000)
        id B724229735B; Thu, 22 Aug 2019 15:55:28 +0200 (CEST)
Date:   Thu, 22 Aug 2019 15:55:28 +0200
From:   Mischa POSLAWSKY <git@shiar.nl>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>
Subject: [PATCH 2/1] t6300: format missing tagger
Message-ID: <20190822135528.GB28725@shiar.net>
References: <20190817215107.13733-1-git@shiar.nl>
 <xmqqimqtxcou.fsf@gitster-ct.c.googlers.com>
 <xmqq1rxerxkk.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq1rxerxkk.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt 1.10.1 + Vim 8.1 (Debian 10.0 GNU/Linux 4.9.0-6-amd64)
X-URL:  http://shiar.nl/
X-Accept-Language: nl, eo, en
X-CMAE-Envelope: MS4wfC6WzFXU0s83JgwEIbicNnvysIjutz41PPPsfCgSjwggfjL2vMedUYyzOqMiG8gBhDDkX8YJwlgGsIfqSxHVDwbBFovPCK/Ql24jHzS/z93+okCgQtSl
 hK2ymyEoFXR9X3C91VQZHhEAVe5bIdI+q6B5HTgyd+7BHM+3bZ7XbIb06BB8vcMOZI8Nt6lcNPVkeyaRdP2FwjOENTN1oKXw9zdYhhJ9LwRrm+QkPaW7Ox0/
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Mischa POSLAWSKY <git@shiar.nl> writes:
> >
> >> If I understand correctly, such tags cannot be produced normally anymore.
> >> Therefore I'm unsure how to make tests, and if that is even warranted.
> >
> > Thanks for spotting.
> 
> A quick trial to recreate a tag object seems to succeed:
> 
>     $ git cat-file tag v0.99 |
>     > sed -e '/-----BEGIN/,$d' |
>     > git hash-object --stdin -w -t tag
>     667d141b478eee5e53d2ee05acd61bb1f640249a
>     $ git cat-file tag 667d141b47
>     object a3eb250f996bf5e12376ec88622c4ccaabf20ea8
>     type commit
>     tag v0.99
> 
>     Test-release for wider distribution.
> 
>     I'll make the first public RPM's etc, thus the tag.
> 
> So we should be able to do something along the above line.  Here is
> my quick-n-dirty one.
> 
>  t/t6300-for-each-ref.sh | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
> index ab69aa176d..b3a6b336fa 100755
> --- a/t/t6300-for-each-ref.sh
> +++ b/t/t6300-for-each-ref.sh
> @@ -869,4 +869,16 @@ test_expect_success 'for-each-ref --ignore-case ignores case' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'show a taggerless tag' '
> +	test_commit tagged &&
> +	git tag -a -m "a normal tag" to-be-shown-0 HEAD &&
> +	another=$(git cat-file tag to-be-shown-0 |
> +		sed -e "/^tagger /d" \
> +		    -e "/^tag to-be-shown/s/0/1/" \
> +		    -e "s/a normal tag/a broken tag/" |
> +		git hash-object --stdin -w -t tag) &&
> +	git tag to-be-shown-1 $another &&
> +	git for-each-ref --format="%(refname:short) %(taggername)" refs/tags/to-be-shown\*
> +'
> +
>  test_done
> 

Alright, thanks for the pointer.
Here's a batch of tests on all pertaining atoms.

-- >8 --

Strip an annotated tag of its tagger header and verify it's ignored
correctly in all cases, as fixed in commit e2a81276e8 (ref-filter:
initialize empty name or email fields, 2019-08-19).

Signed-off-by: Mischa POSLAWSKY <git@shiar.nl>
---
 t/t6300-for-each-ref.sh | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index ab69aa176d..9c910ce746 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -526,6 +526,25 @@ test_expect_success 'Check ambiguous head and tag refs II (loose)' '
 	test_cmp expected actual
 '
 
+test_expect_success 'create tag without tagger' '
+	git tag -a -m "Broken tag" taggerless &&
+	git tag -f taggerless $(git cat-file tag taggerless |
+		sed -e "/^tagger /d" |
+		git hash-object --stdin -w -t tag)
+'
+
+test_atom refs/tags/taggerless type 'commit'
+test_atom refs/tags/taggerless tag 'taggerless'
+test_atom refs/tags/taggerless tagger ''
+test_atom refs/tags/taggerless taggername ''
+test_atom refs/tags/taggerless taggeremail ''
+test_atom refs/tags/taggerless taggerdate ''
+test_atom refs/tags/taggerless committer ''
+test_atom refs/tags/taggerless committername ''
+test_atom refs/tags/taggerless committeremail ''
+test_atom refs/tags/taggerless committerdate ''
+test_atom refs/tags/taggerless subject 'Broken tag'
+
 test_expect_success 'an unusual tag with an incomplete line' '
 
 	git tag -m "bogo" bogo &&
-- 
2.23.0
