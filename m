From: karthik nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v8 1/4] sha1_file.c: support reading from a loose object
 of unknown type
Date: Sat, 18 Apr 2015 00:15:28 +0530
Message-ID: <553154C8.5090001@gmail.com>
References: <552E9816.6040502@gmail.com> <1429117143-4882-1-git-send-email-karthik.188@gmail.com> <xmqqmw29jg78.fsf@gitster.dls.corp.google.com> <20150415221824.GB27566@peff.net> <20150417142310.GA12479@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, sunshine@sunshineco.com,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Apr 17 20:45:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YjBGl-0001iY-Gv
	for gcvg-git-2@plane.gmane.org; Fri, 17 Apr 2015 20:45:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754150AbbDQSpe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Apr 2015 14:45:34 -0400
Received: from mail-pd0-f179.google.com ([209.85.192.179]:35409 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753260AbbDQSpd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Apr 2015 14:45:33 -0400
Received: by pdbqd1 with SMTP id qd1so136345972pdb.2
        for <git@vger.kernel.org>; Fri, 17 Apr 2015 11:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=q0kZwflm4LtX9Y4GbK5aYM5uLXYAG6TOWzcnEVLWOSw=;
        b=nQjsRq2qWG1vPOg0GP7wf5d2srxvuMW00RyFuqXkI772o5cxF7wPI7t76PgBimEo1G
         S1XLOv4vk4YJdFT18m79faP/x73lm2kGs1SFcREVv55Q1D3jZ59nLqQWhW80Cqv2X9sn
         06RGADKK+PvNxpqpKZjAj3Wr64t2nDx7SET7KCIXWqUhksnT0EKkcVXH/OOIVPsWYUSX
         3npilOltL4m2hF9k8qtq095xI7zGSpVuR9jrdKN8YAIE32XIu7LjlUEErgTiX5DO1Upa
         ThyX3Gncm/MA/JHtNn/q0PHvx2VvTRu2Wjbc+xeUfa0dfx881YiX3HoC9/9G17jyHlND
         Fezw==
X-Received: by 10.66.161.161 with SMTP id xt1mr7825896pab.35.1429296333333;
        Fri, 17 Apr 2015 11:45:33 -0700 (PDT)
Received: from [192.168.0.100] ([103.227.98.178])
        by mx.google.com with ESMTPSA id ll2sm10821699pbc.11.2015.04.17.11.45.30
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Apr 2015 11:45:32 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
In-Reply-To: <20150417142310.GA12479@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267375>



On 04/17/2015 07:53 PM, Jeff King wrote:
> On Wed, Apr 15, 2015 at 06:18:24PM -0400, Jeff King wrote:
>
> >> This _might_ have some performance impact in that strbuf_addch()
> >> involves strbuf_grow(*, 1), which does "does it overflow to
> >> increment sb->len by one?"; I would say it should be unmeasurable
> >> because the function is expected to be used only on loose objects
> >> and you shouldn't have very many of them without packing in your
> >> repository in the first place.
> >>
> >> I guess Peff's c1822d4f (strbuf: add an optimized 1-character
> >> strbuf_grow, 2015-04-04) may want to teach strbuf_addch() to use his
> >> new strbuf_grow_ch(), and once that happens the performance worry
> >> would disappear without this code to be changed at all.
> >
> > I haven't re-rolled that series yet, but the discussion there showed
> > that strbuf_grow_ch() is unnecessary; call-sites can just check:
> >
> >    if (!strbuf_avail(sb))
> >     strbuf_grow(sb, 1);
> >
> > to get the fast inline check. Since we go to the trouble to inline
> > strbuf_addch, we should probably teach it the same trick. It would be
> > nice to identify a place with a tight strbuf_addch() loop that could
> > demonstrate the speed increase, though.
>
> Just for reference, I did teach strbuf_addch this trick. And the config
> code is the tight loop to test it with. Results are here:
>
>    http://article.gmane.org/gmane.comp.version-control.git/267266
>
> In this code path, we are typically only seeing short strings (the
> original code used a 10-byte static buffer). So I doubt it makes all
> that much difference.
>
> If there _is_ a performance implication to worry about here, I think it
> would be that we are doing an extra malloc/free. I'm not sure I
> understand why we are copying it at all. The original code copied from
> the hdr into type[10] so that we could NUL-terminate it, which was
> required for type_from_string().
>
> But now we use type_from_string_gently, which can accept a length[1]. So
> we could just count the bytes to the first space and pass the original
> buffer along with that length, no?

Yes, we could, that would eliminate  "struct strbuf typename =
STRBUF_INIT".

Something like this perhaps :

@@ -1614,27 +1642,40 @@ static void *unpack_sha1_rest(git_zstream
*stream, void *buffer, unsigned long s
    * too permissive for what we want to check. So do an anal
    * object header parse by hand.
    */
-int parse_sha1_header(const char *hdr, unsigned long *sizep)
+static int parse_sha1_header_extended(const char *hdr, struct
object_info *oi,
+                              unsigned int flags)
   {
-       char type[10];
-       int i;
+       const char *buf = hdr;
          unsigned long size;
+       int type, len = 0;

          /*
-        * The type can be at most ten bytes (including the
-        * terminating '\0' that we add), and is followed by
+        * The type can be of any size but is followed by
           * a space.
           */
-       i = 0;
          for (;;) {
                  char c = *hdr++;
                  if (c == ' ')
                          break;
-               type[i++] = c;
-               if (i >= sizeof(type))
-                       return -1;
+               len++;
          }
-       type[i] = 0;
+
+       type = type_from_string_gently(buf, len, 1);
+       if (oi->typename) {
+               strbuf_add(oi->typename, buf, len);
+               strbuf_addch(oi->typename, '\0');
+       }
+       /*
+        * Set type to 0 if its an unknown object and
+        * we're obtaining the type using '--literally'
+        * option.
+        */
+       if ((flags & LOOKUP_LITERALLY) && (type == -1))
+               type = 0;
+       else if (type == -1)
+               die("invalid object type");
+       if (oi->typep)
+               *oi->typep = type;

          /*
           * The length must follow immediately, and be in canonical

>
> -Peff
>
> [1] Not related to your patch, but it looks like type_from_string_gently
>      is overly lax. It does a strncmp() with the length of the candidate
>      name, but does not check that we consumed all of the matching name.
>      So "tr" would match "tree", "comm" would match "commit", and so
>      forth.
>
Thanks for the patch re-roll on strbuf_addch() and the patch on
type_from_string_gently().
