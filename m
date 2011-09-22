From: wanghui <Hui.Wang@windriver.com>
Subject: Re: [PATCH] abspath: increase array size of cwd variable to PATH_MAX
Date: Thu, 22 Sep 2011 16:54:16 +0800
Message-ID: <4E7AF7B8.2080208@windriver.com>
References: <1316425872-30457-1-git-send-email-Hui.Wang@windriver.com> <7v8vpkbhyv.fsf@alter.siamese.dyndns.org> <4E791A40.6040102@ramsay1.demon.co.uk> <7vty851wg9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>, <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 22 10:54:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R6f38-0001KK-4v
	for gcvg-git-2@lo.gmane.org; Thu, 22 Sep 2011 10:54:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752018Ab1IVIyY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Sep 2011 04:54:24 -0400
Received: from mail.windriver.com ([147.11.1.11]:55202 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751406Ab1IVIyX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Sep 2011 04:54:23 -0400
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.3/8.14.3) with ESMTP id p8M8sHaV006744
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Thu, 22 Sep 2011 01:54:17 -0700 (PDT)
Received: from [128.224.163.220] (128.224.163.220) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.50) with Microsoft SMTP Server (TLS) id 14.1.255.0; Thu, 22 Sep
 2011 01:54:16 -0700
User-Agent: Thunderbird 2.0.0.24 (X11/20101027)
In-Reply-To: <7vty851wg9.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181890>

Junio C Hamano wrote:
> Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:
>
>   
>> Hmm, the subject line says "... increase array size ...", but that is not
>> necessarily what this patch is doing! :-D
>>     
>
> True; will revert it out of 'next'.
>
> Thanks for noticing.
>
>   
Hi Junio and Ramsay,

In fact, i found lots of similar usage in the git source code. E.G.

in the dir.c,
int is_inside_dir(const char *dir)
{
char cwd[PATH_MAX];
if (!dir)
return 0;
if (!getcwd(cwd, sizeof(cwd)))
die_errno("can't find the current directory");
return dir_inside_of(cwd, dir) >= 0;
}

Since this implementation is not cross-OS safe, Could we use below solution?

step1, add a new function xgetcwd() to wrapper getcwd() like this:
char *xgetcwd(void)
{
size_t size = 100;

while (1) {
char *buffer = (char *) xmalloc (size);
if (getcwd (buffer, size) == buffer)
return buffer;
free (buffer);
if (errno != ERANGE)
return 0;
size *= 2;
}
}

step2, use xgetcwd to replace all getcwd occurrence in the git source code.

This will add a little bit overhead to the git, but it is cross-OS safe.
