Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=0.0 required=3.0 tests=BAYES_20,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F73A1F404
	for <e@80x24.org>; Mon, 12 Feb 2018 19:27:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750930AbeBLT12 (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Feb 2018 14:27:28 -0500
Received: from mail-pl0-f42.google.com ([209.85.160.42]:38875 "EHLO
        mail-pl0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750837AbeBLT10 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Feb 2018 14:27:26 -0500
Received: by mail-pl0-f42.google.com with SMTP id m19so536998pls.5
        for <git@vger.kernel.org>; Mon, 12 Feb 2018 11:27:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=allsysdatasolutions-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:references:in-reply-to:subject:date:message-id:mime-version
         :thread-index:content-language;
        bh=UXvY8lakA8Tu2ofxnNctEnWo0uQ08DTgz4W88x4JwBk=;
        b=u5Fjy/ZCOoKITmk6vjPDa+ufE2jwelVB07tBNf5/7JP9UE5uqmRxalGwln8BrJBkbN
         BWSR3vpjH5B7G5v1NlvL3F0aYmZ3g/ME29TjMHydE0izG1a+DeLYHQYAoxHG/YGduLe6
         GunU2v2r28glz33LjOQXWQkqrIc7fnxaWzYzIT4PJzUSFCFfDLpux9FIOw6LdfwalfV5
         yK8xR1jsQyF/U77ZUgA0jiNAVOzhh1xpMQXtvWxKp4mOkRayppNkmiHx1nyClgdd/Yrs
         qAuvgyzSmx8fyMyx95msIuNtAdIWbI9tZVlDX6S9XFJcJtR1lamh08g6i8y3GxsIxA8/
         M01g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:references:in-reply-to:subject:date
         :message-id:mime-version:thread-index:content-language;
        bh=UXvY8lakA8Tu2ofxnNctEnWo0uQ08DTgz4W88x4JwBk=;
        b=CgE/gWpMD1Ex8atGzfaRw3MuPoiQXfmWZuamuCQqm/W0cEZC9+jgH0V0NDKxyW4v/i
         Lqq5w/SYpFjQ+Y3YzS5vLz5qktBRELLCKPk0cHg0ixKuR0nU8d2Einf26B799xqqfthh
         RJNneYkLfEexiZZjCIleJOHpzfdJcZRYFtOB5u92IB/AZcGvrxYe7ehjeHAMFo88VCVh
         EqrzDroY5BxXUoHHtS3BCgxbC+9JwDOPct3h9h5+i4/2vQKZ2jzJ2302DK+LjBHUpf9o
         o5WJuIcWtktzokHK0GVRgUBAjYVqTraY6Oq1/TUJ2T9JNsaIDggELu9Ksk14kKizhgpg
         TkAA==
X-Gm-Message-State: APf1xPCgORmw9G99r/H72Amh1tJ9xzV0yWWxQK3BPeqJV5/uUvCreerO
        FlelbWe99YdNtTAeZGl5wRU0VNZ7ZDQ=
X-Google-Smtp-Source: AH8x225jdrkSjjUGI1JTv+ATR3cvSwM7Kk/SX352eit42PW0Rgz0kG7HQdzI1gsDSYa7TOo7N88tcg==
X-Received: by 2002:a17:902:6bc3:: with SMTP id m3-v6mr11588619plt.442.1518463646009;
        Mon, 12 Feb 2018 11:27:26 -0800 (PST)
Received: from userPC ([106.200.197.165])
        by smtp.gmail.com with ESMTPSA id o63sm30473588pfa.101.2018.02.12.11.27.24
        for <git@vger.kernel.org>
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 12 Feb 2018 11:27:25 -0800 (PST)
From:   "Sheryl Droege" <sheryl.droege@allsysdatasolutions.com>
To:     <git@vger.kernel.org>
References: 
In-Reply-To: 
Subject: The Minerals, Metals & Materials Society Annual - TMS
Date:   Mon, 12 Feb 2018 14:26:25 -0500
Message-ID: <01a001d3a437$82c12950$88437bf0$@allsysdatasolutions.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
        boundary="----=_NextPart_000_01A1_01D3A40D.99F24D40"
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AdOkNigWpLyy2ljRTWuKfiPoH2g+tw==
Content-Language: en-us
X-MS-TNEF-Correlator: 00000000C98D5C048BF86743838F2AA808CF7ACAC4532900
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a multipart message in MIME format.

------=_NextPart_000_01A1_01D3A40D.99F24D40
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi,

 

 I understand your company is exhibiting in The Minerals, Metals & Materials
Society Annual on MAR/11 - MAR/15/2018.

 

Would you be interested in the complete contact information with email
addresses of Materials scientists and Engineers?

 

Available Data Fields: Practice Name, Web Address/URL, Contact name (First
name, middle name and last name), Specialty,, Postal address (street
address, city, state, zip code, and country), Phone, and Direct email
address.

 

Let me know your interest so that I can send you additional Information in
my next email.

 

Match Test for Appending : Just send us now 10 to 15 contacts in an excel
sheet from your in-house database with missing email address, telephone
numbers, fax numbers or mailing addresses, we can append it for you at no
cost, this will help you check the quality of our services.

 

Regards,                                  

Sheryl Droege

Marketing Associate

 

Please "Unsubscribe" if not interested in receiving further emails.


------=_NextPart_000_01A1_01D3A40D.99F24D40
Content-Type: application/ms-tnef;
	name="winmail.dat"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="winmail.dat"

eJ8+IhgTAQaQCAAEAAAAAAABAAEAAQeQBgAIAAAA5AQAAAAAAADoAAEIgAcAGAAAAElQTS5NaWNy
b3NvZnQgTWFpbC5Ob3RlADEIAQgABQAEAAAAAAAAAAAAAQkABAACAAAAAAAAAAEDkAYAjBUAAC8A
AAALAAIAAQAAAAMAJgAAAAAACwApAAAAAAALACsAAAAAAAMALgAAAAAAHgBNAAEAAAABAAAAAAAA
AB4AcAABAAAANgAAAFRoZSBNaW5lcmFscywgTWV0YWxzICYgTWF0ZXJpYWxzIFNvY2lldHkgQW5u
dWFsIC0gVE1TAAAAAgFxAAEAAAAWAAAAAdOkNigWpLyy2ljRTWuKfiPoH2g+twAACwAXDAAAAAAL
AAEOAAAAAAIBCg4BAAAAGAAAAAAAAADJjVwEi/hnQ4OPKqgIz3rKwoAAAAMAFA4BAAAAHgAoDgEA
AABVAAAAMDAwMDAwMDkBc2hlcnlsLmRyb2VnZUBhbGxzeXNkYXRhc29sdXRpb25zLmNvbQFzaGVy
eWwuZHJvZWdlQGFsbHN5c2RhdGFzb2x1dGlvbnMuY29tAAAAAB4AKQ4BAAAAVQAAADAwMDAwMDA5
AXNoZXJ5bC5kcm9lZ2VAYWxsc3lzZGF0YXNvbHV0aW9ucy5jb20Bc2hlcnlsLmRyb2VnZUBhbGxz
eXNkYXRhc29sdXRpb25zLmNvbQAAAAADAN4/n04AAAMA8T8JBAAAAwACWQAAFgADAAlZAgAAAAMA
E4AIIAYAAAAAAMAAAAAAAABGAAAAABCFAAAAAQAACwAVgAggBgAAAAAAwAAAAAAAAEYAAAAAA4UA
AAAAAAADACmACCAGAAAAAADAAAAAAAAARgAAAAABhQAAAAAAAAsAToAIIAYAAAAAAMAAAAAAAABG
AAAAAIKFAAABAAAAAwBQgAMgBgAAAAAAwAAAAAAAAEYAAAAAEIEAAAAAAAADAFGAAyAGAAAAAADA
AAAAAAAARgAAAAARgQAAAAAAAAsAV4ADIAYAAAAAAMAAAAAAAABGAAAAACSBAAAAAAAAHgBfgAMg
BgAAAAAAwAAAAAAAAEYAAAAAJ4EAAAEAAAABAAAAAAAAAAsAboADIAYAAAAAAMAAAAAAAABGAAAA
ACaBAAAAAAAACwBygAggBgAAAAAAwAAAAAAAAEYAAAAABoUAAAAAAAALAHSACCAGAAAAAADAAAAA
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
QPmbsDE1HhYgkB0hnFHiAJtb8J2gcx1gYvFmch2gXZq2LWYQ5SAdcGRa0WL/xWAdcB9jXzAgYNWS
H7tl4J8ckOHA4vBmIV4AdW0cQOMlkGXgZmF47HYgoJrwb2cy1ZIgF2Xgdx1xnFFh/9VDHGDU1JzT
XfGbsB2QZBDd68FoJJAfUeKgIB1g4uCXG/PUcGEQax1DcXXi0M9jwSCimtIgcHJ2W+Fn7/+4H7wP
1g/XH78/wE/BX9rf/8N/xI/Fn+Pv2y/cP91P4L//4c8FfwaP4p8BPwJP9Z+4//+6DwwP9v/4D/kf
+i/7P/xP/xB//m//fwCPC28CrwO/BM9/CD8G7yAPIR8KHxvP2HFS7GVnFyBbUCwN3w7vD///J68o
vynPKt8r7yz/Lg8vH/8wLzE/Mk8zXzRvNX82jzef/zivOb86zzvfPO89/z8PQB//QS9CP0NPRF9F
b0Z/R49In/9Jr0q/S89M303vTv9QD1Ef/1IvUz9UT1VfVm9Xf1iPWZ//Wq9bv1zPXd9e71//YQ9i
H/9jL2Q/ZU9mX2dvaH9pj2qf/2uvbL9tz27fb+9w/3IPcx//dC91P3ZPd194b3l/eo97n/98r32/
fs9/34Dvgf/ktAxv/w1/EW8SfxOPFJ8Vrxa/gx//GN8Z7xr/HA/H38jvk48dn4Merx+5RjQ5N0Ql
b5WWVFPzIHIjgCBE6HD9JuBlhk+HX4hviX+Kj5Zf/9lfiy+MP41Pjl+Pb5B/kY//kp+nn5dvmH8f
3yNPIf+wn2ckHyUv06pya+gw1ZJB/e7Qb6tQ6aCcn52vnr+fz/+g36R/pY+mn6yvqL+pz6rf/7W/
rP+uD68ZtV/FX7ivg6//hL/Jj7oPux+8L70/vk+/X6/N/8F/wo/Dk3LuAGzInx3VQ1CzgOniy28j
ODIkMjDMuzkz1PhVbsRzdcyAY3Jp7YDa39Xb4jHcPDTkaWmVsOXg//DQ6QCzsOuBs7Dv8cbw64Dt
58Bp9HC3MWbo0PMR7eD/6vP0v8rvzt3Sj9Of1K/Vv+flrbTwwuEvZOMA0S/qD4hnNTijQm9keeWu
LjejQeSy5aB98XAAAAADAA00/T+lDgMADzT9P6UOAgEUNAEAAAAQAAAATklUQfm/uAEAqgA32W4A
AAIBfwABAAAAMQAAADAwMDAwMDAwQzk4RDVDMDQ4QkY4Njc0MzgzOEYyQUE4MDhDRjdBQ0FDNDUz
MjkwMAAAAAADAAYQUGtQ2gMABxAVAwAAAwAQEAAAAAADABEQAQAAAB4ACBABAAAAZQAAAEhJLElV
TkRFUlNUQU5EWU9VUkNPTVBBTllJU0VYSElCSVRJTkdJTlRIRU1JTkVSQUxTLE1FVEFMUyZNQVRF
UklBTFNTT0NJRVRZQU5OVUFMT05NQVIvMTEtTUFSLzE1LzIwMTgAAAAAv+A=

------=_NextPart_000_01A1_01D3A40D.99F24D40--

