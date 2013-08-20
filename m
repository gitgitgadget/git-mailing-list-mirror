From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] stream_to_pack: xread does not guarantee to read all
 requested bytes
Date: Tue, 20 Aug 2013 21:37:14 +0200
Message-ID: <5213C56A.6010305@kdbg.org>
References: <521333AE.1090506@kdbg.org> <xmqqsiy476h4.fsf@gitster.dls.corp.google.com> <xmqq4nak6vpv.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 20 21:37:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VBrk7-0002OB-1W
	for gcvg-git-2@plane.gmane.org; Tue, 20 Aug 2013 21:37:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751443Ab3HTThX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Aug 2013 15:37:23 -0400
Received: from bsmtp5.bon.at ([195.3.86.187]:22299 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751283Ab3HTThW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Aug 2013 15:37:22 -0400
Received: from [10.73.122.231] (178.115.250.231.wireless.dyn.drei.com [178.115.250.231])
	by bsmtp.bon.at (Postfix) with ESMTP id 9DF421300B7;
	Tue, 20 Aug 2013 21:37:19 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130307 Thunderbird/17.0.4
In-Reply-To: <xmqq4nak6vpv.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232638>

Am 20.08.2013 20:52, schrieb Junio C Hamano:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> I wonder if there are more like this broken caller or xread and/or
>> xwrite.
>
> Here is a result of a quick audit (of 1.8.0.x codebase).
>
> As xwrite() will not be splitting a single-byte request, the patch
> to cat-file is more or less a theoretical fix, but if writing the
> date string can fail in I/O error, writing a terminating LF after it
> can fail the same way, so we should be consistent.
>
> Everybody supports the side-band tranfer these days, so the patches
> to receive-pack and upload-pack are also theoretical fixes, I
> think.  Note that in the more recent codebase, safe_write() is gone
> and we use write_or_die() instead in upload-pack.

These changes look reasonable. Thank you!

>
>   builtin/cat-file.c     | 2 +-
>   builtin/receive-pack.c | 2 +-
>   upload-pack.c          | 5 -----
>   3 files changed, 2 insertions(+), 7 deletions(-)
>
> diff --git a/builtin/cat-file.c b/builtin/cat-file.c
> index 00528dd..4beb4d8 100644
> --- a/builtin/cat-file.c
> +++ b/builtin/cat-file.c
> @@ -63,7 +63,7 @@ static void pprint_tag(const unsigned char *sha1, const char *buf, unsigned long
>   					tz = strtol(ep, NULL, 10);
>   					sp = show_date(date, tz, 0);
>   					write_or_die(1, sp, strlen(sp));
> -					xwrite(1, "\n", 1);
> +					write_or_die(1, "\n", 1);
>   					break;
>   				}
>   			}
> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> index ff781fe..a41740d 100644
> --- a/builtin/receive-pack.c
> +++ b/builtin/receive-pack.c
> @@ -202,7 +202,7 @@ static void report_message(const char *prefix, const char *err, va_list params)
>   	if (use_sideband)
>   		send_sideband(1, 2, msg, sz, use_sideband);
>   	else
> -		xwrite(2, msg, sz);
> +		write_in_full(2, msg, sz);
>   }
>
>   static void rp_warning(const char *err, ...)
> diff --git a/upload-pack.c b/upload-pack.c
> index 2e90ccb..7a3e4fd 100644
> --- a/upload-pack.c
> +++ b/upload-pack.c
> @@ -64,11 +64,6 @@ static ssize_t send_client_data(int fd, const char *data, ssize_t sz)
>   	if (fd == 3)
>   		/* emergency quit */
>   		fd = 2;
> -	if (fd == 2) {
> -		/* XXX: are we happy to lose stuff here? */
> -		xwrite(fd, data, sz);
> -		return sz;
> -	}
>   	return safe_write(fd, data, sz);
>   }
>
>
