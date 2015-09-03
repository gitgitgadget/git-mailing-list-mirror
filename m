From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v15 05/13] ref-filter: implement an `align` atom
Date: Thu, 3 Sep 2015 10:12:23 -0400
Message-ID: <CAPig+cRfYow-wBvorX44E4ROH=nvQdS=3zBaEVVbQZf86JFELw@mail.gmail.com>
References: <1441131994-13508-1-git-send-email-Karthik.188@gmail.com>
	<1441131994-13508-6-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 03 16:12:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXVFi-0001BW-0g
	for gcvg-git-2@plane.gmane.org; Thu, 03 Sep 2015 16:12:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756476AbbICOM0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Sep 2015 10:12:26 -0400
Received: from mail-yk0-f179.google.com ([209.85.160.179]:34740 "EHLO
	mail-yk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756336AbbICOMY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Sep 2015 10:12:24 -0400
Received: by ykdg206 with SMTP id g206so44188909ykd.1
        for <git@vger.kernel.org>; Thu, 03 Sep 2015 07:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=DQvyVOYoaDYkOcLeJigCmTT5lAiTdRIf5pgTUEemkT0=;
        b=jfafhe9UZtyalS1v64Fcw2iiTZkG8tdPdMI2n9wg1dREJKMm8eXJVmqVv6TMQetr9f
         AIn5TPA3e8ecHFym9sbkZiUeudWyOjVLOqw6iGvgUyxx/ak8PSAdUY+rKiYxhZ3noLeq
         QTxH+T7g6+T8EHAr0zL13q+rc+O99khajqfEuP0CjQD0NBrbJz4lufXK1y2NpxzlfdoO
         8/ioTUxOJzw3Ktv19qEYyjUAYzyzkjndvnqzgf54PVShYOGVLyCvVFEOktoCYrxajUrD
         gP01wsKO/d3Qgsv3Dk09GLHpSmap8yvybg73HIrxB3+avK5v/nFdmRH1td0klvN6GrSX
         52uA==
X-Received: by 10.129.155.147 with SMTP id s141mr25021406ywg.17.1441289543629;
 Thu, 03 Sep 2015 07:12:23 -0700 (PDT)
Received: by 10.37.36.145 with HTTP; Thu, 3 Sep 2015 07:12:23 -0700 (PDT)
In-Reply-To: <1441131994-13508-6-git-send-email-Karthik.188@gmail.com>
X-Google-Sender-Auth: xsJL9tQZt1XEttfCMyl24qT087U
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277205>

On Tue, Sep 1, 2015 at 2:26 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
> Implement an `align` atom which left-, middle-, or right-aligns the
> content between %(align:..) and %(end).

Spell this either %(align:) or %(align:...) with three dots, not two.
I, personally, think %(align:) is sufficient.

> It is followed by `:<width>,<position>`, where the `<position>` is
> either left, right or middle and `<width>` is the size of the area
> into which the content will be placed. If the content between
> %(align:) and %(end) is more than the width then no alignment is
> performed. e.g. to align a refname atom to the middle with a total
> width of 40 we can do: --format="%(align:middle,40)%(refname)%(end)".
>
> We have an `at_end` function for each element of the stack which is to
> be called when the `end` atom is encountered. Using this we implement
> the aling_handler() for the `align` atom, this aligns the final strbuf
> by calling `strbuf_utf8_align()` from utf8.c.
>
> Ensure that quote formatting is performed on the whole of
> %(align)...%(end) rather than individual atoms inside.  We skip quote

Add colon: %(align:)

> formatting for individual atoms when the current stack element is
> handling an %(align) atom and perform quote formatting at the end when

%(align:)

> we encounter the %(end) atom.
>
> Add documentation and tests for the same.
>
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
> diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
> index e49d578..cac3128 100644
> --- a/Documentation/git-for-each-ref.txt
> +++ b/Documentation/git-for-each-ref.txt
> @@ -127,6 +127,15 @@ color::
>         Change output color.  Followed by `:<colorname>`, where names
>         are described in `color.branch.*`.
>
> +align::
> +       Left-, middle-, or right-align the content between %(align:..)

%(align:)

> +       and %(end). Followed by `:<width>,<position>`, where the
> +       `<position>` is either left, right or middle and `<width>` is
> +       the total length of the content with alignment. If the
> +       contents length is more than the width then no alignment is
> +       performed. If used with '--quote' everything in between
> +       %(align:..)  and %(end) is quoted.

%(align:)
Also drop the extra space before "and": s/\s+and/ and/

>  In addition to the above, for commit and tag objects, the header
>  field names (`tree`, `parent`, `object`, `type`, and `tag`) can
>  be used to specify the value in the header field.
