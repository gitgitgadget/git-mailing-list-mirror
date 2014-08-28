From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH v6 5/6] Change copy_fd() to not close input fd
Date: Thu, 28 Aug 2014 17:37:41 +0200
Message-ID: <3947B7A7-98D0-4313-B7D7-D5EB35427E56@zib.de>
References: <1409066605-4851-1-git-send-email-prohaska@zib.de> <1409066605-4851-6-git-send-email-prohaska@zib.de> <20140826182905.GD17546@peff.net>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Duy Nguyen <pclouds@gmail.com>,
	John Keeping <john@keeping.me.uk>,
	Scott Chacon <schacon@gmail.com>
To: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 28 17:38:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XN1m4-0008Qx-FB
	for gcvg-git-2@plane.gmane.org; Thu, 28 Aug 2014 17:38:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751279AbaH1PiD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2014 11:38:03 -0400
Received: from mailer.zib.de ([130.73.108.11]:64801 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750812AbaH1PiB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2014 11:38:01 -0400
Received: from mailsrv2.zib.de (mailsrv2.zib.de [130.73.108.14])
	by mailer.zib.de (8.14.5/8.14.5) with ESMTP id s7SFbmcI017998;
	Thu, 28 Aug 2014 17:37:48 +0200 (CEST)
Received: from [192.168.1.200] (ip5f5bd082.dynamic.kabel-deutschland.de [95.91.208.130] (may be forged))
	(authenticated bits=0)
	by mailsrv2.zib.de (8.14.5/8.14.5) with ESMTP id s7SFbkeN017986
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Thu, 28 Aug 2014 17:37:47 +0200 (CEST)
In-Reply-To: <20140826182905.GD17546@peff.net>
X-Mailer: Apple Mail (2.1878.6)
X-Miltered: at mailer.zib.de with ID 53FF4CCC.000 by Joe's j-chkmail (http : // j-chkmail dot ensmp dot fr)!
X-j-chkmail-Enveloppe: 53FF4CCC.000 from mailsrv2.zib.de/mailsrv2.zib.de/null/mailsrv2.zib.de/<prohaska@zib.de>
X-j-chkmail-Score: MSGID : 53FF4CCC.000 on mailer.zib.de : j-chkmail score : . : R=. U=. O=. B=0.000 -> S=0.000
X-j-chkmail-Status: Ham
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256098>


On Aug 26, 2014, at 8:29 PM, Jeff King <peff@peff.net> wrote:

> On Tue, Aug 26, 2014 at 05:23:24PM +0200, Steffen Prohaska wrote:
> 
>> The caller opened the fd, so it should be responsible for closing it.
>> 
>> Signed-off-by: Steffen Prohaska <prohaska@zib.de>
>> ---
>> copy.c     | 5 +----
>> lockfile.c | 3 +++
>> 2 files changed, 4 insertions(+), 4 deletions(-)
>> 
>> diff --git a/copy.c b/copy.c
>> index a7f58fd..d0a1d82 100644
>> --- a/copy.c
>> +++ b/copy.c
>> @@ -10,7 +10,6 @@ int copy_fd(int ifd, int ofd)
>> 			break;
>> 		if (len < 0) {
>> 			int read_error = errno;
>> -			close(ifd);
>> 			return error("copy-fd: read returned %s",
>> 				     strerror(read_error));
>> 		}
> 
> This saved errno is not necessary anymore (the problem was that close()
> clobbered the error in the original code). It can go away, and we can
> even drop the curly braces.
> 
>> @@ -21,17 +20,14 @@ int copy_fd(int ifd, int ofd)
>> 				len -= written;
>> 			}
>> 			else if (!written) {
>> -				close(ifd);
>> 				return error("copy-fd: write returned 0");
>> 			} else {
>> 				int write_error = errno;
>> -				close(ifd);
>> 				return error("copy-fd: write returned %s",
>> 					     strerror(write_error));
>> 			}
>> 		}
> 
> Ditto here. Actually, isn't this whole write just a reimplementation of
> write_in_full? The latter treats a return of 0 as ENOSPC rather than
> using a custom message, but I think that is sane.
> 
> All together:

Makes all sense, and seems sane to me, too.

Junio, I saw that you have the changes on pu with 'SQUASH???...'.  Will you
squash it, or shall I send another complete update of the patch series?

	Steffen



> ---
> copy.c | 28 +++++-----------------------
> 1 file changed, 5 insertions(+), 23 deletions(-)
> 
> diff --git a/copy.c b/copy.c
> index a7f58fd..53a9ece 100644
> --- a/copy.c
> +++ b/copy.c
> @@ -4,34 +4,16 @@ int copy_fd(int ifd, int ofd)
> {
> 	while (1) {
> 		char buffer[8192];
> -		char *buf = buffer;
> 		ssize_t len = xread(ifd, buffer, sizeof(buffer));
> 		if (!len)
> 			break;
> -		if (len < 0) {
> -			int read_error = errno;
> -			close(ifd);
> +		if (len < 0)
> 			return error("copy-fd: read returned %s",
> -				     strerror(read_error));
> -		}
> -		while (len) {
> -			int written = xwrite(ofd, buf, len);
> -			if (written > 0) {
> -				buf += written;
> -				len -= written;
> -			}
> -			else if (!written) {
> -				close(ifd);
> -				return error("copy-fd: write returned 0");
> -			} else {
> -				int write_error = errno;
> -				close(ifd);
> -				return error("copy-fd: write returned %s",
> -					     strerror(write_error));
> -			}
> -		}
> +				     strerror(errno));
> +		if (write_in_full(ofd, buffer, len) < 0)
> +			return error("copy-fd: write returned %s",
> +				     strerror(errno));
> 	}
> -	close(ifd);
> 	return 0;
> }
> 
