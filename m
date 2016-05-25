From: Luke Madhanga <lmadhanga@gmail.com>
Subject: Re: Why is my git-http-backend solution using WebDAV on push?
Date: Wed, 25 May 2016 22:54:13 +0100
Message-ID: <CABwKKP89Ncht0MfB7X1x15a6PB-Nm68SDGEDvX1AnQdDucXQkA@mail.gmail.com>
References: <CABwKKP958cW3a5Cjxox+1FCtNLetdufJj0rrYBouAUhJSXKKWA@mail.gmail.com>
	<20160525213850.GB13776@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed May 25 23:59:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5gqG-0007Kd-L9
	for gcvg-git-2@plane.gmane.org; Wed, 25 May 2016 23:59:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751833AbcEYV7s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 May 2016 17:59:48 -0400
Received: from mail-vk0-f45.google.com ([209.85.213.45]:35251 "EHLO
	mail-vk0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751810AbcEYV7s (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2016 17:59:48 -0400
Received: by mail-vk0-f45.google.com with SMTP id f66so80813633vkh.2
        for <git@vger.kernel.org>; Wed, 25 May 2016 14:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=Z5lyCu38jMdbOCqmFPLOBCcOqrZEzkg9+wo2Ea8MJ24=;
        b=gV+wg1lOyURCsSWRYSyHjyiclnMLPRB7R8fC1w6kCWGDez/HETyimg/TtCyWjcnZQu
         Go2cInLMzo2nYFU9fsNxXPwEpkP6bNAV1mDlALGYpydRiZ4RuVgK/XkXLQfDkZHsWKMX
         1KY0/vUEv5SlRie+CAhd6ffPlWAiSkJcRm+ka5jyUJA5ZOjVJbseMdJNu8+07KFpKfiX
         z2ISgwffBTeXK3rBDXl02YHa88k/I1R278FA8mugdk7Z4/HAR4z/on2Yi93HOUbcQBF7
         2rFCbCYdJxwzphobr/PWCd0YX8F1SZcUkwTiKQHEk0Rm/sOxCU8DvOMwnVM/xPb6YmDR
         gHMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=Z5lyCu38jMdbOCqmFPLOBCcOqrZEzkg9+wo2Ea8MJ24=;
        b=O/anQoUL5YjnW0AOSPvY3HqNuZRbqihPKo6BKYjGmd9IeItThiNgZuB8QUrxuqwpye
         Ut1EAsgLcacHD6N/GnBG5Ie7GmbNbPBtCYsHMx6TZ61QzPJhoB+FCyO3YcTofZoBi1Gp
         FX5N4TeSI2t5oKTdhQ5dnDSd+7J1QVOGN0LrXBBb3Ega0ILiwk1miIzyaGj978WwgdqK
         jh94KPxsDtWh3axVqCTIrh8dz+57jS5bXRw6uNPghp7xN+0U1iBkL89MfbLyrzBZBe2a
         O0NX0t+czuTkOkboWMGyp4ulMULPFX48MXWhzIlkTNd+ofZb9wVyoMmEipB4XHHV4cgl
         iHbA==
X-Gm-Message-State: ALyK8tLJpJnikgrP//SCdFRf5NrLsA9xzXEmcXadvnBFtb7Xk1fRpLfjeYYrm70OiYZwuI56Q4/FUZkbpnVb0g==
X-Received: by 10.31.98.135 with SMTP id w129mr3296723vkb.106.1464213253645;
 Wed, 25 May 2016 14:54:13 -0700 (PDT)
Received: by 10.176.4.76 with HTTP; Wed, 25 May 2016 14:54:13 -0700 (PDT)
In-Reply-To: <20160525213850.GB13776@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295593>

Hmmmm. Interesting.

When you look at the PHP code, you'll see the following

    $res = self::proc_open("{$gitcoredir}/git-http-backend", [],
$gitdir, true, [...]);
    ...
    $resbits = explode("\n", $res);
    foreach ($resbits as $index => $header) {
        if ($header && strpos($header, ':') !== false) {
            // Headers
            header($header);
            unset($resbits[$index]);
        } else {
            // First blank line is the space between the headers and
the start of the response from Git
            break;
        }
    }
    echo ltrim(implode("\n", $resbits));
    exit;


Everything being returned is from a direct call to the git-http-backend.

A manual CLI call to git-http-backend doesn't include
'application/x-git-receive-pack-advertisement'

REQUEST_METHOD=GET GIT_PROJECT_ROOT=/path/to/core/
PATH_INFO=/repo.git/info/refs /usr/lib/git-core/git-http-backend

The above command outputs

Expires: Fri, 01 Jan 1980 00:00:00 GMT
Pragma: no-cache
Cache-Control: no-cache, max-age=0, must-revalidate
Content-Length: 118
Content-Type: text/plain

f4648182f5f8eee082c37a83a0072cfc4210e5c5 refs/heads/master
8c4efcd77809bc9b94a59cf94653add8007c6b7d refs/heads/zztest
