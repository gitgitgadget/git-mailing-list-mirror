From: karthik nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 2/3] sha1_file: implement changes for "cat-file --literally
 -t"
Date: Thu, 05 Mar 2015 06:56:38 +0530
Message-ID: <54F7B0CE.4070006@gmail.com>
References: <54F5888B.7040400@gmail.com> <1425377556-25332-1-git-send-email-karthik.188@gmail.com> <xmqqy4nc7a4w.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 05 02:26:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTKYv-0006io-2u
	for gcvg-git-2@plane.gmane.org; Thu, 05 Mar 2015 02:26:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753787AbbCEB0n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Mar 2015 20:26:43 -0500
Received: from mail-pd0-f177.google.com ([209.85.192.177]:43199 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753782AbbCEB0m (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Mar 2015 20:26:42 -0500
Received: by pdjp10 with SMTP id p10so24794488pdj.10
        for <git@vger.kernel.org>; Wed, 04 Mar 2015 17:26:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=rLuexCGBjS2qcr5dkXAWvN6x3EuV2//IXI5kdT4pc6w=;
        b=bbr/qgWaNodLE5Yg5qI0hS+mfqa7Jq+ICzlO+PIPloH3mES8DqYk1tLNcJYvgmf+bQ
         Gbi9MXBlJ+FFnQHeRc3uOSXhcg7zG0NISKu+MJ2bIP66Ucxq9QrsWQ0uRMRCVpzxAYOR
         uAzEPDyU2gMgnegzA2H9ljNu5Se1KphE05bVWXow3gxgduPSj3Ep4/zY+9tGhh5p5lpt
         q1PgiWViYo1jc1B8kWUkv4yb0Fa9hqML30uBWSloWHqAja2rFFeYTYxyUJRBaL7PR0fz
         5hc9cYzOIgAXIB3BVmfXHZo6Gt0RggDUkFHI9Pol7PmaS9Y/62EYhWUnirj4Bmabl/Cy
         4V+w==
X-Received: by 10.70.46.65 with SMTP id t1mr11290782pdm.128.1425518802311;
        Wed, 04 Mar 2015 17:26:42 -0800 (PST)
Received: from [192.168.0.102] ([103.227.98.178])
        by mx.google.com with ESMTPSA id ny1sm5128078pbb.77.2015.03.04.17.26.40
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Mar 2015 17:26:41 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
In-Reply-To: <xmqqy4nc7a4w.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264807>


On 03/05/2015 02:28 AM, Junio C Hamano wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
> > add "sha1_object_info_literally()" which is to be used when
> > the "literally" option is given to get the type of object
> > and print it, using "sha1_object_info_extended()".
> >
> > add "unpack_sha1_header_literally()" to unpack sha headers
> > which may be greater than 32 bytes, which is the threshold
> > for a regular object header.
> >
> > modify "sha1_loose_object_info()" to include a flag argument
> > and also include changes to call "unpack_sha1_header_literally()"
> > when the literally flag is passed. Also copies the obtained
> > type to the typename field of object_info.
> >
> > modify "sha1_object_info_extended()" to call the function
> > "sha1_loose_object_info()" with flags.
> >
> > Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> > ---
> >   sha1_file.c | 84 +++++++++++++++++++++++++++++++++++++++++++++++++++++++------
> >   1 file changed, 77 insertions(+), 7 deletions(-)
> >
> > diff --git a/sha1_file.c b/sha1_file.c
> > index 69a60ec..1068ca0 100644
> > --- a/sha1_file.c
> > +++ b/sha1_file.c
> > @@ -1564,6 +1564,36 @@ int unpack_sha1_header(git_zstream *stream, unsigned char *map, unsigned long ma
> >       return git_inflate(stream, 0);
> >   }
> >
> > +static int unpack_sha1_header_literally(git_zstream *stream, unsigned char *map,
> > +                    unsigned long mapsize,
> > +                    struct strbuf *header)
> > +{
> > +...
> > +}
>
> Looks suspiciously familiar...
Yes, you suggested it.
It has a similar structure to unpack_sha1_header().
Anything wrong with it?
>
> > +int sha1_object_info_literally(const unsigned char *sha1)
> > +{
> > +    enum object_type type;
> > +    struct strbuf sb = STRBUF_INIT;
> > +    struct object_info oi = {NULL};
> > +
> > +    oi.typename = &sb;
> > +    oi.typep = &type;
> > +    if (sha1_object_info_extended(sha1, &oi, LOOKUP_LITERALLY) < 0)
> > +        return -1;
> > +    if (*oi.typep > 0)
> > +        printf("%s\n", typename(*oi.typep));
> > +    else
> > +        printf("%s\n", oi.typename->buf);
> > +    strbuf_release(oi.typename);
> > +    return 0;
> > +}
> > +
>
> NAK.
>
> Please don't add end-user facing final output to sha1_file.c;
> instead have the caller use a helper function like this one to
> extract necessary information and perform the end-user interaction
> there.
>
Ok, will do that.
