From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Possibly solved invalid free() in git-remote-http from Git 1.7.2.1
Date: Mon, 1 Aug 2011 17:39:23 +0200
Message-ID: <CACBZZX5s8+O8X2mpexudGEsaQRm+tr0CQvqTZjZ700DN297__w@mail.gmail.com>
References: <CACBZZX7s+NeH2jLC9Ym65_rMQkgVmfbCAkqZbBFhTiY9U8uP2A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Tay Ray Chuan <rctay89@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 01 17:39:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QnuaX-0008PA-8b
	for gcvg-git-2@lo.gmane.org; Mon, 01 Aug 2011 17:39:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752926Ab1HAPjZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 1 Aug 2011 11:39:25 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:42787 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752318Ab1HAPjY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Aug 2011 11:39:24 -0400
Received: by fxh19 with SMTP id 19so4675929fxh.19
        for <git@vger.kernel.org>; Mon, 01 Aug 2011 08:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=HLyHb2rCnUXpqkezpNgnCRiSrcFajY7nkvLO1rXbCe8=;
        b=PNMqYDhLJ8zTjspVsYueB6yjzMztaYkaI075xIKYedL40BWLtPbK8EzyqxY06txYrf
         hEw3LXAn7mGbaWP9W/0//WgI04FcllR+fzwnfFhPssI32aY1WUxoP1bvuliqqZUZgaxL
         nxfVevi+Py7ISAP75Xudpb6rTh7IkUpiaqbOc=
Received: by 10.204.142.85 with SMTP id p21mr772469bku.241.1312213163327; Mon,
 01 Aug 2011 08:39:23 -0700 (PDT)
Received: by 10.204.123.66 with HTTP; Mon, 1 Aug 2011 08:39:23 -0700 (PDT)
In-Reply-To: <CACBZZX7s+NeH2jLC9Ym65_rMQkgVmfbCAkqZbBFhTiY9U8uP2A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178351>

On Mon, Aug 1, 2011 at 17:22, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <a=
varab@gmail.com> wrote:
> In case anyone would like to look into this I had this undiagnosed
> free() error from git-remote-http in git version 1.7.2.1:

Actually this is still an issue in master, CC-ing Tay who introduced
this error.

This evil hack would get around it most of the time, but would
introduce another race condition:

    diff --git a/http.c b/http.c
    index a1ea3db..ba81158 100644
    --- a/http.c
    +++ b/http.c
    @@ -1212,6 +1212,7 @@ struct http_object_request
*new_http_object_request(const char *base_url,
            ssize_t prev_read =3D 0;
            long prev_posn =3D 0;
            char range[RANGE_HEADER_SIZE];
    +       int allocated_url =3D 0;
            struct curl_slist *range_header =3D NULL;
            struct http_object_request *freq;

    @@ -1260,6 +1261,7 @@ struct http_object_request
*new_http_object_request(const char *base_url,
            git_SHA1_Init(&freq->c);

            freq->url =3D get_remote_object_url(base_url, hex, 0);
    +       allocated_url =3D 1;

            /*
             * If a previous temp file is present, process what was alr=
eady
    @@ -1330,7 +1332,8 @@ struct http_object_request
*new_http_object_request(const char *base_url,

     abort:
            free(filename);
    -       free(freq->url);
    +       if (allocated_url)
    +               free(freq->url);
            free(freq);
            return NULL;
     }

One option would be to memzero freq, but that'll trip up xmalloc which
tries to set things to 0xA5 under XMALLOC_POISON. I don't know what
the proper way to solve this would be.
