From: linux@horizon.com
Subject: Re: [PATCH] git-blame: Make the output human readable
Date: 6 Mar 2006 14:33:26 -0500
Message-ID: <20060306193326.19262.qmail@science.horizon.com>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 06 23:00:36 2006
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by deer.gmane.org with esmtp (Exim 3.35 #1 (Debian))
	id 1FGLSf-0006Fu-00
	for <gcvg-git@gmane.org>; Mon, 06 Mar 2006 20:33:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751660AbWCFTdi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Mar 2006 14:33:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751661AbWCFTdi
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Mar 2006 14:33:38 -0500
Received: from science.horizon.com ([192.35.100.1]:34857 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S1750878AbWCFTdh
	(ORCPT <rfc822;git@vger.kernel.org>); Mon, 6 Mar 2006 14:33:37 -0500
Received: (qmail 19263 invoked by uid 1000); 6 Mar 2006 14:33:26 -0500
To: junkio@cox.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17308>

Well, getting 15 characters in UTF-8 is easy (just stop before the 16th
byte for which ((b & 0xc0) != 0x80)), but what about combining characters?

You've got accents and stuff to worry about.  And the annoying fact that
Unicode defined accents as suffixes, so you have to go past the 15th
column to include all of the 

And then there's that fact that many characters are traditionally
represented as double-wide forms, even on character terminals.

See http://www.cl.cam.ac.uk/~mgk25/ucs/wcwidth.c for details
an an example implementation of wcwidth().

Using that, it would be something like (compiles but untested):

/*
 * Return the number of bytes from the nul-terminated utf8 string
 * that can be printed in at most max columns using a monospaced
 * font.  *actual returns the number of columns actually occupied,
 * which may be less than max.
 *
 * Output is truncated before any control characters or illegal
 * UTF-8 sequences.
 */
unsigned
fit_columns(char const *utf8, unsigned max, unsigned *actual)
{
	char const * const origin = utf8;
	unsigned width = 0;
	unsigned pos = 0;
	unsigned c;

	for (;;) {
		unsigned w;
		unsigned c = *utf8++;

		/* Part 1: Parse the next Unicode code point */
		if (c < 0x20) {
			break;	/* Control character - stop */
		} else if (c < 0x7F) {
			w = 1;	/* Standard ASCII */
		} else if (c < 0xC2 || c > 0xF4) {
			break;	/* DEL or illegal Unicode */
		} else {
			/* Multi-byte UTF-8 sequence */
			unsigned n;
			unsigned char byte = *utf8++;

			if (c < 0xE0) {
				/* 2-byte sequence: U+0080..U+07FF */
				n = 1;
				c &= 0x1F;
			} else if (c < 0xF0) {
				/* 3-byte sequence: U+0800..U+FFFF */
				if (c == 0xE0 && byte < 0xA0)
					break;	/* < /U+0800 */
				n = 2;
				c &= 0x0F;
			} else {
				/* 4-byte sequence: U+10000..U+10FFFF */
				if (byte < 0x90 ? c == 0xF0 : c == 0xF4)
					break; /* < 10000 or > 10FFFF */
				n = 3;
				c &= 0x07;
			}

			for (; n--; byte = *utf8++) {
				if (byte & 0xc0 != 0x80)
					goto done;	/* Double break */
				c = (c << 6) | (byte & 0x3f);
			}
			/* Now find the width of it */
			w = wcwidth(c);
			if (w == -1)
				break;
		}

		/* Part 2: Figure out if it will fit */
		if (width + w > max)
			break;	/* Would exceed space - stop */
		/* Part 3: It fits; update our statistics */
		width += w;
		pos = (unsigned)(utf8 - origin);
	}

done:
	if (actual)
		*actual = width;
	return pos;
}
