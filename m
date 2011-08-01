From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Possibly solved invalid free() in git-remote-http from Git 1.7.2.1
Date: Mon, 1 Aug 2011 17:42:54 +0200
Message-ID: <CACBZZX5N0DaSrU6rxW=PTMQ8b6c_sxMFJQHMaZy1L138eFFo6w@mail.gmail.com>
References: <CACBZZX7s+NeH2jLC9Ym65_rMQkgVmfbCAkqZbBFhTiY9U8uP2A@mail.gmail.com>
	<CACBZZX5s8+O8X2mpexudGEsaQRm+tr0CQvqTZjZ700DN297__w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Tay Ray Chuan <rctay89@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 01 17:43:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qnudw-0001eq-SK
	for gcvg-git-2@lo.gmane.org; Mon, 01 Aug 2011 17:43:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753141Ab1HAPm5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 1 Aug 2011 11:42:57 -0400
Received: from mail-ey0-f171.google.com ([209.85.215.171]:62543 "EHLO
	mail-ey0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753092Ab1HAPmz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Aug 2011 11:42:55 -0400
Received: by eye22 with SMTP id 22so4650538eye.2
        for <git@vger.kernel.org>; Mon, 01 Aug 2011 08:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=2a+xnCQe6IjUzecQnsbcvZ/13E7b1bwt4lX/qNbhhd0=;
        b=iq5Ybew/knQGhxo9VDqydfDKVj2FIkClUVnVzaLmqM4hqk/ujAVgOAxt7N3EqoiFSI
         p1iVj3qQ4AO5bqqPbWosMYOGjNH92HX2QI6S7ouUm6FTtWKRFvZ+aI6QC/ztsWW3SZib
         gY9LRuzoxr9DqXmrmIvdTJYsgjEI9WwAVkor8=
Received: by 10.204.140.134 with SMTP id i6mr1264053bku.189.1312213374342;
 Mon, 01 Aug 2011 08:42:54 -0700 (PDT)
Received: by 10.204.123.66 with HTTP; Mon, 1 Aug 2011 08:42:54 -0700 (PDT)
In-Reply-To: <CACBZZX5s8+O8X2mpexudGEsaQRm+tr0CQvqTZjZ700DN297__w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178353>

On Mon, Aug 1, 2011 at 17:39, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <a=
varab@gmail.com> wrote:
> On Mon, Aug 1, 2011 at 17:22, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason =
<avarab@gmail.com> wrote:
>> In case anyone would like to look into this I had this undiagnosed
>> free() error from git-remote-http in git version 1.7.2.1:
>
> Actually this is still an issue in master, CC-ing Tay who introduced
> this error.
>
> This evil hack would get around it most of the time, but would
> introduce another race condition:

*brainfart*. This would be better:

    diff --git a/http.c b/http.c
    index a1ea3db..c5da23a 100644
    --- a/http.c
    +++ b/http.c
    @@ -1298,7 +1298,7 @@ struct http_object_request
*new_http_object_request(const char *base_url,
                            if (ftruncate(freq->localfile, 0) < 0) {
                                    error("Couldn't truncate temporary
file %s: %s",
                                              freq->tmpfile, strerror(e=
rrno));
    -                               goto abort;
    +                               goto abort_url;
                            }
                    }
            }
    @@ -1328,9 +1328,10 @@ struct http_object_request
*new_http_object_request(const char *base_url,

            return freq;

    +abort_url:
    +       free(freq->url);
     abort:
            free(filename);
    -       free(freq->url);
            free(freq);
            return NULL;
     }
