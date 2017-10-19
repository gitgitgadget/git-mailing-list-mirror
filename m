Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.3 required=3.0 tests=BAYES_00,DKIM_ADSP_ALL,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	T_DKIM_INVALID shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D627B1FF32
	for <e@80x24.org>; Thu, 19 Oct 2017 08:01:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751824AbdJSIBp (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Oct 2017 04:01:45 -0400
Received: from alderaan.xwing.info ([91.134.139.206]:47258 "EHLO
        alderaan.xwing.info" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751735AbdJSIBo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Oct 2017 04:01:44 -0400
X-Greylist: delayed 493 seconds by postgrey-1.27 at vger.kernel.org; Thu, 19 Oct 2017 04:01:43 EDT
Received: from bespin.xwing.info (iv2-technologies-gw1.ter1.prb.par.cust.as8218.eu [213.152.20.178])
        by alderaan.xwing.info (Postfix) with ESMTPSA id 1D6EC6135B;
        Thu, 19 Oct 2017 09:53:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=xwing.info; s=mail;
        t=1508399609; bh=ES5LOx9HdChVHN7lzFBCOGe9XkTHlyyb+ZesG6zvlro=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References;
        b=PVS+mZuPWTdRhg6RxuumZwVa7wEjDOWLYAvaASIdNkKd6gnCK75eSOriPL6I+vp7W
         VObWbzXCXqchQ/PyZsFewVhKXAolmz1SymVmXX25KPH9bdmu6Z5ylHUzA6uTo22hut
         7w4yjJ/2ET0HtqviPDX3KZ8N7Dk9QyHfK6QFQDpI=
Message-ID: <1508399608.4529.10.camel@xwing.info>
Subject: Re: [PATCH] use filetest pragma to work with ACL
From:   Guillaume Castagnino <casta@xwing.info>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Date:   Thu, 19 Oct 2017 09:53:28 +0200
In-Reply-To: <20171018212451.goqxu4qq6aqe4tpl@sigill.intra.peff.net>
References: <0102015f310e24b9-b96378f3-a029-4110-80dd-e454522e2cb7-000000@eu-west-1.amazonses.com>
         <20171018212451.goqxu4qq6aqe4tpl@sigill.intra.peff.net>
Content-Type: multipart/mixed; boundary="=-oz9gt1rRIBFLUdaYD720"
X-Mailer: Evolution 3.24.5 
Mime-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--=-oz9gt1rRIBFLUdaYD720
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

Hi,

Le mercredi 18 octobre 2017 à 17:24 -0400, Jeff King a écrit :
> On Wed, Oct 18, 2017 at 07:55:31PM +0000, Guillaume Castagnino wrote:
> 
> > From: Guillaume Castagnino <casta@xwing.info>
> > [...]
> 
> Stefan raised a few meta issues, all of which I agree with. But I had
> some questions about the patch itself:
> 
> > diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> > index 9208f42ed1753..0ee7f304ce2b1 100755
> > --- a/gitweb/gitweb.perl
> > +++ b/gitweb/gitweb.perl
> > @@ -3072,6 +3072,7 @@ sub git_get_projects_list {
> >  				# only directories can be git
> > repositories
> >  				return unless (-d $_);
> >  				# need search permission
> > +				use filetest 'access';
> >  				return unless (-x $_);
> 
> This "use" will unconditionally at compile-time (such as "compile" is
> for perl, anyway). Which raises a few questions:
> 
>   - would we want to use "require" instead to avoid loading when we
>     don't enter this function?

I was under the impression that as this is a pragma affecting perl
“compiler”, you have to always use “use”, not require, as the pragma
initialisation has to be done before code is run.

>   - If the answer to the above is "no" (e.g., because we basically
>     always need it; I didn't check), should it go at the top of the
>     script with the other "use" directives?
> 
>     I think this is a scoped pragma, so what you have here affects
> only
>     this particular "-x". But wouldn't other uses of "-x" potentially
>     want the same benefit?

I quickly grepped the code, I did not see other calls that could
benefits from the pragma, but it could be indeed nice to move it at the
top to avoid future issues with such tests and POSIX ACL.

>   - Do all relevant versions of perl ship with filetest? According to
>     Module::Corelist, it first shipped with perl 5.6. In general I
> think
>     we treat that as a minimum for our perl scripts, though I do
> notice
>     that the gitweb script says "use 5.008". I'm not sure how
> realistic
>     that is.

So the CGI already requires perl 5.8, so it’s fine I think.

Attached a cleanup proposal and moving the use at the top.

Thanks
Guillaume

-- 
Guillaume Castagnino
    casta@xwing.info / guillaume@castagnino.org
--=-oz9gt1rRIBFLUdaYD720
Content-Disposition: attachment; filename="0001-gitweb-use-filetest-to-allow-ACLs.patch"
Content-Type: text/x-patch; name="0001-gitweb-use-filetest-to-allow-ACLs.patch";
	charset="UTF-8"
Content-Transfer-Encoding: base64

RnJvbSA0ZDVhMDgyOTcwMDYzYjM0ZDNkYmRmNWI5YTU3NzYyNDMxMDA1N2Q2IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBHdWlsbGF1bWUgQ2FzdGFnbmlubyA8Y2FzdGFAeHdpbmcuaW5m
bz4KRGF0ZTogVGh1LCAxOSBPY3QgMjAxNyAwOTozMjo0NiArMDIwMApTdWJqZWN0OiBbUEFUQ0hd
IGdpdHdlYjogdXNlIGZpbGV0ZXN0IHRvIGFsbG93IEFDTHMKCkluIGNvbW1pdCA0NmExMzg1IChn
aXR3ZWI6IHNraXAgdW5yZWFkYWJsZSBzdWJkaXJlY3RvcmllcywgMjAxNy0wNy0xOCkKd2UgZm9y
Z290IHRvIGhhbmRsZSBub24tdW5peCBBQ0xzIGFzIHdlbGwuIEZpeCB0aGlzLgoKU2lnbmVkLW9m
Zi1ieTogR3VpbGxhdW1lIENhc3RhZ25pbm8gPGNhc3RhQHh3aW5nLmluZm8+Ci0tLQogZ2l0d2Vi
L2dpdHdlYi5wZXJsIHwgMiArKwogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQoKZGlm
ZiAtLWdpdCBhL2dpdHdlYi9naXR3ZWIucGVybCBiL2dpdHdlYi9naXR3ZWIucGVybAppbmRleCA5
MjA4ZjQyZWQuLjZhYzQ5ZWFmMyAxMDA3NTUKLS0tIGEvZ2l0d2ViL2dpdHdlYi5wZXJsCisrKyBi
L2dpdHdlYi9naXR3ZWIucGVybApAQCAtMTAsNiArMTAsOCBAQAogdXNlIDUuMDA4OwogdXNlIHN0
cmljdDsKIHVzZSB3YXJuaW5nczsKKyMgaGFuZGxlIEFDTCBpbiBmaWxlIGFjY2VzcyB0ZXN0cwor
dXNlIGZpbGV0ZXN0ICdhY2Nlc3MnOwogdXNlIENHSSBxdyg6c3RhbmRhcmQgOmVzY2FwZUhUTUwg
LW5vc3RpY2t5KTsKIHVzZSBDR0k6OlV0aWwgcXcodW5lc2NhcGUpOwogdXNlIENHSTo6Q2FycCBx
dyhmYXRhbHNUb0Jyb3dzZXIgc2V0X21lc3NhZ2UpOwotLSAKMi4xNC4yCgo=


--=-oz9gt1rRIBFLUdaYD720--

