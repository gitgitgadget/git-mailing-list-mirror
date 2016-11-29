Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_20,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C80A1FC96
	for <e@80x24.org>; Tue, 29 Nov 2016 23:03:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756343AbcK2XDI (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Nov 2016 18:03:08 -0500
Received: from mail-oi0-f50.google.com ([209.85.218.50]:36273 "EHLO
        mail-oi0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756164AbcK2XDG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Nov 2016 18:03:06 -0500
Received: by mail-oi0-f50.google.com with SMTP id v84so209159099oie.3
        for <git@vger.kernel.org>; Tue, 29 Nov 2016 15:03:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=informer-com.20150623.gappssmtp.com; s=20150623;
        h=sender:date:to:from:reply-to:subject:message-id:mime-version
         :content-transfer-encoding;
        bh=mCRqOtZW8pd+52mKL1XvrEkT8YoVzNwk3ImmKsKlMYo=;
        b=NcKwapDcDB0Ss3RGKoAw8ajagPsAVKzKrjGcuME1koWwm4eBsVN60dPfGBKqmfath2
         0VGRdmHUYLIOHB4C3xTiBwKnycMsxSf7/haVcPogJaigqxz2T6FbIiZU1/mvAb5T6jJB
         raYSk8vhXuXaJJXXNntIyMJlKmHTu07/NqJ1n4YZDELC3zjEyWjlGWZQkkoQsxKUFnn8
         SS9bnPovOpOQ7pFOXFShiGERCvJUCtyG6kNqrWXqAoVpWTyIo9o5A9kTArzs3iBq/Nfl
         AlujHlkIl8RC3ZV4P08KRY4cleQgMKrLnDbyJp6uyH3StpayxNHtfXcX54DembG/bzmt
         lLvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:date:to:from:reply-to:subject:message-id
         :mime-version:content-transfer-encoding;
        bh=mCRqOtZW8pd+52mKL1XvrEkT8YoVzNwk3ImmKsKlMYo=;
        b=WvaQaB7MsCPKVTx8P8cz5DbQtIscKG+QEbzIFWtJseoFrAVHbdTfkFf6hIpzlCvgv3
         cxIdhQmjyvlY6e7ylPIUXjRNKtxbiepspzYG/bLkQIBxU50Zm3yBMCi57z26jJVS/7C6
         uBXk1kgzF70nkZcokr+sPEinqppU7WkqOPdlFxNvzrVC7vHQEEQg893J81F+SY1+xZu/
         10oBWs1xMSJzb4u00S8qMwhZefNihSVy0RFE5rDZZRp9V8glSDT7oNGXNszDbRB6Gv6p
         oBqnvwSz7JbM5D/1yy0rcjLHVD1WIxHj3Xuq1znsre6N26awI1rgQR28m1UU/4UafSDE
         8NAA==
X-Gm-Message-State: AKaTC01YQDmWzTXl7vWvDX3TZqku+JMzK9g6aJiXBmaDED03j65JRiWLDIYp3S2X23yEbA==
X-Received: by 10.157.30.202 with SMTP id n68mr16211643otn.200.1480460585594;
        Tue, 29 Nov 2016 15:03:05 -0800 (PST)
Received: from software.informer.com (27.28.24ae.ip4.static.sl-reverse.com. [174.36.40.39])
        by smtp.gmail.com with ESMTPSA id t78sm19775318oih.19.2016.11.29.15.03.01
        for <git@vger.kernel.org>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 29 Nov 2016 15:03:02 -0800 (PST)
Date:   Tue, 29 Nov 2016 18:03:01 -0500
To:     git@vger.kernel.org
From:   Kasey Bloome <partners@informer.com>
Reply-to: Kasey Bloome <partners@informer.com>
Subject: GIT by github 2.10.2.1 is listed on Software Informer
Message-ID: <83cbc4e356b42a010a9996e3c7e134f9@software.informer.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="iso-8859-1"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Good day!

Software.informer.com would like to inform you that your product GIT by github 2.10.2.1 has been reviewed by our editors and your program got "100% Clean Award" http://git.software.informer.com/.

We would be grateful if you place our award with a link to our review on your website. On our part, we can offer featuring your program in our Today's Highlight block. This block is shown in the rotator at the top of the main page and also on every page of our website in the upper right corner.

We also offer you to take advantage of our free storage by hosting your installation package on our servers and listing us as one of the mirror downloads for your application. There is a selection of predesigned buttons available to fit the look of your website.

Please let me know if you're interested in any of these offers.

We are on the list of the world's 500 most visited websites with over 700,000 unique visitors every day, so this could get your application some extra exposure.

Kind regards,
Kasey Bloome


