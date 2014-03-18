From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH 4/4] gc --aggressive: three phase repacking
Date: Tue, 18 Mar 2014 07:19:43 +0100
Message-ID: <87lhw8vxj4.fsf@fencepost.gnu.org>
References: <1394976904-15395-1-git-send-email-pclouds@gmail.com>
	<1394976904-15395-6-git-send-email-pclouds@gmail.com>
	<20140318045050.GB8240@sigill.intra.peff.net>
	<20140318050727.GA14769@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 18 07:20:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WPnNp-0005PC-Ph
	for gcvg-git-2@plane.gmane.org; Tue, 18 Mar 2014 07:20:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752450AbaCRGUL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 18 Mar 2014 02:20:11 -0400
Received: from fencepost.gnu.org ([208.118.235.10]:57088 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751534AbaCRGUJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Mar 2014 02:20:09 -0400
Received: from localhost ([127.0.0.1]:56130 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1WPnNg-0005fC-9v; Tue, 18 Mar 2014 02:20:08 -0400
Received: by lola (Postfix, from userid 1000)
	id C6FCEEACCE; Tue, 18 Mar 2014 07:19:43 +0100 (CET)
In-Reply-To: <20140318050727.GA14769@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 18 Mar 2014 01:07:27 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244334>

Jeff King <peff@peff.net> writes:

> On Tue, Mar 18, 2014 at 12:50:50AM -0400, Jeff King wrote:
>
>> On Sun, Mar 16, 2014 at 08:35:04PM +0700, Nguy=E1=BB=85n Th=C3=A1i N=
g=E1=BB=8Dc Duy wrote:
>>=20
>> > As explained in the previous commit, current aggressive settings
>> > --depth=3D250 --window=3D250 could slow down repository access
>> > significantly. Notice that people usually work on recent history o=
nly,
>> > we could keep recent history more loosely packed, so that repo acc=
ess
>> > is fast most of the time while the pack file remains small.
>>=20
>> One thing I have not seen is real-world timings showing the slowdown
>> based on --depth. Did I miss them, or are we just making assumptions
>> based on one old case from 2009 (that, AFAIK does not have real numb=
ers,
>> just speculation)? Has anyone measured the effect of bumping the del=
ta
>> cache size (and its hash implementation)?
>
> Just as a very quick, rough data point, here are before-and-after
> timings for the patch below doing "git rev-list --objects --all" on m=
y
> linux.git, which is a mix of "--aggressive" and normal packing (I did=
n't
> do a "repack -f", but it's partially what I've downloaded from k.org =
and
> what I've repacked in various experiments over the past few months).
>
>   [before]
>   real    0m28.824s
>   user    0m28.620s
>   sys     0m0.232s
>
>   [after]
>   real    0m21.694s
>   user    0m21.544s
>   sys     0m0.172s
>
> The numbers below are completely pulled out of a hat, so we can perha=
ps
> do even better. But I think it shows that there is room for improveme=
nt
> in the delta base cache.
>
> ---
> diff --git a/environment.c b/environment.c
> index c3c8606..73ed670 100644
> --- a/environment.c
> +++ b/environment.c
> @@ -37,7 +37,7 @@ int core_compression_seen;
>  int fsync_object_files;
>  size_t packed_git_window_size =3D DEFAULT_PACKED_GIT_WINDOW_SIZE;
>  size_t packed_git_limit =3D DEFAULT_PACKED_GIT_LIMIT;
> -size_t delta_base_cache_limit =3D 16 * 1024 * 1024;
> +size_t delta_base_cache_limit =3D 128 * 1024 * 1024;

You need to change a file in Documentation as well.  Can offer a patch.

>  unsigned long big_file_threshold =3D 512 * 1024 * 1024;
>  const char *pager_program;
>  int pager_use_color =3D 1;
> diff --git a/sha1_file.c b/sha1_file.c
> index b37c6f6..a9ab8e3 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -1944,7 +1944,7 @@ static void *unpack_compressed_entry(struct pac=
ked_git *p,
>  	return buffer;
>  }
> =20
> -#define MAX_DELTA_CACHE (256)
> +#define MAX_DELTA_CACHE (1024)

This one really needs experimentation.  I found that increases here lea=
d
to performance degradation rather soon, probably because of decreased
memory locality without significant reduction in cache collisions.  Not
sure whether it's worth touching at all.

--=20
David Kastrup
