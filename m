Return-Path: <SRS0=lJm1=AA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1259DC433DF
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 17:17:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC02820DD4
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 17:17:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732200AbgFSRRb convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Fri, 19 Jun 2020 13:17:31 -0400
Received: from elephants.elehost.com ([216.66.27.132]:16592 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729842AbgFSRRa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jun 2020 13:17:30 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [173.32.57.223])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 05JHHPcX099753
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 19 Jun 2020 13:17:25 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     =?UTF-8?B?J8SQb8OgbiBUcuG6p24gQ8O0bmcgRGFuaCc=?= 
        <congdanhqx@gmail.com>, <randall.s.becker@rogers.com>
Cc:     <git@vger.kernel.org>
References: <20200619150445.4380-1-randall.s.becker@rogers.com> <20200619150445.4380-2-randall.s.becker@rogers.com> <20200619163530.GB5027@danh.dev>
In-Reply-To: <20200619163530.GB5027@danh.dev>
Subject: RE: [Patch v1 1/3] bugreport.c: replace strbuf_write_fd with write_in_full
Date:   Fri, 19 Jun 2020 13:17:19 -0400
Message-ID: <02a501d6465d$80366680$80a33380$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKpTDE+t6IzuT5QyP1r/drrysHRPAImfDU6AorP7dCnFJfCAA==
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On June 19, 2020 12:36 PM, Đoàn Trần Công Danh wrote:
> On 2020-06-19 11:04:43-0400, randall.s.becker@rogers.com wrote:
> > From: "Randall S. Becker" <rsbecker@nexbridge.com>
> >
> > The strbuf_write_fd method did not provide checks for buffers larger
> > than MAX_IO_SIZE. Replacing with write_in_full ensures the entire
> > buffer will always be written to disk or report an error and die.
> >
> > Signed-off-by: Randall S. Becker <rsbecker@nexbridge.com>
> > ---
> >  bugreport.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/bugreport.c b/bugreport.c index aa8a489c35..bc359b7fa8
> > 100644
> > --- a/bugreport.c
> > +++ b/bugreport.c
> > @@ -174,7 +174,10 @@ int cmd_main(int argc, const char **argv)
> >  		die(_("couldn't create a new file at '%s'"), report_path.buf);
> >  	}
> >
> > -	strbuf_write_fd(&buffer, report);
> > +	if (write_in_full(report, buffer.buf, buffer.len) < 0) {
> > +		die(_("couldn't write report contents '%s' to file '%s'"),
> > +			buffer.buf, report_path.buf);
> 
> Doesn't this dump the whole report to the stderr?
> If it's the case, the error would be very hard to grasp.

Where else can we put the error? By this point, we're likely out of disk or virtual memory.

> Nit: We wouldn't want the pair of {}.
> 
> > +	}
> >  	close(report);

I'm not sure what you mean in this nit? {} are balanced. You mean in the error message?

Randall

