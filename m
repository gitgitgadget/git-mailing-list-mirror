Return-Path: <SRS0=lJm1=AA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 415B3C433DF
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 23:26:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 246832166E
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 23:26:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730424AbgFSX0l convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Fri, 19 Jun 2020 19:26:41 -0400
Received: from elephants.elehost.com ([216.66.27.132]:19807 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730379AbgFSX0k (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jun 2020 19:26:40 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [173.32.57.223])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 05JNQZ09021487
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 19 Jun 2020 19:26:36 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     =?UTF-8?B?J8SQb8OgbiBUcuG6p24gQ8O0bmcgRGFuaCc=?= 
        <congdanhqx@gmail.com>
Cc:     <randall.s.becker@rogers.com>, <git@vger.kernel.org>
References: <20200619150445.4380-1-randall.s.becker@rogers.com> <20200619150445.4380-2-randall.s.becker@rogers.com> <20200619163530.GB5027@danh.dev> <02a501d6465d$80366680$80a33380$@nexbridge.com> <20200619230141.GC5027@danh.dev>
In-Reply-To: <20200619230141.GC5027@danh.dev>
Subject: RE: [Patch v1 1/3] bugreport.c: replace strbuf_write_fd with write_in_full
Date:   Fri, 19 Jun 2020 19:26:29 -0400
Message-ID: <02dc01d64691$12db4310$3891c930$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKpTDE+t6IzuT5QyP1r/drrysHRPAImfDU6AorP7dACFQoNBAJ3Q+5OpvCcj9A=
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On June 19, 2020 7:02 PM, Ðoàn Tr?n Công Danh wrote:
> To: Randall S. Becker <rsbecker@nexbridge.com>
> Cc: randall.s.becker@rogers.com; git@vger.kernel.org
> Subject: Re: [Patch v1 1/3] bugreport.c: replace strbuf_write_fd with
> write_in_full
> 
> On 2020-06-19 13:17:19-0400, "Randall S. Becker"
> <rsbecker@nexbridge.com> wrote:
> > On June 19, 2020 12:36 PM, Đoàn Trần Công Danh wrote:
> > > On 2020-06-19 11:04:43-0400, randall.s.becker@rogers.com wrote:
> > > > From: "Randall S. Becker" <rsbecker@nexbridge.com>
> > > >
> > > > The strbuf_write_fd method did not provide checks for buffers
> > > > larger than MAX_IO_SIZE. Replacing with write_in_full ensures the
> > > > entire buffer will always be written to disk or report an error and die.
> > > >
> > > > Signed-off-by: Randall S. Becker <rsbecker@nexbridge.com>
> > > > ---
> > > >  bugreport.c | 5 ++++-
> > > >  1 file changed, 4 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/bugreport.c b/bugreport.c index
> > > > aa8a489c35..bc359b7fa8
> > > > 100644
> > > > --- a/bugreport.c
> > > > +++ b/bugreport.c
> > > > @@ -174,7 +174,10 @@ int cmd_main(int argc, const char **argv)
> > > >  		die(_("couldn't create a new file at '%s'"), report_path.buf);
> > > >  	}
> > > >
> > > > -	strbuf_write_fd(&buffer, report);
> > > > +	if (write_in_full(report, buffer.buf, buffer.len) < 0) {
> > > > +		die(_("couldn't write report contents '%s' to file '%s'"),
> > > > +			buffer.buf, report_path.buf);
> > >
> > > Doesn't this dump the whole report to the stderr?
> > > If it's the case, the error would be very hard to grasp.
> >
> > Where else can we put the error? By this point, we're likely out of
> > disk or virtual memory.
> 
> Sorry, I forgot to suggest an alternatives.
> 
> I was thinking about ignore the report when writing the last email.
> 
> Since, the report is likely consists of multiple lines of text, and they likely
> contains some single quote themselves.
> 
> Now, I think a bit more, I think it's way better to write as:
> 
> 	if (write_in_full(report, buffer.buf, buffer.len) < 0)
> 		die(_("couldn't write the report contents to file '%s'.\n\n"
> 		"The original report was:\n\n"
> 		"%s\n"), report_path.buf, buffer.buf);

I went with Peff's suggestion of using die_error in v2. Thanks though.

> > > Nit: We wouldn't want the pair of {}.
> > >
> > > > +	}
> > > >  	close(report);
> >
> > I'm not sure what you mean in this nit? {} are balanced. You mean in the
> error message?
> 
> Our style guides says we wouldn't want this pair of {} if it's single statement.

Fixed in v2

Regards,
Randall

