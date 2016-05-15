From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v1 2/3] read-cache: factor out get_sha1_from_index() helper
Date: Sun, 15 May 2016 02:45:49 -0400
Message-ID: <CAPig+cRiu_oJZhPj+QPY6JpcEn=d8VWdHU90XThN9_88JryZ_g@mail.gmail.com>
References: <20160513134953.GE2345@dinwoodie.org>
	<1463294297-20215-1-git-send-email-tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sun May 15 08:46:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b1poJ-0001Pc-6h
	for gcvg-git-2@plane.gmane.org; Sun, 15 May 2016 08:45:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752782AbcEOGpu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 15 May 2016 02:45:50 -0400
Received: from mail-io0-f179.google.com ([209.85.223.179]:35328 "EHLO
	mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752039AbcEOGpu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 May 2016 02:45:50 -0400
Received: by mail-io0-f179.google.com with SMTP id d62so177744728iof.2
        for <git@vger.kernel.org>; Sat, 14 May 2016 23:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-transfer-encoding;
        bh=lwaoSB0z5DEumtL0ZZ/a2eEAiLoU485YO4r6cbNx03g=;
        b=W9SJkdVc6W8KyRCdqvVZ5ixC1t+lzBIck++HljqcUxDVfGP9feoGgMCW1wf1kkjHpF
         ClciROnEyxQPqDlcnHP2l4/h/vHfLcdYZ5EUkTas2T2rQFBYosZvL+YX6gByQUZ9wurm
         bwyUtv+IDrY/0sh4x97plgs51B7NN/JMIU1yGjoSsoI254frzvWYDv4LVxGILzfz0o4h
         9Q9FAhxUqwnWmkRLTYNvIiSbpG9vkIjmT4aUvLGu4ubzEJ8y2HfFZSLh5ENC0AKGLDf2
         Cm2gaTd1vysGkBPR+fFw0CeIIYBwK/Asn1DLdsGqT1LJksGR3RDXRGFNYc1FzChCNBue
         ZN+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-transfer-encoding;
        bh=lwaoSB0z5DEumtL0ZZ/a2eEAiLoU485YO4r6cbNx03g=;
        b=LWB31elPItUAFzC05SAV4ewFWnRmaS5iniypeVHQkYTuU1tJ7HUanFXNYO2Hvi0YUs
         lni0UNYEmR1N+QXwZgQMfW7y7kEuii6b10X9WOPnz3GIKwAy9VPxGX3YFv/4WJivtfnE
         u04QQcvsVVNKRFpdRQm9LjTIpnES5FWNYLBLIZaDn/BNJvX1WEr/SPDTXBrbt6zTg43J
         7FRzoUBfIKLM0BP6hVjTEYoj8Tz9dDGckWoDuE1iaquhrht27jZJkHTBt+78etlD3nnJ
         W4z4vcTb9nnY9DSwB2tegwaRkXn3Y8s18gzVwMpazYyNLGBFiojEpACkaDyDrDqz4RGX
         yj5w==
X-Gm-Message-State: AOPr4FUcBZLb+sBmgcgvzyYzUjidUl3oxrqMYtRmBKYW7y8hpRZ3lOZMowwutpg4D1Cr0167LsFGsvpO9zxJMQ==
X-Received: by 10.107.132.66 with SMTP id g63mr17701663iod.34.1463294749306;
 Sat, 14 May 2016 23:45:49 -0700 (PDT)
Received: by 10.79.139.4 with HTTP; Sat, 14 May 2016 23:45:49 -0700 (PDT)
In-Reply-To: <1463294297-20215-1-git-send-email-tboegi@web.de>
X-Google-Sender-Auth: XFh9ykWKnOzu5WF3Xk8rYH-pFqs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294643>

On Sun, May 15, 2016 at 2:38 AM,  <tboegi@web.de> wrote:
> Factor out the retrieval of the sha1 for a given path in
> read_blob_data_from_index() into the function get_sha1_from_index().
>
> This will be used in the next commit, when convert.c can do the
> analyze for "text=3Dauto" without slurping the whole blob into memory
> at once.
>
> Add a wrapper definition get_sha1_from_cache().
>
> Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
> ---
> diff --git a/cache.h b/cache.h
> @@ -379,6 +379,7 @@ extern void free_name_hash(struct index_state *is=
tate);
>  #define read_blob_data_from_cache(path, sz) read_blob_data_from_inde=
x(&the_index, (path), (sz))
> +#define get_sha1_from_cache(path)  get_sha1_from_index (&the_index, =
(path))

s/\s+/ /
