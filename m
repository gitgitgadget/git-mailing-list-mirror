From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git on vagrant shared folder
Date: Thu, 16 Jul 2015 09:41:28 -0700
Message-ID: <xmqq7fq05a2v.fsf@gitster.dls.corp.google.com>
References: <7C05ACF4-6536-4E60-BC92-FF7F0E266C0D@e-confirm.de>
	<20150714183215.GG7613@paksenarrion.iveqy.com>
	<CAGZ79kbBKzbjbg5u7A7BgnV1JF=5A+-gb0OdYs11g6kx_UQu_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Fredrik Gustafsson <iveqy@iveqy.com>,
	Peter =?utf-8?Q?H=C3=BCfner?= <p.huefner@e-confirm.de>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Jul 16 18:41:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZFmE5-0000Oc-V3
	for gcvg-git-2@plane.gmane.org; Thu, 16 Jul 2015 18:41:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751589AbbGPQlc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 16 Jul 2015 12:41:32 -0400
Received: from mail-ig0-f195.google.com ([209.85.213.195]:33712 "EHLO
	mail-ig0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751360AbbGPQlc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jul 2015 12:41:32 -0400
Received: by igbqa2 with SMTP id qa2so1460481igb.0
        for <git@vger.kernel.org>; Thu, 16 Jul 2015 09:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=PS+Ifi2ZNEP4lpZaWgvpTbP18JFH/v82wOm/yTgEqEc=;
        b=A4gk2XblLZkiysD30CeYgj3WRoj7UxcO2dY9wmzbhbhLR1HaUcKrKkg2QQcT1D2Mtt
         LmIT30eHm7FbEOKSx13QuJU+Kg8yVtQjyJtDg0D4345y/Rtd9rq9AJsyhrKqQ0GNvfRA
         45SgYYEma3DU1fX8a532grgJFNLnFVjQ1OmHv5Y5IgRibvk/EKwxwrnVZJN/bSsfRgO+
         5bcbJ3Jxe5VMLDuDIXX7GEx9/8URf/UNFP2civa4BLiE0/S+bQucoY6KGsATsSzwqDuZ
         dd8CeFDTIYVP9St8VLJcUAkaPhB+oK2x5imrCrx0Nww3XGfRcBLFTLqFtw1xyixIZn4o
         YRwQ==
X-Received: by 10.107.7.214 with SMTP id g83mr14334025ioi.28.1437064891312;
        Thu, 16 Jul 2015 09:41:31 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:117b:74b0:a5d4:7d4c])
        by smtp.gmail.com with ESMTPSA id 69sm5335077ioz.10.2015.07.16.09.41.29
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 16 Jul 2015 09:41:29 -0700 (PDT)
In-Reply-To: <CAGZ79kbBKzbjbg5u7A7BgnV1JF=5A+-gb0OdYs11g6kx_UQu_A@mail.gmail.com>
	(Stefan Beller's message of "Tue, 14 Jul 2015 11:53:52 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274032>

Stefan Beller <sbeller@google.com> writes:

>>> A few weeks ago we weren=E2=80=99t able to clone and get an error: =
could
>> not commit /vagrant/.git/config file. Manually we were able to
>> change that file and also the clone command works outside the shared
>> folder.
>>
>> Why are you trying to commit a file inside the .git dir? Files in th=
at
>> dir should not be commited (and I'm pretty sure there was a patch ab=
out
>> this a while ago). The .git/config file for example is local to each=
 git
>> repo and should not be commited.
>
> Actually it is considered a security risk, see
> http://article.gmane.org/gmane.linux.kernel/1853266

I do not think Peter meant to "git add .git/config && git commit" by
referring to the 'could not commit config file' error message he
saw; you two are going in a wrong direction.

    $ git grep 'could not commit'
    config.c: error("could not commit config file %s", config_filename)=
;

I do share Fredrik's suspicion that the virtual filesystem the
Ubuntu guest is trying to write to is at fault, but I never used
"vagrant shared", and I do not know in what specific way their
filesystem is not behaving as we expect.

Applying 7a64592c (config.c: fix writing config files on Windows
network shares, 2015-06-30) might be an interesting thing to try.
Some filesystems do not want to rename a file that has mmaped region
still active, which is my blind guess.
