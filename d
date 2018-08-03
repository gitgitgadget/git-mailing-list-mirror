Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=0.7 required=3.0 tests=BAYES_50,DKIM_SIGNED,
	FROM_WORDY,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIM_INVALID shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E24691F597
	for <e@80x24.org>; Fri,  3 Aug 2018 18:38:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729859AbeHCUfm (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Aug 2018 16:35:42 -0400
Received: from walmailout10.yourhostingaccount.com ([65.254.253.82]:47469 "EHLO
        walmailout10.yourhostingaccount.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728139AbeHCUfm (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 3 Aug 2018 16:35:42 -0400
X-Greylist: delayed 1813 seconds by postgrey-1.27 at vger.kernel.org; Fri, 03 Aug 2018 16:35:41 EDT
Received: from mailscan05.yourhostingaccount.com ([10.1.15.5] helo=walmailscan05.yourhostingaccount.com)
        by walmailout10.yourhostingaccount.com with esmtp (Exim)
        id 1fleUe-0004xX-Cz
        for git@vger.kernel.org; Fri, 03 Aug 2018 14:08:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=customizeleadsinfo.com; s=dkim; h=Sender:Content-Type:MIME-Version:
        Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Ianb6a4WLCHj+32cN6XvuDXpxqSjaXZm+Zx3fC4d8Do=; b=DuGJrb63C3nsgaZgVLaBsx0LK
        7k9zScaNBFPKaBDZpJayy1bJ6B+0gX/60Fgso7Px2neuml5/+trSjpvnmG6/t0y5DOzelanTqezI6
        Gza8HqcOO1F0SM3KeLcXIMI04qS67ljGlooqoDgHbzVWFkh+fnQuR2kSbglJS0gkwCWNQnh6JDvav
        04LqtLbxWx3/uWYEsA3b4aSBcMKRsequ60aYmgH1MXzWIxeBVbrkD9KWJMP970FQOczdjDSjkBov+
        9rGqsetUGTnTax9bxfJvcqiw1fmKoHBo9mDH20BDPA9/CX1YvsZAzIFXZdGnx44b79LHL4rM0Qd8j
        RmocolgjQ==;
Received: from [10.114.3.32] (helo=walimpout12)
        by walmailscan05.yourhostingaccount.com with esmtp (Exim)
        id 1fleUe-0007V1-A3
        for git@vger.kernel.org; Fri, 03 Aug 2018 14:08:04 -0400
Received: from walauthsmtp08.yourhostingaccount.com ([10.1.18.8])
        by walimpout12 with 
        id Ji811y00G0ASqTN01i84Gg; Fri, 03 Aug 2018 14:08:04 -0400
X-Authority-Analysis: v=2.2 cv=Gc9npUfL c=1 sm=1 tr=0
 a=8amoANLqcXHyoDJd6jbCBw==:117 a=uOyXIxSxdcWGuYRjJUu3OA==:17
 a=dapMudl6Dx4A:10 a=zJgmlGxMLkEA:10 a=DAwyPP_o2Byb1YXLmDAA:9
 a=9LNKGf_oSSKJzNSw12cA:9 a=LNciZAYszouOPcv2:21 a=PMlUG1ALFauRImER:21
 a=CjuIK1q_8ugA:10 a=yMhMjlubAAAA:8 a=SSmOFEACAAAA:8 a=fob7L1skLOjqiSShsuIA:9
 a=bsI7ttUUTlLyP7gt:21 a=gKO2Hq4RSVkA:10 a=UiCQ7L4-1S4A:10 a=hTZeC7Yk6K0A:10
 a=frz4AuCg-hUA:10
Received: from [183.82.19.190] (port=19227 helo=AdminPC)
        by walauthsmtp08.yourhostingaccount.com with esmtpa (Exim)
        id 1fleTd-0001qV-JR
        for git@vger.kernel.org; Fri, 03 Aug 2018 14:07:02 -0400
From:   "Cheryl Strack" <Cheryl.Strack@customizeleadsinfo.com>
To:     <git@vger.kernel.org>
Subject: Nurses contact information
Date:   Fri, 3 Aug 2018 13:04:59 -0500
Message-ID: <!&!AAAAAAAAAAAYAAAAAAAAAPCEViNhbpZNlpBHT31GRKLCgAAAEAAAAKOAYW7Mh9dAn+UwzN+zjbgBAAAAAA==@customizeleadsinfo.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
        boundary="----=_NextPart_000_027F_01D42B2A.DF421DE0"
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AdQrU8zY7Teb4OlWSAW3Ubf4n7JQCw==
Content-Language: en-us
X-EN-UserInfo: 11e772dabdf4b773e3ff9cd01128915d:931c98230c6409dcc37fa7e93b490c27
X-EN-AuthUser: cheryl.strack@customizeleadsinfo.com
X-EN-OrigIP: 183.82.19.190
X-EN-OrigHost: unknown
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a multipart message in MIME format.

------=_NextPart_000_027F_01D42B2A.DF421DE0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello there,

 

We have a newly compiled list of Nurses contact information.

 

Contact Information such Name, Company's Name, Phone Number, Fax Number, Job
Title, Email address, Complete Mailing Address, SIC code, Company revenue,
size, Web address etc.

 

We also have other specialist such as Cardiologist, Internal medicine,
Radiologists Family Practitioners Orthopedists and all others.

 

We provide these contacts with complete details with direct email address
with unlimited usage for your email marketing. Please let me know if you are
interested.

 

Please let me know the below and I shall get back to you with other list
details accordingly.

 

Target Specialist___?

Target Geography___?

 

Hope to hear from you soon.

 

Regards,

 

Cheryl Strack - Marketing Analyst

 

This is an attempt to begin a conversation with you. If you would rather not
hear from us, please respond mentioning UNSUBSCRIBE in the subject line.

If you are not the right person please forward this email to the right
person in your organization.

 

 

 

 


------=_NextPart_000_027F_01D42B2A.DF421DE0
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" =
xmlns=3D"http://www.w3.org/TR/REC-html40"><head><META =
HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii"><meta name=3DGenerator content=3D"Microsoft Word 14 =
(filtered medium)"><style><!--
/* Font Definitions */
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";}
p.MsoNoSpacing, li.MsoNoSpacing, div.MsoNoSpacing
	{mso-style-priority:1;
	margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";}
p.m-2368407052388754725gmail-msonospacing, =
li.m-2368407052388754725gmail-msonospacing, =
div.m-2368407052388754725gmail-msonospacing
	{mso-style-name:m_-2368407052388754725gmail-msonospacing;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:12.0pt;
	font-family:"Times New Roman","serif";}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri","sans-serif";}
.MsoPapDefault
	{mso-style-type:export-only;
	margin-bottom:10.0pt;
	line-height:115%;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]--></head><body lang=3DEN-US><div =
class=3DWordSection1><p class=3DMsoNoSpacing>Hello there,</p><p =
class=3DMsoNoSpacing>&nbsp;</p><p class=3DMsoNoSpacing>We have a newly =
compiled list of Nurses contact information.</p><p =
class=3DMsoNoSpacing>&nbsp;</p><p class=3DMsoNoSpacing>Contact =
Information such Name, Company's Name, Phone Number, Fax Number, Job =
Title, Email address, Complete Mailing Address, SIC code, Company =
revenue, size, Web address etc.</p><p class=3DMsoNoSpacing>&nbsp;</p><p =
class=3DMsoNoSpacing>We also have other specialist such as Cardiologist, =
Internal medicine, Radiologists Family Practitioners Orthopedists and =
all others.</p><p class=3DMsoNoSpacing><o:p>&nbsp;</o:p></p><p =
class=3DMsoNoSpacing>We provide these contacts with complete details =
with direct email address with unlimited usage for your email marketing. =
Please let me know if you are interested.</p><p =
class=3DMsoNoSpacing>&nbsp;</p><p class=3DMsoNoSpacing>Please let me =
know the below and I shall get back to you with other list details =
accordingly.</p><p class=3DMsoNoSpacing><o:p>&nbsp;</o:p></p><p =
class=3DMsoNoSpacing>Target Specialist___?</p><p =
class=3DMsoNoSpacing>Target Geography___?</p><p =
class=3DMsoNoSpacing><o:p>&nbsp;</o:p></p><p class=3DMsoNoSpacing>Hope =
to hear from you soon.</p><p =
class=3DMsoNoSpacing><o:p>&nbsp;</o:p></p><p =
class=3DMsoNoSpacing>Regards,</p><p =
class=3DMsoNoSpacing><o:p>&nbsp;</o:p></p><p class=3DMsoNoSpacing>Cheryl =
Strack - Marketing Analyst</p><p =
class=3DMsoNoSpacing><o:p>&nbsp;</o:p></p><p class=3DMsoNoSpacing =
align=3Dcenter style=3D'text-align:center'><span =
style=3D'font-size:9.0pt;color:#D9D9D9'>This is an attempt to begin a =
conversation with you. If you would rather not hear from us, please =
respond mentioning UNSUBSCRIBE in the subject =
line.<o:p></o:p></span></p><p class=3DMsoNoSpacing align=3Dcenter =
style=3D'text-align:center'><span =
style=3D'font-size:9.0pt;color:#D9D9D9'>If you are not the right person =
please forward this email to the right person in your =
organization.<o:p></o:p></span></p><p =
class=3Dm-2368407052388754725gmail-msonospacing align=3Dcenter =
style=3D'margin:0in;margin-bottom:.0001pt;text-align:center;background:wh=
ite'><span =
style=3D'font-size:9.0pt;color:#D9D9D9'><o:p>&nbsp;</o:p></span></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p></div></body></html>
------=_NextPart_000_027F_01D42B2A.DF421DE0--

