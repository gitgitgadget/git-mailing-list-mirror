From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: Re: Bug report about symlinks
Date: Mon, 04 Aug 2014 00:59:51 +0200
Message-ID: <53DEBEE7.6070009@web.de>
References: <web-416867478@relay1.vsu.ru> <53DABD69.7010004@web.de>	<xmqqppgkw55g.fsf@gitster.dls.corp.google.com>	<53DCF14D.8040705@web.de> <xmqqk36ptrs6.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nikolay Avdeev <avdeev@math.vsu.ru>, git@vger.kernel.org,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 04 01:00:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XE4l1-0002TT-Ft
	for gcvg-git-2@plane.gmane.org; Mon, 04 Aug 2014 01:00:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752335AbaHCW76 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Aug 2014 18:59:58 -0400
Received: from mout.web.de ([212.227.17.11]:51174 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751851AbaHCW76 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Aug 2014 18:59:58 -0400
Received: from [192.168.178.27] ([79.250.184.163]) by smtp.web.de (mrweb101)
 with ESMTPSA (Nemesis) id 0LoHTx-1WYOHY03y5-00gITw; Mon, 04 Aug 2014 00:59:53
 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.0
In-Reply-To: <xmqqk36ptrs6.fsf@gitster.dls.corp.google.com>
X-Provags-ID: V03:K0:QulFlCpZKASIEgi1E8PVLuRO9S7GYM7J7YVS3hR9g/MSS6Ihbg2
 J2cx/ICNfG9EY5Vct3OVFDl//IuIEdRxtqQy+7ZHP5K1+PanjrXXzd5/2NRIjWEAPt8NNms
 Pd0B7tB0X1oFYWQz15gptaBWm4E+2jhKJYaVeHQQsgurvk0rnBiJ77IWk9uVdJd+melAomR
 CE1Kp7+lj8lAWQ8dIYnnA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254731>

Am 03.08.2014 um 19:19 schrieb Junio C Hamano:
> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>
>> How about the patch below?  Before it checks if an index entry exist=
s
>> in the work tree, it checks if its path includes a symlink.
>
> Honestly, I didn't expect the fix to be in the refresh-index code
> path, but doing this there sort of makes sense.

I found it through observation, not understanding.  Just looked for=20
stat/lstat calls executed by git status for b/different and b/equal=20
using strace; debugging printfs told me where they came from.

>> And do we need to use the threaded_ variant of the function here?
>
> Hmmm, this is a tangent, but you comment made me wonder if we also
> need to adjust preload_thread() in preload-index.c somehow, but we
> do not touch CE_UPTODATE there, so it probably is not necessary.

The function calls ce_mark_uptodate(), which does set CE_UPTODATE.  It=20
calls threaded_has_symlink_leading_path() before lstat() already,=20
however.  (Since f62ce3de: Make index preloading check the whole path t=
o=20
the file.)

> The caller of refresh_cache_ent() is walking an array of sorted
> pathnames aka istate->cache[] in a single-threaded fashion, possibly
> with a pathspec to limit the scan.

There are two direct callers (refresh_index(), refresh_cache_entry())=20
and several indirect ones.  Do we have a way to detect unsynchronized=20
parallel access to the has_symlink_leading_path()-cache?  Checking the=20
full callers-of-callers tree manually looks a bit scary to me.

> Do you mean that we may want to
> make istate->cache[] scanned by multiple threads?  I am not sure.

No, I didn't want to suggest any performance improvements.  I'm only=20
interested in correctness for now.

Ren=C3=A9
