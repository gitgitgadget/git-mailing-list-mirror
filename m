From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 02/13] xread: poll on non blocking fds
Date: Tue, 22 Sep 2015 08:58:19 -0700
Message-ID: <xmqqh9mm5tus.fsf@gitster.mtv.corp.google.com>
References: <1442875159-13027-1-git-send-email-sbeller@google.com>
	<1442875159-13027-3-git-send-email-sbeller@google.com>
	<CAPig+cQKOEYYR3j-uEeFzF3-qAfqq4SdQrH8LPmSP0VmAOCtzw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>, Git List <git@vger.kernel.org>,
	Jacob Keller <jacob.keller@gmail.com>,
	Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Vitali Lovich <vlovich@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Sep 22 17:58:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZePxd-0004LS-Th
	for gcvg-git-2@plane.gmane.org; Tue, 22 Sep 2015 17:58:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933589AbbIVP6Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Sep 2015 11:58:25 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:36675 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932456AbbIVP6W (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Sep 2015 11:58:22 -0400
Received: by pacgz1 with SMTP id gz1so10121131pac.3
        for <git@vger.kernel.org>; Tue, 22 Sep 2015 08:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=cgWnVOVZdFKekX4594tffNWJLZeTuiNlUna/Ws/vvzk=;
        b=Zvn8Aug/MMhdwe8Am7ICpq/aZNWxF22ylR/0hkt74GmMkoLlU8nm6TiNSrrsSW4Q/h
         pgYoxTT2u88aTlPpFRZhh37MYSVTOusgJXMO4kAKY7Tg37gYnDSfi/Q1sTr7lcug3qtf
         6r7ywVd8ZZnOdbkVajUXxGHdpWEz9sL4fVxabCWyBo98/V7WSIMdrkxGWAlIEA2T0ce9
         Mlr6lfBRQtw92L6Jlpa7v6LOXa49dL+tDq9OLDnpYDCOLfWBhDZUtaVaC0JRNea+gc/2
         o7aMfwZATE8syVG4QyBL8UtX7xO0yC2+cIh3+QRoOhddVXcD2f8YqrkbOqHNls3opHy5
         OH7A==
X-Received: by 10.68.68.133 with SMTP id w5mr31724858pbt.143.1442937502084;
        Tue, 22 Sep 2015 08:58:22 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:fd7e:7071:2eda:9c63])
        by smtp.gmail.com with ESMTPSA id qy5sm3112911pbb.16.2015.09.22.08.58.20
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Tue, 22 Sep 2015 08:58:20 -0700 (PDT)
In-Reply-To: <CAPig+cQKOEYYR3j-uEeFzF3-qAfqq4SdQrH8LPmSP0VmAOCtzw@mail.gmail.com>
	(Eric Sunshine's message of "Mon, 21 Sep 2015 19:56:56 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278396>

Eric Sunshine <sunshine@sunshineco.com> writes:

>>         while (1) {
>>                 nr = read(fd, buf, len);
>> -               if ((nr < 0) && (errno == EAGAIN || errno == EINTR))
>> -                       continue;
>> +               if (nr < 0) {
>> +                       if (errno == EINTR)
>> +                               continue;
>> +                       if (errno == EAGAIN || errno == EWOULDBLOCK) {
>> +                               struct pollfd pfd;
>> +                               int i;
>> +                               pfd.events = POLLIN;
>> +                               pfd.fd = fd;
>> +                               i = poll(&pfd, 1, 100);
>
> Why is this poll() using a timeout? Isn't that still a busy wait of
> sorts (even if less aggressive)?

Good point.  If we _were_ to have this kind of "hiding issues under
the rug and continuing without issues" approach, I do not think we
would need timeout for this poll(2).  The caller accepted that it is
willing to wait until we read up to len (which is capped, though) by
not calling the nonblocking variant.
