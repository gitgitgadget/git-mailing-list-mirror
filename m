From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH 4/6] dir.c::match_pathname(): pay attention to the length
 of string parameters
Date: Fri, 29 Mar 2013 12:32:53 +0100
Message-ID: <51557BE5.8000305@web.de>
References: <20130328214358.GA10685@sigill.intra.peff.net> <20130328214821.GD10936@sigill.intra.peff.net> <CACsJy8DisE8UNZzqmOFxPqw=bmFiHgE5-ao83ciGNUV9Sc9-gA@mail.gmail.com> <CACsJy8CT8DQEEJVMwonW05bFZNb7HjQWBdEjy3tv332xabJ=Bw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org, avila.jn@gmail.com,
	=?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaA==?= =?UTF-8?B?YXVzZW4=?= 
	<tboegi@web.de>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 29 12:33:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULXYq-00019W-9L
	for gcvg-git-2@plane.gmane.org; Fri, 29 Mar 2013 12:33:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753549Ab3C2LdC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Mar 2013 07:33:02 -0400
Received: from mout.web.de ([212.227.15.3]:51735 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753283Ab3C2LdB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Mar 2013 07:33:01 -0400
Received: from [192.168.209.26] ([195.67.191.23]) by smtp.web.de (mrweb002)
 with ESMTPA (Nemesis) id 0MD8RQ-1UQz3y12wm-00GrcM; Fri, 29 Mar 2013 12:32:55
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:17.0) Gecko/20130307 Thunderbird/17.0.4
In-Reply-To: <CACsJy8CT8DQEEJVMwonW05bFZNb7HjQWBdEjy3tv332xabJ=Bw@mail.gmail.com>
X-Provags-ID: V02:K0:9P1OeBU+vVSuLFgXVY7HaycqhIwBLutW0TcyhYORQeJ
 wDWnwAl93qc0LYXrpFGlAt6Mn+03lSrZ9f4P1AIEBvOuyEau95
 lYDlNa+KU6SlLlo/zDchgef0UHlz9FHJcfwXwZaktADI5tqFBr
 HYUF41T2Ngg+DaaAGRiPUQ4+kdKE+ioaz2GkAUdr9qlEZNJnVI
 ZixqBO8nN/YuA9sQa4ddg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219495>

On 29.03.13 11:03, Duy Nguyen wrote:
> On Fri, Mar 29, 2013 at 3:45 PM, Duy Nguyen <pclouds@gmail.com> wrote:
>> On Fri, Mar 29, 2013 at 4:48 AM, Jeff King <peff@peff.net> wrote:
>>> -       return fnmatch_icase(pattern, name, FNM_PATHNAME) == 0;
>>> +       return fnmatch_icase_mem(pattern, patternlen,
>>> +                                name, namelen,
>>> +                                FNM_PATHNAME) == 0;
>>>  }
>>
>> I think you (or Junio) should rebase this on maint. Since c41244e
>> (included in maint), this call is turned to wildmatch(WM_PATHNAME) and
>> WM_PATHNAME is _not_ the same as FNM_PATHNAME for patterns like
>> "foo/**/bar". A diff between next and pu shows me that WM_PATHNAME is
>> incorrectly converted to FNM_PATHNAME. I hope that is the cause of all
>> breakages Junio found out on pu.
> 
> Just tested. t0003 and t3001 on 'pu' work for me because I have
> USE_WILDMATCH on (which turns FNM_PATHNAME to WM_PATHNAME). Both break
> without USE_WILDMATCH.
> 
Hm, tested what?

diff --git a/dir.c b/dir.c
index 73a08af..0b63167 100644
--- a/dir.c
+++ b/dir.c
@@ -564,7 +564,7 @@ int match_pathname(const char *pathname, int pathlen,
 
        return fnmatch_icase_mem(pattern, patternlen,
                                 name, namelen,
-                                FNM_PATHNAME) == 0;
+                                WM_PATHNAME) == 0;
 }
 
Gives only one breakage, so we are coming closer.


*** t3001-ls-files-others-exclude.sh ***
[snip]
not ok 17 - ls-files with "**" patterns
