Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=0.5 required=3.0 tests=BAYES_50,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PP_MIME_FAKE_ASCII_TEXT,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F1FC81F405
	for <e@80x24.org>; Sat, 29 Dec 2018 12:50:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726031AbeL2Mu3 (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Dec 2018 07:50:29 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33993 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbeL2Mu3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Dec 2018 07:50:29 -0500
Received: by mail-pg1-f195.google.com with SMTP id j10so11114726pga.1
        for <git@vger.kernel.org>; Sat, 29 Dec 2018 04:50:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:reply-to:from:to:subject:date:mime-version
         :content-transfer-encoding;
        bh=ayY0xvKW5kSQSzU5CFO/ul/YELV5Eyz1OP3WwxCZoa8=;
        b=ilRCwudqrNgL7o+mTfs/J0Lnvn9jNrbfLTl8Asl/E+WHYWbaUTfoV5HCM0dNwJoxfy
         B/9/riGdfT3JOmAeU5rV889wynPBcJzQB/A/E4LA+PvGQeKPh0cmiU7Hn8TwNNcmz0lS
         DH1qt+6DTRE2g/rdzP+Tp56cT6kWutgsaXGzUPRza/OdAXntzJQ8XicP1nUz9C6jS+q/
         7HprBo+S+Fl+lZXqSh+2dQV+VGykDAY8CeR+AsiSR1fxkQFSLvW8VR2vSHv9A+H8oG2a
         2Yd4gWbDtONTHV45Clu+SYFrIX0miMPW9XFma/p8uRBzcV7mGSvsaoMk7q8Q2JtUwk0v
         eKJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:reply-to:from:to:subject:date
         :mime-version:content-transfer-encoding;
        bh=ayY0xvKW5kSQSzU5CFO/ul/YELV5Eyz1OP3WwxCZoa8=;
        b=V9eqUBsGaFfJ0XhdSZ4wab02c+ggCohc5L/dCXzqhVBvH/2yOcmUnFPdyyB4JTp4XT
         WFCcImS862Qyb3pmgG1wCKshwwkpgEqJKZ8ud8+5xQgmReoBb6xRme3yZci7v8bKh7cV
         tb7uE4Pb7tHB642aTaiDQlaOvSd81bGjeyarEWiNKahaWeqg9cz9110AFw/QpTSjIEiu
         81wjxZPzUpxCWxv0l4IItLK7TVnPimKJLkjJ3ymkt9Kv9esPbBVvjDRGi1m+pS5xtwNf
         YTdYL3nUo0SE5vpPfU9FonOnzl31r3e5f6z7L7BaXLpwhxaL65DnuDOtK7ywPSB7Ex0+
         jsaA==
X-Gm-Message-State: AJcUukfayI+oR+VA7kGkq2Kwlrj1kt9Djxl32ecl5XAeJrEzg7UeE0vl
        hN0VjSVvSz10XfobbjWZ0rroXbcJ
X-Google-Smtp-Source: ALg8bN74mvUcVNNLzdFv5MHwBzjDO3LPpehFGCg3Y71CwxqPX0g2INTev3OzEiNXPHApPyGhdKBGxw==
X-Received: by 2002:a63:9256:: with SMTP id s22mr28753046pgn.224.1546087828166;
        Sat, 29 Dec 2018 04:50:28 -0800 (PST)
Received: from nb166 ([42.190.45.35])
        by smtp.gmail.com with ESMTPSA id 5sm76736750pfz.149.2018.12.29.04.50.27
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Dec 2018 04:50:27 -0800 (PST)
Message-ID: <041ba83b-43463-01ab8682544444@nb166>
Reply-To: "Khaled Ahmed" <khaled@iris.com.my>
From:   "Khaled Ahmed" <khaledahmed1964@gmail.com>
To:     git@vger.kernel.org
Subject: IRIS Expands Partnership & Services of Biometric Secure Products &
 Solutions
Date:   Sat, 29 Dec 2018 20:50:19 +0800
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Priority: 3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Greetings from IRIS Corporation Berhad (“IRIS”)
It gives us great pleasure to introduce IRIS, a global technology solution provider with legal and beneficial ownerships of systems and technologies relating to smartcard based applications and solutions such as, but not limited to, national eID card, ePassport, edriver’s license and other similar electronic credentials. 
A Malaysian company incorporated in 1994 with its headquarters located in Kuala Lumpur, Malaysia, IRIS is listed on Bursa Malaysia (ACE market) since 2002 with significant international presence in 34 countries across the globe.  
In addition to ePassports and multi-application national eCredentials, IRIS offers EMV (EuroPay, MasterCard and Visa) and AMEX (American Express)certified payment cards for the banking and financial industry IRIS also offers bus and train ticketing and key management system, biometric time attendance system with facial recognition and geo-fencing, integrated handheld terminals, scanners and readers for eCredential authentication, biometric smart card readers, automated border control system, including eGate and kiosks. 
Whether for deployment in public or private settings, IRIS secure, end-to-end solutions are scalable and customizable for applications across different platforms including schools, banks, ports, hospitals, etc.
Please find below list of hyperlinks to IRIS Trusted ID Products and Solutions:
       Smart Solutions 
1.	IRIS eID Solution
2.	IRIS ePassport Solution
3.	IRIS Border Control Solution
4.	IRIS eVisa Solution
5.	IRIS Driver’s License Solution
6.	IRIS Voter’s Card Solution
7.	IRIS Electronic Payment Solution
8.	IRIS Automated Fare Collection Solution
9.	IRIS Secure Document Solution
10.	IRIS Biometric Time Attendance Solution
11.	IRIS Biometric Identification Solution
       Smart Devices
1.	Smart Card and Biometric Card Readers 
2.	Passport Readers 
3.	Mobile Terminals 
4.	Personalisation Cards and Passport Laser Markers
5.	Mobile Units {MEU}
6.	Smart Gates and Kiosk
7.	Transportation Readers 
Smart Cards
1.	Multi-app eID card
2.	Voters ID
3.	Driver's License
4.	Residence Permit 
5.	ePassport/ Visa
 Payment/ Transport/ Loyalty/ Membership/ Access Cards
1.	Credit Cards and ATM Cards
2.	eWallet Card 
3.	Transportation Cards
We append herewith our profile for your ease of reference and hope that we are given the opportunity to present our credentials to your goodself and subsequently to the relevant Departments and Ministries.

We look forward to your kind reply.
Kind Regards,

Khaled Ahmed Adel El - Sherief
Director of Sales

IRIS CORPORATION BERHAD
 
IRIS Smart Technology Complex, Technology Park Malaysia, Bukit Jalil, 57000  Kuala Lumpur, Malaysia.
Tel : +603-89960788  |  Email: khaled@iris.com.my  |  HP : +60123343910  |  www.iris.com.my 
 

