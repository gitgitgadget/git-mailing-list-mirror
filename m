From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/3] sha1_file: add the ability to parse objects in "pack file format"
Date: Tue, 11 Jul 2006 17:46:31 -0700
Message-ID: <7vveq31wgo.fsf@assigned-by-dhcp.cox.net>
References: <20060710230132.GA11132@hpsvcnb.fc.hp.com>
	<Pine.LNX.4.64.0607101623230.5623@g5.osdl.org>
	<20060711145527.GA32468@hpsvcnb.fc.hp.com>
	<Pine.LNX.4.64.0607111004360.5623@g5.osdl.org>
	<Pine.LNX.4.64.0607111010320.5623@g5.osdl.org>
	<44B4172B.3070503@stephan-feder.de>
	<Pine.LNX.4.64.0607111449190.5623@g5.osdl.org>
	<7vejwr3ftl.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0607111656250.5623@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: sf <sf-gmane@stephan-feder.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 12 02:46:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G0Ss9-0003Lc-8e
	for gcvg-git@gmane.org; Wed, 12 Jul 2006 02:46:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932102AbWGLAqe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 11 Jul 2006 20:46:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932302AbWGLAqe
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Jul 2006 20:46:34 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:24027 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S932102AbWGLAqd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jul 2006 20:46:33 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060712004632.JCOM6303.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 11 Jul 2006 20:46:32 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0607111656250.5623@g5.osdl.org> (Linus Torvalds's
	message of "Tue, 11 Jul 2006 17:03:20 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23752>

Linus Torvalds <torvalds@osdl.org> writes:

> It's actually really part of the specs, and not just happenstance.

> Well, I normally would agree with you if it was a "oh, all our zlib 
> objects seem to start with 0x78" thing, but after having dug into both the 
> zlib standard (which is actually an RFC, not just some random thing), and 
> looked at the sources, it's definitely the case that the "0x78" byte isn't 
> just an implementation detail.

Ok, I do not think we would worry about casting use of deflate +
32k windowsize in stone that much, and being able to check the
size and type without inflating certainly is attractive.
Validating FCHECK bits is surely a nice touch.  Thanks.

> Anyway, I think this following patch replaces the old 2/3 and 3/3 (it 
> still depends on the original [1/3] cleanup.
>
> (It also renames and reverses the meaning of the config file option: it's 
> now "[core] LegacyHeaders = true" for using legacy headers.)
>
> Not heavily tested, but seems ok.

I'd queue it in "pu" with reversed default and then move it to
"next" later.

>  static void *unpack_sha1_rest(z_stream *stream, void *buffer, unsigned long size)
>  {
>  	int bytes = strlen(buffer) + 1;
>  	unsigned char *buf = xmalloc(1+size);
> +	unsigned long n;
>  
> -	memcpy(buf, (char *) buffer + bytes, stream->total_out - bytes);
> -	bytes = stream->total_out - bytes;
> +	n = stream->total_out - bytes;
> +	if (n > size)
> +		n = size;
> +	memcpy(buf, (char *) buffer + bytes, n);
> +	bytes = n;
>  	if (bytes < size) {
>  		stream->next_out = buf + bytes;
>  		stream->avail_out = size - bytes;

This one looks like an independent fix for a well spotted bug.

>  int write_sha1_file(void *buf, unsigned long len, const char *type, unsigned char *returnsha1)
>  {
>  	int size;
> @@ -1459,7 +1550,7 @@ int write_sha1_file(void *buf, unsigned 
>  	/* Set it up */
>  	memset(&stream, 0, sizeof(stream));
>  	deflateInit(&stream, zlib_compression_level);
> -	size = deflateBound(&stream, len+hdrlen);
> +	size = 8 + deflateBound(&stream, len+hdrlen);
>  	compressed = xmalloc(size);
>  
>  	/* Compress it */

I am wondring what this eight is.  You would pack 7 7-bit length
plus 4-bit totalling 49+4 = 53-bit length (plus 4-bit type).  Is
it an unwritten decision that the format would not deal with
objects larger than 2^53 (which is probably fine but looks
magic)?
