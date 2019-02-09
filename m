Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A4121F453
	for <e@80x24.org>; Sat,  9 Feb 2019 17:01:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727151AbfBIRBB (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Feb 2019 12:01:01 -0500
Received: from elephants.elehost.com ([216.66.27.132]:57486 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726880AbfBIRBB (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Feb 2019 12:01:01 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id x19H0wjZ055367
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 9 Feb 2019 12:00:59 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>
Cc:     <git@vger.kernel.org>
References: <20190208220751.9936-1-randall.s.becker@rogers.com> <xmqq8sypkfzk.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq8sypkfzk.fsf@gitster-ct.c.googlers.com>
Subject: RE: [Fix v2] t5562: remove dependency on /dev/zero
Date:   Sat, 9 Feb 2019 12:00:51 -0500
Message-ID: <000401d4c099$063ae7c0$12b0b740$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQIc/tXX6nKYZRK3AZUxuMH5inI1NwFrWazgpTvVaTA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On February 8, 2019 18:39, Junio C Hamano wrote:
> randall.s.becker@rogers.com writes:
> > Replaced subtest 15 (CONTENT_LENGTH overflow ssite_t) use of /dev/zero
> > with yes and a translation of its result to a stream of NULL. This is
> > a more portable solution.
> >
> > Signed-off-by: Randall S. Becker <rsbecker@nexbridge.com>
> > ---
> >  t/t5562-http-backend-content-length.sh | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/t/t5562-http-backend-content-length.sh
> > b/t/t5562-http-backend-content-length.sh
> > index 90d890d02..b8d1913e5 100755
> > --- a/t/t5562-http-backend-content-length.sh
> > +++ b/t/t5562-http-backend-content-length.sh
> > @@ -143,14 +143,14 @@ test_expect_success GZIP 'push gzipped empty' '
> >
> >  test_expect_success 'CONTENT_LENGTH overflow ssite_t' '
> >  	NOT_FIT_IN_SSIZE=$(ssize_b100dots) &&
> > -	env \
> > +	yes | tr "y" "\\0" | env \
> 
> I do not quite get this use of tr.  The original feeds a stream of NULs
out of
> /dev/zero to the command; the yes-to-tr pipe instead feeds a stream of
> alternating NUL and LF.

That's why we're going to go with a generate_zero_bytes function per Peff.
I'm working on a more comprehensive patch covering t5562, t5318, and
test-lib-functions.sh that will (hopefully) be satisfactory and remove the
dependency on /dev/zero and fixes the related new breakages in 2.21.0-rc0.

The test case in t5318 is specific about wanting zero bytes although the
test is just intending to generate a corrupt block that generates a
different hash, so yes 'yes' might be sufficient, but I don't like
randomness myself if we're taking two different tests being involved.

My current intent is to add to test-lib-functions.sh, a method of
generalizing blocks of zeros to a pipe:

+# Generate an output of $1 bytes of all zeroes (NULs, not ASCII zeroes).
+# If $1 is < 0, output forever or until the receiving pipe stops reading,
whichever comes first.
+ generate_zero_bytes () {
+ 	perl -e ' if ($ARGV[0] < 0) { while (-1) { print "\0" } } else {
print "\0" x $ARGV[0] }' "$@"
+ }

And then fit that into the two tests, then submit as a patch.

> Does the actual bytes fed to the consumer make any difference?  If not,
> perhaps we can use 'yes' as-is?
> 
> >  		CONTENT_TYPE=application/x-git-upload-pack-request \
> >  		QUERY_STRING=/repo.git/git-upload-pack \
> >  		PATH_TRANSLATED="$PWD"/.git/git-upload-pack \
> >  		GIT_HTTP_EXPORT_ALL=TRUE \
> >  		REQUEST_METHOD=POST \
> >  		CONTENT_LENGTH="$NOT_FIT_IN_SSIZE" \
> > -		git http-backend </dev/zero >/dev/null 2>err &&
> > +		git http-backend >/dev/null 2>err &&
> >  	grep "fatal:.*CONTENT_LENGTH" err
> >  '

Regards,
Randall

