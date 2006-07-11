From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/3] sha1_file: add the ability to parse objects in "pack
 file format"
Date: Tue, 11 Jul 2006 20:40:35 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0607112031150.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20060710230132.GA11132@hpsvcnb.fc.hp.com>
 <Pine.LNX.4.64.0607101623230.5623@g5.osdl.org> <20060711145527.GA32468@hpsvcnb.fc.hp.com>
 <Pine.LNX.4.64.0607111004360.5623@g5.osdl.org> <Pine.LNX.4.64.0607111010320.5623@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Carl Baldwin <cnb@fc.hp.com>, Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 11 20:40:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G0NA0-0001cr-Jl
	for gcvg-git@gmane.org; Tue, 11 Jul 2006 20:40:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751127AbWGKSki (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 11 Jul 2006 14:40:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751178AbWGKSkh
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Jul 2006 14:40:37 -0400
Received: from mail.gmx.net ([213.165.64.21]:15511 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751127AbWGKSkh (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Jul 2006 14:40:37 -0400
Received: (qmail invoked by alias); 11 Jul 2006 18:40:35 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp036) with SMTP; 11 Jul 2006 20:40:35 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0607111010320.5623@g5.osdl.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23724>

Hi,

On Tue, 11 Jul 2006, Linus Torvalds wrote:

> @@ -762,20 +765,65 @@ static int parse_sha1_header(char *hdr, 
>  	/*
>  	 * The length must be followed by a zero byte
>  	 */
> -	return *hdr ? -1 : 0;
> +	bytes++;
> +	if (*hdr)
> +		bytes = -1;
> +	return bytes;

Why not just say

	return *hdr ? -1 : bytes;

> +}
> +
> +static int parse_binary_sha1_header(char *hdr, char *type, unsigned long *sizep)
> +{
> +	unsigned char c;
> +	int bytes = 1;
> +	unsigned long size;
> +	unsigned object_type, bits;
> +	static const char *typename[8] = {
> +		NULL,	/* OBJ_EXT */
> +		"commit", "tree", "blob", "tag",
> +		NULL, NULL, NULL 
> +	};	
> +
> +	c = *hdr++;
> +	object_type = (c >> 4) & 7;
> +	if (!typename[object_type])
> +		return -1;

You might want to add a comment saying "since the type is lowercase in 
ascii format, object_type must be 6 or 7, which is an invalid object 
type." It took me a little to figure that out...

> +	strcpy(type, typename[object_type]);
> +	size = c & 15;

Just a nit here: I think 0xf is easier to read with boolean operations.

> +	bits = 4;
> +	while (!(c & 0x80)) {
> +		if (bits >= 8*sizeof(unsigned long))
> +			return -1;
> +		c = *hdr++;
> +		size += (unsigned long) (c & 0x7f) << bits;
> +		bytes++;
> +		bits += 7;
> +	}

Are you not losing the last byte by putting the "while" _before_ instead 
of _after_ the loop?

> @@ -1192,7 +1240,7 @@ struct packed_git *find_sha1_pack(const 
>  
>  int sha1_object_info(const unsigned char *sha1, char *type, unsigned long *sizep)
>  {
> -	int status;
> +	int status, hdrlen;
>  	unsigned long mapsize, size;
>  	void *map;
>  	z_stream stream;
> -

This hunk is unnecessary, right?

Ciao,
Dscho
