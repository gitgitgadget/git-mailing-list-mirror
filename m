Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C3C2202A0
	for <e@80x24.org>; Sat,  4 Nov 2017 18:36:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752626AbdKDSgp (ORCPT <rfc822;e@80x24.org>);
        Sat, 4 Nov 2017 14:36:45 -0400
Received: from zucker2.schokokeks.org ([178.63.68.90]:55165 "EHLO
        zucker2.schokokeks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752552AbdKDSgp (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Nov 2017 14:36:45 -0400
Received: from localhost ([::1])
  (AUTH: PLAIN simon@ruderich.org, TLS: TLSv1/SSLv3,256bits,ECDHE-RSA-AES256-GCM-SHA384)
  by zucker.schokokeks.org with ESMTPSA; Sat, 04 Nov 2017 19:36:43 +0100
  id 0000000000000045.0000000059FE08BB.00005F80
Date:   Sat, 4 Nov 2017 19:36:43 +0100
From:   Simon Ruderich <simon@ruderich.org>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>,
        Git List <git@vger.kernel.org>,
        Ralf Thielow <ralf.thielow@gmail.com>
Subject: Re: [PATCH 1/2] sequencer: factor out rewrite_file()
Message-ID: <20171104183643.akaazwswysphzuoq@ruderich.org>
References: <6150c80b-cb0e-06d4-63a7-a4f4a9107ab2@web.de>
 <20171101194732.fn4n46wppl35e2z2@sigill.intra.peff.net>
 <alpine.DEB.2.21.1.1711012240500.6482@virtualbox>
 <20171101221618.4ioog7jlp7n2nd53@sigill.intra.peff.net>
 <20171103103248.4p45r4klojk5cf2g@ruderich.org>
 <xmqqpo8zpjdj.fsf@gitster.mtv.corp.google.com>
 <20171103191309.sth4zjokgcupvk2e@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20171103191309.sth4zjokgcupvk2e@sigill.intra.peff.net>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 03, 2017 at 03:13:10PM -0400, Jeff King wrote:
> I think we've been gravitating towards error strbufs, which would make
> it something like:

I like this approach to store the error in a separate variable
and let the caller handle it. This provides proper error messages
and is cleaner than printing the error on the error site (what
error_errno does).

However I wouldn't use strbuf directly and instead add a new
struct error which provides a small set of helper functions.
Using a separate type also makes it clear to the reader that is
not a normal string and is more extendable in the future.

> I'm not excited that the amount of error-handling code is now double the
> amount of code that actually does something useful. Maybe this function
> simply isn't large/complex enough to merit flexible error handling, and
> we should simply go with René's original near-duplicate.

A separate struct (and helper functions) would help in this case
and could look like this, which is almost equal (in code size) to
the original solution using error_errno:

    int write_file_buf_gently2(const char *path, const char *buf, size_t len, struct error *err)
    {
            int rc = 0;
            int fd = open(path, O_WRONLY | O_CREAT | O_TRUNC, 0666);
            if (fd < 0)
                    return error_addf_errno(err, _("could not open '%s' for writing"), path);
            if (write_in_full(fd, buf, len) < 0)
                    rc = error_addf_errno(err, _("could not write to '%s'"), path);
            if (close(fd) && !rc)
                    rc = error_addf_errno(err, _("could not close '%s'"), path);
            return rc;
    }

(I didn't touch write_in_full here, but it could also take the
err and then the code would get a little shorter, however would
lose the "path" information, but see below.)

And in the caller:

    void write_file_buf(const char *path, const char *buf, size_t len)
    {
            struct error err = ERROR_INIT;
            if (write_file_buf_gently2(path, buf, len, &err) < 0)
                    error_die(&err);
    }

For now struct error just contains the strbuf, but one could add
the call location (by using a macro for error_addf_errno) or the
original errno or more information in the future.

error_addf_errno() could also prepend the error the buffer so
that the caller can add more information if necessary and we get
something like: "failed to write file 'foo': write failed: errno
text" in the write_file_buf case (the first error string is from
write_file_buf_gently2, the second from write_in_full). However
I'm not sure how well this works with translations.

We could also store the error condition in the error struct and
don't use the return value to indicate and error like this:

    void write_file_buf(const char *path, const char *buf, size_t len)
    {
            struct error err = ERROR_INIT;
            write_file_buf_gently2(path, buf, len, &err);
            if (err.error)
                    error_die(&err);
    }

> OTOH, if we went all-in on flexible error handling contexts, you could
> imagine this function becoming:
>
>   void write_file_buf(const char *path, const char *buf, size_t len,
>                       struct error_context *err)
>   {
> 	int fd = xopen(path, err, O_WRONLY | O_CREAT | O_TRUNC, 0666);
> 	if (fd < 0)
> 		return -1;
> 	if (write_in_full(fd, buf, len, err) < 0)
> 		return -1;
> 	if (xclose(fd, err) < 0)
> 		return -1;
> 	return 0;
>   }

This looks interesting as well, but it misses the feature of
custom error messages which is really useful.

Regards
Simon
-- 
+ privacy is necessary
+ using gnupg http://gnupg.org
+ public key id: 0x92FEFDB7E44C32F9
