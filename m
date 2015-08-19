From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 5/7] submodule: implement `module_list` as a builtin helper
Date: Wed, 19 Aug 2015 11:23:42 -0700
Message-ID: <CAGZ79kbHVAqOFT5s-4RRtHjfBO=KgvMOmup0Q1OyNZ3kSFfvxw@mail.gmail.com>
References: <1439857323-21048-1-git-send-email-sbeller@google.com>
	<1439857323-21048-6-git-send-email-sbeller@google.com>
	<xmqqpp2j9m7g.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 19 20:24:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZS81c-0000yf-Oa
	for gcvg-git-2@plane.gmane.org; Wed, 19 Aug 2015 20:23:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751704AbbHSSXo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Aug 2015 14:23:44 -0400
Received: from mail-yk0-f171.google.com ([209.85.160.171]:36816 "EHLO
	mail-yk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751020AbbHSSXn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Aug 2015 14:23:43 -0400
Received: by ykfw73 with SMTP id w73so13803655ykf.3
        for <git@vger.kernel.org>; Wed, 19 Aug 2015 11:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=zUajDMX4utSYZZ8XZ7nY/CKP8ubsE7wgF6aj+Ke+qm4=;
        b=pDlgrnaJj/6vztXUS63Cv4KEf0YmjMk/tU/YWcyYdKS3NVtjBy7Ue+wFbXauXnzSFo
         dBbJKkqy/66T7xbHhJwINRTxIIHGySg/MLUYQnzgMVBGdILzA6Xvvzi10Gl55sgngjps
         RI7qwP/uleD9Htk06qO2Iz8TCI1kyf+4Ma7xWRgH3UwR97XQgjbQR+v5Z3MpSx+447nq
         HoTVzCWF/cgjqpXLVGvLRRRWHTTrQX3T2pEtJbT63xmpub/QbrhoFmAF4CIqFTdT+xY5
         NS/W0l80bO7sJ5Ojc3jFCEMSbv2ol4unla/go8wemrVbNTVjxByPnjDJI3VOK6GFTL1Y
         vbbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=zUajDMX4utSYZZ8XZ7nY/CKP8ubsE7wgF6aj+Ke+qm4=;
        b=X9KCmXg8ZLFUsH/nOky3ZRFDR+MP4MKq0Hk9daSKvdz72uGTvMjbH4KG7r+U/m6K54
         NXeVfHLIIOCl0dNIp0QG/xFmzvErYvB2xdgzU0OulUYMSWplKwOGse6RjixEQrL8GA3a
         anvcKQauXE1sl01g2y01RQ/q3mCPUTp7XtVgMXWYbQH0ZAxTrhSoR++EDg29nAS7GpLB
         ykqedPRYOW3POkztMtwNYAPUeO0AV1dwiCtAwgGX8rQyRA4RCLhpqhv2+RVyGZi1gIvt
         z2L9wi0VBSTkRziwSDNXi4y/564hn5EWCJw6dlNTpYzMUjz/ZmZHjt+koFKvRY/7ikTj
         UH0Q==
X-Gm-Message-State: ALoCoQmh1p39Ga+rustoSdtASFtaRAa8hqUJ9Qnn0DEQ6eSz1jho/zimKZ05It8GdycqBTRveaKv
X-Received: by 10.170.112.194 with SMTP id e185mr15304491ykb.119.1440008622730;
 Wed, 19 Aug 2015 11:23:42 -0700 (PDT)
Received: by 10.37.21.132 with HTTP; Wed, 19 Aug 2015 11:23:42 -0700 (PDT)
In-Reply-To: <xmqqpp2j9m7g.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276211>

On Wed, Aug 19, 2015 at 11:17 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> +static int module_list_compute(int argc, const char **argv,
>> +                             const char *prefix,
>> +                             struct pathspec *pathspec)
>> +{
>> +     int i;
>> +     char *max_prefix, *ps_matched = NULL;
>> +     int max_prefix_len;
>> +     parse_pathspec(pathspec, 0,
>> +                    PATHSPEC_PREFER_FULL |
>> +                    PATHSPEC_STRIP_SUBMODULE_SLASH_CHEAP,
>> +                    prefix, argv);
>> +
>> +     /* Find common prefix for all pathspec's */
>> +     max_prefix = common_prefix(pathspec);
>> +     max_prefix_len = max_prefix ? strlen(max_prefix) : 0;
>> +
>> +     if (pathspec->nr)
>> +             ps_matched = xcalloc(1, pathspec->nr);
>
> Micronit.  Even though multiplication is commutative, the order of
> arguments to xcalloc() looks odd.  It lets you say "I want an array
> with nmemb elements, and each of its is size-bytes long" by giving
> it nmemb and then size.

Thanks for pointing that out!
I think this would be an alignment issue in theory, if the items were larger and
the number of items not dividable by the size of items.

So because 1 char has no alignment problems, we can happily allocate
just one block of the member size here.

>
> No need to resend; will fix it up while queuing.
>
> Thanks.
