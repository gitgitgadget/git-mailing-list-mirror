From: Mike Gorchak <mike.gorchak.qnx@gmail.com>
Subject: Re: [PATCH 1/1] Fix date checking in case if time was not initialized.
Date: Mon, 25 Feb 2013 21:32:52 +0200
Message-ID: <CAHXAxrOjSS5jGLcCw4KTxP_F_uRQhi0cPSvzbx58jx9dP25XPA@mail.gmail.com>
References: <CAHXAxrOOqn6ZSVT1AFyO3a3paD1tokBtcnaX68a+ddhodOvZ6Q@mail.gmail.com>
	<7vzjysxnb1.fsf@alter.siamese.dyndns.org>
	<CAHXAxrMaQRdBxSvNO+no_9d==v0tVnkpXtguTKyfvnm-VfR_xA@mail.gmail.com>
	<7vr4k4xlie.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 25 20:33:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UA3nd-0007dN-4v
	for gcvg-git-2@plane.gmane.org; Mon, 25 Feb 2013 20:33:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759480Ab3BYTc4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Feb 2013 14:32:56 -0500
Received: from mail-qa0-f52.google.com ([209.85.216.52]:44769 "EHLO
	mail-qa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759188Ab3BYTc4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Feb 2013 14:32:56 -0500
Received: by mail-qa0-f52.google.com with SMTP id bs12so1802216qab.18
        for <git@vger.kernel.org>; Mon, 25 Feb 2013 11:32:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=RMoADExI/28Nmv4BB0EdS8JTkYxppEczz6+J3JiaQbQ=;
        b=CXHxxnMQ7rO/WOAUDz6gYwwSgOIq/IIdA14VHLnWgZ0qbUwPdOZiyOQ4JHGesEWOw+
         ADlXHF7OHQSTKbs4vwN0KswHQw1wMWKW7Wog9i9DByEEpEZZF6Yfgk3tA5Fa/HZzsQD1
         L9nnGacxSLW0VBF1heVRAdpg/+ioSoooBUiEvoxrHpaSYnY+0Ne2RkqYECVujUcCveC5
         LcSWDpROlzjuC/nAikEswVP1fkSLll06yto46KCnJpXlVhbs/VlxsD8nq6XAW5kkgD0k
         sw0QsTcrRPSAj+vTMzpv+1Q4sSpOXYgROEZUOV3sn8qlkNpeODFzQbJmw96Jnko6XDKX
         elBA==
X-Received: by 10.229.179.23 with SMTP id bo23mr3118951qcb.104.1361820772320;
 Mon, 25 Feb 2013 11:32:52 -0800 (PST)
Received: by 10.49.71.68 with HTTP; Mon, 25 Feb 2013 11:32:52 -0800 (PST)
In-Reply-To: <7vr4k4xlie.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217093>

> The thing that puzzles me is that nobody reported that the following
> fail on their platforms (and they do not fail for me on platforms I
> have to test in my real/virtual boxes).

Ok, check_parse calls function parse_date(), it calls
parse_date_basic(), where following code is present:

	memset(&tm, 0, sizeof(tm));
	tm.tm_year = -1;
	tm.tm_mon = -1;
	tm.tm_mday = -1;
	tm.tm_isdst = -1;
	tm.tm_hour = -1;
	tm.tm_min = -1;
	tm.tm_sec = -1;

Almost all fields are set to -1. A bit later match_multi_number() is
called. It parses the date and calls is_date() with partially filled
tm structure, where all time fields: tm_hour, tm_min, tm_sec are set
to -1. tm_to_time_t() function is called by is_date() and has special
check:

	if (tm->tm_hour < 0 || tm->tm_min < 0 || tm->tm_sec < 0)
		return -1;

So is_date() always return negative result for the text string where
date is placed before time like '2008-02-14 20:30:45'. It must fail on
other platforms as well.
