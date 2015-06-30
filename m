From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH] config.c: fix writing config files on Windows network
 shares
Date: Tue, 30 Jun 2015 16:46:20 +0200
Message-ID: <5592ABBC.60904@web.de>
References: <20150528075142.GB3688@peff.net> <20150528075443.GB23395@peff.net>
 <5592A8E5.2090601@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Jorge <griffin@gmx.es>, git@vger.kernel.org
To: Karsten Blees <karsten.blees@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 30 16:46:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9wnq-0004rf-BI
	for gcvg-git-2@plane.gmane.org; Tue, 30 Jun 2015 16:46:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751960AbbF3OqW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Jun 2015 10:46:22 -0400
Received: from mout.web.de ([212.227.15.4]:58023 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751534AbbF3OqU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jun 2015 10:46:20 -0400
Received: from macce.local ([213.66.56.100]) by smtp.web.de (mrweb002) with
 ESMTPSA (Nemesis) id 0Lx73h-1Yz7wD0zCT-016elb; Tue, 30 Jun 2015 16:46:12
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:38.0)
 Gecko/20100101 Thunderbird/38.0.1
In-Reply-To: <5592A8E5.2090601@gmail.com>
X-Provags-ID: V03:K0:qVb1yPCLFsYV6Cx6j9RsKNl1p898osq5BGt8JnxZ7B06nqxpldX
 3KqO1prtcOQKmuerJ9QKZ3SpQEQhZOZcubZybM3wZXTvKUxdyyZ+1m337/gbBFUiwhM5G6x
 YIxkiHl3GljlOMQ5V1h0aIoVLsM3CGeaRG0n4pxhi0NUmlKzQhKST86+3HE4z3mOi6bMguT
 B4f/TgiiQlr5WvVUnybRQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ovjZRAgCv00=:e9cXW1CHmaXLJVAwOA5OxC
 aj4HWo7hvfvQxJljAorLRblpaeZaX3lxoGDIxq3KNaPIX46e1G1IoNHXjid/KIjNJxhihaCE0
 BsoIUQSX4lHKnn0urmg4J5ClkhbQDhcRtjFwD3shqC2UOtIAPTw1TXEZAf7biVNrY7VkKG5+6
 358Z1idPydu2siSvc+dSY3OCpjPvBsJEJDUH+5LFwcy9XvoU0w8if7/djqIO3Xin2FV9IvFx5
 SAki0iSsqnh9kdY90dqwQ+EYttH5p6pOdNWHxaIju3/ZBN1MzsrdhN/ACdBCDrX6K+Iqff8D9
 JafxU40NpbJkYhTPFM+KGHscVL8Ayl3w+jRh0QOz43UmKslv5E5CF+VyN0C8pZnNzo2k1AvTA
 ykuYWUetcB7jnP6ouV6oRi8oClf8eb4P9Cchy79YO5IaDDQslV9zcrIsB9TVkesY3bIttzHpl
 NGHN4LKS7vfafFNE92MGQz41h7bkfbMzXlYEUe57kppiWu+4jQT6IwmD5K5/B9jIsGK/bQcTh
 eI/czxNVk7vz3hrCUBfbeDrUXZ7xfxwflfMC8FRB0TJTqMNQQKhvFIrfVnSM6kKhpzHPpwA2c
 MFhc2ytbC/AfE4pw8ySoTBSb6U7ySBKKx8Xl6HpbiJSjnmca1MKHOUgbuCIuSLxl65/22Hc9V
 FbfrnrIKFTUV2E0ETPGb/ELCBIco39eP7CnfnMcY7Bl9fI/pawIatlVgmMbQhVIBoU1s=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273067>

On 2015-06-30 16.34, Karsten Blees wrote:
> Renaming to an existing file doesn't work on Windows network shares if the
> target file is open.
> 
> munmap() the old config file before commit_lock_file.
> 
> Signed-off-by: Karsten Blees <blees@dcon.de>
> ---
> 
> See https://github.com/git-for-windows/git/issues/226
> 
> Strangely, renaming to an open file works fine on local disks...
> 
>  config.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/config.c b/config.c
> index 07133ef..3a23c11 100644
> --- a/config.c
> +++ b/config.c
> @@ -2153,6 +2153,9 @@ int git_config_set_multivar_in_file(const char *config_filename,
>  					  contents_sz - copy_begin) <
>  			    contents_sz - copy_begin)
>  				goto write_err_out;
> +
> +		munmap(contents, contents_sz);
> +		contents = NULL;
>  	}
>  
>  	if (commit_lock_file(lock) < 0) {
> 

Nice catch.
Talking about network file system,
somebody volunteering to fix this issue ?

The value of fstat() is not checked here:
(indicated by a compiler warning, that contents_sz may be uninitalized.

 config.c:
 int git_config_set_multivar_in_file(
 //around line 2063 (the only call to fstat())
 		fstat(in_fd, &st);
 		contents_sz = xsize_t(st.st_size);


(sorry for hijacking your email thread)
