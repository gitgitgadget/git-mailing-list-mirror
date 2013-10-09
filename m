From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH 1/2] http: add option to enable 100 Continue responses
Date: Wed, 9 Oct 2013 14:19:36 -0700
Message-ID: <CAJo=hJvyorMjFYZnVwz4iZr88ewor6LuqOE-mpt4LsPyoddBqg@mail.gmail.com>
References: <1381265287-39331-1-git-send-email-sandals@crustytoothpaste.net>
 <1381265287-39331-2-git-send-email-sandals@crustytoothpaste.net> <20131009193054.GA3767@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Oct 09 23:20:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VU1Ap-0003Vf-Vg
	for gcvg-git-2@plane.gmane.org; Wed, 09 Oct 2013 23:20:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754889Ab3JIVT7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Oct 2013 17:19:59 -0400
Received: from mail-wg0-f47.google.com ([74.125.82.47]:46333 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751500Ab3JIVT5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Oct 2013 17:19:57 -0400
Received: by mail-wg0-f47.google.com with SMTP id f12so1444076wgh.26
        for <git@vger.kernel.org>; Wed, 09 Oct 2013 14:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=T2r//dqTfesQa+vcd391NK9e4yuLQ3jcGONGc8pIk84=;
        b=Fp0SA/6v4I2UTfvJ+n9k4L/1HJfwngCuERwwyoUrDXzezeoglPRC2p71GRg5VjyOzc
         IBHqJM7H/Z7cOtIEJ5UnXyRkh8IR9kGXnPKAeSqU1pHb+qu6QXpyO924zw5+w3JtcTVd
         8G+mlCVJ0+cF/mb4l+bKrDPfrzkzwhSAFfsNw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=T2r//dqTfesQa+vcd391NK9e4yuLQ3jcGONGc8pIk84=;
        b=TXgbxK5tCrmJe/b/KxkbHdSKK40knOLU0DmFpZ0DlMDoi2P3BXghxJCAJLm0DMh5Qe
         Qsj6AiBC9icPlvKCRkuVex/Ix9n0uILCM43fJBarXnWOQCX2Yu6SpgGvykE0RIdtoFl2
         Z/9IP5tpe7quX3k+8xCDiXCTunA9h0CMEuDIssXcQwu+Tx7E2Wz+PFVTf5CgVfzCAFYV
         1auaZZD7MLLYxmZRD5v3ExM2OoL6jTyzcmnaO0NH5cHxzhZBPB5KMTsWn1tPMwWojeqk
         Bp4UK6k2FNsiS99k9FEckDuJXt7i57UTcxFmqvd0cUpFeEivwqAYdM052FTcA/l+ZEFa
         jYZg==
X-Gm-Message-State: ALoCoQno3JtPpIGzgckc6dAYk94utZM4eaP3kcg+QgAnxN+Z/aONkweNv71tEuErAv/FEgSiVBXp
X-Received: by 10.194.78.78 with SMTP id z14mr8725105wjw.32.1381353596593;
 Wed, 09 Oct 2013 14:19:56 -0700 (PDT)
Received: by 10.227.204.72 with HTTP; Wed, 9 Oct 2013 14:19:36 -0700 (PDT)
In-Reply-To: <20131009193054.GA3767@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235843>

On Wed, Oct 9, 2013 at 12:30 PM, Jeff King <peff@peff.net> wrote:
> On Tue, Oct 08, 2013 at 08:48:06PM +0000, brian m. carlson wrote:
>
>> When using GSS-Negotiate authentication with libcurl, the authentication
>> provided will change every time, and so the probe that git uses to determine if
>> authentication is needed is not sufficient to guarantee that data can be sent.
>> If the data fits entirely in http.postBuffer bytes, the data can be rewound and
>> resent if authentication fails; otherwise, a 100 Continue must be requested in
>> this case.
>>
>> By default, curl will send an Expect: 100-continue if a certain amount of data
>> is to be uploaded, but when using chunked data this is never triggered.  Add an
>> option http.continue, which defaults to enabled, to control whether this header
>> is sent.  The addition of an option is necessary because some proxies break
>> badly if sent this header.
>
> [+cc spearce]
>
> I'd be more comfortable defaulting this to "on" if I understood more
> about the original problem that led to 959dfcf and 206b099. It sounds
> like enabling this all the time will cause annoying stalls in the
> protocol, unless the number of non-crappy proxy implementations has
> gotten smaller over the past few years.

It actually hasn't, not significantly.

206b099 was written because the Google web servers for
android.googlesource.com and code.google.com do not support
100-continue semantics. This caused the client to stall a full 1
second before each POST exchange. If ancestor negotiation required
O(128) have lines to be advertised I think this was 2 or 4 POSTs,
resulting in 2-4 second stalls above the other latency of the network
and the server.

The advice I received from the Google web server developers was to not
rely on 100-continue, because a large number of corporate proxy
servers do not support it correctly. HTTP 100-continue is just pretty
broken in the wild.

If "Expect: 100-continue" is required for GSS-Negotiate to work then
Git should only enable the option if the server is demanding
GSS-Negotiate for authentication. Per 206b099 the default should still
be off for anonymous and HTTP basic, digest, and SSL certificate
authentication.

>> diff --git a/remote-curl.c b/remote-curl.c
>> index b5ebe01..3b5e160 100644
>> --- a/remote-curl.c
>> +++ b/remote-curl.c
>> @@ -470,7 +470,12 @@ static int post_rpc(struct rpc_state *rpc)
>>
>>       headers = curl_slist_append(headers, rpc->hdr_content_type);
>>       headers = curl_slist_append(headers, rpc->hdr_accept);
>> -     headers = curl_slist_append(headers, "Expect:");
>> +
>> +     /* Force it either on or off, since curl will try to decide based on how
>> +      * much data is to be uploaded and we want consistency.
>> +      */
>> +     headers = curl_slist_append(headers, http_use_100_continue ?
>> +             "Expect: 100-continue" : "Expect:");
>
> Is there any point in sending the Expect: header in cases where curl
> would not send it, though? It seems like we should assume curl does the
> right thing most of the time, and have our option only be to override
> curl in the negative direction.

Adding a header of "Expect:" causes curl to disable the header and
never use it. Always supplying the header with no value prevents
libcurl from using 100-continue on its own, which is what I fixed in
959dfcf.
