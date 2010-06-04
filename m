From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/6] Add memory pool library
Date: Fri, 4 Jun 2010 13:29:28 -0500
Message-ID: <20100604182928.GB20909@progeny.tock>
References: <1275658871-1473-1-git-send-email-artagnon@gmail.com>
 <1275658871-1473-2-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	David Michael Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 04 20:29:39 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OKbeF-0003VM-5i
	for gcvg-git-2@lo.gmane.org; Fri, 04 Jun 2010 20:29:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753504Ab0FDS3d convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 Jun 2010 14:29:33 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:48210 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751239Ab0FDS3c (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jun 2010 14:29:32 -0400
Received: by pwj5 with SMTP id 5so117610pwj.19
        for <git@vger.kernel.org>; Fri, 04 Jun 2010 11:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=QHa2TElP28mA6vkbfMtWnfPl9wM4uXOWrmOADHVRzcY=;
        b=dByftEbtyNsQCzKhJblh3/XKoi+OrRNQ/BSgpCB+j9+hNfPz6ePIvW8HeSnjs39UN4
         DO61GEzYoz1uq/njI2V0SUYA580/wU+j9vL9LCoZ44q6jTU/ZQ5K+V4YUquDfD4Wlqmr
         bq7aewY0i5pQKhGYYQofvDie7iAkEgr3koU4k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=ATwHMNLhm7SXvfVdEMsjkWTD7b6HWiwB4QuNKdN/JrLi73JiPWI0nZL90tnR0cdDCb
         eBiJ+6NcBSsFIhiQkJnpnOX7ASkCBitCHdl3I/LP1sh91sBL43aW9lXd7bMcvVkn3u1j
         nMUMlk9NotuVKMyFJeMQnbV6onMwHeShJJxLI=
Received: by 10.143.27.41 with SMTP id e41mr900018wfj.343.1275676172066;
        Fri, 04 Jun 2010 11:29:32 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id e16sm933198wfg.2.2010.06.04.11.29.29
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 04 Jun 2010 11:29:30 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1275658871-1473-2-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148433>

Ramkumar Ramachandra wrote:

> Add a memory pool library implemented using cpp macros. The library
> provides macros that can be used to create a type-specific memory poo=
l
> API.

More details:

  The memory pool library is distinguished from the existing specialize=
d
  allocators in alloc.c by using a contiguous block for all allocations=
=2E
  This means that on one hand, long-lived pointers have to be written a=
s
  offsets, since the base address changes as the pool grows, but on the
  other hand, the entire pool can be easily written to the file system.
  This allows the memory pool to persist between runs of an application=
=2E
 =20
  For svn-fe, such a facility is useful because each svn revision can
  copy trees and files from any previous revision.  Therefore the
  relevant information for all revisions has to persist somehow to
  support incremental runs.
 =20
  The current implementation is backed by the file system using mmap().

Thanks for the explanations, David.

> +#define obj_pool_gen(pre, obj_t, initial_capacity) \
> +static struct { \
> +	uint32_t size; \
> +	uint32_t capacity; \
> +	obj_t *base; \
> +        FILE *file; \

Whitespace damaged.

> +} pre##_pool =3D { 0, 0, NULL, NULL}; \
> +static void pre##_init(void) \
> +{ \
> +	struct stat st; \
> +	size_t ps =3D sysconf (_SC_PAGESIZE); \

Probably an ignorant question, but why?  I do not think the win32 mmap
emulation in git currently supports sysconf().

> +	/* Touch binary file before opening read/write */ \
> +	pre##_pool.file =3D fopen(#pre ".bin", "a"); \
> +	fclose(pre##_pool.file); \
> +	/* Open, check size, compute capacity */ \
> +	pre##_pool.file =3D fopen(#pre ".bin", "r+"); \

Maybe

	..._pool.file =3D fopen(..., "a+");
	rewind(..._pool.file);

would be simpler.  But given that there is no buffered I/O going on
for this file, why not just

	..._pool.file =3D open(..., O_RDWR);

?

> +	/* Truncate to calculated capacity and map to VM */ \
> +	ftruncate(fileno(pre##_pool.file), pre##_pool.capacity * sizeof(obj=
_t)); \

Reasonable.

> +	pre##_pool.base =3D mmap(0, pre##_pool.capacity * sizeof(obj_t), \
> +				PROT_READ | PROT_WRITE, MAP_SHARED, \
> +				fileno(pre##_pool.file), 0); \

This is the first use of MAP_SHARED in git.  I wouldn=E2=80=99t be surp=
rised if
the win32 mmap emulation does not support it.

> +} \
> +static uint32_t pre##_alloc(uint32_t count) \
> +{ \
> +	uint32_t offset; \
> +	if (pre##_pool.size + count > pre##_pool.capacity) { \
> +		if (NULL =3D=3D pre##_pool.base) \
> +			pre##_init(); \
> +		fsync(fileno(pre##_pool.file)); \

Necessary?  (Maybe yes: we are about to truncate the file, so the
fsync() may be intended to force the data to be committed before
the metadata.)  Portable?  (I suspect the fsync() should go after
the munmap().)

[...]
> +static void pre##_reset(void) \
> +{ \
> +	if (pre##_pool.base) { \
> +		fsync(fileno(pre##_pool.file)); \

Same question.

> +		munmap(pre##_pool.base, \
> +			pre##_pool.capacity * sizeof(obj_t)); \
> +		ftruncate(fileno(pre##_pool.file), \
> +				pre##_pool.size * sizeof(obj_t)); \
> +		fclose(pre##_pool.file); \

Because of these portability concerns, I=E2=80=99d rather use the old v=
ersion
until the incremental parser is ready.

Hope that helps,
Jonathan
