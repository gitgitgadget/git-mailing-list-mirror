Return-Path: <SRS0=FHek=5A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19CB6C10DCE
	for <git@archiver.kernel.org>; Sun, 15 Mar 2020 23:13:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB3C3206B1
	for <git@archiver.kernel.org>; Sun, 15 Mar 2020 23:13:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728707AbgCOXNY (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 15 Mar 2020 19:13:24 -0400
Received: from nef2.ens.fr ([129.199.96.40]:43859 "EHLO nef.ens.fr"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728612AbgCOXNY (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Mar 2020 19:13:24 -0400
X-Greylist: delayed 3214 seconds by postgrey-1.27 at vger.kernel.org; Sun, 15 Mar 2020 19:13:23 EDT
X-ENS-nef-client: 129.199.129.80
Received: from phare.normalesup.org (phare.normalesup.org [129.199.129.80])
          by nef.ens.fr (8.14.4/1.01.28121999) with ESMTP id 02FMJfnf027876
          ; Sun, 15 Mar 2020 23:19:41 +0100
Received: by phare.normalesup.org (Postfix, from userid 1317)
        id 7F471E0101; Sun, 15 Mar 2020 23:19:41 +0100 (CET)
Date:   Sun, 15 Mar 2020 23:19:40 +0100
From:   Damien Robert <damien.olivier.robert@gmail.com>
To:     James Ramsay <james@jramsay.com.au>
Cc:     git@vger.kernel.org
Subject: Re: [TOPIC 3/17] Obliterate
Message-ID: <20200315221940.bdgi5mluxuetq2lz@doriath>
X-PGP-Key: http://www.normalesup.org/~robert/pro/files/Damien_Olivier_Robert.asc
X-Start-Date: Sun, 15 Mar 2020 23:04:12 +0100
References: <AC2EB721-2979-43FD-922D-C5076A57F24B@jramsay.com.au>
 <5B2FEA46-A12F-4DE7-A184-E8856EF66248@jramsay.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5B2FEA46-A12F-4DE7-A184-E8856EF66248@jramsay.com.au>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.4.3 (nef.ens.fr [129.199.96.32]); Sun, 15 Mar 2020 23:19:42 +0100 (CET)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From James Ramsay, Thu 12 Mar 2020 at 14:57:24 (+1100) :
> 6. Elijah: replace refs helps, but not supported by hosts like GitHub etc
>     a. Stolee: breaks commit graph because of generation numbers.
>     b. Replace refs for blobs, then special packfile, there were edge cases.

I am interested in more details on how to handle this using replace.

My situation: coworkers push big files by mistake, I don't want to rewrite
history because they are not too well versed with git, but I want to keep
*my* repo clean.

Partial solution:
- identify the large blobs (easy)
- write a replace ref (easy):
  $ git replace b5f74037bb91 $(git hash-object -w -t blob /dev/null)
  and replace the file (if it is still in the repo) by an empty file.

Now the pain points start:
- first the index does not handle replace (I think), so the replaced file
  appear as changed in git status, even through eg git diff shows nothing.

=> Solution: configure .git/info/sparse-checkout

- secondly, I want to remove the large blob from my repo.

Ideally I'd like to repack everything but filter this blob, except that
repack does not understand --filter. So I need to use `git pack-objects`
directly and then do the naming and clean up that repack usually does
manually, which is error prone.

Furthermore, while `git pack-objects` accepts --filter, I can only filter on
blob size, not blob oid. (there is filter=sparse:oid where I could reuse my
sparse checkout file, but I would need to make a blob of it first). And if I
have one large file I want to keep, I cannot filter by blob size.

Another solution would be to use `git unpack-objects` to unpack all objects
(except I would need to do that in an empty git dir), remove the blob, and
then repack everything.

Am I missing a simpler solution?

- finally, checkouting to a ref including the replaced (now missing) blob
  gives error messages of the form:
error: invalid object 100644 b5f74037bb91c45606b233b0ad6aad86f8e3875e for 'Silverman-Height-NonTorsion.pdf'

On the one hand it is reassuring that git checks that the real object
(rather than only the replaced object) is still there, on the other hand it
would be nice to ask git to completely forget about the original object
(except fsck of course).

Thanks,
Damien
