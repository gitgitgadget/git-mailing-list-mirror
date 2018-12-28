Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D2191F804
	for <e@80x24.org>; Fri, 28 Dec 2018 20:39:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725868AbeL1UjE (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Dec 2018 15:39:04 -0500
Received: from elephants.elehost.com ([216.66.27.132]:30339 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725840AbeL1UjD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Dec 2018 15:39:03 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id wBSKd09m017271
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 28 Dec 2018 15:39:00 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>,
        <randall.s.becker@rogers.com>
Cc:     <git@vger.kernel.org>
References: <20181226230523.16572-1-randall.s.becker@rogers.com>        <20181226230523.16572-2-randall.s.becker@rogers.com> <xmqqk1jto1jb.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqk1jto1jb.fsf@gitster-ct.c.googlers.com>
Subject: RE: [PATCH v1 1/4] transport-helper: use xread instead of read
Date:   Fri, 28 Dec 2018 15:38:54 -0500
Message-ID: <001001d49eed$5c9df300$15d9d900$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHP6M3TTaFeK+MquD7CewJFvBAGhQJ/kADwAkrh8wqld7UzEA==
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On December 28, 2018 15:11,  Junio C Hamano wrote:
> randall.s.becker@rogers.com writes:
> 
> > From: "Randall S. Becker" <rsbecker@nexbridge.com>
> >
> > This fix was needed on HPE NonStop NSE and NSX where SSIZE_MAX is less
> > than BUFFERSIZE resulting in EINVAL. The call to read in
> > transport-helper.c was the only place outside of wrapper.c where it is
used
> instead of xread.
> >
> > Signed-off-by: Randall S. Becker <rsbecker@nexbridge.com>
> > ---
> >  transport-helper.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/transport-helper.c b/transport-helper.c index
> > bf225c698f..a290695a12 100644
> > --- a/transport-helper.c
> > +++ b/transport-helper.c
> > @@ -1225,7 +1225,7 @@ static int udt_do_read(struct
> unidirectional_transfer *t)
> >  		return 0;	/* No space for more. */
> >
> >  	transfer_debug("%s is readable", t->src_name);
> > -	bytes = read(t->src, t->buf + t->bufuse, BUFFERSIZE - t->bufuse);
> > +	bytes = xread(t->src, t->buf + t->bufuse, BUFFERSIZE - t->bufuse);
> >  	if (bytes < 0 && errno != EWOULDBLOCK && errno != EAGAIN &&
> >  		errno != EINTR) {
> >  		error_errno(_("read(%s) failed"), t->src_name);
> 
> As Peff pointed out in the earlier round of the same patch, replacing
read()
> with xread() here will affect what errno's can be possible after the
function
> returns.  The checks affected by this change must also be updated, either
in
> the same patch, or a follow-up patch in the same series.  Otherwise we
> _will_ forget to clean them up.

If I read the xread code correctly, the change would be to leave EINTR and
remove the other two conditions. Correct?

